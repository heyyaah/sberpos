"""
Telegram Terminal Bot — render.com (Python / pyTelegramBotAPI)
Хранит терминалы в terminals.json (персистентно на диске).
"""

import os, json, time, threading
import telebot
from telebot.types import ReplyKeyboardMarkup, KeyboardButton
import requests
from fake_useragent import UserAgent
from flask import Flask, request as flask_request

# ── Config ────────────────────────────────────────────────────────────────
TOKEN = os.environ.get('BOT_TOKEN', '8442780236:AAEkaevYiE0ni2TDOq2WnD4Ttv_DmUFpai8')
TERMINALS_DB = 'terminals.json'
COOLDOWN_SEC = 2

bot = telebot.TeleBot(TOKEN, threaded=True)

user_data     = {}  # chat_id -> session dict
auto_idle     = {}  # chat_id -> {'enabled': bool, 'delay_sec': int}
cooldowns     = {}  # chat_id -> timestamp
waiting_state = {}  # chat_id -> 'amount' | 'delay' | 'terminal'

# ── Persistent terminal storage ───────────────────────────────────────────
def _load_db() -> dict:
    try:
        with open(TERMINALS_DB, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return {}

def _save_db(db: dict):
    with open(TERMINALS_DB, 'w', encoding='utf-8') as f:
        json.dump(db, f, ensure_ascii=False, indent=2)

def db_get_terminals(user_id: str) -> dict:
    return _load_db().get(user_id, {})

def db_save_terminal(user_id: str, name: str, data: dict):
    db = _load_db()
    db.setdefault(user_id, {})[name] = data
    _save_db(db)

def db_delete_terminal(user_id: str, name: str):
    db = _load_db()
    db.get(user_id, {}).pop(name, None)
    _save_db(db)

# ── Helpers ───────────────────────────────────────────────────────────────
def check_cooldown(chat_id) -> bool:
    now = time.time()
    if now - cooldowns.get(chat_id, 0) < COOLDOWN_SEC:
        return False
    cooldowns[chat_id] = now
    return True

def fmt_time(seconds: int) -> str:
    if seconds < 60:
        return f"{seconds} сек"
    return f"{seconds // 60} мин {seconds % 60} сек"

def get_auto_idle(chat_id):
    return auto_idle.get(chat_id, {'enabled': True, 'delay_sec': 8})

# ── Terminal API ──────────────────────────────────────────────────────────
class TerminalAPI:
    BASE = os.environ.get('BASE_URL', 'https://sberpos-api.onrender.com')

    def __init__(self, terminal_id, password):
        self.terminal_id      = terminal_id
        self.password         = password
        self.session          = requests.Session()
        self.ua               = UserAgent()
        self.csrf_token       = None
        self.is_authenticated = False

    def _h(self, use_json=False):
        h = {
            'User-Agent':   'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'X-CSRF-Token': self.csrf_token or '',
            'Origin':       self.BASE,
            'Referer':      self.BASE + '/',
        }
        if use_json:
            h['Content-Type'] = 'application/json'
        return h

    def _ensure_auth(self) -> bool:
        """Авторизуется если сессия не активна."""
        if not self.is_authenticated:
            ok, _ = self.login()
            return ok
        return True

    def _post(self, path, payload, retry_fn):
        try:
            r = self.session.post(f"{self.BASE}{path}", json=payload, headers=self._h(True), timeout=5)
            if r.status_code == 200:
                return True, r
            if self._reauth_if_needed(r.status_code):
                return retry_fn()
            return False, r
        except Exception as e:
            return False, e

    def _reauth_if_needed(self, code):
        if code in (401, 403):
            self.is_authenticated = False
            ok, _ = self.login()
            return ok
        return False

    def ping(self):
        try:
            return self.session.get(f"{self.BASE}/login", timeout=5).status_code == 200
        except Exception:
            return False

    def login(self):
        try:
            self.session = requests.Session()
            self.session.headers.update({'Connection': 'keep-alive'})
            r = self.session.post(
                f"{self.BASE}/login",
                data={'username': self.terminal_id, 'password': self.password},
                headers={'User-Agent': self.ua.random}, timeout=5
            )
            if r.status_code == 200:
                try:
                    d = r.json()
                    if d.get('error') or d.get('status') == 'error':
                        return False, f"❌ Неверные данные: {d.get('error', 'unknown')}"
                except Exception:
                    pass
                self.csrf_token = self.session.cookies.get('csrf')
                self.is_authenticated = True
                return True, "✅ Авторизация успешна"
            return False, f"❌ Ошибка: {r.status_code}"
        except Exception as e:
            return False, f"❌ Ошибка: {str(e)[:100]}"

    def send_pay(self, amount=100):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        # Сбрасываем предыдущую операцию перед новой оплатой
        self._post('/admin/set_device_payload', {'terminal_id': self.terminal_id, 'payload': 'idle'}, lambda: None)
        payload = {
            'state': 'pay', 'amount': str(amount),
            'content': '      \n            \n             \n',
            'buttons': '        :card\n         :cash\n      :cancel'
        }
        ok, r = self._post('/admin/set_payload', payload, lambda: self.send_pay(amount))
        if ok:
            return True, f"✅ Оплата {amount}₽ отправлена"
        else:
            # Пробуем распарсить JSON ответ с ошибкой
            try:
                error_data = r.json()
                error_msg = error_data.get('error', 'Неизвестная ошибка')
                return False, f"❌ {error_msg}"
            except:
                return False, f"❌ Ошибка: {getattr(r, 'status_code', r)}"

    def cancel_pay(self):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/set_device_payload', {'terminal_id': self.terminal_id, 'payload': 'idle'}, self.cancel_pay)
        return (True, "🚫 Операция отменена") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def reset_all(self):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/reset', {}, self.reset_all)
        return (True, "🔄 Все терминалы сброшены в idle") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def set_face_confirm(self, enabled: bool):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/set_face_confirm', {'terminal_id': self.terminal_id, 'enabled': enabled}, lambda: self.set_face_confirm(enabled))
        return (True, f"🙂 Подтверждение лицом {'включено' if enabled else 'выключено'}") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def set_bypass_shift_check(self, enabled: bool):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/set_bypass_shift_check', {'terminal_id': self.terminal_id, 'enabled': enabled}, lambda: self.set_bypass_shift_check(enabled))
        return (True, f"🔓 Обход проверки смены {'включен' if enabled else 'выключен'}") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def set_bypass_card_check(self, enabled: bool):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/set_bypass_card_check', {'terminal_id': self.terminal_id, 'enabled': enabled}, lambda: self.set_bypass_card_check(enabled))
        return (True, f"💳 Обход проверки карты/лица {'включен' if enabled else 'выключен'}") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def confirm_card(self, approved=True):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/confirm_card', {'terminal_id': self.terminal_id, 'approved': approved}, lambda: self.confirm_card(approved))
        return (True, "✅ Карта подтверждена" if approved else "❌ Карта отклонена") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def confirm_face(self, approved: bool):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/confirm_face', {'terminal_id': self.terminal_id, 'approved': approved}, lambda: self.confirm_face(approved))
        return (True, "✅ Лицо подтверждено" if approved else "❌ Лицо отклонено") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def confirm_qr(self, approved: bool):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/api/qr/confirm', {'terminal_id': self.terminal_id, 'approved': approved}, lambda: self.confirm_qr(approved))
        return (True, "✅ QR оплата подтверждена" if approved else "❌ QR оплата отменена") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

    def get_status(self):
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        try:
            r = self.session.get(f"{self.BASE}/admin/status", headers=self._h(), timeout=10)
            if r.status_code == 200:
                data    = r.json()
                devices = data.get('devices', [])
                device  = next((d for d in devices if d.get('terminal_id') == self.terminal_id), None) or (devices[0] if devices else None)
                if device:
                    cur    = device.get('current_payload', {})
                    state  = cur.get('state', 'unknown')
                    amount = cur.get('data', {}).get('amount', 'N/A')
                    face   = " 🙂 Face" if device.get('face_confirm_enabled') else ""
                    return True, f"📊 Терминал: {self.terminal_id}\nСостояние: {state}\nСумма: {amount}₽{face}"
                return True, f"📊 Статус:\n{json.dumps(data, indent=2, ensure_ascii=False)[:800]}"
            if self._reauth_if_needed(r.status_code):
                return self.get_status()
            return False, f"❌ Ошибка: {r.status_code}"
        except Exception as e:
            return False, f"❌ Ошибка: {str(e)}"

    def delete_terminal(self):
        """Удалить терминал с сервера"""
        if not self._ensure_auth(): return False, "❌ Ошибка авторизации"
        ok, r = self._post('/admin/delete_terminal', {'terminal_id': self.terminal_id}, self.delete_terminal)
        return (True, f"🗑️ Терминал {self.terminal_id} удалён с сервера") if ok else (False, f"❌ Ошибка: {getattr(r, 'status_code', r)}")

# ── Keyboards ─────────────────────────────────────────────────────────────
def kb_main():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("➕ Добавить терминал"))
    kb.row(KeyboardButton("📁 Сохранённые терминалы"))
    return kb

def kb_terminal(name):
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("🔧 Основные функции"), KeyboardButton("⚙️ Детальные функции"))
    kb.row(KeyboardButton(f"ℹ️ {name}"))
    kb.row(KeyboardButton("🗑️ Удалить терминал"), KeyboardButton("🔙 Главное меню"))
    return kb

def kb_basic():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("💸 Оплатить 100₽"), KeyboardButton("💸 Своя сумма"))
    kb.row(KeyboardButton("✅ Подтвердить карту"), KeyboardButton("❌ Отклонить карту"))
    kb.row(KeyboardButton("✅ Face подтвердить"), KeyboardButton("❌ Face отклонить"))
    kb.row(KeyboardButton("✅ QR подтвердить"), KeyboardButton("❌ QR отменить"))
    kb.row(KeyboardButton("🚫 Отменить"), KeyboardButton("🔄 Выход в idle (все)"))
    kb.row(KeyboardButton("🔙 Назад"))
    return kb

def kb_detailed():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("📊 Статус"), KeyboardButton("🏓 Пинг"))
    kb.row(KeyboardButton("🙂 Face ON"), KeyboardButton("🙂 Face OFF"))
    kb.row(KeyboardButton("🔓 Обход смены"))
    kb.row(KeyboardButton("💳 Обход карты/лица"))
    kb.row(KeyboardButton("⚙️ Auto-idle настройки"))
    kb.row(KeyboardButton("🔙 Назад"))
    return kb

def kb_bypass_shift():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("🔓 Обход ВКЛ"), KeyboardButton("🔓 Обход ВЫКЛ"))
    kb.row(KeyboardButton("🔙 Назад"))
    return kb

def kb_bypass_card():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("💳 Обход ВКЛ"), KeyboardButton("💳 Обход ВЫКЛ"))
    kb.row(KeyboardButton("🔙 Назад"))
    return kb

def kb_auto_idle(chat_id):
    s = get_auto_idle(chat_id)
    status = "✅ ВКЛ" if s['enabled'] else "❌ ВЫКЛ"
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton(f"🔘 {status}"), KeyboardButton("⏱️ Установить время"))
    kb.row(KeyboardButton("🔙 Назад"))
    return kb

# ── Background helpers ────────────────────────────────────────────────────
def send_status_after_delay(chat_id, api, delay=1):
    def _task():
        time.sleep(delay)
        ok, status = api.get_status()
        if ok:
            bot.send_message(chat_id, status)
    threading.Thread(target=_task, daemon=True).start()

def auto_idle_after_confirm(chat_id, api):
    s = get_auto_idle(chat_id)
    if not s['enabled']:
        return
    delay = s['delay_sec']
    def _task():
        time.sleep(delay)
        ok, result = api.cancel_pay()
        if ok:
            bot.send_message(chat_id, f"🔄 Терминал переведён в idle (через {fmt_time(delay)})")
    threading.Thread(target=_task, daemon=True).start()

def run_async(fn, chat_id, msg_id, *args, on_done=None):
    """Запускает fn(*args) в фоне, редактирует msg_id с результатом."""
    def _task():
        ok, result = fn(*args)
        bot.edit_message_text(result, chat_id, msg_id)
        if on_done:
            on_done(ok, result)
    threading.Thread(target=_task, daemon=True).start()

def start_card_watcher(chat_id, api):
    """Опрашивает статус каждые 2 сек, присылает уведомление при смене состояния."""
    def _task():
        prev_state = None
        for _ in range(30):  # max 60 сек
            time.sleep(2)
            ok, status = api.get_status()
            if not ok:
                continue
            # parse state from status string
            for line in status.split('\n'):
                if line.startswith('Состояние:'):
                    state = line.split(':', 1)[1].strip()
                    if prev_state and state != prev_state:
                        bot.send_message(chat_id, f"🔔 Статус изменился: {prev_state} → {state}\n{status}")
                        return
                    prev_state = state
                    break
    threading.Thread(target=_task, daemon=True).start()

# ── Handlers ──────────────────────────────────────────────────────────────
@bot.message_handler(commands=['start'])
def cmd_start(message):
    print(f"[DEBUG] /start from {message.chat.id}")
    chat_id = message.chat.id
    user_data.pop(chat_id, None)
    waiting_state.pop(chat_id, None)
    bot.send_message(chat_id,
        "🤖 *Terminal Control Bot*\n\nДобро пожаловать!\n\n"
        "📌 *Возможности:*\n• Управление оплатой\n• Подтверждение карт и Face ID\n"
        "• Мониторинг статуса\n• Автоматический перевод в idle\n• Сохранение терминалов\n\n"
        "Выберите действие:",
        parse_mode='Markdown', reply_markup=kb_main())

@bot.message_handler(func=lambda m: m.text == "➕ Добавить терминал")
def add_terminal(message):
    chat_id = message.chat.id
    waiting_state[chat_id] = 'terminal'
    bot.send_message(chat_id,
        "🔑 *Введите данные терминала*\n\n"
        "Формат: `TERMINAL_ID ПАРОЛЬ`\n"
        "Или с названием: `Название, TERMINAL_ID, ПАРОЛЬ`",
        parse_mode='Markdown')

@bot.message_handler(func=lambda m: m.text == "📁 Сохранённые терминалы")
def saved_terminals(message):
    chat_id = message.chat.id
    terminals = db_get_terminals(str(chat_id))
    if not terminals:
        bot.send_message(chat_id, "📭 Нет сохранённых терминалов.", reply_markup=kb_main())
        return
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    for name in terminals:
        kb.row(KeyboardButton(f"📌 {name}"))
    kb.row(KeyboardButton("🔙 Главное меню"))
    bot.send_message(chat_id, "📁 *Сохранённые терминалы:*", parse_mode='Markdown', reply_markup=kb)

@bot.message_handler(func=lambda m: m.text == "🗑️ Удалить терминал")
def delete_terminal(message):
    chat_id = message.chat.id
    session = user_data.get(chat_id)
    if session and session.get('name'):
        name = session['name']
        api = session.get('api')
        
        # Удаляем из базы бота
        db_delete_terminal(str(chat_id), name)
        
        # Удаляем с сервера если есть API
        if api:
            msg = bot.send_message(chat_id, f"🔄 Удаление терминала `{name}` с сервера...", parse_mode='Markdown')
            ok, result = api.delete_terminal()
            bot.edit_message_text(result, chat_id, msg.message_id, parse_mode='Markdown')
        
        user_data.pop(chat_id, None)
        bot.send_message(chat_id, f"🗑️ Терминал `{name}` удалён из бота.", parse_mode='Markdown', reply_markup=kb_main())
    else:
        bot.send_message(chat_id, "❌ Нет активного терминала.", reply_markup=kb_main())

@bot.message_handler(func=lambda m: m.text == "🔙 Главное меню")
def go_main(message):
    chat_id = message.chat.id
    user_data.pop(chat_id, None)
    waiting_state.pop(chat_id, None)
    bot.send_message(chat_id, "🏠 *Главное меню*", parse_mode='Markdown', reply_markup=kb_main())

@bot.message_handler(func=lambda m: m.text == "🔙 Назад")
def go_back(message):
    chat_id = message.chat.id
    session = user_data.get(chat_id, {})
    name = session.get('name', '')
    bot.send_message(chat_id, f"🔌 *Терминал `{name}`*", parse_mode='Markdown', reply_markup=kb_terminal(name))

@bot.message_handler(func=lambda m: m.text == "🔧 Основные функции")
def basic_menu(message):
    chat_id = message.chat.id
    name = user_data.get(chat_id, {}).get('name', '')
    bot.send_message(chat_id, f"🔧 *Основные функции* — {name}", parse_mode='Markdown', reply_markup=kb_basic())

@bot.message_handler(func=lambda m: m.text == "⚙️ Детальные функции")
def detailed_menu(message):
    chat_id = message.chat.id
    name = user_data.get(chat_id, {}).get('name', '')
    bot.send_message(chat_id, f"⚙️ *Детальные функции* — {name}", parse_mode='Markdown', reply_markup=kb_detailed())

@bot.message_handler(func=lambda m: m.text == "⚙️ Auto-idle настройки")
def auto_idle_menu(message):
    chat_id = message.chat.id
    s = get_auto_idle(chat_id)
    bot.send_message(chat_id,
        f"⚙️ *Auto-idle настройки*\n\nСтатус: {'✅ ВКЛЮЧЕН' if s['enabled'] else '❌ ВЫКЛЮЧЕН'}\n"
        f"Задержка: {fmt_time(s['delay_sec'])}\n\nПосле подтверждения терминал автоматически перейдёт в idle.",
        parse_mode='Markdown', reply_markup=kb_auto_idle(chat_id))

@bot.message_handler(func=lambda m: m.text and m.text.startswith("🔘 "))
def toggle_auto_idle(message):
    chat_id = message.chat.id
    s = get_auto_idle(chat_id)
    s['enabled'] = not s['enabled']
    auto_idle[chat_id] = s
    bot.send_message(chat_id, f"⚙️ Auto-idle {'✅ ВКЛЮЧЕН' if s['enabled'] else '❌ ВЫКЛЮЧЕН'}", reply_markup=kb_auto_idle(chat_id))

@bot.message_handler(func=lambda m: m.text == "⏱️ Установить время")
def set_delay_prompt(message):
    chat_id = message.chat.id
    waiting_state[chat_id] = 'delay'
    bot.send_message(chat_id,
        "⏱️ Введите время задержки в секундах (1-300):\nПример: `8`, `2м`, `1м30с`",
        parse_mode='Markdown')

@bot.message_handler(func=lambda m: m.text and not m.text.startswith('/'))
def handle_all(message):
    chat_id = message.chat.id
    text    = message.text or ''

    # ── Выбор терминала из списка ─────────────────────────────────────────
    if text.startswith("📌 "):
        name = text[len("📌 "):]
        terminals = db_get_terminals(str(chat_id))
        td = terminals.get(name)
        if not td:
            bot.send_message(chat_id, "❌ Терминал не найден", reply_markup=kb_main())
            return
        msg = bot.send_message(chat_id, f"🔄 Подключение к `{name}`...", parse_mode='Markdown')
        api = TerminalAPI(td['terminalId'], td['password'])
        ok, result = api.login()
        if ok:
            bot.edit_message_text(f"✅ Подключено к `{name}`", chat_id, msg.message_id, parse_mode='Markdown')
            user_data[chat_id] = {'terminalId': td['terminalId'], 'password': td['password'], 'api': api, 'name': name}
            bot.send_message(chat_id, f"🔌 *Терминал `{name}` активен*", parse_mode='Markdown', reply_markup=kb_terminal(name))
        else:
            bot.edit_message_text(f"❌ Ошибка подключения\n{result}", chat_id, msg.message_id)
        return

    # ── Ввод данных терминала ─────────────────────────────────────────────
    if waiting_state.get(chat_id) == 'terminal':
        waiting_state.pop(chat_id)
        inp = text.strip()
        parts = inp.split(',')
        if len(parts) == 3:
            name, terminal_id, password = [p.strip() for p in parts]
        elif len(inp.split()) == 2:
            terminal_id, password = inp.split()
            name = terminal_id
        else:
            bot.send_message(chat_id, "❌ Неверный формат. /start", reply_markup=kb_main())
            return
        msg = bot.send_message(chat_id, f"🔄 Проверка `{name}`...", parse_mode='Markdown')
        api = TerminalAPI(terminal_id, password)
        ok, result = api.login()
        if ok:
            db_save_terminal(str(chat_id), name, {'terminalId': terminal_id, 'password': password, 'name': name})
            bot.edit_message_text(f"✅ *Терминал сохранён!*\n📌 `{name}`\n🆔 `{terminal_id}`", chat_id, msg.message_id, parse_mode='Markdown')
            if chat_id not in auto_idle:
                auto_idle[chat_id] = {'enabled': True, 'delay_sec': 8}
            user_data[chat_id] = {'terminalId': terminal_id, 'password': password, 'api': api, 'name': name}
            bot.send_message(chat_id, f"🔌 *Терминал `{name}` активен*", parse_mode='Markdown', reply_markup=kb_terminal(name))
        else:
            bot.edit_message_text(f"❌ Ошибка авторизации\n{result}", chat_id, msg.message_id)
        return

    # ── Ввод задержки auto-idle ───────────────────────────────────────────
    if waiting_state.get(chat_id) == 'delay':
        waiting_state.pop(chat_id)
        inp = text.lower().strip()
        seconds = 0
        try:
            import re
            m = re.match(r'^(?:(\d+)\s*[мm])?(?:\s*(\d+)\s*[сs])?$', inp)
            if m and (m.group(1) or m.group(2)):
                seconds = int(m.group(1) or 0) * 60 + int(m.group(2) or 0)
            else:
                seconds = int(inp)
            seconds = max(1, min(300, seconds))
            s = get_auto_idle(chat_id)
            s['delay_sec'] = seconds
            auto_idle[chat_id] = s
            bot.send_message(chat_id, f"✅ Задержка: {fmt_time(seconds)}", reply_markup=kb_auto_idle(chat_id))
        except Exception:
            bot.send_message(chat_id, "❌ Неверный формат. Пример: `8`, `2м`, `1м30с`", parse_mode='Markdown', reply_markup=kb_auto_idle(chat_id))
        return

    # ── Ввод суммы ────────────────────────────────────────────────────────
    if waiting_state.get(chat_id) == 'amount':
        waiting_state.pop(chat_id)
        session = user_data.get(chat_id)
        if not session:
            bot.send_message(chat_id, "❌ Сессия истекла. /start")
            return
        try:
            amount = int(text.strip())
            if amount <= 0: raise ValueError
        except ValueError:
            bot.send_message(chat_id, "❌ Введите целое число больше 0")
            waiting_state[chat_id] = 'amount'
            return
        api = session['api']
        msg = bot.send_message(chat_id, f"🔄 Отправка {amount}₽...")
        run_async(api.send_pay, chat_id, msg.message_id, amount,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))
        return

    # ── Проверка сессии ───────────────────────────────────────────────────
    session = user_data.get(chat_id)
    if not session or not session.get('api'):
        bot.send_message(chat_id, "❌ Сначала выберите терминал", reply_markup=kb_main())
        return

    if not check_cooldown(chat_id):
        bot.send_message(chat_id, "⏳ Не так быстро, подожди секунду")
        return

    api  = session['api']
    name = session.get('name', '')

    # ── Info ──────────────────────────────────────────────────────────────
    if text.startswith("ℹ️ "):
        ok, status = api.get_status()
        bot.send_message(chat_id,
            f"📋 *Информация*\n📌 `{name}`\n🆔 `{session['terminalId']}`\n"
            f"🔐 {'✅ Авторизован' if api.is_authenticated else '❌ Не авторизован'}\n"
            f"📊 {status if ok else 'Не удалось получить'}",
            parse_mode='Markdown')
        return

    # ── Основные действия ─────────────────────────────────────────────────
    if text == "💸 Оплатить 100₽":
        msg = bot.send_message(chat_id, "🔄 Отправка 100₽...")
        run_async(api.send_pay, chat_id, msg.message_id, 100,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

    elif text == "✅ Подтвердить карту":
        msg = bot.send_message(chat_id, "💳 Подтверждение карты...")
        run_async(api.confirm_card, chat_id, msg.message_id, True,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

    elif text == "❌ Отклонить карту":
        msg = bot.send_message(chat_id, "🔄 Отклонение карты...")
        run_async(api.confirm_card, chat_id, msg.message_id, False,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

    elif text == "✅ Face подтвердить":
        msg = bot.send_message(chat_id, "🔄 Подтверждение лица...")
        run_async(api.confirm_face, chat_id, msg.message_id, True,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

    elif text == "❌ Face отклонить":
        msg = bot.send_message(chat_id, "🔄 Отклонение лица...")
        run_async(api.confirm_face, chat_id, msg.message_id, False,
                  on_done=lambda ok, _: (send_status_after_delay(chat_id, api), auto_idle_after_confirm(chat_id, api)))

    elif text == "🔄 Выход в idle (все)":
        msg = bot.send_message(chat_id, "🔄 Сброс всех терминалов...")
        run_async(api.reset_all, chat_id, msg.message_id)

    elif text == "💸 Своя сумма":
        waiting_state[chat_id] = 'amount'
        bot.send_message(chat_id, "💵 Введите сумму в рублях:")

    elif text == "🚫 Отменить":
        msg = bot.send_message(chat_id, "🔄 Отмена операции...")
        run_async(api.cancel_pay, chat_id, msg.message_id,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

    elif text == "📊 Статус":
        msg = bot.send_message(chat_id, "🔄 Получение статуса...")
        run_async(api.get_status, chat_id, msg.message_id)

    elif text == "🏓 Пинг":
        msg = bot.send_message(chat_id, "🔄 Проверка соединения...")
        def _ping():
            ok = api.ping()
            return ok, "✅ Сайт доступен" if ok else "❌ Сайт недоступен"
        run_async(_ping, chat_id, msg.message_id)

    elif text == "🙂 Face ON":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_face_confirm, chat_id, msg.message_id, True)

    elif text == "🙂 Face OFF":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_face_confirm, chat_id, msg.message_id, False)

    elif text == "🔓 Обход смены":
        bot.send_message(chat_id, "🔓 *Обход проверки смены*\n\nПозволяет отправлять оплаты даже при закрытой смене.", 
                        parse_mode='Markdown', reply_markup=kb_bypass_shift())

    elif text == "🔓 Обход ВКЛ":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_bypass_shift_check, chat_id, msg.message_id, True)

    elif text == "🔓 Обход ВЫКЛ":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_bypass_shift_check, chat_id, msg.message_id, False)

    elif text == "💳 Обход карты/лица":
        bot.send_message(chat_id, "💳 *Обход проверки карты/лица*\n\nПозволяет пропускать подтверждение карты и лица.", 
                        parse_mode='Markdown', reply_markup=kb_bypass_card())

    elif text == "💳 Обход ВКЛ":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_bypass_card_check, chat_id, msg.message_id, True)

    elif text == "💳 Обход ВЫКЛ":
        msg = bot.send_message(chat_id, "🔄...")
        run_async(api.set_bypass_card_check, chat_id, msg.message_id, False)

    elif text == "✅ QR подтвердить":
        msg = bot.send_message(chat_id, "🔄 Подтверждение QR оплаты...")
        run_async(api.confirm_qr, chat_id, msg.message_id, True,
                  on_done=lambda ok, _: (send_status_after_delay(chat_id, api), auto_idle_after_confirm(chat_id, api)))

    elif text == "❌ QR отменить":
        msg = bot.send_message(chat_id, "🔄 Отмена QR оплаты...")
        run_async(api.confirm_qr, chat_id, msg.message_id, False,
                  on_done=lambda ok, _: send_status_after_delay(chat_id, api))

# ── Entry point ───────────────────────────────────────────────────────────
app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    update = telebot.types.Update.de_json(flask_request.get_json())
    bot.process_new_updates([update])
    return 'OK', 200

@app.route('/')
def index():
    return 'Bot is running', 200

@app.route('/health')
def health():
    return 'OK', 200

# ===== МОНИТОРИНГ САЙТОВ =====

MONITORING_GROUP_ID = -1003740288667
ADMIN_USERNAME = "@romancev228"

# Сайты для мониторинга
MONITORED_SITES = [
    {'name': 'API Server', 'url': 'https://sberpos-api.onrender.com/health'},
    {'name': 'Web Server', 'url': 'https://sberpos-web.onrender.com/'},
    {'name': 'Cabinet', 'url': 'https://sberpos-api.onrender.com/cabinet'},
]

# Состояние мониторинга
monitoring_state = {
    'message_id': None,
    'last_status': {},
    'down_sites': set(),
    'last_alert_time': {}
}

def ping_site(url: str) -> tuple:
    """Пингует сайт и возвращает (доступен, время_ответа_мс)"""
    try:
        start = time.time()
        response = requests.get(url, timeout=10)
        elapsed_ms = int((time.time() - start) * 1000)
        
        if response.status_code == 200:
            return True, elapsed_ms
        else:
            return False, 0
    except Exception as e:
        return False, 0

def get_status_emoji(is_up: bool) -> str:
    return "🟢" if is_up else "🔴"

def format_monitoring_message() -> str:
    """Форматирует сообщение со статусом всех сайтов"""
    lines = ["📊 Статус сайтов SberPOS\n"]
    
    all_up = True
    for site in MONITORED_SITES:
        is_up, ping_ms = ping_site(site['url'])
        monitoring_state['last_status'][site['name']] = is_up
        
        emoji = get_status_emoji(is_up)
        status_text = f"{ping_ms}ms" if is_up else "НЕДОСТУПЕН"
        lines.append(f"{emoji} {site['name']}: {status_text}")
        
        if not is_up:
            all_up = False
    
    lines.append(f"\n🕐 Обновлено: {time.strftime('%H:%M:%S')}")
    
    if not all_up:
        lines.append(f"\n⚠️ Внимание {ADMIN_USERNAME}! Есть недоступные сайты!")
    
    return "\n".join(lines)

def check_and_alert_down_sites():
    """Проверяет сайты и отправляет алерты если что-то упало"""
    current_down = set()
    
    for site in MONITORED_SITES:
        is_up, _ = ping_site(site['url'])
        
        if not is_up:
            current_down.add(site['name'])
            
            # Если сайт только что упал (не был в списке упавших)
            if site['name'] not in monitoring_state['down_sites']:
                # Отправляем алерт
                alert_msg = f"🚨 АЛЕРТ {ADMIN_USERNAME}!\n\n"
                alert_msg += f"Сайт {site['name']} недоступен!\n"
                alert_msg += f"URL: {site['url']}\n"
                alert_msg += f"Время: {time.strftime('%H:%M:%S')}"
                
                try:
                    bot.send_message(MONITORING_GROUP_ID, alert_msg)
                    monitoring_state['last_alert_time'][site['name']] = time.time()
                except Exception as e:
                    print(f"❌ Error sending alert: {e}")
    
    # Проверяем восстановленные сайты
    recovered = monitoring_state['down_sites'] - current_down
    for site_name in recovered:
        recovery_msg = f"✅ Сайт {site_name} восстановлен!\n"
        recovery_msg += f"Время: {time.strftime('%H:%M:%S')}"
        
        try:
            bot.send_message(MONITORING_GROUP_ID, recovery_msg)
        except Exception as e:
            print(f"❌ Error sending recovery message: {e}")
    
    monitoring_state['down_sites'] = current_down

def update_monitoring_message():
    """Обновляет сообщение с мониторингом каждую минуту"""
    while True:
        try:
            # Проверяем сайты и отправляем алерты
            check_and_alert_down_sites()
            
            # Форматируем сообщение
            message_text = format_monitoring_message()
            
            # Обновляем или создаем сообщение
            if monitoring_state['message_id']:
                try:
                    bot.edit_message_text(
                        chat_id=MONITORING_GROUP_ID,
                        message_id=monitoring_state['message_id'],
                        text=message_text
                    )
                except Exception as e:
                    # Если не удалось отредактировать, создаем новое
                    print(f"⚠️ Could not edit message: {e}, creating new one")
                    monitoring_state['message_id'] = None
            
            if not monitoring_state['message_id']:
                try:
                    msg = bot.send_message(MONITORING_GROUP_ID, message_text)
                    monitoring_state['message_id'] = msg.message_id
                except Exception as e:
                    print(f"❌ Error sending monitoring message: {e}")
        
        except Exception as e:
            print(f"❌ Monitoring error: {e}")
        
        # Ждем 60 секунд до следующего обновления
        time.sleep(60)

# Запускаем мониторинг в отдельном потоке
monitoring_thread = threading.Thread(target=update_monitoring_message, daemon=True)
monitoring_thread.start()
print("✅ Monitoring thread started")

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    webhook_url = os.environ.get('WEBHOOK_URL')
    
    if webhook_url:
        print(f"Setting webhook to {webhook_url}/webhook")
        bot.remove_webhook()
        bot.set_webhook(url=f"{webhook_url}/webhook")
        print(f"Starting Flask server on port {port}")
        app.run(host='0.0.0.0', port=port)
    else:
        print("No WEBHOOK_URL set, starting polling mode")
        print(f"Starting Flask health server on port {port}")
        # Запускаем Flask в отдельном потоке для health check
        import threading
        import time
        flask_thread = threading.Thread(target=lambda: app.run(host='0.0.0.0', port=port))
        flask_thread.daemon = True
        flask_thread.start()
        # Запускаем polling с обработкой конфликтов
        bot.remove_webhook()
        while True:
            try:
                bot.infinity_polling(timeout=60, long_polling_timeout=60)
            except telebot.apihelper.ApiTelegramException as e:
                if e.error_code == 409:
                    print("⚠️ Conflict detected (409), waiting 5 seconds before retry...")
                    time.sleep(5)
                    continue
                else:
                    raise
            except Exception as e:
                print(f"❌ Polling error: {e}")
                time.sleep(5)
                continue
