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
    """Инициализация таблицы терминалов"""
    if not DATABASE_URL or not PSYCOPG_AVAILABLE:
        print("⚠️  DATABASE_URL не найден или psycopg недоступен, используется файловое хранилище")
        return
    
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('''
            CREATE TABLE IF NOT EXISTS terminals (
                terminal_id VARCHAR(10) PRIMARY KEY,
                data JSONB NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()
        cur.close()
        conn.close()
        print("✅ База данных инициализирована")
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
    """Загрузка пользователей"""
    global users
    try:
        with open(USERS_FILE, 'r', encoding='utf-8') as f:
            users = json.load(f)
            print(f"👥 Загружено {len(users)} пользователей")
    except FileNotFoundError:
        users = {}
        print("👥 Файл пользователей не найден, создан новый")
    except Exception as e:
        print(f"❌ Ошибка загрузки пользователей: {e}")
        users = {}

def save_users():
    """Сохранение пользователей"""
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
            terminals[terminal_id]['card_status'] = {
                'pending': True,
                'approved': False
            }
            terminals[terminal_id]['qr_password'] = qr_password  # Сохраняем пароль
            terminals[terminal_id]['payment_processed'] = False  # Сбрасываем флаг при новой оплате
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
    
    print(f"💳 [CARD] {terminal_id}: {'✅ approved' if approved else '❌ declined'} (pending=False)")
    print(f"   Card status will auto-reset to idle in 5s")
    
    # Автоматически сбросить в idle через 5 секунд
    auto_reset_to_idle(terminal_id, delay=5)
    
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
    
    print(f"🙂 [FACE] {terminal_id}: {'✅ approved' if approved else '❌ declined'} (pending=False)")
    print(f"   Card status will auto-reset to idle in 5s")
    
    # Автоматически сбросить в idle через 5 секунд
    auto_reset_to_idle(terminal_id, delay=5)
    
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

@app.route('/cabinet/terminals', methods=['GET'])
def cabinet_terminals():
    """Получить список терминалов пользователя"""
    session = get_session(request)
    if not session or session.get('type') != 'user':
        return jsonify({'error': 'Unauthorized'}), 401
    
    username = session['username']
    user_terminals = users[username]['terminals']
    
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
                'shift_total': shift_status.get('total_amount', 0)
            })
    
    return jsonify({'terminals': terminals_data}), 200

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
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'SB Sans Text', -apple-system, BlinkMacSystemFont, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover { transform: translateY(-2px); }
        .btn-success { background: #28a745; color: white; }
        .btn-danger { background: #dc3545; color: white; }
        .terminal-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .terminal-card.active { border-color: #28a745; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px; }
        .stat-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-value { font-size: 32px; font-weight: bold; color: #667eea; }
        .stat-label { color: #666; font-size: 14px; margin-top: 5px; }
        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .hidden { display: none; }
        .transaction {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
        }
        .transaction.success { background: #d4edda; }
        .transaction.failed { background: #f8d7da; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <h1>💼 Личный кабинет СберЭкран</h1>
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <p id="username"></p>
                    <p id="balance" class="hidden" style="font-size: 24px; margin-top: 10px;">💰 Баланс: <span id="balanceAmount">0</span> ₽</p>
                </div>
                <button id="logoutBtn" class="hidden" onclick="logout()" style="background: rgba(255,255,255,0.2); color: white; border: 2px solid white; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 16px;">Выйти</button>
            </div>
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

        <!-- Список терминалов -->
        <div id="terminalsSection" class="card hidden">
            <h2>Мои терминалы</h2>
            <div id="terminalsList"></div>
        </div>

        <!-- Статистика выбранного терминала -->
        <div id="statsSection" class="card hidden">
            <h2>Статистика терминала <span id="selectedTerminal"></span></h2>
            <div class="stats" id="statsGrid"></div>
            
            <h3 style="margin-top: 20px;">Управление сменой</h3>
            <div id="shiftControls"></div>
            
            <h3 style="margin-top: 20px;">Последние транзакции</h3>
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

            data.terminals.forEach(terminal => {
                const card = document.createElement('div');
                card.className = 'terminal-card' + (terminal.shift_opened ? ' active' : '');
                card.innerHTML = `
                    <h3>${terminal.terminal_id}</h3>
                    <p>Состояние: ${terminal.current_state}</p>
                    <p>Смена: ${terminal.shift_opened ? '🟢 Открыта' : '🔴 Закрыта'}</p>
                    <p>Транзакций в смене: ${terminal.shift_transactions}</p>
                    <p>Сумма в смене: ${terminal.shift_total} ₽</p>
                    <button class="btn btn-primary" onclick="showStats('${terminal.terminal_id}')">Подробнее</button>
                `;
                list.appendChild(card);
            });
        }

        async function showStats(terminalId) {
            selectedTerminal = terminalId;
            document.getElementById('selectedTerminal').textContent = terminalId;
            document.getElementById('statsSection').classList.remove('hidden');

            const response = await fetch('/cabinet/stats/' + terminalId);
            const data = await response.json();

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

            // Транзакции
            const transactionsList = document.getElementById('transactionsList');
            transactionsList.innerHTML = '';
            data.recent_transactions.reverse().forEach(t => {
                const div = document.createElement('div');
                div.className = 'transaction ' + t.status;
                div.innerHTML = `
                    <span>${new Date(t.timestamp).toLocaleString()}</span>
                    <span>${t.amount} ₽ (${t.type})</span>
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
                document.getElementById('logoutBtn').classList.add('hidden');
                document.getElementById('authSection').classList.remove('hidden');
                document.getElementById('bindSection').classList.add('hidden');
                document.getElementById('terminalsSection').classList.add('hidden');
                document.getElementById('statsSection').classList.add('hidden');
                document.getElementById('authUsername').value = '';
                document.getElementById('authPassword').value = '';
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
    </script>
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
