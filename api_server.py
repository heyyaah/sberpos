"""
API Server для управления терминалами SberPOS
Эмулирует серверную часть для тестирования
"""

from flask import Flask, request, jsonify, make_response
import json
import uuid
import random
import os
import threading
import time
from datetime import datetime, timedelta

app = Flask(__name__)

# Хранилище данных в памяти
sessions = {}  # session_id -> {terminal_id, authenticated, csrf_token}
terminals = {}  # terminal_id -> {password, current_payload, face_confirm_enabled}
device_states = {}  # terminal_id -> {state, amount, last_update}
auto_reset_timers = {}  # terminal_id -> timer
last_seen = {}  # terminal_id -> datetime последнего запроса

TERMINALS_FILE = 'terminals_db.json'
TERMINAL_TIMEOUT = 10  # секунд без активности для отмены оплаты

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
            terminals[terminal_id]['payment_processed'] = False  # Сбрасываем флаг
            device_states[terminal_id] = {
                'state': 'idle',
                'amount': '0',
                'last_update': datetime.now().isoformat()
            }
            print(f"🔄 [AUTO-RESET] {terminal_id} -> idle (card_status reset)")
    
    timer = threading.Timer(delay, reset)
    timer.start()
    auto_reset_timers[terminal_id] = timer

def load_terminals():
    """Загрузка терминалов из файла"""
    global terminals
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
    """Сохранение терминалов в файл"""
    try:
        with open(TERMINALS_FILE, 'w', encoding='utf-8') as f:
            json.dump(terminals, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ Ошибка сохранения терминалов: {e}")

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

# Загрузка терминалов при старте
load_terminals()

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
            terminals[terminal_id]['card_status'] = {
                'pending': True,
                'approved': False
            }
            terminals[terminal_id]['payment_processed'] = False  # Сбрасываем флаг при новой оплате
        
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
    
    # Сохраняем изменения
    save_terminals()
    
    print(f"🗑️  [DELETE] Terminal {terminal_id} deleted")
    
    return jsonify({'success': True, 'status': 'success', 'message': f'Terminal {terminal_id} deleted'}), 200

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
            'POST /admin/set_device_payload',
            'POST /admin/reset',
            'POST /admin/set_face_confirm',
            'POST /admin/confirm_card',
            'POST /admin/confirm_face',
            'POST /admin/delete_terminal - Delete terminal',
            'GET /admin/status'
        ],
        'terminals_count': len(terminals)
    }), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5001))
    print(f"🚀 API Server запущен на порту {port}")
    print(f"📌 Загружено терминалов: {len(terminals)}")
    print("   Регистрация: POST /register")
    print("   Формат: TRM-#### (4 цифры), пароль: 6 цифр")
    app.run(host='0.0.0.0', port=port, debug=False)
