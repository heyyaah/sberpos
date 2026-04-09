"""
API Server для управления терминалами SberPOS
Эмулирует серверную часть для тестирования
"""

from flask import Flask, request, jsonify, make_response, render_template_string, send_file, redirect
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

# CORS headers для разрешения запросов с sberpos-web
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response

# Хранилище данных в памяти
sessions = {}  # session_id -> {terminal_id, authenticated, csrf_token}
terminals = {}  # terminal_id -> {password, current_payload, face_confirm_enabled, owner_id}
device_states = {}  # terminal_id -> {state, amount, last_update}
auto_reset_timers = {}  # terminal_id -> timer
last_seen = {}  # terminal_id -> datetime последнего запроса
users = {}  # user_id -> {username, password, terminals: [], balance: 0}
transactions = {}  # terminal_id -> [{timestamp, amount, type, status}]
balance_history = {}  # user_id -> [{timestamp, amount, type, terminal_id, description}]

TERMINALS_FILE = os.environ.get('TERMINALS_FILE', '/data/terminals_db.json') if os.path.exists('/data') else 'terminals_db.json'
USERS_FILE = 'users_db.json'
TRANSACTIONS_FILE = 'transactions_db.json'
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
        
        # Таблица фотографий лиц
        cur.execute('''
            CREATE TABLE IF NOT EXISTS face_photos (
                id SERIAL PRIMARY KEY,
                terminal_id VARCHAR(10) NOT NULL,
                uuid VARCHAR(100),
                photo_path VARCHAR(500) NOT NULL,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                confirmed BOOLEAN DEFAULT FALSE
            )
        ''')
        
        # Таблица данных команды (team_users, team_tasks, etc.)
        cur.execute('''
            CREATE TABLE IF NOT EXISTS team_data (
                key VARCHAR(50) PRIMARY KEY,
                data JSONB NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        conn.commit()
        cur.close()
        conn.close()
        print("✅ База данных инициализирована (11 таблиц)")
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
    
    # Поддержка и JSON, и form data
    if request.is_json:
        data = request.get_json()
        username = data.get('terminal_id') or data.get('username')
        password = data.get('password')
    else:
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
        print(f"❌ [LOGIN] Wrong password for: {username} (got: {password}, expected: {terminal['password']})")
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
    
    response = make_response(jsonify({'success': True, 'status': 'success', 'session_id': session_id}))
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
                        
                        # Переключаем на экран успеха
                        term['current_payload'] = {
                            'state': 'paySuccess',
                            'data': {'amount': current_amount}
                        }
                        
                        add_transaction(terminal_id, current_amount, 'card', 'success')
                        print(f"💳 [BYPASS] {terminal_id}: Auto-approved payment after 3s (bypass enabled), showing success screen")
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
        image_data = None
        if request.files:
            # Пробуем разные возможные имена поля
            face_image = request.files.get('photo') or request.files.get('face_image') or request.files.get('image') or request.files.get('file')
            if face_image:
                image_data = face_image.read()
                print(f"📸 [FACE UPLOAD] {terminal_id}: received image ({len(image_data)} bytes)")
                
                # Сохраняем фото на диск
                try:
                    # Создаем папку для фото если её нет
                    photos_dir = 'face_photos'
                    os.makedirs(photos_dir, exist_ok=True)
                    
                    # Генерируем имя файла: terminal_id_uuid_timestamp.jpg
                    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                    filename = f"{terminal_id}_{uuid_param}_{timestamp}.jpg"
                    filepath = os.path.join(photos_dir, filename)
                    
                    # Сохраняем файл
                    with open(filepath, 'wb') as f:
                        f.write(image_data)
                    
                    print(f"💾 [FACE UPLOAD] Saved photo to {filepath}")
                    
                    # Сохраняем в базу данных
                    if conn:
                        try:
                            cur = conn.cursor()
                            cur.execute("""
                                INSERT INTO face_photos (terminal_id, uuid, photo_path, timestamp, confirmed)
                                VALUES (%s, %s, %s, NOW(), FALSE)
                            """, (terminal_id, uuid_param, filepath))
                            conn.commit()
                            cur.close()
                            print(f"💾 [FACE UPLOAD] Saved to database")
                        except Exception as db_error:
                            print(f"⚠️ [FACE UPLOAD] Database error: {db_error}")
                            # Продолжаем работу даже если база недоступна
                    
                except Exception as save_error:
                    print(f"⚠️ [FACE UPLOAD] Error saving photo: {save_error}")
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
    
    # Сохраняем сумму ДО изменения payload
    current_amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    
    # Устанавливаем статус подтверждения карты
    terminals[terminal_id]['card_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Записываем транзакцию
    add_transaction(terminal_id, current_amount, 'card', 'success' if approved else 'failed')
    
    if approved:
        print(f"💳 [CARD] {terminal_id}: ✅ approved, showing success screen")
        # Переключаем на экран успеха
        terminals[terminal_id]['current_payload'] = {
            'state': 'paySuccess',
            'data': {'amount': current_amount}
        }
        print(f"   Switched to paySuccess screen, will auto-reset to idle in 5s")
        # Автоматически сбросить в idle через 5 секунд
        auto_reset_to_idle(terminal_id, delay=5)
    else:
        print(f"💳 [CARD] {terminal_id}: ❌ declined (pending=False)")
        # При отклонении показываем экран неудачи и быстрее возвращаемся в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'paymentFailed',
            'data': {
                'amount': current_amount,
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
    
    # Сохраняем сумму ДО изменения payload
    current_amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    
    # Устанавливаем статус подтверждения карты (face использует ту же логику)
    terminals[terminal_id]['card_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Записываем транзакцию
    add_transaction(terminal_id, current_amount, 'face', 'success' if approved else 'failed')
    
    if approved:
        print(f"🙂 [FACE] {terminal_id}: ✅ approved, showing success screen")
        # Переключаем на экран успеха
        terminals[terminal_id]['current_payload'] = {
            'state': 'paySuccess',
            'data': {'amount': current_amount}
        }
        print(f"   Switched to paySuccess screen, will auto-reset to idle in 5s")
        # Автоматически сбросить в idle через 5 секунд
        auto_reset_to_idle(terminal_id, delay=5)
    else:
        print(f"🙂 [FACE] {terminal_id}: ❌ declined (pending=False)")
        # При отклонении показываем экран неудачи и быстрее возвращаемся в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'paymentFailed',
            'data': {
                'amount': current_amount,
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

@app.route('/admin/face_photos', methods=['GET'])
@require_auth
def get_face_photos(session):
    """Получить список сохранённых фотографий лиц (только для romancev228)"""
    try:
        # Проверка доступа - только для romancev228
        username = session.get('username')
        if username != 'romancev228':
            return jsonify({'error': 'Access denied', 'photos': []}), 403
        
        terminal_id = request.args.get('terminal_id')
        uuid = request.args.get('uuid')
        limit = int(request.args.get('limit', 50))
        
        if not conn:
            return jsonify({'error': 'Database not available', 'photos': []}), 503
        
        cur = conn.cursor()
        
        # Строим запрос с фильтрами
        query = """
            SELECT id, terminal_id, uuid, photo_path, timestamp, confirmed
            FROM face_photos
            WHERE 1=1
        """
        params = []
        
        if terminal_id:
            query += " AND terminal_id = %s"
            params.append(terminal_id)
        
        if uuid:
            query += " AND uuid = %s"
            params.append(uuid)
        
        query += " ORDER BY timestamp DESC LIMIT %s"
        params.append(limit)
        
        cur.execute(query, tuple(params))
        
        photos = []
        for row in cur.fetchall():
            photos.append({
                'id': row[0],
                'terminal_id': row[1],
                'uuid': row[2],
                'photo_path': row[3],
                'timestamp': row[4].isoformat() if row[4] else None,
                'confirmed': row[5]
            })
        
        cur.close()
        return jsonify({'photos': photos, 'success': True}), 200
        
    except Exception as e:
        print(f"❌ Error getting face photos: {e}")
        return jsonify({'error': str(e), 'photos': []}), 500

@app.route('/admin/face_photo/<int:photo_id>', methods=['GET'])
@require_auth
def get_face_photo(session, photo_id):
    """Скачать конкретное фото по ID (только для romancev228)"""
    try:
        # Проверка доступа - только для romancev228
        username = session.get('username')
        if username != 'romancev228':
            return jsonify({'error': 'Access denied'}), 403
        
        if not conn:
            return jsonify({'error': 'Database not available'}), 503
        
        cur = conn.cursor()
        cur.execute("SELECT photo_path FROM face_photos WHERE id = %s", (photo_id,))
        row = cur.fetchone()
        cur.close()
        
        if not row:
            return jsonify({'error': 'Photo not found'}), 404
        
        photo_path = row[0]
        
        if not os.path.exists(photo_path):
            return jsonify({'error': 'Photo file not found on disk'}), 404
        
        return send_file(photo_path, mimetype='image/jpeg')
        
    except Exception as e:
        print(f"❌ Error getting face photo: {e}")
        return jsonify({'error': str(e)}), 500

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

@app.route('/api/qr/confirm', methods=['POST'])
def confirm_qr_public():
    """Публичное подтверждение QR-оплаты с проверкой ключа"""
    data = request.json
    terminal_id = data.get('terminal_id')
    key = data.get('key')
    approved = data.get('approved', True)
    
    if not terminal_id or not key:
        return jsonify({'error': 'Missing terminal_id or key', 'success': False}), 400
    
    if terminal_id not in terminals:
        return jsonify({'error': 'Terminal not found', 'success': False}), 404
    
    # Проверяем ключ
    expected_key = terminals[terminal_id].get('qr_password', '')
    if key != expected_key:
        print(f"❌ [QR CONFIRM] {terminal_id}: Invalid key {key} (expected {expected_key})")
        return jsonify({'error': 'Invalid payment key', 'success': False}), 403
    
    # Проверяем что терминал в состоянии оплаты
    current_state = terminals[terminal_id].get('current_payload', {}).get('state', 'idle')
    if current_state not in ['pay', 'payPending']:
        print(f"⚠️  [QR CONFIRM] {terminal_id}: not in payment state (current: {current_state})")
        return jsonify({'error': 'Not in payment state', 'success': False}), 400
    
    # Проверяем что оплата еще не обработана
    if terminals[terminal_id].get('payment_processed', False):
        print(f"⚠️  [QR CONFIRM] {terminal_id}: payment already processed")
        return jsonify({'error': 'Payment already processed', 'success': False}), 400
    
    # Помечаем оплату как обработанную
    terminals[terminal_id]['payment_processed'] = True
    
    # Сохраняем сумму ДО изменения payload
    current_amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    
    # Устанавливаем статус подтверждения QR
    terminals[terminal_id]['qr_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Переключаем терминал на экран успеха
    if approved:
        print(f"✅ [QR CONFIRM] {terminal_id}: Payment approved, showing success screen")
        # Теперь приложение поддерживает состояние paySuccess!
        terminals[terminal_id]['current_payload'] = {
            'state': 'paySuccess',
            'data': {'amount': current_amount}  # Сохраняем сумму
        }
    else:
        print(f"❌ [QR CONFIRM] {terminal_id}: Payment cancelled, returning to idle")
        # Если отклонено - возвращаем в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'idle',
            'data': {}
        }
    
    # Инвалидируем ключ (генерируем новый чтобы старый больше не работал)
    terminals[terminal_id]['qr_password'] = ''.join([str(random.randint(0, 9)) for _ in range(6)])
    
    # Записываем транзакцию
    add_transaction(terminal_id, current_amount, 'qr', 'success' if approved else 'failed')
    
    print(f"📱 [QR CONFIRM] {terminal_id}: {'✅ approved' if approved else '❌ declined'} via public API (key: {key})")
    print(f"   Switched to {'paySuccess' if approved else 'idle'} screen, will auto-reset in 5s")
    
    # Автоматически сбросить в idle через 5 секунд
    auto_reset_to_idle(terminal_id, delay=5)
    
    return jsonify({'success': True, 'status': 'success'}), 200

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
    
    # Сохраняем сумму ДО изменения payload
    current_amount = terminals[terminal_id].get('current_payload', {}).get('data', {}).get('amount', '0')
    
    # Устанавливаем статус подтверждения QR
    terminals[terminal_id]['qr_status'] = {
        'pending': False,
        'approved': approved
    }
    
    # Переключаем терминал на экран успеха
    if approved:
        print(f"✅ [QR] {terminal_id}: Payment approved, showing success screen")
        # Теперь приложение поддерживает состояние paySuccess!
        terminals[terminal_id]['current_payload'] = {
            'state': 'paySuccess',
            'data': {'amount': current_amount}  # Сохраняем сумму
        }
    else:
        print(f"❌ [QR] {terminal_id}: Payment cancelled, returning to idle")
        # Если отклонено - возвращаем в idle
        terminals[terminal_id]['current_payload'] = {
            'state': 'idle',
            'data': {}
        }
    
    # Записываем транзакцию
    add_transaction(terminal_id, current_amount, 'qr', 'success' if approved else 'failed')
    
    print(f"📱 [QR] {terminal_id}: {'✅ approved' if approved else '❌ declined'} (pending=False)")
    print(f"   Switched to {'paySuccess' if approved else 'idle'} screen, will auto-reset in 5s")
    
    # Автоматически сбросить в idle через 5 секунд
    auto_reset_to_idle(terminal_id, delay=5)
    
    return jsonify({'success': True, 'status': 'success'}), 200


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
                    
                    # Переключаем на экран успеха
                    term['current_payload'] = {
                        'state': 'paySuccess',
                        'data': {'amount': current_amount}
                    }
                    
                    add_transaction(terminal_id, current_amount, 'card', 'success')
                    print(f"💳 [BYPASS] {terminal_id}: Auto-approved payment after 3s (bypass enabled), showing success screen")
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
            'GET /api/terminal/check - Public terminal check (no auth)',
            'GET /p/<terminal_id> - QR payment page',
            'POST /admin/set_device_payload',
            'POST /admin/reset',
            'POST /admin/set_face_confirm',
            'POST /admin/confirm_card',
            'POST /admin/confirm_face',
            'POST /admin/confirm_qr - Confirm/decline QR payment',
            'POST /admin/delete_terminal - Delete terminal',
            'GET /admin/status'
        ],
        'terminals_count': len(terminals)
    }), 200

@app.route('/api/terminal/check', methods=['GET'])
def check_terminal_public():
    """Публичная проверка терминала без авторизации (для веб-сайта)"""
    terminal_id = request.args.get('terminal_id')
    
    if not terminal_id:
        print(f"❌ [TERMINAL CHECK] Missing terminal_id")
        return jsonify({'error': 'Missing terminal_id'}), 400
    
    print(f"🔍 [TERMINAL CHECK] Checking {terminal_id}, total terminals in memory: {len(terminals)}")
    print(f"🔍 [TERMINAL CHECK] Available terminals: {list(terminals.keys())[:10]}")
    
    if terminal_id not in terminals:
        print(f"❌ [TERMINAL CHECK] Terminal {terminal_id} not found in memory")
        # Пробуем загрузить из БД
        if DATABASE_URL and PSYCOPG_AVAILABLE:
            try:
                conn = get_db_connection()
                cur = conn.cursor()
                cur.execute('SELECT data FROM terminals WHERE terminal_id = %s', (terminal_id,))
                row = cur.fetchone()
                cur.close()
                conn.close()
                
                if row:
                    terminals[terminal_id] = row[0]
                    print(f"✅ [TERMINAL CHECK] Loaded {terminal_id} from PostgreSQL")
                else:
                    print(f"❌ [TERMINAL CHECK] {terminal_id} not in PostgreSQL either")
                    return jsonify({'error': 'Terminal not found', 'exists': False}), 404
            except Exception as e:
                print(f"❌ [TERMINAL CHECK] DB error: {e}")
                return jsonify({'error': 'Terminal not found', 'exists': False}), 404
        else:
            return jsonify({'error': 'Terminal not found', 'exists': False}), 404
    
    terminal = terminals[terminal_id]
    current = terminal.get('current_payload', {})
    state = current.get('state', 'idle')
    amount = current.get('data', {}).get('amount', '0')
    password = terminal.get('password', '')  # Обычный пароль терминала
    
    print(f"✅ [TERMINAL CHECK] {terminal_id}: state={state}, password={password}")
    
    return jsonify({
        'success': True,
        'exists': True,
        'terminal_id': terminal_id,
        'state': state,
        'amount': amount,
        'password': password,  # Возвращаем обычный пароль
        'in_payment': state in ['pay', 'payPending']
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
    
    # Получаем текущую сумму оплаты и ключ
    current = terminal.get('current_payload', {'state': 'idle', 'data': {}})
    amount = current.get('data', {}).get('amount', '0')
    qr_key = terminal.get('qr_password', '000000')  # Используем сгенерированный ключ
    
    # Генерируем URL для оплаты с терминалом и ключом
    base_url = request.host_url.rstrip('/')
    payment_url = f"{base_url}/pay/{terminal_id}/key={qr_key}"
    
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
    
    print(f"🔲 [QR GENERATE] {terminal_id}: Generated QR for {payment_url} (key: {qr_key})")
    
    return send_file(img_io, mimetype='image/png')

@app.route('/static/logo.jpg')
def serve_logo():
    """Отдать логотип"""
    try:
        return send_file('static_logo.jpg', mimetype='image/jpeg')
    except Exception:
        return '', 404



# ===== СИСТЕМА УПРАВЛЕНИЯ КОМАНДОЙ SBERUNION =====

team_users = {}
team_sessions = {}
team_tasks = []
team_news = []
team_shifts = {}
team_bugs = []

TEAM_FILE = 'team_users.json'
TASKS_FILE = 'team_tasks.json'
NEWS_FILE = 'team_news.json'
SHIFTS_FILE = 'team_shifts.json'
BUGS_FILE = 'team_bugs.json'

def load_team_data():
    global team_users, team_tasks, team_news, team_shifts, team_bugs
    
    # Загружаем team_users из PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute("SELECT data FROM team_data WHERE key = 'team_users'")
            row = cur.fetchone()
            cur.close()
            conn.close()
            if row:
                team_users = row[0]
                print(f"👥 Loaded {len(team_users)} team users from PostgreSQL")
            else:
                # Создаем дефолтного пользователя
                team_users = {'romancev228': {'password': 'lolkek123', 'role': 'owner', 'full_name': 'Романцев', 'created_at': datetime.now().isoformat()}}
                save_team_users()
        except Exception as e:
            print(f"❌ Error loading team users from DB: {e}")
            # Fallback на файл
            try:
                with open(TEAM_FILE, 'r', encoding='utf-8') as f:
                    team_users = json.load(f)
            except:
                team_users = {'romancev228': {'password': 'lolkek123', 'role': 'owner', 'full_name': 'Романцев', 'created_at': datetime.now().isoformat()}}
                save_team_users()
    else:
        # Загружаем из файла
        try:
            with open(TEAM_FILE, 'r', encoding='utf-8') as f:
                team_users = json.load(f)
        except:
            team_users = {'romancev228': {'password': 'lolkek123', 'role': 'owner', 'full_name': 'Романцев', 'created_at': datetime.now().isoformat()}}
            save_team_users()
    
    try:
        with open(TASKS_FILE, 'r', encoding='utf-8') as f:
            team_tasks = json.load(f)
    except:
        team_tasks = []
    try:
        with open(NEWS_FILE, 'r', encoding='utf-8') as f:
            team_news = json.load(f)
    except:
        team_news = [{'id': 1, 'title': 'Добро пожаловать в SberUnion!', 'content': 'Система управления командой запущена. Начните работу с открытия смены.', 'created_at': datetime.now().isoformat(), 'author': 'Система'}]
        save_team_news()
    try:
        with open(SHIFTS_FILE, 'r', encoding='utf-8') as f:
            team_shifts = json.load(f)
    except:
        team_shifts = {}
    try:
        with open(BUGS_FILE, 'r', encoding='utf-8') as f:
            team_bugs = json.load(f)
    except:
        team_bugs = []

def save_team_users():
    # Сохраняем в PostgreSQL
    if DATABASE_URL and PSYCOPG_AVAILABLE:
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            # Сохраняем как один JSON объект
            cur.execute('''
                INSERT INTO team_data (key, data, updated_at)
                VALUES ('team_users', %s, CURRENT_TIMESTAMP)
                ON CONFLICT (key) 
                DO UPDATE SET data = %s, updated_at = CURRENT_TIMESTAMP
            ''', (Jsonb(team_users), Jsonb(team_users)))
            conn.commit()
            cur.close()
            conn.close()
            print(f"💾 Saved {len(team_users)} team users to PostgreSQL")
            return
        except Exception as e:
            print(f"❌ Error saving team users to DB: {e}")
    
    # Fallback на файл
    with open(TEAM_FILE, 'w', encoding='utf-8') as f:
        json.dump(team_users, f, ensure_ascii=False, indent=2)

def save_team_tasks():
    with open(TASKS_FILE, 'w', encoding='utf-8') as f:
        json.dump(team_tasks, f, ensure_ascii=False, indent=2)

def save_team_news():
    with open(NEWS_FILE, 'w', encoding='utf-8') as f:
        json.dump(team_news, f, ensure_ascii=False, indent=2)

def save_team_shifts():
    with open(SHIFTS_FILE, 'w', encoding='utf-8') as f:
        json.dump(team_shifts, f, ensure_ascii=False, indent=2)

def save_team_bugs():
    with open(BUGS_FILE, 'w', encoding='utf-8') as f:
        json.dump(team_bugs, f, ensure_ascii=False, indent=2)

load_team_data()
print(f"👥 Загружено пользователей: {len(team_users)}")
print(f"📋 Загружено задач: {len(team_tasks)}")
print(f"🔍 DATABASE_URL установлен: {bool(DATABASE_URL)}")
print(f"🔍 PSYCOPG_AVAILABLE: {PSYCOPG_AVAILABLE}")
if team_users:
    print(f"🔍 Пользователи: {list(team_users.keys())}")

@app.route('/admin/login', methods=['GET', 'POST'])
def team_login():
    if request.method == 'GET':
        error = request.args.get('error', '')
        html = '''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>SberUnion - Вход</title>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:Arial,sans-serif;background:linear-gradient(135deg,#21d4fd 0%,#b721ff 100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px}.card{background:#fff;border-radius:20px;padding:40px;max-width:400px;width:100%;box-shadow:0 20px 60px rgba(0,0,0,0.3)}h1{color:#333;margin-bottom:5px;font-size:28px}.subtitle{color:#666;margin-bottom:30px;font-size:14px}input{width:100%;padding:12px;border:2px solid #e0e0e0;border-radius:10px;margin:10px 0;font-size:14px}button{width:100%;padding:14px;background:linear-gradient(135deg,#21d4fd 0%,#b721ff 100%);color:#fff;border:none;border-radius:10px;font-size:16px;font-weight:700;cursor:pointer;margin-top:10px}button:hover{opacity:0.9}.error{background:#fee;color:#c33;padding:12px;border-radius:8px;margin-bottom:20px;font-size:14px}</style>
</head><body><div class="card"><h1>🚀 SberUnion</h1><p class="subtitle">Система управления командой</p>'''
        if error:
            html += f'<div class="error">{error}</div>'
        html += '''<form method="POST"><input type="text" name="username" placeholder="Логин" required><input type="password" name="password" placeholder="Пароль" required><button type="submit">Войти</button></form></div></body></html>'''
        return html
    
    username = request.form.get('username')
    password = request.form.get('password')
    
    if username in team_users and team_users[username]['password'] == password:
        session_token = str(uuid.uuid4())
        team_sessions[session_token] = {
            'username': username,
            'role': team_users[username]['role'],
            'created_at': datetime.now().isoformat(),
            'ip': request.remote_addr
        }
        response = make_response(redirect('/admin/dashboard'))
        response.set_cookie('team_session', session_token, max_age=86400)
        return response
    return redirect('/admin/login?error=Неверный логин или пароль')

@app.route('/admin/dashboard')
def team_dashboard():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    
    session = team_sessions[session_token]
    username = session['username']
    role = session['role']
    user = team_users[username]
    
    shift_opened = username in team_shifts and team_shifts[username].get('opened_at') and not team_shifts[username].get('closed_at')
    
    # Фильтруем задачи с учетом нового формата assigned_to (может быть список)
    pending_tasks = []
    my_tasks = []
    
    for t in team_tasks:
        assigned_to = t.get('assigned_to')
        
        # Проверяем pending задачи (назначенные текущему пользователю)
        if t['status'] == 'pending':
            if isinstance(assigned_to, list) and username in assigned_to:
                pending_tasks.append(t)
            elif assigned_to == username:
                pending_tasks.append(t)
        
        # Проверяем мои активные задачи
        if t['status'] in ['pending', 'in_progress']:
            accepted_by = t.get('accepted_by')
            if accepted_by == username:
                my_tasks.append(t)
            elif isinstance(assigned_to, list) and username in assigned_to and t['status'] == 'pending':
                my_tasks.append(t)
            elif assigned_to == username:
                my_tasks.append(t)
    completed_tasks = [t for t in team_tasks if t['status'] == 'completed']
    
    recent_news = sorted(team_news, key=lambda x: x['created_at'], reverse=True)[:5]
    
    online_count = sum(1 for tid in terminals if tid in last_seen and (datetime.now() - last_seen[tid]).total_seconds() < 30)
    offline_count = len(terminals) - online_count
    
    news_html = ''.join([f"<div class='news-item'><h4>{n['title']}</h4><p>{n['content']}</p><small>{n['created_at'][:16]} - {n['author']}</small></div>" for n in recent_news]) if recent_news else "<p style='color:#999'>Нет новостей</p>"
    
    # Генерируем HTML для задач с информацией о назначении
    def render_task_assigned(task):
        assigned_to = task.get('assigned_to')
        if isinstance(assigned_to, list):
            if len(assigned_to) > 3:
                return f"Назначено: {len(assigned_to)} сотрудникам"
            else:
                names = [team_users.get(u, {}).get('full_name', u) for u in assigned_to]
                return f"Назначено: {', '.join(names)}"
        elif assigned_to:
            return f"Назначено: {team_users.get(assigned_to, {}).get('full_name', assigned_to)}"
        else:
            return "Назначено: Всем"
    
    pending_html = ''.join([f"<div class='task-item'><h4>{t['title']}</h4><p>{t['description']}</p><small>Создал: {t['created_by']} | {t['created_at'][:10]}<br>{render_task_assigned(t)}</small><div class='task-actions'><button onclick='acceptTask({t['id']})'>Принять</button><button onclick='rejectTask({t['id']})' class='btn-reject'>Отклонить</button></div></div>" for t in pending_tasks]) if pending_tasks else "<p style='color:#999'>Нет новых задач</p>"
    
    my_html = ''.join([f"<div class='task-item'><h4>{t['title']}</h4><p>{t['description']}</p><small>Статус: {t['status']}<br>{render_task_assigned(t)}</small><button onclick='completeTask({t['id']})'>Завершить</button></div>" for t in my_tasks]) if my_tasks else "<p style='color:#999'>Нет активных задач</p>"
    
    completed_html = ''.join([f"<div class='task-item completed'><h4>{t['title']}</h4><p>{t['description']}</p><small>Завершено: {t.get('completed_at', 'N/A')[:16]}<br>{render_task_assigned(t)}</small></div>" for t in completed_tasks[-10:]]) if completed_tasks else "<p style='color:#999'>Нет завершённых задач</p>"
    
    role_features = ""
    if role == 'owner':
        role_features = '<div class="section"><h2>⚙️ Управление (Владелец)</h2><div class="btn-group"><button onclick="location.href=\'/admin/manage/users\'">👥 Пользователи</button><button onclick="location.href=\'/admin/manage/employees\'">👔 Сотрудники</button><button onclick="location.href=\'/admin/manage/tasks\'">📋 Создать задачу</button><button onclick="location.href=\'/admin/manage/news\'">📰 Добавить новость</button><button onclick="location.href=\'/admin/terminals\'">🖥️ Терминалы</button></div></div>'
    elif role == 'developer':
        role_features = '<div class="section"><h2>🔧 Инструменты разработчика</h2><div class="btn-group"><button onclick="location.href=\'/admin/terminals\'">🖥️ Терминалы</button><button onclick="location.href=\'/admin/logs\'">📜 Логи</button></div></div>'
    elif role == 'tester':
        role_features = '<div class="section"><h2>🧪 Инструменты тестировщика</h2><div class="btn-group"><button onclick="location.href=\'/admin/terminals\'">🖥️ Тестирование</button><button onclick="location.href=\'/admin/bugs\'">🐛 Отчёты</button></div></div>'
    
    shift_btn = f"<button onclick='openShift()' class='shift-btn'>Открыть смену</button>" if not shift_opened else f"<button onclick='closeShift()' class='shift-btn shift-close'>Закрыть смену</button>"

    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>SberUnion - Панель управления</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:linear-gradient(135deg,#21d4fd 0%,#b721ff 100%);color:#fff;padding:30px;border-radius:15px;margin-bottom:20px;box-shadow:0 4px 15px rgba(0,0,0,0.1)}}h1{{font-size:32px;margin-bottom:5px}}.subtitle{{opacity:0.9;font-size:14px}}.user-info{{float:right;text-align:right}}.user-info strong{{display:block;font-size:18px}}.user-info small{{opacity:0.8}}.stats{{display:flex;gap:20px;margin-bottom:20px}}.stat{{background:#fff;padding:20px;border-radius:10px;flex:1;text-align:center;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}.stat h3{{font-size:28px;color:#21d4fd;margin-bottom:5px}}.stat p{{color:#666;font-size:14px}}.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}h2{{color:#333;margin-bottom:20px;font-size:20px}}.news-item,.task-item{{background:#f9f9f9;padding:15px;border-radius:8px;margin-bottom:15px;border-left:4px solid #21d4fd}}.task-item.completed{{border-left-color:#27ae60;opacity:0.7}}.news-item h4,.task-item h4{{color:#333;margin-bottom:8px;font-size:16px}}.news-item p,.task-item p{{color:#666;font-size:14px;margin-bottom:8px}}.news-item small,.task-item small{{color:#999;font-size:12px}}button{{padding:10px 20px;background:linear-gradient(135deg,#21d4fd 0%,#b721ff 100%);color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:14px;font-weight:600;margin-right:10px}}button:hover{{opacity:0.9}}.btn-reject{{background:#e74c3c}}.shift-btn{{width:100%;padding:15px;font-size:16px;margin-bottom:20px}}.shift-close{{background:#e74c3c}}.task-actions{{margin-top:10px}}.logout{{background:#e74c3c;padding:8px 16px;border-radius:5px;color:#fff;text-decoration:none;font-size:14px;margin-left:15px}}.btn-group{{display:flex;gap:10px;flex-wrap:wrap}}.btn-group button{{flex:1;min-width:150px}}</style>
<script>
function openShift(){{fetch('/admin/shift/open',{{method:'POST'}}).then(r=>r.json()).then(d=>{{if(d.success)location.reload()}})}}
function closeShift(){{fetch('/admin/shift/close',{{method:'POST'}}).then(r=>r.json()).then(d=>{{if(d.success)location.reload()}})}}
function acceptTask(id){{fetch('/admin/task/accept',{{method:'POST',headers:{{'Content-Type':'application/json'}},body:JSON.stringify({{task_id:id}})}}).then(r=>r.json()).then(d=>{{if(d.success)location.reload()}})}}
function rejectTask(id){{let reason=prompt('Причина отклонения:');if(reason)fetch('/admin/task/reject',{{method:'POST',headers:{{'Content-Type':'application/json'}},body:JSON.stringify({{task_id:id,reason:reason}})}}).then(r=>r.json()).then(d=>{{if(d.success)location.reload()}})}}
function completeTask(id){{fetch('/admin/task/complete',{{method:'POST',headers:{{'Content-Type':'application/json'}},body:JSON.stringify({{task_id:id}})}}).then(r=>r.json()).then(d=>{{if(d.success)location.reload()}})}}
</script>
</head><body>
<div class="header"><div class="user-info"><strong>{user['full_name']}</strong><small>Роль: {role}</small><br><a href="/admin/logout" class="logout">Выйти</a></div><h1>🚀 Приветствуем в SberUnion команде!</h1><p class="subtitle">Система управления терминалами и задачами</p></div>
<div class="stats"><div class="stat"><h3>{online_count}</h3><p>Терминалов онлайн</p></div><div class="stat"><h3>{offline_count}</h3><p>Терминалов оффлайн</p></div><div class="stat"><h3>{len(pending_tasks)}</h3><p>Новых задач</p></div></div>
{shift_btn}
<div class="section"><h2>📰 Новости</h2>{news_html}</div>
<div class="section"><h2>📋 Новые задачи</h2>{pending_html}</div>
<div class="section"><h2>✅ Мои задачи</h2>{my_html}</div>
<div class="section"><h2>🎉 Завершённые задачи</h2>{completed_html}</div>
{role_features}
</body></html>'''
    return html

@app.route('/admin/shift/open', methods=['POST'])
def team_shift_open():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    username = team_sessions[session_token]['username']
    team_shifts[username] = {'opened_at': datetime.now().isoformat(), 'closed_at': None}
    save_team_shifts()
    return jsonify({'success': True})

@app.route('/admin/shift/close', methods=['POST'])
def team_shift_close():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    username = team_sessions[session_token]['username']
    if username in team_shifts:
        team_shifts[username]['closed_at'] = datetime.now().isoformat()
        save_team_shifts()
    return jsonify({'success': True})

@app.route('/admin/task/accept', methods=['POST'])
def team_task_accept():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    username = team_sessions[session_token]['username']
    data = request.json
    task_id = data.get('task_id')
    for task in team_tasks:
        if task['id'] == task_id:
            # Проверяем, назначена ли задача этому пользователю
            assigned_to = task.get('assigned_to')
            if isinstance(assigned_to, list):
                if username not in assigned_to:
                    return jsonify({'error': 'Task not assigned to you', 'success': False}), 403
            
            task['status'] = 'in_progress'
            task['accepted_by'] = username  # Кто принял задачу
            save_team_tasks()
            return jsonify({'success': True})
    return jsonify({'error': 'Task not found'}), 404

@app.route('/admin/task/reject', methods=['POST'])
def team_task_reject():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    data = request.json
    task_id = data.get('task_id')
    reason = data.get('reason')
    for task in team_tasks:
        if task['id'] == task_id:
            task['status'] = 'rejected'
            task['reject_reason'] = reason
            save_team_tasks()
            return jsonify({'success': True})
    return jsonify({'error': 'Task not found'}), 404

@app.route('/admin/task/complete', methods=['POST'])
def team_task_complete():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    data = request.json
    task_id = data.get('task_id')
    for task in team_tasks:
        if task['id'] == task_id:
            task['status'] = 'completed'
            task['completed_at'] = datetime.now().isoformat()
            save_team_tasks()
            return jsonify({'success': True})
    return jsonify({'error': 'Task not found'}), 404

@app.route('/admin/terminals')
def team_terminals():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    
    online_terminals = []
    offline_terminals = []
    
    for terminal_id, terminal in terminals.items():
        if terminal_id in last_seen:
            last_seen_dt = last_seen[terminal_id]
            if (datetime.now() - last_seen_dt).total_seconds() < 30:
                online_terminals.append({
                    'id': terminal_id,
                    'state': terminal.get('current_payload', {}).get('state', 'idle'),
                    'last_seen': last_seen_dt.strftime('%H:%M:%S'),
                    'uuid': terminal.get('uuid', 'N/A'),
                    'password': terminal.get('password', 'N/A'),
                    'qr_password': terminal.get('qr_password', 'N/A')
                })
            else:
                offline_terminals.append({
                    'id': terminal_id,
                    'last_seen': last_seen_dt.strftime('%Y-%m-%d %H:%M:%S'),
                    'password': terminal.get('password', 'N/A')
                })
    
    online_rows = ''.join([f"<tr><td>{t['id']}</td><td><span class='status-{t['state']}'>{t['state']}</span></td><td>{t['uuid']}</td><td><code>{t['password']}</code></td><td><code>{t['qr_password']}</code></td><td>{t['last_seen']}</td></tr>" for t in online_terminals])
    offline_rows = ''.join([f"<tr><td>{t['id']}</td><td><code>{t['password']}</code></td><td>{t['last_seen']}</td></tr>" for t in offline_terminals])
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><meta http-equiv="refresh" content="5"><title>Мониторинг терминалов</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}h1{{color:#333}}.stats{{display:flex;gap:20px;margin:20px 0}}.stat{{background:linear-gradient(135deg,#21d4fd 0%,#b721ff 100%);color:#fff;padding:20px;border-radius:10px;flex:1;text-align:center}}.stat h2{{font-size:32px;margin-bottom:5px}}.stat p{{font-size:14px;opacity:0.9}}.section{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1)}}h2{{color:#333;margin-bottom:15px}}table{{width:100%;border-collapse:collapse}}th,td{{padding:12px;text-align:left;border-bottom:1px solid #e0e0e0}}th{{background:#f8f8f8;font-weight:600;color:#666}}tr:hover{{background:#f9f9f9}}button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;text-decoration:none;display:inline-block;font-size:14px}}button:hover{{opacity:0.9}}.status-idle{{color:#999}}.status-pay{{color:#f39c12;font-weight:600}}.status-success{{color:#27ae60;font-weight:600}}.status-error{{color:#e74c3c;font-weight:600}}code{{background:#f0f0f0;padding:4px 8px;border-radius:4px;font-family:monospace;font-size:13px;color:#e74c3c;font-weight:600}}</style>
</head><body><div class="header"><h1>🖥️ Мониторинг терминалов</h1><button onclick="location.href='/admin/dashboard'">← Назад</button></div>
<div class="stats"><div class="stat"><h2>{len(online_terminals)}</h2><p>Онлайн</p></div><div class="stat"><h2>{len(offline_terminals)}</h2><p>Оффлайн</p></div><div class="stat"><h2>{len(terminals)}</h2><p>Всего</p></div></div>
<div class="section"><h2>✅ Онлайн терминалы</h2><table><tr><th>ID</th><th>Состояние</th><th>UUID</th><th>Пароль</th><th>QR пароль</th><th>Последняя активность</th></tr>{online_rows if online_rows else "<tr><td colspan='6' style='text-align:center;color:#999'>Нет онлайн терминалов</td></tr>"}</table></div>
<div class="section"><h2>❌ Оффлайн терминалы</h2><table><tr><th>ID</th><th>Пароль</th><th>Последняя активность</th></tr>{offline_rows if offline_rows else "<tr><td colspan='3' style='text-align:center;color:#999'>Нет оффлайн терминалов</td></tr>"}</table></div>
</body></html>'''
    return html

@app.route('/admin/manage/users', methods=['GET', 'POST'])
def manage_users():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    if team_sessions[session_token]['role'] != 'owner':
        return "Access denied", 403
    
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        role = request.form.get('role')
        full_name = request.form.get('full_name')
        
        team_users[username] = {
            'password': password,
            'role': role,
            'full_name': full_name,
            'created_at': datetime.now().isoformat()
        }
        save_team_users()
        return redirect('/admin/manage/users?success=1')
    
    users_rows = ''.join([f"<tr><td>{u}</td><td>{team_users[u]['full_name']}</td><td>{team_users[u]['role']}</td><td>{team_users[u]['created_at'][:10]}</td></tr>" for u in team_users])
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Управление пользователями</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}h1{{color:#333}}.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}h2{{color:#333;margin-bottom:20px}}table{{width:100%;border-collapse:collapse}}th,td{{padding:12px;text-align:left;border-bottom:1px solid #e0e0e0}}th{{background:#f8f8f8;font-weight:600;color:#666}}tr:hover{{background:#f9f9f9}}input,select{{width:100%;padding:10px;border:2px solid #e0e0e0;border-radius:5px;margin:5px 0;font-size:14px}}button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px;margin-top:10px}}button:hover{{opacity:0.9}}.form-group{{margin-bottom:15px}}label{{display:block;color:#666;margin-bottom:5px;font-weight:600}}.success{{background:#d4edda;color:#155724;padding:12px;border-radius:5px;margin-bottom:20px}}</style>
</head><body><div class="header"><h1>👥 Управление пользователями</h1><button onclick="location.href='/admin/dashboard'">← Назад</button></div>
{"<div class='success'>Пользователь успешно добавлен!</div>" if request.args.get('success') else ""}
<div class="section"><h2>Добавить пользователя</h2>
<form method="POST">
<div class="form-group"><label>Логин:</label><input type="text" name="username" required></div>
<div class="form-group"><label>Пароль:</label><input type="password" name="password" required></div>
<div class="form-group"><label>Полное имя:</label><input type="text" name="full_name" required></div>
<div class="form-group"><label>Роль:</label><select name="role" required>
<option value="developer">Разработчик</option>
<option value="tester">Тестировщик</option>
<option value="owner">Владелец</option>
</select></div>
<button type="submit">Добавить пользователя</button>
</form></div>
<div class="section"><h2>Список пользователей</h2>
<table><tr><th>Логин</th><th>Имя</th><th>Роль</th><th>Создан</th></tr>{users_rows}</table></div>
</body></html>'''
    return html

@app.route('/admin/manage/tasks', methods=['GET', 'POST'])
def manage_tasks():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    if team_sessions[session_token]['role'] != 'owner':
        return "Access denied", 403
    
    if request.method == 'POST':
        title = request.form.get('title')
        description = request.form.get('description')
        assign_type = request.form.get('assign_type', 'all')  # all, role, specific
        target_role = request.form.get('target_role', '')
        target_users = request.form.getlist('target_users[]')
        
        # Определяем кому назначена задача
        assigned_to = []
        if assign_type == 'all':
            assigned_to = list(team_users.keys())
        elif assign_type == 'role' and target_role:
            assigned_to = [username for username, user in team_users.items() if user.get('role') == target_role]
        elif assign_type == 'specific':
            assigned_to = target_users
        
        new_id = max([t['id'] for t in team_tasks], default=0) + 1
        team_tasks.append({
            'id': new_id,
            'title': title,
            'description': description,
            'created_by': team_sessions[session_token]['username'],
            'created_at': datetime.now().isoformat(),
            'status': 'pending',
            'assigned_to': assigned_to,  # Теперь это список
            'assign_type': assign_type,
            'target_role': target_role if assign_type == 'role' else None
        })
        save_team_tasks()
        return redirect('/admin/manage/tasks?success=1')
    
    # Генерируем список пользователей для выбора
    users_checkboxes = ''
    for username, user in team_users.items():
        full_name = user.get('full_name', username)
        role = user.get('role', 'unknown')
        users_checkboxes += f'<label class="checkbox-label"><input type="checkbox" name="target_users[]" value="{username}" class="user-checkbox"> {full_name} ({role})</label>'
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Управление задачами</title>
<style>
*{{margin:0;padding:0;box-sizing:border-box}}
body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}
.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}
h1{{color:#333}}
.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}
h2{{color:#333;margin-bottom:20px}}
input,textarea,select{{width:100%;padding:10px;border:2px solid #e0e0e0;border-radius:5px;margin:5px 0;font-size:14px;font-family:Arial,sans-serif}}
textarea{{min-height:100px}}
button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px;margin-top:10px}}
button:hover{{opacity:0.9}}
.form-group{{margin-bottom:15px}}
label{{display:block;color:#666;margin-bottom:5px;font-weight:600}}
.success{{background:#d4edda;color:#155724;padding:12px;border-radius:5px;margin-bottom:20px}}
.assign-section{{display:none;margin-top:10px;padding:15px;background:#f9f9f9;border-radius:8px}}
.assign-section.active{{display:block}}
.checkbox-label{{display:block;padding:8px;margin:5px 0;background:#fff;border-radius:5px;cursor:pointer;font-weight:normal}}
.checkbox-label:hover{{background:#f0f0f0}}
.checkbox-label input{{width:auto;margin-right:10px}}
.btn-select-all{{background:#27ae60;padding:8px 15px;font-size:13px;margin-bottom:10px}}
</style>
<script>
function updateAssignSection() {{
    const assignType = document.getElementById('assign_type').value;
    document.querySelectorAll('.assign-section').forEach(el => el.classList.remove('active'));
    if (assignType === 'role') {{
        document.getElementById('role-section').classList.add('active');
    }} else if (assignType === 'specific') {{
        document.getElementById('users-section').classList.add('active');
    }}
}}
function selectAllUsers() {{
    document.querySelectorAll('.user-checkbox').forEach(cb => cb.checked = true);
}}
function deselectAllUsers() {{
    document.querySelectorAll('.user-checkbox').forEach(cb => cb.checked = false);
}}
</script>
</head><body>
<div class="header">
    <h1>📋 Управление задачами</h1>
    <button onclick="location.href='/admin/dashboard'">← Назад</button>
</div>
{"<div class='success'>Задача успешно создана!</div>" if request.args.get('success') else ""}
<div class="section">
    <h2>Создать новую задачу</h2>
    <form method="POST">
        <div class="form-group">
            <label>Название:</label>
            <input type="text" name="title" required>
        </div>
        <div class="form-group">
            <label>Описание:</label>
            <textarea name="description" required></textarea>
        </div>
        <div class="form-group">
            <label>Назначить задачу:</label>
            <select name="assign_type" id="assign_type" onchange="updateAssignSection()">
                <option value="all">Всем сотрудникам</option>
                <option value="role">По роли</option>
                <option value="specific">Конкретным сотрудникам</option>
            </select>
        </div>
        
        <div id="role-section" class="assign-section">
            <label>Выберите роль:</label>
            <select name="target_role">
                <option value="">-- Выберите роль --</option>
                <option value="owner">Владелец</option>
                <option value="developer">Разработчик</option>
                <option value="tester">Тестировщик</option>
                <option value="employee">Сотрудник</option>
            </select>
        </div>
        
        <div id="users-section" class="assign-section">
            <button type="button" onclick="selectAllUsers()" class="btn-select-all">✓ Выбрать всех</button>
            <button type="button" onclick="deselectAllUsers()" class="btn-select-all" style="background:#e74c3c">✗ Снять выбор</button>
            <div style="margin-top:10px">
                {users_checkboxes}
            </div>
        </div>
        
        <button type="submit">Создать задачу</button>
    </form>
</div>
</body></html>'''
    return html

@app.route('/admin/manage/news', methods=['GET', 'POST'])
def manage_news():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    if team_sessions[session_token]['role'] != 'owner':
        return "Access denied", 403
    
    if request.method == 'POST':
        title = request.form.get('title')
        content = request.form.get('content')
        
        new_id = max([n['id'] for n in team_news], default=0) + 1
        team_news.append({
            'id': new_id,
            'title': title,
            'content': content,
            'created_at': datetime.now().isoformat(),
            'author': team_sessions[session_token]['username']
        })
        save_team_news()
        return redirect('/admin/manage/news?success=1')
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Управление новостями</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}h1{{color:#333}}.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}h2{{color:#333;margin-bottom:20px}}input,textarea{{width:100%;padding:10px;border:2px solid #e0e0e0;border-radius:5px;margin:5px 0;font-size:14px;font-family:Arial,sans-serif}}textarea{{min-height:100px}}button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px;margin-top:10px}}button:hover{{opacity:0.9}}.form-group{{margin-bottom:15px}}label{{display:block;color:#666;margin-bottom:5px;font-weight:600}}.success{{background:#d4edda;color:#155724;padding:12px;border-radius:5px;margin-bottom:20px}}</style>
</head><body><div class="header"><h1>📰 Управление новостями</h1><button onclick="location.href='/admin/dashboard'">← Назад</button></div>
{"<div class='success'>Новость успешно добавлена!</div>" if request.args.get('success') else ""}
<div class="section"><h2>Добавить новость</h2>
<form method="POST">
<div class="form-group"><label>Заголовок:</label><input type="text" name="title" required></div>
<div class="form-group"><label>Содержание:</label><textarea name="content" required></textarea></div>
<button type="submit">Опубликовать новость</button>
</form></div>
</body></html>'''
    return html

@app.route('/admin/manage/employees')
def manage_employees():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    if team_sessions[session_token]['role'] != 'owner':
        return "Access denied", 403
    
    employees_rows = ""
    for username, user in team_users.items():
        shift_status = "❌ Смена закрыта"
        shift_time = ""
        if username in team_shifts:
            shift = team_shifts[username]
            if shift.get('opened_at') and not shift.get('closed_at'):
                shift_status = "✅ Смена открыта"
                opened = datetime.fromisoformat(shift['opened_at'])
                duration = datetime.now() - opened
                hours = int(duration.total_seconds() // 3600)
                minutes = int((duration.total_seconds() % 3600) // 60)
                shift_time = f"{hours}ч {minutes}м"
            elif shift.get('closed_at'):
                shift_status = "❌ Смена закрыта"
                closed = datetime.fromisoformat(shift['closed_at'])
                shift_time = closed.strftime('%H:%M')
        
        employees_rows += f"<tr><td>{username}</td><td>{user['full_name']}</td><td>{user['role']}</td><td>{shift_status}</td><td>{shift_time}</td></tr>"
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Сотрудники</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}h1{{color:#333}}.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}h2{{color:#333;margin-bottom:20px}}table{{width:100%;border-collapse:collapse}}th,td{{padding:12px;text-align:left;border-bottom:1px solid #e0e0e0}}th{{background:#f8f8f8;font-weight:600;color:#666}}tr:hover{{background:#f9f9f9}}button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px}}button:hover{{opacity:0.9}}</style>
<script>setInterval(function(){{location.reload()}}, 10000);</script>
</head><body><div class="header"><h1>👔 Сотрудники</h1><button onclick="location.href='/admin/dashboard'">← Назад</button></div>
<div class="section"><h2>Список сотрудников и их статус</h2>
<table><tr><th>Логин</th><th>Имя</th><th>Роль</th><th>Статус смены</th><th>Время</th></tr>{employees_rows}</table></div>
</body></html>'''
    return html

@app.route('/admin/logs')
def admin_logs():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    
    # Читаем последние 100 строк логов из консоли (если есть)
    logs = []
    try:
        # Здесь можно добавить чтение из файла логов если он есть
        logs.append({'time': datetime.now().strftime('%H:%M:%S'), 'level': 'INFO', 'message': 'Система работает нормально'})
        logs.append({'time': datetime.now().strftime('%H:%M:%S'), 'level': 'INFO', 'message': f'Терминалов онлайн: {sum(1 for tid in terminals if tid in last_seen and (datetime.now() - last_seen[tid]).total_seconds() < 30)}'})
        logs.append({'time': datetime.now().strftime('%H:%M:%S'), 'level': 'INFO', 'message': f'Активных сессий: {len(team_sessions)}'})
    except:
        pass
    
    logs_rows = ''.join([f"<tr><td>{log['time']}</td><td class='level-{log['level'].lower()}'>{log['level']}</td><td>{log['message']}</td></tr>" for log in logs])
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><meta http-equiv="refresh" content="10"><title>Логи системы</title>
<style>*{{margin:0;padding:0;box-sizing:border-box}}body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}h1{{color:#333}}.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}h2{{color:#333;margin-bottom:20px}}table{{width:100%;border-collapse:collapse;font-family:monospace}}th,td{{padding:12px;text-align:left;border-bottom:1px solid #e0e0e0}}th{{background:#f8f8f8;font-weight:600;color:#666}}tr:hover{{background:#f9f9f9}}button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px}}button:hover{{opacity:0.9}}.level-info{{color:#3498db}}.level-warning{{color:#f39c12}}.level-error{{color:#e74c3c}}</style>
</head><body><div class="header"><h1>📜 Логи системы</h1><button onclick="location.href='/admin/dashboard'">← Назад</button></div>
<div class="section"><h2>Последние события</h2>
<table><tr><th>Время</th><th>Уровень</th><th>Сообщение</th></tr>{logs_rows if logs_rows else "<tr><td colspan='3' style='text-align:center;color:#999'>Нет логов</td></tr>"}</table></div>
</body></html>'''
    return html

@app.route('/admin/bugs')
def admin_bugs():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return redirect('/admin/login')
    
    session = team_sessions[session_token]
    username = session['username']
    role = session['role']
    
    # Фильтруем баги по статусу
    open_bugs = [b for b in team_bugs if b['status'] == 'open']
    in_progress_bugs = [b for b in team_bugs if b['status'] == 'in_progress']
    resolved_bugs = [b for b in team_bugs if b['status'] == 'resolved']
    cancelled_bugs = [b for b in team_bugs if b['status'] == 'cancelled']
    
    # Генерируем HTML для списка багов
    def render_bug_item(bug):
        severity_colors = {
            'critical': '#e74c3c',
            'medium': '#f39c12',
            'minor': '#3498db'
        }
        severity_labels = {
            'critical': '🔴 Критичный',
            'medium': '🟡 Средний',
            'minor': '🔵 Мелкий'
        }
        
        color = severity_colors.get(bug['severity'], '#999')
        label = severity_labels.get(bug['severity'], bug['severity'])
        
        actions = ''
        if bug['status'] == 'open' and role in ['owner', 'developer']:
            actions = f'''
                <button onclick="takeBug({bug['id']})" class="btn-take">Взять в работу</button>
                <button onclick="cancelBug({bug['id']})" class="btn-cancel">Отменить</button>
            '''
        elif bug['status'] == 'in_progress' and role in ['owner', 'developer']:
            actions = f'''
                <button onclick="resolveBug({bug['id']})" class="btn-resolve">Решить</button>
                <button onclick="cancelBug({bug['id']})" class="btn-cancel">Отменить</button>
            '''
        
        assigned_info = f"<p><strong>Исполнитель:</strong> {bug.get('assigned_to', 'Не назначен')}</p>" if bug.get('assigned_to') else ''
        cancel_reason = f"<p><strong>Причина отмены:</strong> {bug.get('cancel_reason', '')}</p>" if bug.get('cancel_reason') else ''
        
        return f'''
            <div class="bug-item" style="border-left: 4px solid {color}">
                <div class="bug-header">
                    <span class="bug-severity" style="color: {color}">{label}</span>
                    <span class="bug-id">#{bug['id']}</span>
                </div>
                <p class="bug-description">{bug['description']}</p>
                <div class="bug-meta">
                    <small>Создал: {bug['created_by']} | {bug['created_at'][:16]}</small>
                    {assigned_info}
                    {cancel_reason}
                </div>
                <div class="bug-actions">{actions}</div>
            </div>
        '''
    
    open_html = ''.join([render_bug_item(b) for b in open_bugs]) if open_bugs else "<p class='empty'>Нет открытых багов</p>"
    in_progress_html = ''.join([render_bug_item(b) for b in in_progress_bugs]) if in_progress_bugs else "<p class='empty'>Нет багов в работе</p>"
    resolved_html = ''.join([render_bug_item(b) for b in resolved_bugs]) if resolved_bugs else "<p class='empty'>Нет решённых багов</p>"
    cancelled_html = ''.join([render_bug_item(b) for b in cancelled_bugs]) if cancelled_bugs else "<p class='empty'>Нет отменённых багов</p>"
    
    html = f'''<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Отчёты о багах</title>
<style>
*{{margin:0;padding:0;box-sizing:border-box}}
body{{font-family:Arial,sans-serif;background:#f5f5f5;padding:20px}}
.header{{background:#fff;padding:20px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.1);display:flex;justify-content:space-between;align-items:center}}
h1{{color:#333}}
.section{{background:#fff;padding:25px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 10px rgba(0,0,0,0.05)}}
h2{{color:#333;margin-bottom:20px;font-size:18px}}
button{{padding:10px 20px;background:#21d4fd;color:#fff;border:none;border-radius:5px;cursor:pointer;font-size:14px;margin-right:10px}}
button:hover{{opacity:0.9}}
.btn-report{{background:linear-gradient(135deg,#e74c3c 0%,#c0392b 100%);font-weight:600}}
.btn-take{{background:#3498db}}
.btn-resolve{{background:#27ae60}}
.btn-cancel{{background:#e74c3c}}
.bug-item{{background:#f9f9f9;padding:15px;border-radius:8px;margin-bottom:15px}}
.bug-header{{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}}
.bug-severity{{font-weight:600;font-size:14px}}
.bug-id{{color:#999;font-size:12px}}
.bug-description{{color:#333;margin-bottom:10px;line-height:1.5}}
.bug-meta{{color:#666;font-size:13px;margin-bottom:10px}}
.bug-meta p{{margin:5px 0}}
.bug-actions{{margin-top:10px}}
.empty{{color:#999;text-align:center;padding:20px}}
.modal{{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:1000;align-items:center;justify-content:center}}
.modal.active{{display:flex}}
.modal-content{{background:#fff;padding:30px;border-radius:15px;max-width:500px;width:90%}}
.modal-content h2{{margin-bottom:20px}}
.form-group{{margin-bottom:20px}}
.form-group label{{display:block;margin-bottom:8px;color:#333;font-weight:600}}
.form-group select,.form-group textarea{{width:100%;padding:12px;border:2px solid #e0e0e0;border-radius:8px;font-size:14px;font-family:Arial,sans-serif}}
.form-group textarea{{min-height:120px;resize:vertical}}
.modal-buttons{{display:flex;gap:10px}}
.modal-buttons button{{flex:1}}
.stats{{display:flex;gap:15px;margin-bottom:20px}}
.stat{{background:#fff;padding:15px;border-radius:8px;flex:1;text-align:center;box-shadow:0 2px 5px rgba(0,0,0,0.05)}}
.stat h3{{font-size:24px;margin-bottom:5px}}
.stat.critical h3{{color:#e74c3c}}
.stat.medium h3{{color:#f39c12}}
.stat.minor h3{{color:#3498db}}
.stat p{{color:#666;font-size:13px}}
</style>
<script>
function showReportModal() {{
    document.getElementById('reportModal').classList.add('active');
}}
function hideReportModal() {{
    document.getElementById('reportModal').classList.remove('active');
}}
function submitBug() {{
    const severity = document.getElementById('severity').value;
    const description = document.getElementById('description').value;
    
    if (!description.trim()) {{
        alert('Пожалуйста, опишите баг');
        return;
    }}
    
    fetch('/admin/bugs/report', {{
        method: 'POST',
        headers: {{'Content-Type': 'application/json'}},
        body: JSON.stringify({{severity, description}})
    }})
    .then(r => r.json())
    .then(d => {{
        if (d.success) {{
            location.reload();
        }} else {{
            alert('Ошибка: ' + (d.error || 'Неизвестная ошибка'));
        }}
    }});
}}
function takeBug(id) {{
    fetch('/admin/bugs/take', {{
        method: 'POST',
        headers: {{'Content-Type': 'application/json'}},
        body: JSON.stringify({{bug_id: id}})
    }})
    .then(r => r.json())
    .then(d => {{
        if (d.success) location.reload();
        else alert('Ошибка: ' + (d.error || 'Неизвестная ошибка'));
    }});
}}
function resolveBug(id) {{
    fetch('/admin/bugs/resolve', {{
        method: 'POST',
        headers: {{'Content-Type': 'application/json'}},
        body: JSON.stringify({{bug_id: id}})
    }})
    .then(r => r.json())
    .then(d => {{
        if (d.success) location.reload();
        else alert('Ошибка: ' + (d.error || 'Неизвестная ошибка'));
    }});
}}
function cancelBug(id) {{
    const reason = prompt('Укажите причину отмены:');
    if (!reason) return;
    
    fetch('/admin/bugs/cancel', {{
        method: 'POST',
        headers: {{'Content-Type': 'application/json'}},
        body: JSON.stringify({{bug_id: id, reason}})
    }})
    .then(r => r.json())
    .then(d => {{
        if (d.success) location.reload();
        else alert('Ошибка: ' + (d.error || 'Неизвестная ошибка'));
    }});
}}
</script>
</head><body>
<div class="header">
    <h1>🐛 Отчёты о багах</h1>
    <div>
        <button onclick="showReportModal()" class="btn-report">+ Заявить о баге</button>
        <button onclick="location.href='/admin/dashboard'">← Назад</button>
    </div>
</div>

<div class="stats">
    <div class="stat critical">
        <h3>{len([b for b in team_bugs if b['severity'] == 'critical' and b['status'] in ['open', 'in_progress']])}</h3>
        <p>Критичных</p>
    </div>
    <div class="stat medium">
        <h3>{len([b for b in team_bugs if b['severity'] == 'medium' and b['status'] in ['open', 'in_progress']])}</h3>
        <p>Средних</p>
    </div>
    <div class="stat minor">
        <h3>{len([b for b in team_bugs if b['severity'] == 'minor' and b['status'] in ['open', 'in_progress']])}</h3>
        <p>Мелких</p>
    </div>
</div>

<div class="section">
    <h2>📋 Открытые баги</h2>
    {open_html}
</div>

<div class="section">
    <h2>🔧 В работе</h2>
    {in_progress_html}
</div>

<div class="section">
    <h2>✅ Решённые</h2>
    {resolved_html}
</div>

<div class="section">
    <h2>❌ Отменённые</h2>
    {cancelled_html}
</div>

<div id="reportModal" class="modal">
    <div class="modal-content">
        <h2>🐛 Заявить о баге</h2>
        <div class="form-group">
            <label>Критичность:</label>
            <select id="severity">
                <option value="critical">🔴 Критичный</option>
                <option value="medium" selected>🟡 Средний</option>
                <option value="minor">🔵 Мелкий</option>
            </select>
        </div>
        <div class="form-group">
            <label>Опишите баг:</label>
            <textarea id="description" placeholder="Подробно опишите проблему..."></textarea>
        </div>
        <div class="modal-buttons">
            <button onclick="submitBug()">Отправить</button>
            <button onclick="hideReportModal()" style="background:#95a5a6">Отменить</button>
        </div>
    </div>
</div>

</body></html>'''
    return html

@app.route('/admin/bugs/report', methods=['POST'])
def report_bug():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    
    session = team_sessions[session_token]
    username = session['username']
    
    data = request.json
    severity = data.get('severity', 'medium')
    description = data.get('description', '').strip()
    
    if not description:
        return jsonify({'error': 'Description is required', 'success': False}), 400
    
    # Генерируем ID
    bug_id = max([b['id'] for b in team_bugs], default=0) + 1
    
    bug = {
        'id': bug_id,
        'severity': severity,
        'description': description,
        'status': 'open',
        'created_by': username,
        'created_at': datetime.now().isoformat(),
        'assigned_to': None,
        'resolved_at': None,
        'cancel_reason': None
    }
    
    team_bugs.append(bug)
    save_team_bugs()
    
    print(f"🐛 [BUG REPORT] #{bug_id} by {username}: {severity} - {description[:50]}")
    
    return jsonify({'success': True, 'bug_id': bug_id}), 200

@app.route('/admin/bugs/take', methods=['POST'])
def take_bug():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    
    session = team_sessions[session_token]
    username = session['username']
    role = session['role']
    
    if role not in ['owner', 'developer']:
        return jsonify({'error': 'Access denied', 'success': False}), 403
    
    data = request.json
    bug_id = data.get('bug_id')
    
    for bug in team_bugs:
        if bug['id'] == bug_id:
            bug['status'] = 'in_progress'
            bug['assigned_to'] = username
            save_team_bugs()
            print(f"🐛 [BUG TAKE] #{bug_id} taken by {username}")
            return jsonify({'success': True}), 200
    
    return jsonify({'error': 'Bug not found', 'success': False}), 404

@app.route('/admin/bugs/resolve', methods=['POST'])
def resolve_bug():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    
    session = team_sessions[session_token]
    role = session['role']
    
    if role not in ['owner', 'developer']:
        return jsonify({'error': 'Access denied', 'success': False}), 403
    
    data = request.json
    bug_id = data.get('bug_id')
    
    for bug in team_bugs:
        if bug['id'] == bug_id:
            bug['status'] = 'resolved'
            bug['resolved_at'] = datetime.now().isoformat()
            save_team_bugs()
            print(f"🐛 [BUG RESOLVE] #{bug_id} resolved")
            return jsonify({'success': True}), 200
    
    return jsonify({'error': 'Bug not found', 'success': False}), 404

@app.route('/admin/bugs/cancel', methods=['POST'])
def cancel_bug():
    session_token = request.cookies.get('team_session')
    if not session_token or session_token not in team_sessions:
        return jsonify({'error': 'Unauthorized'}), 401
    
    session = team_sessions[session_token]
    role = session['role']
    
    if role not in ['owner', 'developer']:
        return jsonify({'error': 'Access denied', 'success': False}), 403
    
    data = request.json
    bug_id = data.get('bug_id')
    reason = data.get('reason', '').strip()
    
    if not reason:
        return jsonify({'error': 'Reason is required', 'success': False}), 400
    
    for bug in team_bugs:
        if bug['id'] == bug_id:
            bug['status'] = 'cancelled'
            bug['cancel_reason'] = reason
            save_team_bugs()
            print(f"🐛 [BUG CANCEL] #{bug_id} cancelled: {reason}")
            return jsonify({'success': True}), 200
    
    return jsonify({'error': 'Bug not found', 'success': False}), 404

@app.route('/admin/logout')
def team_logout():
    session_token = request.cookies.get('team_session')
    if session_token and session_token in team_sessions:
        del team_sessions[session_token]
    response = make_response(redirect('/admin/login'))
    response.set_cookie('team_session', '', max_age=0)
    return response

# ===== КАБИНЕТ УПРАВЛЕНИЯ ТЕРМИНАЛАМИ =====

@app.route('/cabinet')
def cabinet():
    """Простой кабинет для управления терминалами и оплатами (без показа всех терминалов)"""
    
    html = '''<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Кабинет управления терминалами</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { 
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}
.container { max-width: 800px; margin: 0 auto; }
.header {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    margin-bottom: 30px;
}
h1 { color: #333; font-size: 28px; margin-bottom: 10px; }
.subtitle { color: #666; font-size: 14px; }
.section {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    margin-bottom: 20px;
}
.section.hidden { display: none; }
h2 { color: #333; margin-bottom: 20px; font-size: 20px; }
.form-group { margin-bottom: 15px; }
label { display: block; color: #555; font-weight: 600; margin-bottom: 5px; font-size: 14px; }
input {
    width: 100%;
    padding: 12px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 14px;
    transition: border 0.3s;
}
input:focus {
    outline: none;
    border-color: #667eea;
}
.btn {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    margin-right: 10px;
    margin-top: 10px;
}
.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
}
.btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4); }
.btn-success {
    background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
    color: white;
}
.btn-success:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4); }
.btn-danger {
    background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
    color: white;
}
.btn-danger:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(235, 51, 73, 0.4); }
.btn-secondary {
    background: #6c757d;
    color: white;
}
.btn-secondary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4); }
.message {
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
}
.message-success { background: #e8f5e9; color: #2e7d32; border-left: 4px solid #4caf50; }
.message-error { background: #ffebee; color: #c62828; border-left: 4px solid #f44336; }
.quick-amounts {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 10px;
}
.quick-amount {
    padding: 8px 16px;
    background: #f5f5f5;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.3s;
}
.quick-amount:hover {
    background: #667eea;
    color: white;
    border-color: #667eea;
}
.terminal-info {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 20px;
}
.info-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px solid #e0e0e0;
}
.info-row:last-child {
    border-bottom: none;
}
.info-label {
    font-weight: 600;
    color: #555;
}
.info-value {
    color: #333;
    font-family: monospace;
}
</style>
</head><body>
<div class="container">
    <div class="header">
        <h1>💳 Кабинет управления терминалами</h1>
        <p class="subtitle">Управление терминалами и оплатами SberPOS</p>
    </div>
    
    <div id="message"></div>
    
    <!-- Секция подключения (показывается если терминал не подключен) -->
    <div id="connectSection" class="section">
        <h2>🔐 Подключить терминал</h2>
        <div class="form-group">
            <label>ID терминала (TRM-####)</label>
            <input type="text" id="terminalId" placeholder="TRM-1234" maxlength="8">
        </div>
        <div class="form-group">
            <label>Пароль терминала (6 цифр)</label>
            <input type="password" id="terminalPassword" placeholder="123456" maxlength="6">
        </div>
        <button class="btn btn-primary" onclick="connectTerminal()">Подключить</button>
    </div>
    
    <!-- Секция управления (показывается после подключения) -->
    <div id="controlSection" class="section hidden">
        <div class="terminal-info">
            <h3 style="margin-bottom: 15px;">📱 Подключенный терминал</h3>
            <div class="info-row">
                <span class="info-label">ID:</span>
                <span class="info-value" id="connectedId">-</span>
            </div>
            <button class="btn btn-secondary btn-sm" onclick="disconnectTerminal()" style="margin-top: 15px; padding: 8px 16px; font-size: 13px;">Отключить терминал</button>
        </div>
        
        <h2>💰 Отправить оплату</h2>
        <div class="form-group">
            <label>Сумма оплаты (₽)</label>
            <input type="number" id="paymentAmount" placeholder="100" min="1">
            <div class="quick-amounts">
                <div class="quick-amount" onclick="setAmount(100)">100 ₽</div>
                <div class="quick-amount" onclick="setAmount(500)">500 ₽</div>
                <div class="quick-amount" onclick="setAmount(1000)">1000 ₽</div>
                <div class="quick-amount" onclick="setAmount(5000)">5000 ₽</div>
            </div>
        </div>
        <button class="btn btn-primary" onclick="sendPayment()">Отправить оплату</button>
        
        <h2 style="margin-top: 30px;">✅ Управление оплатой</h2>
        <button class="btn btn-success" onclick="confirmPayment()">✅ Подтвердить оплату</button>
        <button class="btn btn-danger" onclick="cancelPayment()">❌ Отменить оплату</button>
    </div>
</div>

<script>
let currentTerminal = null;

// Загружаем сохраненный терминал при загрузке страницы
window.onload = function() {
    const saved = localStorage.getItem('connectedTerminal');
    if (saved) {
        try {
            currentTerminal = JSON.parse(saved);
            showControlSection();
        } catch (e) {
            localStorage.removeItem('connectedTerminal');
        }
    }
};

function showMessage(text, type) {
    const msg = document.getElementById('message');
    msg.className = 'message message-' + type;
    msg.textContent = text;
    setTimeout(() => msg.textContent = '', 5000);
}

function setAmount(amount) {
    document.getElementById('paymentAmount').value = amount;
}

function showControlSection() {
    document.getElementById('connectSection').classList.add('hidden');
    document.getElementById('controlSection').classList.remove('hidden');
    document.getElementById('connectedId').textContent = currentTerminal.id;
}

function showConnectSection() {
    document.getElementById('connectSection').classList.remove('hidden');
    document.getElementById('controlSection').classList.add('hidden');
}

async function connectTerminal() {
    const id = document.getElementById('terminalId').value.trim();
    const password = document.getElementById('terminalPassword').value.trim();
    
    if (!id || !password) {
        showMessage('Заполните все поля', 'error');
        return;
    }
    
    if (!id.match(/^TRM-\\d{4}$/)) {
        showMessage('ID должен быть в формате TRM-####', 'error');
        return;
    }
    
    if (!password.match(/^\\d{6}$/)) {
        showMessage('Пароль должен содержать 6 цифр', 'error');
        return;
    }
    
    try {
        // Проверяем терминал через login
        const res = await fetch('/login', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({terminal_id: id, password: password})
        });
        const data = await res.json();
        
        if (res.ok && data.session_id) {
            currentTerminal = {id: id, password: password, session: data.session_id};
            
            // Сохраняем в localStorage
            localStorage.setItem('connectedTerminal', JSON.stringify(currentTerminal));
            
            showMessage('Терминал успешно подключен!', 'success');
            showControlSection();
        } else {
            showMessage('Неверный ID или пароль', 'error');
        }
    } catch (e) {
        showMessage('Ошибка соединения', 'error');
    }
}

function disconnectTerminal() {
    if (confirm('Отключить терминал?')) {
        currentTerminal = null;
        localStorage.removeItem('connectedTerminal');
        showMessage('Терминал отключен', 'success');
        showConnectSection();
    }
}

async function sendPayment() {
    if (!currentTerminal) {
        showMessage('Сначала подключите терминал', 'error');
        return;
    }
    
    const amount = document.getElementById('paymentAmount').value;
    
    if (!amount) {
        showMessage('Укажите сумму', 'error');
        return;
    }
    
    try {
        const res = await fetch('/admin/set_payload', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                terminal_id: currentTerminal.id,
                state: 'pay',
                data: {amount: amount}
            })
        });
        
        if (res.ok) {
            showMessage('Оплата отправлена на терминал!', 'success');
        } else {
            showMessage('Ошибка отправки оплаты', 'error');
        }
    } catch (e) {
        showMessage('Ошибка соединения', 'error');
    }
}

async function confirmPayment() {
    if (!currentTerminal) {
        showMessage('Сначала подключите терминал', 'error');
        return;
    }
    
    try {
        const res = await fetch('/admin/confirm_qr', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                terminal_id: currentTerminal.id,
                approved: true
            })
        });
        
        if (res.ok) {
            showMessage('Оплата подтверждена!', 'success');
        } else {
            showMessage('Ошибка подтверждения', 'error');
        }
    } catch (e) {
        showMessage('Ошибка соединения', 'error');
    }
}

async function cancelPayment() {
    if (!currentTerminal) {
        showMessage('Сначала подключите терминал', 'error');
        return;
    }
    
    try {
        const res = await fetch('/admin/confirm_qr', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                terminal_id: currentTerminal.id,
                approved: false
            })
        });
        
        if (res.ok) {
            showMessage('Оплата отменена!', 'success');
        } else {
            showMessage('Ошибка отмены', 'error');
        }
    } catch (e) {
        showMessage('Ошибка соединения', 'error');
    }
}
</script>
</body></html>'''
    
    return html
if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5001))
    print(f"🚀 API Server запущен на порту {port}")
    print(f"📌 Загружено терминалов: {len(terminals)}")
    print("   Регистрация: POST /register")
    print("   Формат: TRM-#### (4 цифры), пароль: 6 цифр")
    app.run(host='0.0.0.0', port=port, debug=False)
