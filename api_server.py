"""
API Server для управления терминалами SberPOS
Эмулирует серверную часть для тестирования
"""

from flask import Flask, request, jsonify, make_response, render_template_string, send_file
import json
import uuid
import random
import os
import threading
import time
from datetime import datetime, timedelta
from io import BytesIO

# Пробуем импортировать psycopg3, если не получается - работаем без БД
try:
    import psycopg
    from psycopg.types.json import Jsonb
    PSYCOPG_AVAILABLE = True
    print("✅ psycopg3 загружен успешно")
except ImportError as e:
    print(f"⚠️  psycopg не доступен: {e}")
    print("⚠️  Будет использоваться только файловое хранилище")
    PSYCOPG_AVAILABLE = False

# Пробуем импортировать qrcode для генерации QR-кодов
try:
    import qrcode
    QRCODE_AVAILABLE = True
    print("✅ qrcode загружен успешно")
except ImportError:
    print("⚠️  qrcode не доступен, QR-коды не будут генерироваться")
    print("⚠️  Установите: pip install qrcode[pil]")
    QRCODE_AVAILABLE = False

app = Flask(__name__)

# Хранилище данных в памяти
sessions = {}  # session_id -> {terminal_id, authenticated, csrf_token}
terminals = {}  # terminal_id -> {password, current_payload, face_confirm_enabled, owner_id}
device_states = {}  # terminal_id -> {state, amount, last_update}
auto_reset_timers = {}  # terminal_id -> timer
last_seen = {}  # terminal_id -> datetime последнего запроса
users = {}  # user_id -> {username, password, terminals: [], balance: 0}
transactions = {}  # terminal_id -> [{timestamp, amount, type, status}]
shifts = {}  # terminal_id -> {opened_at, closed_at, transactions_count, total_amount}
balance_history = {}  # user_id -> [{timestamp, amount, type, terminal_id, description}]

TERMINALS_FILE = os.environ.get('TERMINALS_FILE', '/data/terminals_db.json') if os.path.exists('/data') else 'terminals_db.json'
USERS_FILE = 'users_db.json'
TRANSACTIONS_FILE = 'transactions_db.json'
SHIFTS_FILE = 'shifts_db.json'
BALANCE_HISTORY_FILE = 'balance_history_db.json'
TERMINAL_TIMEOUT = 10  # секунд без активности для отмены оплаты
DATABASE_URL = os.environ.get('DATABASE_URL')  # PostgreSQL URL от Render

def get_db_connection():
    """Получить подключение к БД"""
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        # Render использует postgres://, но psycopg требует postgresql://
        db_url = DATABASE_URL.replace('postgres://', 'postgresql://')
        return psycopg.connect(db_url)
    return None

def init_db():
    """Инициализация таблиц БД"""
    if not DATABASE_URL or not PSYCOPG_AVAILABLE:
        print("⚠️  DATABASE_URL не найден или psycopg недоступен, используется файловое хранилище")
        return
    
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Таблица терминалов
        cur.execute('''
            CREATE TABLE IF NOT EXISTS terminals (
                terminal_id VARCHAR(10) PRIMARY KEY,
                data JSONB NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица пользователей
        cur.execute('''
            CREATE TABLE IF NOT EXISTS users (
                username VARCHAR(100) PRIMARY KEY,
                data JSONB NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица транзакций
        cur.execute('''
            CREATE TABLE IF NOT EXISTS transactions (
                id SERIAL PRIMARY KEY,
                terminal_id VARCHAR(10) NOT NULL,
                data JSONB NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица смен
        cur.execute('''
            CREATE TABLE IF NOT EXISTS shifts (
                terminal_id VARCHAR(10) PRIMARY KEY,
                data JSONB NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица истории баланса
        cur.execute('''
            CREATE TABLE IF NOT EXISTS balance_history (
                id SERIAL PRIMARY KEY,
                user_id VARCHAR(100) NOT NULL,
                data JSONB NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица избранных терминалов
        cur.execute('''
            CREATE TABLE IF NOT EXISTS favorite_terminals (
                username VARCHAR(100) NOT NULL,
                terminal_id VARCHAR(10) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (username, terminal_id)
            )
        ''')
        
        # Таблица сообщений чата поддержки
        cur.execute('''
            CREATE TABLE IF NOT EXISTS support_messages (
                id SERIAL PRIMARY KEY,
                username VARCHAR(100) NOT NULL,
                message TEXT NOT NULL,
                is_admin BOOLEAN DEFAULT FALSE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица базы знаний
        cur.execute('''
            CREATE TABLE IF NOT EXISTS knowledge_base (
                id SERIAL PRIMARY KEY,
                title VARCHAR(200) NOT NULL,
                content TEXT NOT NULL,
                category VARCHAR(50) NOT NULL,
                views INT DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Таблица новостей
        cur.execute('''
            CREATE TABLE IF NOT EXISTS news (
                id SERIAL PRIMARY KEY,
                title VARCHAR(200) NOT NULL,
                content TEXT NOT NULL,
                type VARCHAR(50) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        conn.commit()
        cur.close()
        conn.close()
        print("✅ База данных инициализирована (9 таблиц)")
    except Exception as e:
        print(f"❌ Ошибка инициализации БД: {e}")

def auto_reset_to_idle(terminal_id, delay=5):
    """Автоматически сбросить терминал в idle через delay секунд"""
    # Отменяем предыдущий таймер если есть
    if terminal_id in auto_reset_timers:
        auto_reset_timers[terminal_id].cancel()
    
    def reset():
        if terminal_id in terminals:
            terminals[terminal_id]['current_payload'] = {'state': 'idle', 'data': {}}
            terminals[terminal_id]['card_status'] = {
                'pending': True,
                'approved': False
            }
            terminals[terminal_id]['qr_status'] = {
                'pending': True,
                'approved': False
            }
            terminals[terminal_id]['payment_processed'] = False  # Сбрасываем флаг
            device_states[terminal_id] = {
                'state': 'idle',
                'amount': '0',
                'last_update': datetime.now().isoformat()
            }
            print(f"🔄 [AUTO-RESET] {terminal_id} -> idle (all statuses reset)")
    
    timer = threading.Timer(delay, reset)
    timer.start()
    auto_reset_timers[terminal_id] = timer

def load_terminals():
    """Загрузка терминалов из БД или файла"""
    global terminals
    
    # Пробуем загрузить из PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('SELECT terminal_id, data FROM terminals')
            rows = cur.fetchall()
            terminals = {row[0]: row[1] for row in rows}
            cur.close()
            conn.close()
            print(f"📂 Загружено {len(terminals)} терминалов из PostgreSQL")
            return
        except Exception as e:
            print(f"❌ Ошибка загрузки из БД: {e}")
    
    # Fallback на файл
    try:
        with open(TERMINALS_FILE, 'r', encoding='utf-8') as f:
            terminals = json.load(f)
            print(f"📂 Загружено {len(terminals)} терминалов из {TERMINALS_FILE}")
    except FileNotFoundError:
        print(f"📂 Файл {TERMINALS_FILE} не найден, создан новый")
        terminals = {}
    except Exception as e:
        print(f"❌ Ошибка загрузки терминалов: {e}")
        terminals = {}

def save_terminals():
    """Сохранение терминалов в БД или файл"""
    # Сохраняем в PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            for terminal_id, data in terminals.items():
                cur.execute('''
                    INSERT INTO terminals (terminal_id, data, updated_at)
                    VALUES (%s, %s, CURRENT_TIMESTAMP)
                    ON CONFLICT (terminal_id) 
                    DO UPDATE SET data = %s, updated_at = CURRENT_TIMESTAMP
                ''', (terminal_id, Jsonb(data), Jsonb(data)))
            conn.commit()
            cur.close()
            conn.close()
            return
        except Exception as e:
            print(f"❌ Ошибка сохранения в БД: {e}")
    
    # Fallback на файл
    try:
        with open(TERMINALS_FILE, 'w', encoding='utf-8') as f:
            json.dump(terminals, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения терминалов: {e}")

def load_users():
    """Загрузка пользователей из БД или файла"""
    global users
    
    # Пробуем загрузить из PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('SELECT username, data FROM users')
            rows = cur.fetchall()
            users = {row[0]: row[1] for row in rows}
            cur.close()
            conn.close()
            print(f"👥 Загружено {len(users)} пользователей из PostgreSQL")
            return
        except Exception as e:
            print(f"❌ Ошибка загрузки пользователей из БД: {e}")
    
    # Fallback на файл
    try:
        with open(USERS_FILE, 'r', encoding='utf-8') as f:
            users = json.load(f)
            print(f"👥 Загружено {len(users)} пользователей из файла")
    except FileNotFoundError:
        users = {}
        print("👥 Файл пользователей не найден, создан новый")
    except Exception as e:
        print(f"❌ Ошибка загрузки пользователей: {e}")
        users = {}

def save_users():
    """Сохранение пользователей в БД или файл"""
    # Сохраняем в PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            for username, data in users.items():
                cur.execute('''
                    INSERT INTO users (username, data, updated_at)
                    VALUES (%s, %s, CURRENT_TIMESTAMP)
                    ON CONFLICT (username) 
                    DO UPDATE SET data = %s, updated_at = CURRENT_TIMESTAMP
                ''', (username, Jsonb(data), Jsonb(data)))
            conn.commit()
            cur.close()
            conn.close()
            return
        except Exception as e:
            print(f"❌ Ошибка сохранения пользователей в БД: {e}")
    
    # Fallback на файл
    try:
        with open(USERS_FILE, 'w', encoding='utf-8') as f:
            json.dump(users, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения пользователей: {e}")

def load_transactions():
    """Загрузка транзакций"""
    global transactions
    try:
        with open(TRANSACTIONS_FILE, 'r', encoding='utf-8') as f:
            transactions = json.load(f)
            print(f"💳 Загружено транзакций для {len(transactions)} терминалов")
    except FileNotFoundError:
        transactions = {}
        print("💳 Файл транзакций не найден, создан новый")
    except Exception as e:
        print(f"❌ Ошибка загрузки транзакций: {e}")
        transactions = {}

def save_transactions():
    """Сохранение транзакций"""
    try:
        with open(TRANSACTIONS_FILE, 'w', encoding='utf-8') as f:
            json.dump(transactions, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения транзакций: {e}")

def load_shifts():
    """Загрузка смен"""
    global shifts
    try:
        with open(SHIFTS_FILE, 'r', encoding='utf-8') as f:
            shifts = json.load(f)
            print(f"📅 Загружено смен для {len(shifts)} терминалов")
    except FileNotFoundError:
        shifts = {}
        print("📅 Файл смен не найден, создан новый")
    except Exception as e:
        print(f"❌ Ошибка загрузки смен: {e}")
        shifts = {}

def save_shifts():
    """Сохранение смен"""
    try:
        with open(SHIFTS_FILE, 'w', encoding='utf-8') as f:
            json.dump(shifts, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения смен: {e}")

def load_balance_history():
    """Загрузка истории баланса"""
    global balance_history
    try:
        with open(BALANCE_HISTORY_FILE, 'r', encoding='utf-8') as f:
            balance_history = json.load(f)
            print(f"💰 Загружено истории баланса для {len(balance_history)} пользователей")
    except FileNotFoundError:
        balance_history = {}
        print("💰 Файл истории баланса не найден, создан новый")
    except Exception as e:
        print(f"❌ Ошибка загрузки истории баланса: {e}")
        balance_history = {}

def save_balance_history():
    """Сохранение истории баланса"""
    try:
        with open(BALANCE_HISTORY_FILE, 'w', encoding='utf-8') as f:
            json.dump(balance_history, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения истории баланса: {e}")

def add_balance(user_id, amount, transaction_type, terminal_id, description):
    """Добавить средства на баланс пользователя"""
    # Находим пользователя по user_id
    username = None
    for uname, udata in users.items():
        if udata.get('user_id') == user_id:
            username = uname
            break
    
    if not username:
        print(f"⚠️  [BALANCE] User {user_id} not found")
        return
    
    # Добавляем к балансу
    users[username]['balance'] = users[username].get('balance', 0) + float(amount)
    
    # Записываем в историю
    if user_id not in balance_history:
        balance_history[user_id] = []
    
    balance_history[user_id].append({
        'timestamp': datetime.now().isoformat(),
        'amount': float(amount),
        'type': transaction_type,
        'terminal_id': terminal_id,
        'description': description
    })
    
    save_users()
    save_balance_history()
    
    print(f"💰 [BALANCE] User {username}: +{amount}₽ (total: {users[username]['balance']}₽)")

def add_transaction(terminal_id, amount, payment_type, status):
    """Добавить транзакцию"""
    if terminal_id not in transactions:
        transactions[terminal_id] = []
    
    transaction = {
        'timestamp': datetime.now().isoformat(),
        'amount': amount,
        'type': payment_type,  # 'card', 'face', 'qr'
        'status': status  # 'success', 'failed'
    }
    
    transactions[terminal_id].append(transaction)
    save_transactions()
    
    # Обновляем статистику смены если смена открыта
    if terminal_id in shifts and shifts[terminal_id].get('opened_at') and not shifts[terminal_id].get('closed_at'):
        shifts[terminal_id]['transactions_count'] = shifts[terminal_id].get('transactions_count', 0) + 1
        if status == 'success':
            shifts[terminal_id]['total_amount'] = shifts[terminal_id].get('total_amount', 0) + float(amount)
        save_shifts()
    
    # Начисляем деньги владельцу терминала если оплата успешна
    if status == 'success' and terminal_id in terminals:
        owner_id = terminals[terminal_id].get('owner_id')
        if owner_id:
            add_balance(owner_id, amount, payment_type, terminal_id, f'Оплата через терминал {terminal_id}')
    
    print(f"💰 [TRANSACTION] {terminal_id}: {amount}₽ via {payment_type} - {status}")

def check_terminal_timeouts():
    """Проверка таймаутов терминалов и отмена оплат"""
    print("🔍 [TIMEOUT CHECKER] Started background thread")
    while True:
        time.sleep(0.5)  # Проверяем каждые 0.5 секунды для быстрой реакции
        now = datetime.now()
        
        for terminal_id in list(last_seen.keys()):
            last_activity = last_seen.get(terminal_id)
            if not last_activity:
                continue
            
            inactive_seconds = (now - last_activity).total_seconds()
            
            # Если терминал не активен больше TERMINAL_TIMEOUT секунд
            if inactive_seconds > TERMINAL_TIMEOUT:
                if terminal_id in terminals:
                    current_state = terminals[terminal_id].get('current_payload', {}).get('state', 'idle')
                    
                    # Если терминал в процессе оплаты - отменяем
                    if current_state in ['pay', 'payPending']:
                        print(f"⏱️  [TIMEOUT] {terminal_id}: no activity for {int(inactive_seconds)}s, cancelling payment (state: {current_state})")
                        terminals[terminal_id]['current_payload'] = {'state': 'idle', 'data': {}}
                        terminals[terminal_id]['card_status'] = {
                            'pending': True,
                            'approved': False
                        }
                        terminals[terminal_id]['payment_processed'] = False
                        if terminal_id in device_states:
                            device_states[terminal_id]['state'] = 'idle'
                            device_states[terminal_id]['last_update'] = now.isoformat()
                    else:
                        print(f"🔍 [TIMEOUT] {terminal_id}: inactive for {int(inactive_seconds)}s but state is {current_state}, skipping")
                
                # Удаляем из отслеживания
                del last_seen[terminal_id]
                print(f"🗑️  [TIMEOUT] {terminal_id}: removed from tracking")

# Инициализация БД
init_db()

# Загрузка терминалов при старте
load_terminals()
load_users()
load_transactions()
load_shifts()
load_balance_history()

# Запуск фонового потока для проверки таймаутов
print("🚀 Starting timeout checker thread...")
timeout_thread = threading.Thread(target=check_terminal_timeouts, daemon=True)
timeout_thread.start()
print("✅ Timeout checker thread started")

def get_session(request):
    """Получить сессию из cookies"""
    session_id = request.cookies.get('session_id')
    return sessions.get(session_id) if session_id else None

def require_auth(f):
    """Декоратор для проверки авторизации"""
    def wrapper(*args, **kwargs):
        session = get_session(request)
        if not session or not session.get('authenticated'):
            return jsonify({'error': 'Unauthorized'}), 401
        return f(session, *args, **kwargs)
    wrapper.__name__ = f.__name__
    return wrapper

@app.route('/api/register_device', methods=['POST'])
def register_terminal():
    """Регистрация нового терминала"""
    data = request.json or {}
    terminal_id = data.get('terminal_id')
    password = data.get('password')
    
    # Валидация формата TRM-####
    if terminal_id:
        if not terminal_id.startswith('TRM-') or len(terminal_id) != 8:
            print(f"❌ [REGISTER] Invalid format: {terminal_id}")
            return jsonify({'error': 'Invalid terminal_id format. Use TRM-####', 'status': 'error'}), 400
        try:
            int(terminal_id[4:])
        except ValueError:
            print(f"❌ [REGISTER] Non-digit ID: {terminal_id}")
            return jsonify({'error': 'Terminal ID must be TRM-#### where #### are digits', 'status': 'error'}), 400
    else:
        # Генерация случайного ID
        terminal_id = f"TRM-{random.randint(1000, 9999)}"
        while terminal_id in terminals:
            terminal_id = f"TRM-{random.randint(1000, 9999)}"
    
    # Валидация пароля
    if password:
        if len(password) != 6 or not password.isdigit():
            print(f"❌ [REGISTER] Invalid password format for {terminal_id}")
            return jsonify({'error': 'Password must be 6 digits', 'status': 'error'}), 400
    else:
        # Генерация случайного пароля
        password = ''.join([str(random.randint(0, 9)) for _ in range(6)])
    
    # Проверка существования
    if terminal_id in terminals:
        print(f"⚠️  [REGISTER] Terminal already exists: {terminal_id}")
        return jsonify({'error': 'Terminal already exists', 'status': 'error'}), 409
    
    # Создание терминала
    terminals[terminal_id] = {
        'password': password,
        'current_payload': {'state': 'idle', 'data': {}},
        'face_confirm_enabled': False,
        'uuid': str(uuid.uuid4()),
        'card_status': {
            'pending': True,
            'approved': False
        },
        'qr_status': {
            'pending': True,
            'approved': False
        },
        'payment_processed': False  # Флаг для предотвращения двойного подтверждения
    }
    
    save_terminals()
    
    print(f"✅ [REGISTER] New terminal created: {terminal_id} / {password}")
    
    return jsonify({
        'success': True,
        'status': 'success',
        'terminal_id': terminal_id,
        'terminal_password': password,
        'uuid': terminals[terminal_id]['uuid']
    }), 201

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Авторизация терминала"""
    if request.method == 'GET':
        return 'Login page', 200
    
    username = request.form.get('username')
    password = request.form.get('password')
    
    if not username or not password:
        print(f"❌ [LOGIN] Missing credentials")
        return jsonify({'error': 'Missing credentials', 'status': 'error'}), 200
    
    terminal = terminals.get(username)
    if not terminal:
        print(f"❌ [LOGIN] Terminal not found: {username}")
        return jsonify({'error': 'Terminal not found', 'status': 'error'}), 200
    
    if terminal['password'] != password:
        print(f"❌ [LOGIN] Wrong password for: {username}")
        return jsonify({'error': 'Invalid password', 'status': 'error'}), 200
    
    # Создаём сессию
    session_id = str(uuid.uuid4())
    csrf_token = str(uuid.uuid4())
    
    sessions[session_id] = {
        'terminal_id': username,
        'authenticated': True,
        'csrf_token': csrf_token
    }
    
    print(f"✅ [LOGIN] Successful login: {username} (session: {session_id[:8]}...)")
    
    response = make_response(jsonify({'success': True, 'status': 'success'}))
    response.set_cookie('session_id', session_id)
    response.set_cookie('csrf', csrf_token)
    
    return response

@app.route('/api/card/status', methods=['GET'])
def card_status():
    """Получить статус карты/оплаты"""
    terminal_id = request.args.get('terminal_id')
    uuid_param = request.args.get('uuid')
    source = request.args.get('source', 'unknown')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверка UUID
    if uuid_param and terminal.get('uuid') != uuid_param:
        return jsonify({'error': 'Invalid UUID'}), 403
    
    # Обновляем время последней активности
    last_seen[terminal_id] = datetime.now()
    
    # Получаем статус подтверждения карты
    card_status_data = terminal.get('card_status', {})
    pending = card_status_data.get('pending', True)
    approved = card_status_data.get('approved', False)
    
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    state = current.get('state', 'idle')
    
    # Если карта приложена (source=sensor) и включен bypass, запускаем автоподтверждение
    if source == 'sensor' and state == 'pay' and pending and not terminal.get('payment_processed', False):
        bypass_card_check = terminal.get('bypass_card_check', False)
        if bypass_card_check and not terminal.get('bypass_timer_started', False):
            terminal['bypass_timer_started'] = True
            current_amount = current.get('data', {}).get('amount', '0')
            
            def auto_confirm():
                print(f"⏱️  [BYPASS] {terminal_id}: Starting 3s countdown (from card sensor)...")
                time.sleep(3)
                if terminal_id in terminals:
                    term = terminals[terminal_id]
                    curr_state = term.get('current_payload', {}).get('state', 'idle')
                    print(f"⏱️  [BYPASS] {terminal_id}: After 3s - state={curr_state}, processed={term.get('payment_processed', False)}")
                    
                    # Проверяем что терминал все еще в pay и оплата не обработана
                    if curr_state == 'pay' and not term.get('payment_processed', False):
                        # Обновляем card_status
                        term['card_status'] = {
                            'pending': False,
                            'approved': True
                        }
                        term['payment_processed'] = True
                        term['bypass_timer_started'] = False
                        add_transaction(terminal_id, current_amount, 'card', 'success')
                        print(f"💳 [BYPASS] {terminal_id}: Auto-approved payment after 3s (bypass enabled)")
                        # Автоматически сбросить в idle через 5 секунд
                        auto_reset_to_idle(terminal_id, delay=5)
                    else:
                        term['bypass_timer_started'] = False
                        print(f"⚠️  [BYPASS] {terminal_id}: Conditions not met - state={curr_state}, processed={term.get('payment_processed', False)}")
            
            threading.Thread(target=auto_confirm, daemon=True).start()
            print(f"⏱️  [BYPASS] {terminal_id}: Auto-confirm timer started (3s) from card sensor")
    
    print(f"📥 [CARD STATUS] {terminal_id}: state={state}, pending={pending}, approved={approved}, source={source}")
    
    return jsonify({
        'success': True,
        'status': state,
        'state': state,
        'pending': pending,
        'approved': approved,
        'data': current.get('data', {}),
        'terminal_id': terminal_id
    }), 200

@app.route('/api/face/status', methods=['GET'])
def face_status():
    """Получить статус оплаты улыбкой"""
    terminal_id = request.args.get('terminal_id')
    uuid_param = request.args.get('uuid')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверка UUID
    if uuid_param and terminal.get('uuid') != uuid_param:
        return jsonify({'error': 'Invalid UUID'}), 403
    
    # Обновляем время последней активности
    last_seen[terminal_id] = datetime.now()
    
    # Получаем статус подтверждения (используем тот же card_status для face)
    face_status_data = terminal.get('card_status', {})
    pending = face_status_data.get('pending', True)
    approved = face_status_data.get('approved', False)
    
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    state = current.get('state', 'idle')
    
    print(f"😊 [FACE STATUS] {terminal_id}: state={state}, pending={pending}, approved={approved}")
    
    return jsonify({
        'success': True,
        'status': state,
        'state': state,
        'pending': pending,
        'approved': approved,
        'data': current.get('data', {}),
        'terminal_id': terminal_id
    }), 200

@app.route('/api/face/upload', methods=['POST'])
def face_upload():
    """Загрузка фото лица для оплаты"""
    try:
        # Получаем данные из формы (multipart/form-data)
        terminal_id = request.form.get('terminal_id')
        uuid_param = request.form.get('uuid')
        
        # Если нет в форме, пробуем из args
        if not terminal_id:
            terminal_id = request.args.get('terminal_id')
        if not uuid_param:
            uuid_param = request.args.get('uuid')
        
        print(f"📸 [FACE UPLOAD] Request from {terminal_id}, content-type: {request.content_type}")
        
        if not terminal_id:
            print(f"❌ [FACE UPLOAD] Missing terminal_id")
            return jsonify({'error': 'Missing terminal_id', 'success': False}), 400
        
        if terminal_id not in terminals:
            print(f"❌ [FACE UPLOAD] Terminal not found: {terminal_id}")
            return jsonify({'error': 'Terminal not found', 'success': False}), 404
        
        terminal = terminals[terminal_id]
        
        # Проверка UUID
        if uuid_param and terminal.get('uuid') != uuid_param:
            print(f"❌ [FACE UPLOAD] Invalid UUID for {terminal_id}")
            return jsonify({'error': 'Invalid UUID', 'success': False}), 403
        
        # Получаем фото если есть
        face_image = None
        if request.files:
            # Пробуем разные возможные имена поля
            face_image = request.files.get('face_image') or request.files.get('image') or request.files.get('file')
            if face_image:
                image_data = face_image.read()
                print(f"📸 [FACE UPLOAD] {terminal_id}: received image ({len(image_data)} bytes)")
        else:
            print(f"📸 [FACE UPLOAD] {terminal_id}: no files in request")
        
        # Проверяем включено ли подтверждение лицом
        face_confirm_enabled = terminal.get('face_confirm_enabled', True)
        
        print(f"😊 [FACE UPLOAD] {terminal_id}: face_confirm_enabled={face_confirm_enabled}, returning success")
        
        # Возвращаем успешный ответ с флагом подтверждения
        return jsonify({
            'success': True,
            'face_confirm_enabled': face_confirm_enabled,
            'terminal_id': terminal_id,
            'message': 'Face uploaded successfully'
        }), 200
        
    except Exception as e:
        print(f"❌ [FACE UPLOAD] Error: {e}")
        return jsonify({'error': str(e), 'success': False}), 500

@app.route('/api/payload', methods=['GET', 'POST'])
@app.route('/admin/set_payload', methods=['POST'])  # Алиас для бота
def payload_handler():
    """Получить или установить payload для терминала"""
    
    if request.method == 'GET':
        # Получение payload - проверка терминала
        terminal_id = request.args.get('terminal_id')
        uuid_param = request.args.get('uuid')
        
        if not terminal_id:
            return jsonify({'error': 'Missing terminal_id'}), 400
        
        if terminal_id not in terminals:
            return jsonify({'error': 'Terminal not found'}), 404
        
        terminal = terminals[terminal_id]
        
        # Проверка UUID
        if uuid_param and terminal.get('uuid') != uuid_param:
            return jsonify({'error': 'Invalid UUID'}), 403
        
        # Обновляем время последней активности
        last_seen[terminal_id] = datetime.now()
        
        current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
        
        response_data = {
            'success': True,
            'state': current.get('state', 'idle'),
            'data': current.get('data', {}),
            'terminal_id': terminal_id
        }
        
        print(f"📥 [GET PAYLOAD] {terminal_id}: state={current.get('state')} (last_seen updated)")
        print(f"   Response: {response_data}")
        
        return jsonify(response_data), 200
    
    else:
        # POST - установка payload (требует авторизации)
        session = get_session(request)
        if not session or not session.get('authenticated'):
            return jsonify({'error': 'Unauthorized'}), 401
        
        data = request.json
        terminal_id = session['terminal_id']
        
        if terminal_id not in terminals:
            return jsonify({'error': 'Terminal not found'}), 404
        
        state = data.get('state', 'idle')
        amount = data.get('amount', '0')
        content = data.get('content', '')
        buttons = data.get('buttons', '')
        
        # Проверяем открыта ли смена если пытаемся отправить оплату
        if state == 'pay':
            owner_id = terminals[terminal_id].get('owner_id')
            bypass_shift_check = terminals[terminal_id].get('bypass_shift_check', False)
            
            if owner_id and not bypass_shift_check:
                # Проверяем есть ли открытая смена
                shift = shifts.get(terminal_id, {})
                if not (shift.get('opened_at') and not shift.get('closed_at')):
                    print(f"❌ [PAYLOAD] {terminal_id}: Cannot send payment - shift is closed")
                    return jsonify({'error': 'Смена закрыта', 'status': 'error'}), 400
        
        terminals[terminal_id]['current_payload'] = {
            'state': state,
            'data': {
                'amount': amount,
                'content': content,
                'buttons': buttons
            }
        }
        
        # Если начинается оплата, устанавливаем pending=True
        if state == 'pay':
            # Генерируем одноразовый пароль для QR-оплаты
            qr_password = ''.join([str(random.randint(0, 9)) for _ in range(6)])
            
            # Обычная логика - требуется подтверждение
            terminals[terminal_id]['card_status'] = {
                'pending': True,
                'approved': False
            }
            terminals[terminal_id]['payment_processed'] = False  # Сбрасываем флаг при новой оплате
            
            terminals[terminal_id]['qr_password'] = qr_password  # Сохраняем пароль
            print(f"🔐 [PAYLOAD] Generated QR password for {terminal_id}: {qr_password}")
        
        device_states[terminal_id] = {
            'state': state,
            'amount': amount,
            'last_update': datetime.now().isoformat()
        }
        
        print(f"📤 [PAYLOAD] Set for {terminal_id}: state={state}, amount={amount}")
        
        return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/set_device_payload', methods=['POST'])
@require_auth
def set_device_payload(session):
    """Установить payload для конкретного устройства"""
    data = request.json
    terminal_id = data.get('terminal_id')
    payload = data.get('payload', 'idle')
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminals[terminal_id]['current_payload'] = {
        'state': payload,
        'data': {}
    }
    
    device_states[terminal_id] = {
        'state': payload,
        'amount': '0',
        'last_update': datetime.now().isoformat()
    }
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/set_device_payload_full', methods=['POST'])
@require_auth
def set_device_payload_full(session):
    """Установить полный payload для конкретного устройства (с amount и state)"""
    data = request.json
    terminal_id = data.get('terminal_id')
    state = data.get('state', 'idle')
    amount = data.get('amount', '0')
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Проверяем открыта ли смена если пытаемся отправить оплату
    if state == 'pay':
        owner_id = terminals[terminal_id].get('owner_id')
        bypass_shift_check = terminals[terminal_id].get('bypass_shift_check', False)
        
        if owner_id and not bypass_shift_check:
            # Проверяем есть ли открытая смена
            shift = shifts.get(terminal_id, {})
            if not (shift.get('opened_at') and not shift.get('closed_at')):
                print(f"❌ [PAYLOAD_FULL] {terminal_id}: Cannot send payment - shift is closed")
                return jsonify({'error': 'Смена закрыта', 'status': 'error'}), 400
    
    terminals[terminal_id]['current_payload'] = {
        'state': state,
        'data': {
            'amount': amount,
            'content': '',
            'buttons': ''
        }
    }
    
    # Если начинается оплата, устанавливаем pending=True
    if state == 'pay':
        # Генерируем одноразовый пароль для QR-оплаты
        qr_password = ''.join([str(random.randint(0, 9)) for _ in range(6)])
        
        # Обычная логика - требуется подтверждение
        terminals[terminal_id]['card_status'] = {
            'pending': True,
            'approved': False
        }
        terminals[terminal_id]['payment_processed'] = False
        
        terminals[terminal_id]['qr_password'] = qr_password
        print(f"🔐 [PAYLOAD_FULL] Generated QR password for {terminal_id}: {qr_password}")
    
    device_states[terminal_id] = {
        'state': state,
        'amount': amount,
        'last_update': datetime.now().isoformat()
    }
    
    print(f"📤 [PAYLOAD_FULL] Set for {terminal_id}: state={state}, amount={amount}")
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/reset', methods=['POST'])
@require_auth
def reset_all(session):
    """Сбросить все терминалы в idle"""
    for terminal_id in terminals:
        terminals[terminal_id]['current_payload'] = {'state': 'idle', 'data': {}}
        device_states[terminal_id] = {'state': 'idle', 'amount': '0', 'last_update': datetime.now().isoformat()}
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/set_face_confirm', methods=['POST'])
@require_auth
def set_face_confirm(session):
    """Включить/выключить подтверждение лицом"""
    data = request.json
    terminal_id = data.get('terminal_id')
    enabled = data.get('enabled', False)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminals[terminal_id]['face_confirm_enabled'] = enabled
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/set_bypass_shift_check', methods=['POST'])
@require_auth
def set_bypass_shift_check(session):
    """Включить/выключить обход проверки смены"""
    data = request.json
    terminal_id = data.get('terminal_id')
    enabled = data.get('enabled', False)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminals[terminal_id]['bypass_shift_check'] = enabled
    save_terminals()
    
    print(f"🔓 [BYPASS] {terminal_id}: Shift check bypass {'enabled' if enabled else 'disabled'}")
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/set_bypass_card_check', methods=['POST'])
@require_auth
def set_bypass_card_check(session):
    """Включить/выключить обход проверки карты/лица"""
    data = request.json
    terminal_id = data.get('terminal_id')
    enabled = data.get('enabled', False)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminals[terminal_id]['bypass_card_check'] = enabled
    save_terminals()
    
    print(f"💳 [BYPASS] {terminal_id}: Card/face check bypass {'enabled' if enabled else 'disabled'}")
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/confirm_card', methods=['POST'])
@require_auth
def confirm_card(session):
    """Подтвердить/отклонить карту"""
    data = request.json
    terminal_id = data.get('terminal_id')
    approved = data.get('approved', True)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Проверяем что терминал в состоянии оплаты
    current_state = terminals[terminal_id].get('current_payload', {}).get('state', 'idle')
    if current_state not in ['pay', 'payPending']:
        print(f"⚠️  [CARD] {terminal_id}: not in payment state (current: {current_state})")
        return jsonify({'error': 'Not in payment state', 'success': False}), 400
    
    # Проверяем что оплата еще не обработана
    if terminals[terminal_id].get('payment_processed', False):
        print(f"⚠️  [CARD] {terminal_id}: payment already processed")
        return jsonify({'error': 'Payment already processed', 'success': False}), 400
    
    # Помечаем оплату как обработанную
    terminals[terminal_id]['payment_processed'] = True
    
    # Устанавливаем статус подтверждения карты
    terminals[terminal_id]['card_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Записываем транзакцию
    amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    add_transaction(terminal_id, amount, 'card', 'success' if approved else 'failed')
    
    if approved:
        print(f"💳 [CARD] {terminal_id}: ✅ approved (pending=False)")
        print(f"   Card status will auto-reset to idle in 5s")
        # Автоматически сбросить в idle через 5 секунд
        auto_reset_to_idle(terminal_id, delay=5)
    else:
        print(f"💳 [CARD] {terminal_id}: ❌ declined (pending=False)")
        # При отклонении показываем экран неудачи и быстрее возвращаемся в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'paymentFailed',
            'data': {
                'amount': amount,
                'content': 'Оплата отклонена',
                'buttons': ''
            }
        }
        print(f"   Showing paymentFailed screen, will auto-reset to idle in 3s")
        auto_reset_to_idle(terminal_id, delay=3)
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/confirm_face', methods=['POST'])
@require_auth
def confirm_face(session):
    """Подтвердить/отклонить лицо"""
    data = request.json
    terminal_id = data.get('terminal_id')
    approved = data.get('approved', True)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Проверяем что терминал в состоянии оплаты
    current_state = terminals[terminal_id].get('current_payload', {}).get('state', 'idle')
    if current_state not in ['pay', 'payPending']:
        print(f"⚠️  [FACE] {terminal_id}: not in payment state (current: {current_state})")
        return jsonify({'error': 'Not in payment state', 'success': False}), 400
    
    # Проверяем что оплата еще не обработана
    if terminals[terminal_id].get('payment_processed', False):
        print(f"⚠️  [FACE] {terminal_id}: payment already processed")
        return jsonify({'error': 'Payment already processed', 'success': False}), 400
    
    # Помечаем оплату как обработанную
    terminals[terminal_id]['payment_processed'] = True
    
    # Устанавливаем статус подтверждения карты (face использует ту же логику)
    terminals[terminal_id]['card_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Записываем транзакцию
    amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    add_transaction(terminal_id, amount, 'face', 'success' if approved else 'failed')
    
    if approved:
        print(f"🙂 [FACE] {terminal_id}: ✅ approved (pending=False)")
        print(f"   Card status will auto-reset to idle in 5s")
        # Автоматически сбросить в idle через 5 секунд
        auto_reset_to_idle(terminal_id, delay=5)
    else:
        print(f"🙂 [FACE] {terminal_id}: ❌ declined (pending=False)")
        # При отклонении показываем экран неудачи и быстрее возвращаемся в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'paymentFailed',
            'data': {
                'amount': amount,
                'content': 'Оплата отклонена',
                'buttons': ''
            }
        }
        print(f"   Showing paymentFailed screen, will auto-reset to idle in 3s")
        auto_reset_to_idle(terminal_id, delay=3)
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/admin/status', methods=['GET'])
@require_auth
def get_status(session):
    """Получить статус всех терминалов"""
    devices = []
    
    for terminal_id, terminal_data in terminals.items():
        devices.append({
            'terminal_id': terminal_id,
            'current_payload': terminal_data['current_payload'],
            'face_confirm_enabled': terminal_data.get('face_confirm_enabled', False),
            'last_update': device_states.get(terminal_id, {}).get('last_update', '')
        })
    
    return jsonify({'devices': devices}), 200

@app.route('/admin/delete_terminal', methods=['POST'])
@require_auth
def delete_terminal(session):
    """Удалить терминал"""
    data = request.json
    terminal_id = data.get('terminal_id')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id', 'success': False}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found', 'success': False}), 404
    
    # Удаляем терминал
    del terminals[terminal_id]
    
    # Удаляем из БД если используется
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM terminals WHERE terminal_id = %s', (terminal_id,))
            conn.commit()
            cur.close()
            conn.close()
        except Exception as e:
            print(f"❌ Ошибка удаления из БД: {e}")
    
    # Удаляем из device_states
    if terminal_id in device_states:
        del device_states[terminal_id]
    
    # Удаляем из last_seen
    if terminal_id in last_seen:
        del last_seen[terminal_id]
    
    # Отменяем таймер если есть
    if terminal_id in auto_reset_timers:
        auto_reset_timers[terminal_id].cancel()
        del auto_reset_timers[terminal_id]
    
    # Сохраняем изменения в файл (fallback)
    save_terminals()
    
    print(f"🗑️  [DELETE] Terminal {terminal_id} deleted")
    
    return jsonify({'success': True, 'status': 'success', 'message': f'Terminal {terminal_id} deleted'}), 200

@app.route('/admin/clear_all_terminals', methods=['POST'])
@require_auth
def clear_all_terminals(session):
    """Удалить ВСЕ терминалы (осторожно!)"""
    global terminals, device_states, last_seen, auto_reset_timers
    
    count = len(terminals)
    
    # Отменяем все таймеры
    for timer in auto_reset_timers.values():
        timer.cancel()
    
    # Очищаем все словари
    terminals.clear()
    device_states.clear()
    last_seen.clear()
    auto_reset_timers.clear()
    
    # Удаляем из БД если используется
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM terminals')
            conn.commit()
            cur.close()
            conn.close()
            print(f"🗑️  [CLEAR ALL] Deleted {count} terminals from database")
        except Exception as e:
            print(f"❌ Ошибка очистки БД: {e}")
    
    # Сохраняем пустой файл
    save_terminals()
    
    print(f"🗑️  [CLEAR ALL] Deleted all {count} terminals")
    
    return jsonify({'success': True, 'status': 'success', 'message': f'Deleted {count} terminals'}), 200

@app.route('/api/qr/password', methods=['GET'])
def qr_password():
    """Получить QR-пароль для терминала"""
    terminal_id = request.args.get('terminal_id')
    uuid_param = request.args.get('uuid')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверка UUID
    if uuid_param and terminal.get('uuid') != uuid_param:
        return jsonify({'error': 'Invalid UUID'}), 403
    
    qr_password = terminal.get('qr_password', '')
    
    print(f"🔐 [QR PASSWORD] {terminal_id}: returning password {qr_password}")
    
    return jsonify({
        'success': True,
        'password': qr_password,
        'terminal_id': terminal_id
    }), 200

@app.route('/api/qr/status', methods=['GET'])
def qr_status():
    """Получить статус QR-оплаты"""
    terminal_id = request.args.get('terminal_id')
    uuid_param = request.args.get('uuid')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверка UUID
    if uuid_param and terminal.get('uuid') != uuid_param:
        return jsonify({'error': 'Invalid UUID'}), 403
    
    # Обновляем время последней активности
    last_seen[terminal_id] = datetime.now()
    
    # Получаем статус QR-оплаты
    qr_status_data = terminal.get('qr_status', {})
    pending = qr_status_data.get('pending', True)
    approved = qr_status_data.get('approved', False)
    
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    state = current.get('state', 'idle')
    
    print(f"📱 [QR STATUS] {terminal_id}: state={state}, pending={pending}, approved={approved}")
    
    return jsonify({
        'success': True,
        'status': state,
        'state': state,
        'pending': pending,
        'approved': approved,
        'data': current.get('data', {}),
        'terminal_id': terminal_id
    }), 200

@app.route('/admin/confirm_qr', methods=['POST'])
@require_auth
def confirm_qr(session):
    """Подтвердить/отклонить QR-оплату"""
    data = request.json
    terminal_id = data.get('terminal_id')
    approved = data.get('approved', True)
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Проверяем что терминал в состоянии оплаты
    current_state = terminals[terminal_id].get('current_payload', {}).get('state', 'idle')
    if current_state not in ['pay', 'payPending']:
        print(f"⚠️  [QR] {terminal_id}: not in payment state (current: {current_state})")
        return jsonify({'error': 'Not in payment state', 'success': False}), 400
    
    # Проверяем что оплата еще не обработана
    if terminals[terminal_id].get('payment_processed', False):
        print(f"⚠️  [QR] {terminal_id}: payment already processed")
        return jsonify({'error': 'Payment already processed', 'success': False}), 400
    
    # Помечаем оплату как обработанную
    terminals[terminal_id]['payment_processed'] = True
    
    # Устанавливаем статус подтверждения QR
    terminals[terminal_id]['qr_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Записываем транзакцию
    amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    add_transaction(terminal_id, amount, 'qr', 'success' if approved else 'failed')
    
    print(f"📱 [QR] {terminal_id}: {'✅ approved' if approved else '❌ declined'} (pending=False)")
    print(f"   QR status will auto-reset to idle in 5s")
    
    # Автоматически сбросить в idle через 5 секунд
    auto_reset_to_idle(terminal_id, delay=5)
    
    return jsonify({'success': True, 'status': 'success'}), 200

@app.route('/pay')
def universal_payment_page():
    """Универсальная страница оплаты - определяет терминал автоматически"""
    # Ищем активный терминал в состоянии оплаты
    active_terminal = None
    for terminal_id, terminal in terminals.items():
        current = terminal.get('current_payload', {'state': 'idle'})
        if current.get('state') in ['pay', 'payPending']:
            active_terminal = terminal_id
            break
    
    if not active_terminal:
        return render_template_string('''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>СберЭкран - Оплата</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'SB Sans Text', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 400px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 { color: #333; margin-bottom: 20px; font-size: 24px; }
        p { color: #666; font-size: 16px; line-height: 1.6; }
        .icon { font-size: 64px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">⏳</div>
        <h1>Нет активных оплат</h1>
        <p>Пожалуйста, запустите оплату на терминале и отсканируйте QR-код заново.</p>
    </div>
</body>
</html>
        '''), 404
    
    # Показываем страницу оплаты для найденного терминала
    terminal = terminals[active_terminal]
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    amount = current.get('data', {}).get('amount', '0')
    state = current.get('state', 'idle')
    
    # Страница оплаты (без проверки пароля для универсального URL)
    return render_template_string('''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>СберЭкран - Оплата {{ amount }} ₽</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'SB Sans Text', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 400px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .logo { font-size: 48px; margin-bottom: 20px; }
        h1 { color: #333; margin-bottom: 10px; font-size: 28px; }
        .amount {
            font-size: 48px;
            font-weight: bold;
            color: #667eea;
            margin: 20px 0;
        }
        .terminal { color: #999; font-size: 14px; margin-bottom: 30px; }
        .btn {
            width: 100%;
            padding: 18px;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 12px;
        }
        .btn-pay {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-pay:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4); }
        .btn-pay:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        .btn-cancel {
            background: #f5f5f5;
            color: #666;
        }
        .btn-cancel:hover { background: #e0e0e0; }
        .status {
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            font-size: 16px;
            display: none;
        }
        .status.success { background: #d4edda; color: #155724; display: block; }
        .status.error { background: #f8d7da; color: #721c24; display: block; }
        .status.waiting { background: #fff3cd; color: #856404; display: block; }
        .loader {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #667eea;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
            display: none;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">💳</div>
        <h1>Оплата по QR-коду</h1>
        <div class="amount">{{ amount }} ₽</div>
        <div class="terminal">Терминал: {{ terminal_id }}</div>
        
        <button class="btn btn-pay" id="payBtn" onclick="pay()">Оплатить</button>
        <button class="btn btn-cancel" onclick="cancel()">Отменить</button>
        
        <div class="loader" id="loader"></div>
        <div class="status" id="status"></div>
    </div>

    <script>
        const terminalId = '{{ terminal_id }}';

        function showStatus(message, type) {
            const status = document.getElementById('status');
            status.textContent = message;
            status.className = 'status ' + type;
        }

        function showLoader(show) {
            document.getElementById('loader').style.display = show ? 'block' : 'none';
        }

        async function pay() {
            const btn = document.getElementById('payBtn');
            btn.disabled = true;
            showLoader(true);
            showStatus('Переключение терминала на ожидание...', 'waiting');

            try {
                const response = await fetch('/api/qr/initiate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ terminal_id: terminalId })
                });

                const data = await response.json();
                
                if (data.success) {
                    showStatus('Ожидание подтверждения кассира...', 'waiting');
                    startPolling();
                } else {
                    showStatus('Ошибка: ' + (data.message || 'Неизвестная ошибка'), 'error');
                    btn.disabled = false;
                    showLoader(false);
                }
            } catch (error) {
                showStatus('Ошибка соединения с сервером', 'error');
                btn.disabled = false;
                showLoader(false);
            }
        }

        function startPolling() {
            const pollInterval = setInterval(async () => {
                try {
                    const response = await fetch('/api/qr/check?terminal_id=' + terminalId);
                    const data = await response.json();
                    
                    if (data.status === 'success') {
                        clearInterval(pollInterval);
                        showLoader(false);
                        showStatus('✅ Оплата успешна!', 'success');
                        setTimeout(() => window.close(), 2000);
                    } else if (data.status === 'failed') {
                        clearInterval(pollInterval);
                        showLoader(false);
                        showStatus('❌ Оплата отклонена', 'error');
                        setTimeout(() => window.close(), 2000);
                    }
                } catch (error) {
                    console.error('Polling error:', error);
                }
            }, 1000);
        }

        function cancel() {
            window.close();
        }
    </script>
</body>
</html>
    ''', terminal_id=active_terminal, amount=amount)

@app.route('/api/qr/initiate', methods=['POST'])
def qr_initiate():
    """Инициировать QR-оплату - переключить терминал на сцену ожидания"""
    data = request.json
    terminal_id = data.get('terminal_id')
    qr_password = data.get('password', '')  # Получаем пароль от клиента
    
    if not terminal_id or terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found', 'success': False}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверяем что терминал в состоянии оплаты
    current_state = terminal.get('current_payload', {}).get('state', 'idle')
    if current_state not in ['pay', 'payPending']:
        return jsonify({'error': 'Not in payment state', 'success': False}), 400
    
    # Сохраняем пароль если передан
    if qr_password:
        terminal['qr_password'] = qr_password
        print(f"🔐 [QR INITIATE] {terminal_id}: Password set to {qr_password}")
    
    # Переключаем терминал на сцену ожидания (payPending)
    current_amount = terminal.get('current_payload', {}).get('data', {}).get('amount', '0')
    terminal['current_payload'] = {
        'state': 'payPending',
        'data': {
            'amount': current_amount,
            'content': '',
            'buttons': ''
        }
    }
    
    # Инициализируем QR статус
    terminal['qr_status'] = {
        'pending': True,
        'approved': False,
        'initiated_at': datetime.now().isoformat()
    }
    
    device_states[terminal_id] = {
        'state': 'payPending',
        'amount': current_amount,
        'last_update': datetime.now().isoformat()
    }
    
    print(f"📱 [QR INITIATE] {terminal_id}: Switched to payPending, waiting for confirmation")
    
    # Проверяем включен ли обход проверки карты/лица
    bypass_card_check = terminal.get('bypass_card_check', False)
    if bypass_card_check:
        # Запускаем таймер автоподтверждения через 3 секунды
        def auto_confirm():
            print(f"⏱️  [BYPASS] {terminal_id}: Starting 3s countdown...")
            time.sleep(3)
            if terminal_id in terminals:
                term = terminals[terminal_id]
                current = term.get('current_payload', {}).get('state', 'idle')
                print(f"⏱️  [BYPASS] {terminal_id}: After 3s - state={current}, processed={term.get('payment_processed', False)}")
                
                # Проверяем что терминал все еще в payPending и оплата не обработана
                if current == 'payPending' and not term.get('payment_processed', False):
                    # Обновляем card_status
                    term['card_status'] = {
                        'pending': False,
                        'approved': True
                    }
                    # Обновляем qr_status (для совместимости)
                    term['qr_status'] = {
                        'pending': False,
                        'approved': True
                    }
                    term['payment_processed'] = True
                    add_transaction(terminal_id, current_amount, 'card', 'success')
                    print(f"💳 [BYPASS] {terminal_id}: Auto-approved payment after 3s (bypass enabled)")
                    # Автоматически сбросить в idle через 5 секунд
                    auto_reset_to_idle(terminal_id, delay=5)
                else:
                    print(f"⚠️  [BYPASS] {terminal_id}: Conditions not met - state={current}, processed={term.get('payment_processed', False)}")
        
        threading.Thread(target=auto_confirm, daemon=True).start()
        print(f"⏱️  [BYPASS] {terminal_id}: Auto-confirm timer started (3s)")
    
    return jsonify({'success': True}), 200

@app.route('/api/qr/check', methods=['GET'])
def qr_check():
    """Проверить статус QR-оплаты (для веб-страницы)"""
    terminal_id = request.args.get('terminal_id')
    
    if not terminal_id or terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    qr_status_data = terminal.get('qr_status', {'pending': True, 'approved': False})
    
    # Определяем статус для веб-страницы
    if qr_status_data.get('pending', True):
        status = 'pending'
    elif qr_status_data.get('approved', False):
        status = 'success'
    else:
        status = 'failed'
    
    return jsonify({
        'success': True,
        'status': status,
        'pending': qr_status_data.get('pending', True),
        'approved': qr_status_data.get('approved', False)
    }), 200

@app.route('/')
def index():
    return jsonify({
        'status': 'running',
        'endpoints': [
            'POST /api/register_device - Register new terminal',
            'POST /login - Login terminal',
            'GET /api/payload - Get payload',
            'POST /api/payload - Set payload',
            'GET /api/card/status - Get card confirmation status',
            'GET /api/face/status - Get face confirmation status',
            'POST /api/face/upload - Upload face image for payment',
            'GET /api/qr/status - Get QR payment status',
            'POST /api/qr/initiate - Initiate QR payment',
            'GET /api/qr/check - Check QR payment status (web)',
            'GET /p/<terminal_id> - QR payment page',
            'POST /admin/set_device_payload',
            'POST /admin/reset',
            'POST /admin/set_face_confirm',
            'POST /admin/confirm_card',
            'POST /admin/confirm_face',
            'POST /admin/confirm_qr - Confirm/decline QR payment',
            'POST /admin/delete_terminal - Delete terminal',
            'GET /admin/status',
            '--- Personal Cabinet ---',
            'POST /cabinet/register - Register user',
            'POST /cabinet/login - Login user',
            'POST /cabinet/bind_terminal - Bind terminal to user',
            'GET /cabinet/terminals - Get user terminals',
            'GET /cabinet/stats/<terminal_id> - Get terminal statistics',
            'POST /cabinet/shift/open - Open shift',
            'POST /cabinet/shift/close - Close shift',
            'GET /cabinet/shift/status - Get shift status'
        ],
        'terminals_count': len(terminals)
    }), 200

@app.route('/api/qr/generate', methods=['GET'])
def qr_generate():
    """Сгенерировать QR-код для оплаты"""
    terminal_id = request.args.get('terminal_id')
    uuid_param = request.args.get('uuid')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    terminal = terminals[terminal_id]
    
    # Проверка UUID
    if uuid_param and terminal.get('uuid') != uuid_param:
        return jsonify({'error': 'Invalid UUID'}), 403
    
    if not QRCODE_AVAILABLE:
        return jsonify({'error': 'QR code generation not available'}), 503
    
    # Получаем текущую сумму оплаты
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    amount = current.get('data', {}).get('amount', '0')
    
    # Генерируем URL для оплаты
    # Используем универсальный URL /pay который автоматически найдет активный терминал
    base_url = request.host_url.rstrip('/')
    payment_url = f"{base_url}/pay"
    
    # Генерируем QR-код
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(payment_url)
    qr.make(fit=True)
    
    img = qr.make_image(fill_color="black", back_color="white")
    
    # Сохраняем в BytesIO
    img_io = BytesIO()
    img.save(img_io, 'PNG')
    img_io.seek(0)
    
    print(f"🔲 [QR GENERATE] {terminal_id}: Generated QR for {payment_url}")
    
    return send_file(img_io, mimetype='image/png')

# ===== ЛИЧНЫЙ КАБИНЕТ =====

@app.route('/cabinet/register', methods=['POST'])
def cabinet_register():
    """Регистрация пользователя"""
    data = request.json
    username = data.get('username')
    password = data.get('password')
    
    if not username or not password:
        return jsonify({'error': 'Missing username or password'}), 400
    
    if username in users:
        return jsonify({'error': 'User already exists'}), 409
    
    user_id = str(uuid.uuid4())
    users[username] = {
        'user_id': user_id,
        'password': password,
        'terminals': [],
        'balance': 0,  # Начальный баланс
        'created_at': datetime.now().isoformat()
    }
    
    save_users()
    print(f"👤 [REGISTER] New user: {username}")
    
    return jsonify({'success': True, 'user_id': user_id}), 201

@app.route('/cabinet/login', methods=['POST'])
def cabinet_login():
    """Вход в личный кабинет"""
    data = request.json
    username = data.get('username')
    password = data.get('password')
    
    if not username or not password:
        return jsonify({'error': 'Missing credentials'}), 400
    
    user = users.get(username)
    if not user or user['password'] != password:
        return jsonify({'error': 'Invalid credentials'}), 401
    
    # Создаём сессию
    session_id = str(uuid.uuid4())
    sessions[session_id] = {
        'user_id': user['user_id'],
        'username': username,
        'authenticated': True,
        'type': 'user'  # отличаем от терминальной сессии
    }
    
    print(f"👤 [LOGIN] User logged in: {username}")
    
    response = make_response(jsonify({'success': True}))
    response.set_cookie('session_id', session_id)
    
    return response

@app.route('/cabinet/bind_terminal', methods=['POST'])
def cabinet_bind_terminal():
    """Привязать терминал к пользователю"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    data = request.json
    terminal_id = data.get('terminal_id')
    terminal_password = data.get('password')
    
    if not terminal_id or not terminal_password:
        return jsonify({'error': 'Missing terminal_id or password'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    if terminals[terminal_id]['password'] != terminal_password:
        return jsonify({'error': 'Invalid terminal password'}), 403
    
    # Проверяем что терминал еще не привязан
    if 'owner_id' in terminals[terminal_id]:
        return jsonify({'error': 'Terminal already bound to another user'}), 409
    
    # Привязываем терминал
    username = session['username']
    terminals[terminal_id]['owner_id'] = users[username]['user_id']
    users[username]['terminals'].append(terminal_id)
    
    save_terminals()
    save_users()
    
    print(f"🔗 [BIND] Terminal {terminal_id} bound to user {username}")
    
    return jsonify({'success': True}), 200

@app.route('/cabinet/unbind_terminal', methods=['POST'])
def cabinet_unbind_terminal():
    """Отвязать терминал от пользователя"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    data = request.json
    terminal_id = data.get('terminal_id')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    username = session['username']
    user_id = users[username]['user_id']
    
    # Проверяем что терминал принадлежит этому пользователю
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Terminal not owned by user'}), 403
    
    # Отвязываем терминал
    if terminal_id in terminals:
        terminals[terminal_id].pop('owner_id', None)
        save_terminals()
    
    users[username]['terminals'].remove(terminal_id)
    save_users()
    
    print(f"🔓 [UNBIND] Terminal {terminal_id} unbound from user {username}")
    
    return jsonify({'success': True}), 200

@app.route('/admin/force_unbind_terminal', methods=['POST'])
@require_auth
def admin_force_unbind_terminal(session):
    """Принудительно отвязать терминал (для админов)"""
    data = request.json
    terminal_id = data.get('terminal_id')
    
    if not terminal_id:
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Находим владельца
    owner_id = terminals[terminal_id].get('owner_id')
    if owner_id:
        # Удаляем из списка терминалов пользователя
        for username, user_data in users.items():
            if user_data.get('user_id') == owner_id and terminal_id in user_data.get('terminals', []):
                user_data['terminals'].remove(terminal_id)
                save_users()
                break
    
    # Отвязываем терминал
    terminals[terminal_id].pop('owner_id', None)
    save_terminals()
    
    print(f"🔓 [FORCE UNBIND] Terminal {terminal_id} force unbound")
    
    return jsonify({'success': True, 'message': f'Terminal {terminal_id} unbound'}), 200

@app.route('/cabinet/terminals', methods=['GET'])
def cabinet_terminals():
    """Получить список терминалов пользователя"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user_terminals = users[username]['terminals']
    favorites = users[username].get('favorites', [])
    
    terminals_data = []
    for terminal_id in user_terminals:
        if terminal_id in terminals:
            terminal = terminals[terminal_id]
            shift_status = shifts.get(terminal_id, {})
            
            terminals_data.append({
                'terminal_id': terminal_id,
                'current_state': terminal.get('current_payload', {}).get('state', 'idle'),
                'shift_opened': bool(shift_status.get('opened_at') and not shift_status.get('closed_at')),
                'shift_transactions': shift_status.get('transactions_count', 0),
                'shift_total': shift_status.get('total_amount', 0),
                'is_favorite': terminal_id in favorites
            })
    
    return jsonify({'terminals': terminals_data, 'favorites': favorites}), 200

@app.route('/cabinet/stats/<terminal_id>', methods=['GET'])
def cabinet_stats(terminal_id):
    """Получить статистику терминала"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    
    # Проверяем что терминал принадлежит пользователю
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Access denied'}), 403
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found'}), 404
    
    # Получаем транзакции
    terminal_transactions = transactions.get(terminal_id, [])
    
    # Статистика
    total_transactions = len(terminal_transactions)
    successful_transactions = len([t for t in terminal_transactions if t['status'] == 'success'])
    total_amount = sum(float(t['amount']) for t in terminal_transactions if t['status'] == 'success')
    
    # Группировка по типам оплаты
    by_type = {}
    for t in terminal_transactions:
        payment_type = t['type']
        if payment_type not in by_type:
            by_type[payment_type] = {'count': 0, 'amount': 0}
        by_type[payment_type]['count'] += 1
        if t['status'] == 'success':
            by_type[payment_type]['amount'] += float(t['amount'])
    
    # Статус смены
    shift = shifts.get(terminal_id, {})
    
    return jsonify({
        'terminal_id': terminal_id,
        'total_transactions': total_transactions,
        'successful_transactions': successful_transactions,
        'failed_transactions': total_transactions - successful_transactions,
        'total_amount': total_amount,
        'by_type': by_type,
        'shift': {
            'opened': bool(shift.get('opened_at') and not shift.get('closed_at')),
            'opened_at': shift.get('opened_at'),
            'closed_at': shift.get('closed_at'),
            'transactions_count': shift.get('transactions_count', 0),
            'total_amount': shift.get('total_amount', 0)
        },
        'recent_transactions': terminal_transactions[-10:]  # последние 10
    }), 200

@app.route('/cabinet/shift/open', methods=['POST'])
def cabinet_shift_open():
    """Открыть смену"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    data = request.json
    terminal_id = data.get('terminal_id')
    
    username = session['username']
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Access denied'}), 403
    
    # Проверяем что смена не открыта
    if terminal_id in shifts and shifts[terminal_id].get('opened_at') and not shifts[terminal_id].get('closed_at'):
        return jsonify({'error': 'Shift already opened'}), 400
    
    shifts[terminal_id] = {
        'opened_at': datetime.now().isoformat(),
        'closed_at': None,
        'transactions_count': 0,
        'total_amount': 0
    }
    
    save_shifts()
    print(f"📅 [SHIFT] Opened for {terminal_id}")
    
    return jsonify({'success': True}), 200

@app.route('/cabinet/shift/close', methods=['POST'])
def cabinet_shift_close():
    """Закрыть смену"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    data = request.json
    terminal_id = data.get('terminal_id')
    
    username = session['username']
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Access denied'}), 403
    
    # Проверяем что смена открыта
    if terminal_id not in shifts or not shifts[terminal_id].get('opened_at') or shifts[terminal_id].get('closed_at'):
        return jsonify({'error': 'No open shift'}), 400
    
    shifts[terminal_id]['closed_at'] = datetime.now().isoformat()
    save_shifts()
    
    print(f"📅 [SHIFT] Closed for {terminal_id}")
    
    return jsonify({
        'success': True,
        'shift': shifts[terminal_id]
    }), 200

@app.route('/cabinet/shift/status', methods=['GET'])
def cabinet_shift_status():
    """Получить статус смены"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    terminal_id = request.args.get('terminal_id')
    
    username = session['username']
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Access denied'}), 403
    
    shift = shifts.get(terminal_id, {})
    
    return jsonify({
        'opened': bool(shift.get('opened_at') and not shift.get('closed_at')),
        'shift': shift
    }), 200

@app.route('/cabinet/balance', methods=['GET'])
def cabinet_balance():
    """Получить баланс пользователя"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user = users[username]
    user_id = user['user_id']
    
    # История баланса
    history = balance_history.get(user_id, [])
    
    return jsonify({
        'balance': user.get('balance', 0),
        'history': history[-20:]  # последние 20 операций
    }), 200

@app.route('/cabinet/terminal/<terminal_id>/favorite', methods=['POST'])
def toggle_favorite(terminal_id):
    """Добавить/удалить терминал из избранного"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    
    # Проверяем что терминал принадлежит пользователю
    if terminal_id not in users[username]['terminals']:
        return jsonify({'error': 'Access denied'}), 403
    
    # Получаем текущий список избранных
    favorites = users[username].get('favorites', [])
    
    # Переключаем статус
    if terminal_id in favorites:
        favorites.remove(terminal_id)
        is_favorite = False
    else:
        favorites.append(terminal_id)
        is_favorite = True
    
    users[username]['favorites'] = favorites
    save_users()
    
    print(f"⭐ [FAVORITE] {username}: {terminal_id} {'added to' if is_favorite else 'removed from'} favorites")
    
    return jsonify({'success': True, 'is_favorite': is_favorite}), 200

@app.route('/cabinet/analytics', methods=['GET'])
def cabinet_analytics():
    """Получить аналитику по всем терминалам пользователя"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user_terminals = users[username]['terminals']
    
    period = request.args.get('period', 'day')  # day, week, month
    date_from = request.args.get('date_from')
    date_to = request.args.get('date_to')
    
    # Собираем все транзакции пользователя
    all_transactions = []
    for terminal_id in user_terminals:
        if terminal_id in transactions:
            for t in transactions[terminal_id]:
                t_copy = t.copy()
                t_copy['terminal_id'] = terminal_id
                all_transactions.append(t_copy)
    
    # Фильтруем по датам если указаны
    if date_from:
        all_transactions = [t for t in all_transactions if t['timestamp'] >= date_from]
    if date_to:
        all_transactions = [t for t in all_transactions if t['timestamp'] <= date_to + 'T23:59:59']
    
    # Группируем по периодам
    from collections import defaultdict
    grouped = defaultdict(lambda: {'success': 0, 'failed': 0, 'amount': 0})
    
    for t in all_transactions:
        dt = datetime.fromisoformat(t['timestamp'])
        
        if period == 'day':
            key = dt.strftime('%Y-%m-%d')
        elif period == 'week':
            key = dt.strftime('%Y-W%W')
        else:  # month
            key = dt.strftime('%Y-%m')
        
        if t['status'] == 'success':
            grouped[key]['success'] += 1
            grouped[key]['amount'] += float(t['amount'])
        else:
            grouped[key]['failed'] += 1
    
    # Топ терминалов по выручке
    terminal_revenue = defaultdict(lambda: {'amount': 0, 'count': 0})
    for t in all_transactions:
        if t['status'] == 'success':
            terminal_revenue[t['terminal_id']]['amount'] += float(t['amount'])
            terminal_revenue[t['terminal_id']]['count'] += 1
    
    top_terminals = sorted(
        [{'terminal_id': k, 'amount': v['amount'], 'count': v['count']} 
         for k, v in terminal_revenue.items()],
        key=lambda x: x['amount'],
        reverse=True
    )[:10]
    
    # Конверсия по типам оплаты
    by_type = defaultdict(lambda: {'success': 0, 'failed': 0})
    for t in all_transactions:
        by_type[t['type']][t['status']] += 1
    
    conversion = {}
    for payment_type, stats in by_type.items():
        total = stats['success'] + stats['failed']
        conversion[payment_type] = {
            'rate': (stats['success'] / total * 100) if total > 0 else 0,
            'success': stats['success'],
            'failed': stats['failed']
        }
    
    return jsonify({
        'chart_data': dict(grouped),
        'top_terminals': top_terminals,
        'conversion': conversion
    }), 200

@app.route('/cabinet/export/transactions', methods=['GET'])
def export_transactions():
    """Экспорт транзакций в Excel или CSV"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user_terminals = users[username]['terminals']
    export_format = request.args.get('format', 'csv')  # csv или xlsx
    terminal_id = request.args.get('terminal_id')  # опционально
    
    # Собираем транзакции
    all_transactions = []
    if terminal_id and terminal_id in user_terminals:
        # Экспорт одного терминала
        if terminal_id in transactions:
            for t in transactions[terminal_id]:
                t_copy = t.copy()
                t_copy['terminal_id'] = terminal_id
                all_transactions.append(t_copy)
    else:
        # Экспорт всех терминалов
        for tid in user_terminals:
            if tid in transactions:
                for t in transactions[tid]:
                    t_copy = t.copy()
                    t_copy['terminal_id'] = tid
                    all_transactions.append(t_copy)
    
    # Сортируем по дате
    all_transactions.sort(key=lambda x: x['timestamp'], reverse=True)
    
    if export_format == 'xlsx':
        # Excel экспорт
        try:
            from openpyxl import Workbook
            from openpyxl.styles import Font, PatternFill
            
            wb = Workbook()
            ws = wb.active
            ws.title = "Транзакции"
            
            # Заголовки
            headers = ['Дата и время', 'Терминал', 'Сумма (₽)', 'Тип оплаты', 'Статус']
            ws.append(headers)
            
            # Стиль заголовков
            for cell in ws[1]:
                cell.font = Font(bold=True)
                cell.fill = PatternFill(start_color="667eea", end_color="667eea", fill_type="solid")
            
            # Данные
            for t in all_transactions:
                ws.append([
                    t['timestamp'],
                    t['terminal_id'],
                    float(t['amount']),
                    t['type'],
                    'Успешно' if t['status'] == 'success' else 'Неудачно'
                ])
            
            # Сохраняем в память
            output = BytesIO()
            wb.save(output)
            output.seek(0)
            
            response = make_response(output.read())
            response.headers['Content-Type'] = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            response.headers['Content-Disposition'] = f'attachment; filename=transactions_{datetime.now().strftime("%Y%m%d_%H%M%S")}.xlsx'
            
            return response
        except ImportError:
            return jsonify({'error': 'openpyxl not installed'}), 500
    
    else:
        # CSV экспорт
        import csv
        
        output = BytesIO()
        writer = csv.writer(output)
        
        # Заголовки
        writer.writerow(['Дата и время', 'Терминал', 'Сумма (₽)', 'Тип оплаты', 'Статус'])
        
        # Данные
        for t in all_transactions:
            writer.writerow([
                t['timestamp'],
                t['terminal_id'],
                t['amount'],
                t['type'],
                'Успешно' if t['status'] == 'success' else 'Неудачно'
            ])
        
        output.seek(0)
        response = make_response(output.read().decode('utf-8'))
        response.headers['Content-Type'] = 'text/csv; charset=utf-8'
        response.headers['Content-Disposition'] = f'attachment; filename=transactions_{datetime.now().strftime("%Y%m%d_%H%M%S")}.csv'
        
        return response

@app.route('/cabinet/support/messages', methods=['GET'])
def get_support_messages():
    """Получить сообщения чата поддержки"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user = users.get(username)
    
    # Проверяем блокировку
    try:
        with open('users.json', 'r') as f:
            bot_users = json.load(f)
            telegram_id = user.get('telegram_id')
            if telegram_id and telegram_id in bot_users.get('blocked', []):
                return jsonify({'error': 'Вы заблокированы в боте', 'blocked': True}), 403
    except Exception:
        pass
    
    # Загружаем сообщения из заявки
    messages = []
    try:
        with open('tickets.json', 'r') as f:
            tickets = json.load(f)
            telegram_id = user.get('telegram_id')
            
            # Ищем заявку пользователя
            for tid, ticket in tickets.items():
                if ticket.get('user_id') == telegram_id or ticket.get('username') == username:
                    # Добавляем описание как первое сообщение
                    messages.append({
                        'message': ticket.get('description', ''),
                        'is_admin': False,
                        'timestamp': datetime.fromtimestamp(ticket.get('created_at', 0)).isoformat()
                    })
                    
                    # Добавляем все сообщения из истории
                    for msg in ticket.get('messages', []):
                        messages.append({
                            'message': msg.get('text', ''),
                            'is_admin': msg.get('from') == 'admin',
                            'timestamp': datetime.fromtimestamp(msg.get('timestamp', 0)).isoformat()
                        })
                    break
    except Exception as e:
        print(f"❌ Ошибка загрузки заявок: {e}")
    
    # Также загружаем из БД (для совместимости)
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('''
                SELECT message, is_admin, created_at 
                FROM support_messages 
                WHERE username = %s 
                ORDER BY created_at ASC
            ''', (username,))
            rows = cur.fetchall()
            db_messages = [{'message': r[0], 'is_admin': r[1], 'timestamp': r[2].isoformat()} for r in rows]
            
            # Объединяем сообщения (избегаем дубликатов)
            for db_msg in db_messages:
                if not any(m['message'] == db_msg['message'] and m['timestamp'] == db_msg['timestamp'] for m in messages):
                    messages.append(db_msg)
            
            cur.close()
            conn.close()
        except Exception as e:
            print(f"❌ Ошибка загрузки из БД: {e}")
    
    # Сортируем по времени
    messages.sort(key=lambda x: x['timestamp'])
    
    return jsonify({'messages': messages}), 200

@app.route('/cabinet/support/send', methods=['POST'])
def send_support_message():
    """Отправить сообщение в поддержку"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    data = request.json
    message = data.get('message', '').strip()
    
    if not message:
        return jsonify({'error': 'Empty message'}), 400
    
    # Получаем user_id пользователя
    user = users.get(username)
    if not user:
        return jsonify({'error': 'User not found'}), 404
    
    # Проверяем заблокирован ли пользователь в боте
    try:
        import requests
        BOT_TOKEN = os.environ.get('SUPPORT_BOT_TOKEN', '8742060687:AAHfsRrh1EKju-ZZ3CLHb2cBl-CkM63fByc')
        
        # Проверяем блокировку через файл users.json бота
        try:
            with open('users.json', 'r') as f:
                bot_users = json.load(f)
                # Ищем telegram_id пользователя по username
                telegram_id = user.get('telegram_id')
                if telegram_id and telegram_id in bot_users.get('blocked', []):
                    return jsonify({'error': 'Вы заблокированы в боте'}), 403
        except Exception:
            pass
        
        # Загружаем или создаем заявку
        try:
            with open('tickets.json', 'r') as f:
                tickets = json.load(f)
        except Exception:
            tickets = {}
        
        # Ищем открытую заявку пользователя или создаем новую
        user_ticket_id = None
        telegram_id = user.get('telegram_id')
        
        if telegram_id:
            for tid, ticket in tickets.items():
                if ticket.get('user_id') == telegram_id and ticket.get('status') in ['open', 'in_progress']:
                    user_ticket_id = tid
                    break
        
        if not user_ticket_id:
            # Создаем новую заявку
            ticket_id = max([int(k) for k in tickets.keys()], default=0) + 1
            user_ticket_id = str(ticket_id)
            
            tickets[user_ticket_id] = {
                'user_id': telegram_id or 0,
                'username': username,
                'first_name': username,
                'description': message,
                'status': 'open',
                'created_at': time.time(),
                'messages': [],
                'from_web': True
            }
            
            print(f"🆕 [SUPPORT] Created new ticket #{user_ticket_id} from web for {username}")
            
            # Уведомляем админов через Telegram с кнопками
            try:
                with open('users.json', 'r') as f:
                    bot_users = json.load(f)
                    admins = bot_users.get('admins', [])
                    
                    print(f"📢 [SUPPORT] Notifying {len(admins)} admins about ticket #{user_ticket_id}")
                    
                    # Создаем inline клавиатуру с кнопками
                    keyboard = {
                        'inline_keyboard': [
                            [{'text': '✅ Принять', 'callback_data': f'accept_{user_ticket_id}'}],
                        ]
                    }
                    
                    for admin_id in admins:
                        try:
                            response = requests.post(
                                f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage',
                                json={
                                    'chat_id': admin_id,
                                    'text': f"🆕 🌐 Заявка #{user_ticket_id}\n"
                                           f"От: {username} (веб-кабинет)\n"
                                           f"Статус: open\n"
                                           f"Создана: {datetime.now().strftime('%d.%m.%Y %H:%M')}\n\n"
                                           f"📝 {message}",
                                    'reply_markup': keyboard
                                }
                            )
                            if response.status_code == 200:
                                print(f"✅ [SUPPORT] Notified admin {admin_id}")
                            else:
                                print(f"❌ [SUPPORT] Failed to notify admin {admin_id}: {response.text}")
                        except Exception as e:
                            print(f"❌ [SUPPORT] Error notifying admin {admin_id}: {e}")
            except Exception as e:
                print(f"❌ [SUPPORT] Error loading admins: {e}")
        else:
            # Добавляем сообщение к существующей заявке
            tickets[user_ticket_id]['messages'].append({
                'from': 'user',
                'user_id': telegram_id or 0,
                'text': message,
                'timestamp': time.time(),
                'from_web': True
            })
            
            # Уведомляем назначенного админа
            assigned_to = tickets[user_ticket_id].get('assigned_to')
            if assigned_to:
                try:
                    requests.post(
                        f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage',
                        json={
                            'chat_id': assigned_to,
                            'text': f"💬 {username} ответил на заявку #{user_ticket_id} (из веб-кабинета):\n\n{message}"
                        }
                    )
                except Exception:
                    pass
        
        # Сохраняем заявки
        with open('tickets.json', 'w', encoding='utf-8') as f:
            json.dump(tickets, f, ensure_ascii=False, indent=2)
        
        print(f"💾 [SUPPORT] Saved ticket #{user_ticket_id} to tickets.json")
        
        # Сохраняем в БД для отображения в веб-интерфейсе
        if DATABASE_URL and PSYCOPG_AVAILABLE:
            try:
                conn = get_db_connection()
                cur = conn.cursor()
                cur.execute('''
                    INSERT INTO support_messages (username, message, is_admin, created_at)
                    VALUES (%s, %s, FALSE, CURRENT_TIMESTAMP)
                ''', (username, message))
                conn.commit()
                cur.close()
                conn.close()
            except Exception as e:
                print(f"❌ Ошибка сохранения в БД: {e}")
        
        print(f"💬 [SUPPORT] {username}: {message} (ticket #{user_ticket_id})")
        
        return jsonify({'success': True, 'ticket_id': user_ticket_id}), 200
        
    except Exception as e:
        print(f"❌ Ошибка отправки в бот: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/cabinet/faq', methods=['GET'])
def get_faq():
    """Получить FAQ"""
    # Простой статический FAQ
    faq = [
        {
            'question': 'Как привязать терминал?',
            'answer': 'Введите ID терминала (TRM-####) и пароль в разделе "Привязать терминал".'
        },
        {
            'question': 'Как открыть смену?',
            'answer': 'Выберите терминал и нажмите "Открыть смену" в разделе управления сменой.'
        },
        {
            'question': 'Как экспортировать транзакции?',
            'answer': 'Перейдите в раздел "Аналитика" и нажмите кнопку "Скачать Excel" или "Скачать CSV".'
        },
        {
            'question': 'Что делать если терминал не отвечает?',
            'answer': 'Проверьте интернет-соединение терминала. Если проблема сохраняется, обратитесь в поддержку через чат.'
        },
        {
            'question': 'Как посмотреть статистику?',
            'answer': 'Нажмите "Подробнее" на карточке терминала или перейдите в раздел "Аналитика" для общей статистики.'
        }
    ]
    return jsonify({'faq': faq}), 200

@app.route('/cabinet/news', methods=['GET'])
def get_news():
    """Получить новости"""
    # Простые статические новости
    news = [
        {
            'id': 1,
            'title': 'Добавлена темная тема',
            'content': 'Теперь вы можете переключаться между светлой и темной темой интерфейса.',
            'type': 'feature',
            'date': '2026-04-06'
        },
        {
            'id': 2,
            'title': 'Новая аналитика',
            'content': 'Доступны графики транзакций, рейтинг терминалов и анализ конверсии.',
            'type': 'feature',
            'date': '2026-04-06'
        },
        {
            'id': 3,
            'title': 'Экспорт в Excel и CSV',
            'content': 'Теперь можно экспортировать транзакции в удобном формате для анализа.',
            'type': 'feature',
            'date': '2026-04-06'
        },
        {
            'id': 4,
            'title': 'Чат с поддержкой',
            'content': 'Добавлен виджет чата для быстрой связи с технической поддержкой.',
            'type': 'feature',
            'date': '2026-04-06'
        }
    ]
    return jsonify({'news': news}), 200

@app.route('/static/logo.jpg')
def serve_logo():
    """Отдать логотип"""
    try:
        return send_file('static_logo.jpg', mimetype='image/jpeg')
    except Exception:
        return '', 404

@app.route('/cabinet')
def cabinet_page():
    """Страница личного кабинета"""
    return render_template_string('''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет - СберЭкран</title>
    <link rel="icon" type="image/jpeg" href="/static/logo.jpg">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        :root {
            --bg-gradient-start: #667eea;
            --bg-gradient-end: #764ba2;
            --card-bg: rgba(255, 255, 255, 0.95);
            --text-primary: #333;
            --text-secondary: #666;
            --border-color: #e0e0e0;
            --input-bg: white;
            --input-border: #e0e0e0;
            --stat-box-bg: rgba(102, 126, 234, 0.1);
            --stat-box-border: rgba(102, 126, 234, 0.2);
            --terminal-card-bg: rgba(102, 126, 234, 0.05);
            --transaction-success-bg: rgba(40, 167, 69, 0.1);
            --transaction-failed-bg: rgba(220, 53, 69, 0.1);
        }
        
        [data-theme="dark"] {
            --bg-gradient-start: #1a1a2e;
            --bg-gradient-end: #16213e;
            --card-bg: rgba(30, 30, 46, 0.95);
            --text-primary: #e0e0e0;
            --text-secondary: #b0b0b0;
            --border-color: #3a3a4a;
            --input-bg: #2a2a3a;
            --input-border: #3a3a4a;
            --stat-box-bg: rgba(102, 126, 234, 0.2);
            --stat-box-border: rgba(102, 126, 234, 0.3);
            --terminal-card-bg: rgba(102, 126, 234, 0.15);
            --transaction-success-bg: rgba(40, 167, 69, 0.2);
            --transaction-failed-bg: rgba(220, 53, 69, 0.2);
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'SB Sans Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%);
            min-height: 100vh;
            padding-bottom: 150px; /* Отступ для баннера */
            transition: background 0.3s ease;
        }
        .header {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            color: var(--text-primary);
            padding: 30px 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: background 0.3s ease, color 0.3s ease;
        }
        .logo-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        .logo-img {
            width: 100px;
            height: 100px;
            border-radius: 20px;
            object-fit: cover;
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.3);
            border: 4px solid white;
        }
        .header h1 {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
            font-weight: 700;
            margin: 0;
        }
        .user-info {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .balance-display {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 24px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 30px 20px; 
        }
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            border: 1px solid var(--border-color);
            transition: background 0.3s ease, border-color 0.3s ease;
        }
        .card h2 {
            color: var(--text-primary);
            margin-bottom: 20px;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: color 0.3s ease;
        }
        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.4);
        }
        .btn-success { 
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white; 
        }
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(40, 167, 69, 0.4);
        }
        .btn-danger { 
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white; 
        }
        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(220, 53, 69, 0.4);
        }
        .btn:active { transform: translateY(-1px); }
        .logout-btn {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 2px solid #dc3545;
            padding: 10px 20px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .logout-btn:hover {
            background: #dc3545;
            color: white;
            transform: translateY(-2px);
        }
        .terminal-card {
            background: var(--terminal-card-bg);
            border: 2px solid var(--border-color);
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        .terminal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .terminal-card.active { 
            border-color: #28a745;
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.1) 0%, rgba(32, 201, 151, 0.1) 100%);
        }
        .terminal-card h3 {
            color: #667eea;
            font-size: 20px;
            margin-bottom: 10px;
        }
        .stats { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); 
            gap: 20px; 
            margin-top: 20px; 
        }
        .stat-box {
            background: var(--stat-box-bg);
            padding: 25px;
            border-radius: 16px;
            text-align: center;
            border: 2px solid var(--stat-box-border);
            transition: all 0.3s;
        }
        .stat-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
        }
        .stat-value { 
            font-size: 36px; 
            font-weight: 700; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .stat-label { 
            color: var(--text-secondary); 
            font-size: 14px; 
            margin-top: 8px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--input-border);
            border-radius: 12px;
            font-size: 16px;
            margin-bottom: 15px;
            transition: all 0.3s;
            background: var(--input-bg);
            color: var(--text-primary);
        }
        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .hidden { display: none; }
        .transaction {
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s;
        }
        .transaction:hover {
            transform: translateX(5px);
        }
        .transaction.success { 
            background: var(--transaction-success-bg);
            border-left: 4px solid #28a745;
        }
        .transaction.failed { 
            background: var(--transaction-failed-bg);
            border-left: 4px solid #dc3545;
        }
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--card-bg);
            border: 2px solid var(--border-color);
            border-radius: 50px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 24px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            z-index: 1001;
        }
        .theme-toggle:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }
        
        /* Чат поддержки */
        .support-chat-btn {
            position: fixed;
            bottom: 170px;
            right: 20px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            font-size: 28px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            transition: all 0.3s;
            z-index: 1001;
        }
        .support-chat-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }
        .support-chat-window {
            position: fixed;
            bottom: 240px;
            right: 20px;
            width: 350px;
            height: 500px;
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            display: none;
            flex-direction: column;
            z-index: 1002;
            border: 2px solid var(--border-color);
        }
        .support-chat-window.open {
            display: flex;
        }
        .support-chat-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            border-radius: 18px 18px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .support-chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .support-message {
            padding: 10px 15px;
            border-radius: 12px;
            max-width: 80%;
            word-wrap: break-word;
        }
        .support-message.user {
            background: #667eea;
            color: white;
            align-self: flex-end;
        }
        .support-message.admin {
            background: var(--stat-box-bg);
            color: var(--text-primary);
            align-self: flex-start;
        }
        .support-chat-input {
            display: flex;
            gap: 10px;
            padding: 15px;
            border-top: 2px solid var(--border-color);
        }
        .support-chat-input input {
            flex: 1;
            margin-bottom: 0;
        }
        
        /* Уведомления */
        .notifications-btn {
            position: fixed;
            top: 20px;
            right: 100px;
            background: var(--card-bg);
            border: 2px solid var(--border-color);
            border-radius: 50px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 24px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            z-index: 1001;
        }
        .notifications-btn:hover {
            transform: scale(1.1);
        }
        .notifications-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }
        .notifications-panel {
            position: fixed;
            top: 80px;
            right: 20px;
            width: 350px;
            max-height: 500px;
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            display: none;
            flex-direction: column;
            z-index: 1002;
            border: 2px solid var(--border-color);
        }
        .notifications-panel.open {
            display: flex;
        }
        .notifications-header {
            padding: 15px;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .notifications-list {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
        }
        .notification-item {
            padding: 15px;
            background: var(--stat-box-bg);
            border-radius: 12px;
            margin-bottom: 10px;
            border-left: 4px solid #667eea;
            cursor: pointer;
            transition: all 0.3s;
        }
        .notification-item:hover {
            transform: translateX(-5px);
        }
        .notification-item.error {
            border-left-color: #dc3545;
        }
        .notification-item.warning {
            border-left-color: #ffc107;
        }
        .notification-item.success {
            border-left-color: #28a745;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card {
            animation: fadeIn 0.5s ease;
        }
    </style>
</head>
<body>
    <button class="theme-toggle" onclick="toggleTheme()" title="Переключить тему">🌙</button>
    
    <!-- Уведомления -->
    <button class="notifications-btn hidden" id="notificationsBtn" onclick="toggleNotifications()">
        🔔
        <span class="notifications-badge hidden" id="notificationsBadge">0</span>
    </button>
    <div class="notifications-panel" id="notificationsPanel">
        <div class="notifications-header">
            <span style="font-weight: bold; color: var(--text-primary);">🔔 Уведомления</span>
            <button onclick="clearNotifications()" style="background: none; border: none; color: var(--text-secondary); cursor: pointer; font-size: 14px;">Очистить</button>
        </div>
        <div class="notifications-list" id="notificationsList"></div>
    </div>
    
    <!-- Чат поддержки -->
    <button class="support-chat-btn hidden" id="supportChatBtn" onclick="toggleSupportChat()">💬</button>
    <div class="support-chat-window" id="supportChatWindow">
        <div class="support-chat-header">
            <span style="font-weight: bold;">💬 Поддержка</span>
            <button onclick="toggleSupportChat()" style="background: none; border: none; color: white; font-size: 24px; cursor: pointer;">×</button>
        </div>
        <div class="support-chat-messages" id="supportMessages"></div>
        <div class="support-chat-input">
            <input type="text" id="supportMessageInput" placeholder="Напишите сообщение..." onkeypress="if(event.key==='Enter') sendSupportMessage()">
            <button class="btn btn-primary" onclick="sendSupportMessage()" style="padding: 10px 20px; margin-bottom: 0;">➤</button>
        </div>
    </div>
    
    <div class="header">
        <div class="logo-container">
            <img src="/static/logo.jpg" alt="СберЭкран" class="logo-img">
            <h1>Личный кабинет СберЭкран</h1>
        </div>
        <div class="user-info">
            <p id="username" style="font-size: 18px; color: #666;"></p>
            <div id="balance" class="hidden balance-display">
                💰 <span id="balanceAmount">0</span> ₽
            </div>
            <button id="terminalsBtn" class="hidden btn" onclick="showTerminals()" style="padding: 10px 20px; background: #6c757d; color: white;">📱 Терминалы</button>
            <button id="analyticsBtn" class="hidden btn btn-primary" onclick="showAnalytics()" style="padding: 10px 20px;">📊 Аналитика</button>
            <button id="faqBtn" class="hidden btn" onclick="showFAQ()" style="padding: 10px 20px; background: #17a2b8; color: white;">❓ FAQ</button>
            <button id="newsBtn" class="hidden btn" onclick="showNews()" style="padding: 10px 20px; background: #ffc107; color: black;">📰 Новости</button>
            <button id="logoutBtn" class="hidden logout-btn" onclick="logout()">Выйти</button>
        </div>
    </div>

    <div class="container">
        <!-- Форма входа/регистрации -->
        <div id="authSection" class="card">
            <h2>Вход / Регистрация</h2>
            <input type="text" id="authUsername" placeholder="Имя пользователя">
            <input type="password" id="authPassword" placeholder="Пароль">
            <button class="btn btn-primary" onclick="login()">Войти</button>
            <button class="btn" onclick="register()">Регистрация</button>
        </div>

        <!-- Привязка терминала -->
        <div id="bindSection" class="card hidden">
            <h2>Привязать терминал</h2>
            <input type="text" id="bindTerminalId" placeholder="ID терминала (TRM-####)">
            <input type="password" id="bindPassword" placeholder="Пароль терминала">
            <button class="btn btn-primary" onclick="bindTerminal()">Привязать</button>
        </div>

        <!-- Аналитика -->
        <div id="analyticsSection" class="card hidden">
            <h2>📊 Аналитика</h2>
            
            <div style="display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap;">
                <select id="analyticsPeriod" onchange="loadAnalytics()" style="padding: 10px; border: 2px solid var(--border-color); border-radius: 8px; background: var(--input-bg); color: var(--text-primary);">
                    <option value="day">По дням</option>
                    <option value="week">По неделям</option>
                    <option value="month">По месяцам</option>
                </select>
                <input type="date" id="analyticsDateFrom" onchange="loadAnalytics()" style="padding: 10px; border: 2px solid var(--border-color); border-radius: 8px; background: var(--input-bg); color: var(--text-primary);">
                <input type="date" id="analyticsDateTo" onchange="loadAnalytics()" style="padding: 10px; border: 2px solid var(--border-color); border-radius: 8px; background: var(--input-bg); color: var(--text-primary);">
            </div>
            
            <div style="background: var(--card-bg); padding: 20px; border-radius: 16px; margin-bottom: 20px;">
                <canvas id="transactionsChart" style="max-height: 400px;"></canvas>
            </div>
            
            <h3>🏆 Топ терминалов по выручке</h3>
            <div id="terminalRanking" style="margin-bottom: 20px;"></div>
            
            <h3>📈 Конверсия платежей</h3>
            <div id="conversionStats" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;"></div>
            
            <h3 style="margin-top: 30px;">📥 Экспорт данных</h3>
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                <button class="btn btn-success" onclick="exportData('xlsx')">📊 Скачать Excel</button>
                <button class="btn btn-primary" onclick="exportData('csv')">📄 Скачать CSV</button>
            </div>
        </div>

        <!-- FAQ -->
        <div id="faqSection" class="card hidden">
            <h2>❓ Часто задаваемые вопросы</h2>
            <div id="faqList"></div>
        </div>

        <!-- Новости -->
        <div id="newsSection" class="card hidden">
            <h2>📰 Новости и обновления</h2>
            <div id="newsList"></div>
        </div>

        <!-- Список терминалов -->
        <div id="terminalsSection" class="card hidden">
            <h2>Мои терминалы</h2>
            
            <!-- Панель быстрых действий -->
            <div id="quickActions" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 30px; padding: 20px; background: var(--stat-box-bg); border-radius: 16px; border: 2px solid var(--stat-box-border);">
                <div style="text-align: center;">
                    <div style="font-size: 32px; font-weight: bold; color: #667eea;" id="openShiftsCount">0</div>
                    <div style="color: var(--text-secondary); font-size: 14px; margin-top: 5px;">Открытых смен</div>
                </div>
                <div style="text-align: center;">
                    <div style="font-size: 32px; font-weight: bold; color: #28a745;" id="activeTerminalsCount">0</div>
                    <div style="color: var(--text-secondary); font-size: 14px; margin-top: 5px;">Активных терминалов</div>
                </div>
                <div style="text-align: center;">
                    <div style="font-size: 32px; font-weight: bold; color: #ffc107;" id="todayTransactionsCount">0</div>
                    <div style="color: var(--text-secondary); font-size: 14px; margin-top: 5px;">Транзакций сегодня</div>
                </div>
            </div>
            
            <div id="terminalsList"></div>
        </div>

        <!-- Статистика выбранного терминала -->
        <div id="statsSection" class="card hidden">
            <h2>Статистика терминала <span id="selectedTerminal"></span></h2>
            <div class="stats" id="statsGrid"></div>
            
            <h3 style="margin-top: 20px;">Управление сменой</h3>
            <div id="shiftControls"></div>
            
            <h3 style="margin-top: 20px;">💳 Касса</h3>
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-bottom: 20px;">
                <button class="btn btn-success" onclick="sendPayment(100)">100 ₽</button>
                <button class="btn btn-success" onclick="sendPayment(200)">200 ₽</button>
                <button class="btn btn-success" onclick="sendPayment(500)">500 ₽</button>
                <button class="btn btn-success" onclick="sendPayment(1000)">1000 ₽</button>
                <button class="btn btn-success" onclick="sendPayment(2000)">2000 ₽</button>
                <button class="btn btn-success" onclick="sendPayment(5000)">5000 ₽</button>
            </div>
            <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                <input type="number" id="customAmount" placeholder="Своя сумма" style="flex: 1; padding: 10px; border: 2px solid #ddd; border-radius: 8px; font-size: 16px;">
                <button class="btn btn-primary" onclick="sendCustomPayment()">Отправить</button>
            </div>
            <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px;">
                <button class="btn" style="background: #28a745;" onclick="confirmCard(true)">✅ Подтвердить карту</button>
                <button class="btn" style="background: #dc3545;" onclick="confirmCard(false)">❌ Отклонить карту</button>
                <button class="btn" style="background: #ffc107; color: black;" onclick="cancelPayment()">🚫 Отменить операцию</button>
                <button class="btn" style="background: #17a2b8;" onclick="getStatus()">📊 Статус</button>
            </div>
            
            <h3 style="margin-top: 20px;">Последние транзакции</h3>
            
            <!-- Экспорт транзакций терминала -->
            <div style="margin-bottom: 15px;">
                <button class="btn" style="background: #28a745; color: white; padding: 8px 16px;" onclick="exportTerminalData('xlsx')">📊 Excel</button>
                <button class="btn" style="background: #17a2b8; color: white; padding: 8px 16px;" onclick="exportTerminalData('csv')">📄 CSV</button>
            </div>
            
            <!-- Поиск и фильтры -->
            <div style="margin-bottom: 20px; padding: 20px; background: var(--stat-box-bg); border-radius: 16px; border: 2px solid var(--stat-box-border);">
                <div style="display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 15px;">
                    <input type="text" id="searchAmount" placeholder="Поиск по сумме" style="flex: 1; min-width: 150px; margin-bottom: 0;">
                    <input type="date" id="searchDateFrom" placeholder="От даты" style="flex: 1; min-width: 150px; margin-bottom: 0;">
                    <input type="date" id="searchDateTo" placeholder="До даты" style="flex: 1; min-width: 150px; margin-bottom: 0;">
                </div>
                <div style="display: flex; gap: 10px; flex-wrap: wrap; align-items: center;">
                    <label style="display: flex; align-items: center; gap: 5px; color: var(--text-primary);">
                        <input type="checkbox" id="filterCard" checked onchange="applyFilters()"> Карта
                    </label>
                    <label style="display: flex; align-items: center; gap: 5px; color: var(--text-primary);">
                        <input type="checkbox" id="filterFace" checked onchange="applyFilters()"> Лицо
                    </label>
                    <label style="display: flex; align-items: center; gap: 5px; color: var(--text-primary);">
                        <input type="checkbox" id="filterQr" checked onchange="applyFilters()"> QR
                    </label>
                    <label style="display: flex; align-items: center; gap: 5px; color: var(--text-primary);">
                        <input type="checkbox" id="filterSuccess" checked onchange="applyFilters()"> Успешные
                    </label>
                    <label style="display: flex; align-items: center; gap: 5px; color: var(--text-primary);">
                        <input type="checkbox" id="filterFailed" checked onchange="applyFilters()"> Неудачные
                    </label>
                    <button class="btn" style="padding: 8px 16px; background: #dc3545; color: white;" onclick="clearFilters()">Очистить фильтры</button>
                </div>
                <div id="filterTags" style="display: flex; gap: 8px; flex-wrap: wrap; margin-top: 15px;"></div>
                <div style="margin-top: 10px; color: var(--text-secondary); font-size: 14px;">
                    Найдено: <span id="transactionsCount">0</span> транзакций
                </div>
            </div>
            
            <div id="transactionsList"></div>
        </div>
    </div>

    <script>
        let currentUser = null;
        let selectedTerminal = null;

        async function login() {
            const username = document.getElementById('authUsername').value;
            const password = document.getElementById('authPassword').value;

            const response = await fetch('/cabinet/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, password })
            });

            if (response.ok) {
                currentUser = username;
                document.getElementById('username').textContent = 'Пользователь: ' + username;
                document.getElementById('balance').classList.remove('hidden');
                document.getElementById('terminalsBtn').classList.remove('hidden');
                document.getElementById('analyticsBtn').classList.remove('hidden');
                document.getElementById('faqBtn').classList.remove('hidden');
                document.getElementById('newsBtn').classList.remove('hidden');
                document.getElementById('supportChatBtn').classList.remove('hidden');
                document.getElementById('notificationsBtn').classList.remove('hidden');
                document.getElementById('logoutBtn').classList.remove('hidden');
                document.getElementById('authSection').classList.add('hidden');
                document.getElementById('bindSection').classList.remove('hidden');
                document.getElementById('terminalsSection').classList.remove('hidden');
                loadTerminals();
                loadBalance();
            } else {
                alert('Ошибка входа');
            }
        }

        async function loadBalance() {
            const response = await fetch('/cabinet/balance');
            if (!response.ok) {
                return; // Игнорируем ошибки (например, 401 если не авторизован)
            }
            const data = await response.json();
            document.getElementById('balanceAmount').textContent = data.balance.toFixed(2);
        }

        async function register() {
            const username = document.getElementById('authUsername').value;
            const password = document.getElementById('authPassword').value;

            const response = await fetch('/cabinet/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, password })
            });

            if (response.ok) {
                alert('Регистрация успешна! Теперь войдите.');
            } else {
                const data = await response.json();
                alert('Ошибка: ' + data.error);
            }
        }

        async function bindTerminal() {
            const terminal_id = document.getElementById('bindTerminalId').value;
            const password = document.getElementById('bindPassword').value;

            const response = await fetch('/cabinet/bind_terminal', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ terminal_id, password })
            });

            if (response.ok) {
                alert('Терминал привязан!');
                document.getElementById('bindTerminalId').value = '';
                document.getElementById('bindPassword').value = '';
                loadTerminals();
            } else {
                const data = await response.json();
                alert('Ошибка: ' + data.error);
            }
        }

        async function loadTerminals() {
            const response = await fetch('/cabinet/terminals');
            if (!response.ok) {
                return; // Игнорируем ошибки (например, 401 если не авторизован)
            }
            const data = await response.json();

            const list = document.getElementById('terminalsList');
            list.innerHTML = '';
            
            const favorites = data.favorites || [];

            // Обновляем счетчики быстрых действий
            const openShifts = data.terminals.filter(t => t.shift_opened).length;
            const activeTerminals = data.terminals.filter(t => t.current_state !== 'idle').length;
            const todayTransactions = data.terminals.reduce((sum, t) => sum + t.shift_transactions, 0);
            
            document.getElementById('openShiftsCount').textContent = openShifts;
            document.getElementById('activeTerminalsCount').textContent = activeTerminals;
            document.getElementById('todayTransactionsCount').textContent = todayTransactions;

            // Сортируем: избранные сначала
            const sortedTerminals = data.terminals.sort((a, b) => {
                if (a.is_favorite && !b.is_favorite) return -1;
                if (!a.is_favorite && b.is_favorite) return 1;
                return 0;
            });

            // Добавляем заголовок для избранных если есть
            const hasFavorites = sortedTerminals.some(t => t.is_favorite);
            if (hasFavorites) {
                const favHeader = document.createElement('h3');
                favHeader.textContent = '⭐ Избранные';
                favHeader.style.color = 'var(--text-primary)';
                favHeader.style.marginBottom = '15px';
                list.appendChild(favHeader);
            }

            let regularHeaderAdded = false;

            sortedTerminals.forEach(terminal => {
                // Добавляем заголовок для обычных терминалов
                if (!terminal.is_favorite && !regularHeaderAdded && hasFavorites) {
                    const regHeader = document.createElement('h3');
                    regHeader.textContent = '📱 Все терминалы';
                    regHeader.style.color = 'var(--text-primary)';
                    regHeader.style.marginTop = '30px';
                    regHeader.style.marginBottom = '15px';
                    list.appendChild(regHeader);
                    regularHeaderAdded = true;
                }
                
                const card = document.createElement('div');
                card.className = 'terminal-card' + (terminal.shift_opened ? ' active' : '');
                card.innerHTML = `
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <h3>${terminal.terminal_id}</h3>
                        <button class="btn" style="padding: 5px 15px; font-size: 20px; background: ${terminal.is_favorite ? '#ffc107' : 'transparent'}; border: 2px solid ${terminal.is_favorite ? '#ffc107' : 'var(--border-color)'};" onclick="toggleFavorite('${terminal.terminal_id}', event)">${terminal.is_favorite ? '⭐' : '☆'}</button>
                    </div>
                    <p style="color: var(--text-secondary);">Состояние: ${terminal.current_state}</p>
                    <p style="color: var(--text-secondary);">Смена: ${terminal.shift_opened ? '🟢 Открыта' : '🔴 Закрыта'}</p>
                    <p style="color: var(--text-secondary);">Транзакций в смене: ${terminal.shift_transactions}</p>
                    <p style="color: var(--text-secondary);">Сумма в смене: ${terminal.shift_total} ₽</p>
                    <div style="display: flex; gap: 10px; margin-top: 10px;">
                        <button class="btn btn-primary" onclick="showStats('${terminal.terminal_id}')">Подробнее</button>
                        <button class="btn btn-danger" onclick="unbindTerminal('${terminal.terminal_id}')">Отвязать</button>
                    </div>
                `;
                list.appendChild(card);
            });
        }

        async function toggleFavorite(terminalId, event) {
            event.stopPropagation();
            
            const response = await fetch(`/cabinet/terminal/${terminalId}/favorite`, {
                method: 'POST'
            });

            if (response.ok) {
                loadTerminals();
            } else {
                alert('Ошибка при изменении избранного');
            }
        }

        async function unbindTerminal(terminalId) {
            if (!confirm(`Вы уверены что хотите отвязать терминал ${terminalId}?`)) {
                return;
            }

            const response = await fetch('/cabinet/unbind_terminal', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ terminal_id: terminalId })
            });

            if (response.ok) {
                alert('Терминал отвязан!');
                loadTerminals();
                if (selectedTerminal === terminalId) {
                    document.getElementById('statsSection').classList.add('hidden');
                    selectedTerminal = null;
                }
            } else {
                const data = await response.json();
                alert('Ошибка: ' + data.error);
            }
        }

        async function showStats(terminalId) {
            selectedTerminal = terminalId;
            document.getElementById('selectedTerminal').textContent = terminalId;
            document.getElementById('statsSection').classList.remove('hidden');

            const response = await fetch('/cabinet/stats/' + terminalId);
            const data = await response.json();
            
            // Сохраняем все транзакции для фильтрации
            window.allTransactions = data.recent_transactions || [];

            // Статистика
            const statsGrid = document.getElementById('statsGrid');
            statsGrid.innerHTML = `
                <div class="stat-box">
                    <div class="stat-value">${data.total_transactions}</div>
                    <div class="stat-label">Всего транзакций</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value">${data.successful_transactions}</div>
                    <div class="stat-label">Успешных</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value">${data.total_amount.toFixed(2)} ₽</div>
                    <div class="stat-label">Общая сумма</div>
                </div>
            `;

            // Управление сменой
            const shiftControls = document.getElementById('shiftControls');
            if (data.shift.opened) {
                shiftControls.innerHTML = `
                    <p>Смена открыта: ${new Date(data.shift.opened_at).toLocaleString()}</p>
                    <p>Транзакций: ${data.shift.transactions_count}, Сумма: ${data.shift.total_amount} ₽</p>
                    <button class="btn btn-danger" onclick="closeShift()">Закрыть смену</button>
                `;
            } else {
                shiftControls.innerHTML = `
                    <p>Смена закрыта</p>
                    <button class="btn btn-success" onclick="openShift()">Открыть смену</button>
                `;
            }

            // Применяем фильтры
            applyFilters();
            
            // Добавляем обработчики поиска
            document.getElementById('searchAmount').oninput = applyFilters;
            document.getElementById('searchDateFrom').onchange = applyFilters;
            document.getElementById('searchDateTo').onchange = applyFilters;
        }

        function applyFilters() {
            if (!window.allTransactions) return;
            
            const searchAmount = document.getElementById('searchAmount').value.toLowerCase();
            const dateFrom = document.getElementById('searchDateFrom').value;
            const dateTo = document.getElementById('searchDateTo').value;
            
            const filterCard = document.getElementById('filterCard').checked;
            const filterFace = document.getElementById('filterFace').checked;
            const filterQr = document.getElementById('filterQr').checked;
            const filterSuccess = document.getElementById('filterSuccess').checked;
            const filterFailed = document.getElementById('filterFailed').checked;
            
            let filtered = window.allTransactions.filter(t => {
                // Фильтр по сумме
                if (searchAmount && !t.amount.toString().includes(searchAmount)) return false;
                
                // Фильтр по дате
                const tDate = new Date(t.timestamp).toISOString().split('T')[0];
                if (dateFrom && tDate < dateFrom) return false;
                if (dateTo && tDate > dateTo) return false;
                
                // Фильтр по типу оплаты
                if (!filterCard && t.type === 'card') return false;
                if (!filterFace && t.type === 'face') return false;
                if (!filterQr && t.type === 'qr') return false;
                
                // Фильтр по статусу
                if (!filterSuccess && t.status === 'success') return false;
                if (!filterFailed && t.status === 'failed') return false;
                
                return true;
            });
            
            // Обновляем счетчик
            document.getElementById('transactionsCount').textContent = filtered.length;
            
            // Обновляем теги фильтров
            updateFilterTags();
            
            // Отображаем транзакции
            displayTransactions(filtered.reverse());
        }

        function updateFilterTags() {
            const tags = [];
            const searchAmount = document.getElementById('searchAmount').value;
            const dateFrom = document.getElementById('searchDateFrom').value;
            const dateTo = document.getElementById('searchDateTo').value;
            
            if (searchAmount) tags.push({ label: `Сумма: ${searchAmount}`, clear: () => { document.getElementById('searchAmount').value = ''; applyFilters(); } });
            if (dateFrom) tags.push({ label: `От: ${dateFrom}`, clear: () => { document.getElementById('searchDateFrom').value = ''; applyFilters(); } });
            if (dateTo) tags.push({ label: `До: ${dateTo}`, clear: () => { document.getElementById('searchDateTo').value = ''; applyFilters(); } });
            
            const filterCard = document.getElementById('filterCard').checked;
            const filterFace = document.getElementById('filterFace').checked;
            const filterQr = document.getElementById('filterQr').checked;
            const filterSuccess = document.getElementById('filterSuccess').checked;
            const filterFailed = document.getElementById('filterFailed').checked;
            
            if (!filterCard) tags.push({ label: 'Без карты', clear: () => { document.getElementById('filterCard').checked = true; applyFilters(); } });
            if (!filterFace) tags.push({ label: 'Без лица', clear: () => { document.getElementById('filterFace').checked = true; applyFilters(); } });
            if (!filterQr) tags.push({ label: 'Без QR', clear: () => { document.getElementById('filterQr').checked = true; applyFilters(); } });
            if (!filterSuccess) tags.push({ label: 'Без успешных', clear: () => { document.getElementById('filterSuccess').checked = true; applyFilters(); } });
            if (!filterFailed) tags.push({ label: 'Без неудачных', clear: () => { document.getElementById('filterFailed').checked = true; applyFilters(); } });
            
            const tagsContainer = document.getElementById('filterTags');
            tagsContainer.innerHTML = '';
            tags.forEach(tag => {
                const tagEl = document.createElement('span');
                tagEl.style.cssText = 'background: #667eea; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; display: inline-flex; align-items: center; gap: 8px; cursor: pointer;';
                tagEl.innerHTML = `${tag.label} <span style="font-weight: bold;">×</span>`;
                tagEl.onclick = tag.clear;
                tagsContainer.appendChild(tagEl);
            });
        }

        function clearFilters() {
            document.getElementById('searchAmount').value = '';
            document.getElementById('searchDateFrom').value = '';
            document.getElementById('searchDateTo').value = '';
            document.getElementById('filterCard').checked = true;
            document.getElementById('filterFace').checked = true;
            document.getElementById('filterQr').checked = true;
            document.getElementById('filterSuccess').checked = true;
            document.getElementById('filterFailed').checked = true;
            applyFilters();
        }

        function displayTransactions(transactions) {
            const transactionsList = document.getElementById('transactionsList');
            transactionsList.innerHTML = '';
            transactions.forEach(t => {
                const div = document.createElement('div');
                div.className = 'transaction ' + t.status;
                
                // Подсветка совпадений
                const searchAmount = document.getElementById('searchAmount').value;
                let amountText = t.amount + ' ₽';
                if (searchAmount && t.amount.toString().includes(searchAmount)) {
                    amountText = amountText.replace(searchAmount, `<mark style="background: #ffc107; padding: 2px 4px; border-radius: 3px;">${searchAmount}</mark>`);
                }
                
                div.innerHTML = `
                    <span>${new Date(t.timestamp).toLocaleString()}</span>
                    <span>${amountText} (${t.type})</span>
                    <span>${t.status === 'success' ? '✅' : '❌'}</span>
                `;
                transactionsList.appendChild(div);
            });
        }

        async function openShift() {
            const response = await fetch('/cabinet/shift/open', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ terminal_id: selectedTerminal })
            });

            if (response.ok) {
                alert('Смена открыта!');
                showStats(selectedTerminal);
                loadTerminals();
            } else {
                const data = await response.json();
                alert('Ошибка: ' + data.error);
            }
        }

        async function closeShift() {
            if (!confirm('Вы точно хотите закончить смену?')) {
                return;
            }
            
            const response = await fetch('/cabinet/shift/close', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ terminal_id: selectedTerminal })
            });

            if (response.ok) {
                const data = await response.json();
                alert(`Смена закрыта!\\nТранзакций: ${data.shift.transactions_count}\\nСумма: ${data.shift.total_amount} ₽`);
                showStats(selectedTerminal);
                loadTerminals();
            } else {
                const data = await response.json();
                alert('Ошибка: ' + data.error);
            }
        }

        function logout() {
            if (confirm('Вы точно хотите выйти?')) {
                currentUser = null;
                selectedTerminal = null;
                document.getElementById('username').textContent = '';
                document.getElementById('balance').classList.add('hidden');
                document.getElementById('analyticsBtn').classList.add('hidden');
                document.getElementById('faqBtn').classList.add('hidden');
                document.getElementById('newsBtn').classList.add('hidden');
                document.getElementById('supportChatBtn').classList.add('hidden');
                document.getElementById('notificationsBtn').classList.add('hidden');
                document.getElementById('logoutBtn').classList.add('hidden');
                document.getElementById('authSection').classList.remove('hidden');
                document.getElementById('bindSection').classList.add('hidden');
                document.getElementById('terminalsSection').classList.add('hidden');
                document.getElementById('statsSection').classList.add('hidden');
                document.getElementById('analyticsSection').classList.add('hidden');
                document.getElementById('faqSection').classList.add('hidden');
                document.getElementById('newsSection').classList.add('hidden');
                document.getElementById('authUsername').value = '';
                document.getElementById('authPassword').value = '';
            }
        }

        // Аналитика
        let transactionsChart = null;

        function showAnalytics() {
            document.getElementById('analyticsSection').classList.remove('hidden');
            document.getElementById('terminalsSection').classList.add('hidden');
            document.getElementById('statsSection').classList.add('hidden');
            
            // Устанавливаем даты по умолчанию (последние 30 дней)
            const today = new Date();
            const monthAgo = new Date(today);
            monthAgo.setDate(monthAgo.getDate() - 30);
            
            document.getElementById('analyticsDateFrom').value = monthAgo.toISOString().split('T')[0];
            document.getElementById('analyticsDateTo').value = today.toISOString().split('T')[0];
            
            loadAnalytics();
        }

        async function loadAnalytics() {
            const period = document.getElementById('analyticsPeriod').value;
            const dateFrom = document.getElementById('analyticsDateFrom').value;
            const dateTo = document.getElementById('analyticsDateTo').value;
            
            const response = await fetch(`/cabinet/analytics?period=${period}&date_from=${dateFrom}&date_to=${dateTo}`);
            if (!response.ok) return;
            
            const data = await response.json();
            
            // График транзакций
            const chartData = data.chart_data;
            const labels = Object.keys(chartData).sort();
            const successData = labels.map(l => chartData[l].success);
            const failedData = labels.map(l => chartData[l].failed);
            
            const ctx = document.getElementById('transactionsChart');
            
            if (transactionsChart) {
                transactionsChart.destroy();
            }
            
            transactionsChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Успешные',
                            data: successData,
                            borderColor: '#28a745',
                            backgroundColor: 'rgba(40, 167, 69, 0.1)',
                            tension: 0.4
                        },
                        {
                            label: 'Неудачные',
                            data: failedData,
                            borderColor: '#dc3545',
                            backgroundColor: 'rgba(220, 53, 69, 0.1)',
                            tension: 0.4
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            labels: {
                                color: getComputedStyle(document.documentElement).getPropertyValue('--text-primary')
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                color: getComputedStyle(document.documentElement).getPropertyValue('--text-secondary')
                            },
                            grid: {
                                color: getComputedStyle(document.documentElement).getPropertyValue('--border-color')
                            }
                        },
                        x: {
                            ticks: {
                                color: getComputedStyle(document.documentElement).getPropertyValue('--text-secondary')
                            },
                            grid: {
                                color: getComputedStyle(document.documentElement).getPropertyValue('--border-color')
                            }
                        }
                    }
                }
            });
            
            // Топ терминалов
            const ranking = document.getElementById('terminalRanking');
            ranking.innerHTML = '';
            data.top_terminals.forEach((t, index) => {
                const div = document.createElement('div');
                div.style.cssText = 'padding: 15px; background: var(--stat-box-bg); border-radius: 12px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center;';
                div.innerHTML = `
                    <div>
                        <span style="font-size: 24px; font-weight: bold; color: ${index === 0 ? '#ffc107' : index === 1 ? '#c0c0c0' : index === 2 ? '#cd7f32' : '#667eea'};">${index + 1}.</span>
                        <span style="font-weight: bold; color: var(--text-primary); margin-left: 10px;">${t.terminal_id}</span>
                    </div>
                    <div style="text-align: right;">
                        <div style="font-size: 20px; font-weight: bold; color: #28a745;">${t.amount.toFixed(2)} ₽</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">${t.count} транзакций</div>
                    </div>
                `;
                ranking.appendChild(div);
            });
            
            // Конверсия
            const conversion = document.getElementById('conversionStats');
            conversion.innerHTML = '';
            
            const typeNames = { card: 'Карта', face: 'Лицо', qr: 'QR' };
            
            for (const [type, stats] of Object.entries(data.conversion)) {
                const div = document.createElement('div');
                div.className = 'stat-box';
                const isLow = stats.rate < 80;
                div.innerHTML = `
                    <div style="font-size: 36px; font-weight: bold; color: ${isLow ? '#dc3545' : '#28a745'};">${stats.rate.toFixed(1)}%</div>
                    <div class="stat-label">${typeNames[type] || type}</div>
                    <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">
                        ✅ ${stats.success} / ❌ ${stats.failed}
                    </div>
                `;
                conversion.appendChild(div);
            }
        }

        function exportData(format) {
            window.location.href = `/cabinet/export/transactions?format=${format}`;
        }

        function exportTerminalData(format) {
            if (!selectedTerminal) {
                alert('Выберите терминал');
                return;
            }
            window.location.href = `/cabinet/export/transactions?format=${format}&terminal_id=${selectedTerminal}`;
        }

        // Чат поддержки
        function toggleSupportChat() {
            const chatWindow = document.getElementById('supportChatWindow');
            chatWindow.classList.toggle('open');
            if (chatWindow.classList.contains('open')) {
                loadSupportMessages();
            }
        }

        async function loadSupportMessages() {
            const response = await fetch('/cabinet/support/messages');
            
            if (response.status === 403) {
                const data = await response.json();
                if (data.blocked) {
                    const messagesDiv = document.getElementById('supportMessages');
                    messagesDiv.innerHTML = '<div style="text-align: center; padding: 20px; color: #dc3545; font-weight: bold;">🚫 Вы заблокированы в боте</div>';
                    document.getElementById('supportMessageInput').disabled = true;
                    return;
                }
            }
            
            if (!response.ok) return;
            
            const data = await response.json();
            const messagesDiv = document.getElementById('supportMessages');
            messagesDiv.innerHTML = '';
            
            if (data.messages.length === 0) {
                messagesDiv.innerHTML = '<div style="text-align: center; padding: 20px; color: var(--text-secondary);">Напишите первое сообщение</div>';
                return;
            }
            
            data.messages.forEach(msg => {
                const div = document.createElement('div');
                div.className = 'support-message ' + (msg.is_admin ? 'admin' : 'user');
                div.textContent = msg.message;
                messagesDiv.appendChild(div);
            });
            
            // Прокрутка вниз
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        async function sendSupportMessage() {
            const input = document.getElementById('supportMessageInput');
            const message = input.value.trim();
            
            if (!message || input.disabled) return;
            
            const response = await fetch('/cabinet/support/send', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message })
            });
            
            if (response.status === 403) {
                const data = await response.json();
                alert(data.error || 'Вы заблокированы в боте');
                input.disabled = true;
                return;
            }
            
            if (response.ok) {
                input.value = '';
                loadSupportMessages();
            } else {
                const data = await response.json();
                alert('Ошибка: ' + (data.error || 'Неизвестная ошибка'));
            }
        }

        // Автообновление сообщений каждые 5 секунд если чат открыт
        setInterval(() => {
            const chatWindow = document.getElementById('supportChatWindow');
            if (chatWindow && chatWindow.classList.contains('open')) {
                loadSupportMessages();
            }
        }, 5000);

        // FAQ
        async function showFAQ() {
            document.getElementById('faqSection').classList.remove('hidden');
            document.getElementById('terminalsSection').classList.add('hidden');
            document.getElementById('statsSection').classList.add('hidden');
            document.getElementById('analyticsSection').classList.add('hidden');
            document.getElementById('newsSection').classList.add('hidden');
            
            const response = await fetch('/cabinet/faq');
            if (!response.ok) return;
            
            const data = await response.json();
            const faqList = document.getElementById('faqList');
            faqList.innerHTML = '';
            
            data.faq.forEach(item => {
                const div = document.createElement('div');
                div.style.cssText = 'padding: 20px; background: var(--stat-box-bg); border-radius: 12px; margin-bottom: 15px; border-left: 4px solid #667eea;';
                div.innerHTML = `
                    <h3 style="color: var(--text-primary); margin-bottom: 10px; font-size: 18px;">❓ ${item.question}</h3>
                    <p style="color: var(--text-secondary); line-height: 1.6;">${item.answer}</p>
                `;
                faqList.appendChild(div);
            });
        }

        // Терминалы
        function showTerminals() {
            document.getElementById('terminalsSection').classList.remove('hidden');
            document.getElementById('statsSection').classList.add('hidden');
            document.getElementById('analyticsSection').classList.add('hidden');
            document.getElementById('faqSection').classList.add('hidden');
            document.getElementById('newsSection').classList.add('hidden');
        }

        // Новости
        async function showNews() {
            document.getElementById('newsSection').classList.remove('hidden');
            document.getElementById('terminalsSection').classList.add('hidden');
            document.getElementById('statsSection').classList.add('hidden');
            document.getElementById('analyticsSection').classList.add('hidden');
            document.getElementById('faqSection').classList.add('hidden');
            
            const response = await fetch('/cabinet/news');
            if (!response.ok) return;
            
            const data = await response.json();
            const newsList = document.getElementById('newsList');
            newsList.innerHTML = '';
            
            const typeIcons = { feature: '✨', maintenance: '🔧', tip: '💡' };
            const typeColors = { feature: '#28a745', maintenance: '#ffc107', tip: '#17a2b8' };
            
            data.news.forEach(item => {
                const div = document.createElement('div');
                div.style.cssText = 'padding: 20px; background: var(--stat-box-bg); border-radius: 12px; margin-bottom: 15px; border-left: 4px solid ' + typeColors[item.type] + ';';
                div.innerHTML = `
                    <div style="display: flex; justify-content: between; align-items: start; margin-bottom: 10px;">
                        <h3 style="color: var(--text-primary); font-size: 18px; flex: 1;">${typeIcons[item.type]} ${item.title}</h3>
                        <span style="color: var(--text-secondary); font-size: 14px;">${item.date}</span>
                    </div>
                    <p style="color: var(--text-secondary); line-height: 1.6;">${item.content}</p>
                `;
                newsList.appendChild(div);
            });
        }

        // Уведомления
        let notifications = [];
        let lastCheckedTerminals = {};

        function toggleNotifications() {
            const panel = document.getElementById('notificationsPanel');
            panel.classList.toggle('open');
            if (panel.classList.contains('open')) {
                displayNotifications();
            }
        }

        function addNotification(type, title, message, terminalId) {
            const notification = {
                id: Date.now(),
                type: type,
                title: title,
                message: message,
                terminalId: terminalId,
                timestamp: new Date().toISOString()
            };
            
            notifications.unshift(notification);
            if (notifications.length > 20) {
                notifications = notifications.slice(0, 20);
            }
            
            updateNotificationBadge();
            displayNotifications();
        }

        function updateNotificationBadge() {
            const badge = document.getElementById('notificationsBadge');
            if (notifications.length > 0) {
                badge.textContent = notifications.length;
                badge.classList.remove('hidden');
            } else {
                badge.classList.add('hidden');
            }
        }

        function displayNotifications() {
            const list = document.getElementById('notificationsList');
            list.innerHTML = '';
            
            if (notifications.length === 0) {
                list.innerHTML = '<div style="text-align: center; padding: 20px; color: var(--text-secondary);">Нет уведомлений</div>';
                return;
            }
            
            notifications.forEach(notif => {
                const div = document.createElement('div');
                div.className = 'notification-item ' + notif.type;
                div.innerHTML = `
                    <div style="font-weight: bold; color: var(--text-primary); margin-bottom: 5px;">${notif.title}</div>
                    <div style="color: var(--text-secondary); font-size: 14px; margin-bottom: 5px;">${notif.message}</div>
                    <div style="color: var(--text-secondary); font-size: 12px;">${new Date(notif.timestamp).toLocaleString()}</div>
                `;
                if (notif.terminalId) {
                    div.onclick = () => {
                        showStats(notif.terminalId);
                        toggleNotifications();
                    };
                }
                list.appendChild(div);
            });
        }

        function clearNotifications() {
            notifications = [];
            updateNotificationBadge();
            displayNotifications();
        }

        // Проверка состояния терминалов для уведомлений
        async function checkTerminalsForNotifications() {
            if (!currentUser) return;
            
            const response = await fetch('/cabinet/terminals');
            if (!response.ok) return;
            
            const data = await response.json();
            
            data.terminals.forEach(terminal => {
                const terminalId = terminal.terminal_id;
                const lastState = lastCheckedTerminals[terminalId] || {};
                
                // Проверка неудачных транзакций
                if (terminal.current_state === 'idle' && lastState.current_state === 'pay') {
                    // Возможно неудачная транзакция
                    addNotification('error', '❌ Возможна неудачная транзакция', `Терминал ${terminalId} вернулся в idle`, terminalId);
                }
                
                // Проверка долгой смены (больше 24 часов)
                if (terminal.shift_opened) {
                    // Упрощенная проверка - просто уведомляем если смена открыта
                    if (!lastState.shift_opened) {
                        addNotification('warning', '⏰ Смена открыта', `Терминал ${terminalId} - не забудьте закрыть смену`, terminalId);
                    }
                }
                
                lastCheckedTerminals[terminalId] = terminal;
            });
        }

        // Проверяем терминалы каждые 30 секунд
        setInterval(checkTerminalsForNotifications, 30000);

        // Функции кассы
        async function sendPayment(amount) {
            if (!selectedTerminal) {
                alert('Выберите терминал');
                return;
            }

            const response = await fetch('/admin/set_device_payload_full', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    terminal_id: selectedTerminal,
                    state: 'pay',
                    amount: amount.toString()
                })
            });

            if (response.ok) {
                alert(`✅ Оплата ${amount} ₽ отправлена`);
            } else {
                const data = await response.json();
                alert('❌ Ошибка: ' + data.error);
            }
        }

        async function sendCustomPayment() {
            const amount = parseInt(document.getElementById('customAmount').value);
            if (!amount || amount <= 0) {
                alert('Введите корректную сумму');
                return;
            }
            await sendPayment(amount);
            document.getElementById('customAmount').value = '';
        }

        async function confirmCard(approved) {
            if (!selectedTerminal) {
                alert('Выберите терминал');
                return;
            }

            const response = await fetch('/admin/confirm_card', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    terminal_id: selectedTerminal,
                    approved: approved
                })
            });

            if (response.ok) {
                alert(approved ? '✅ Карта подтверждена' : '❌ Карта отклонена');
            } else {
                alert('Ошибка');
            }
        }

        async function cancelPayment() {
            if (!selectedTerminal) {
                alert('Выберите терминал');
                return;
            }

            const response = await fetch('/admin/set_device_payload', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    terminal_id: selectedTerminal,
                    payload: 'idle'
                })
            });

            if (response.ok) {
                alert('🚫 Операция отменена');
            } else {
                alert('Ошибка');
            }
        }

        async function getStatus() {
            if (!selectedTerminal) {
                alert('Выберите терминал');
                return;
            }

            const response = await fetch('/admin/status');
            if (response.ok) {
                const data = await response.json();
                const device = data.devices.find(d => d.terminal_id === selectedTerminal);
                if (device) {
                    const payload = device.current_payload || {};
                    const state = payload.state || 'unknown';
                    const amount = payload.data?.amount || 'N/A';
                    alert(`📊 Статус терминала ${selectedTerminal}\\nСостояние: ${state}\\nСумма: ${amount} ₽`);
                } else {
                    alert('Терминал не найден');
                }
            } else {
                alert('Ошибка получения статуса');
            }
        }

        // Автообновление каждые 5 секунд
        setInterval(() => {
            if (currentUser) {
                loadTerminals();
                loadBalance();
                if (selectedTerminal) {
                    showStats(selectedTerminal);
                }
            }
        }, 5000);

        // Темная тема
        function toggleTheme() {
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            const themeBtn = document.querySelector('.theme-toggle');
            
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            themeBtn.textContent = newTheme === 'dark' ? '☀️' : '🌙';
        }

        // Загрузка сохраненной темы
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'light';
            const themeBtn = document.querySelector('.theme-toggle');
            document.documentElement.setAttribute('data-theme', savedTheme);
            if (themeBtn) {
                themeBtn.textContent = savedTheme === 'dark' ? '☀️' : '🌙';
            }
        })();
    </script>
    
    <!-- Баннер скачивания -->
    <div id="downloadBanner" style="position: fixed; bottom: 0; left: 0; right: 0; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 10px; box-shadow: 0 -4px 20px rgba(0,0,0,0.3); z-index: 1000;">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: center; align-items: center; gap: 15px; flex-wrap: wrap;">
            <div style="color: white; font-size: 16px; font-weight: bold; width: 100%; text-align: center;">
                📱 Скачать приложение:
            </div>
            <a href="https://github.com/heyyaah/sberpos/raw/main/cabinet_unsigned.apk" 
               style="background: white; color: #667eea; padding: 10px 20px; border-radius: 25px; text-decoration: none; font-weight: bold; display: flex; align-items: center; gap: 8px; transition: transform 0.2s, box-shadow 0.2s; font-size: 14px;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 20px rgba(0,0,0,0.3)'"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 10px rgba(0,0,0,0.2)'">
                <span style="font-size: 20px;">🤖</span>
                <span>Android</span>
            </a>
            <a href="https://github.com/heyyaah/sberpos/raw/main/dist/SberScreen-Cashier.exe" 
               style="background: white; color: #667eea; padding: 10px 20px; border-radius: 25px; text-decoration: none; font-weight: bold; display: flex; align-items: center; gap: 8px; transition: transform 0.2s, box-shadow 0.2s; font-size: 14px;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 20px rgba(0,0,0,0.3)'"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 10px rgba(0,0,0,0.2)'">
                <span style="font-size: 20px;">💻</span>
                <span>Windows</span>
            </a>
        </div>
    </div>
    
    <style>
        @media (min-width: 768px) {
            #downloadBanner {
                padding: 20px !important;
            }
            #downloadBanner > div > div {
                width: auto !important;
                text-align: left !important;
                font-size: 18px !important;
            }
            #downloadBanner a {
                padding: 12px 30px !important;
                font-size: 16px !important;
            }
            #downloadBanner a span:first-child {
                font-size: 24px !important;
            }
        }
    </style>
</body>
</html>
    ''')

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5001))
    print(f"🚀 API Server запущен на порту {port}")
    print(f"📌 Загружено терминалов: {len(terminals)}")
    print("   Регистрация: POST /register")
    print("   Формат: TRM-#### (4 цифры), пароль: 6 цифр")
    app.run(host='0.0.0.0', port=port, debug=False)
