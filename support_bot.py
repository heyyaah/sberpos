"""
Support Bot для SberPOS
Система заявок с админ-панелью
"""

import os
import json
import time
from datetime import datetime
import telebot
from telebot.types import ReplyKeyboardMarkup, KeyboardButton, InlineKeyboardMarkup, InlineKeyboardButton

# ── Config ────────────────────────────────────────────────────────────────
TOKEN = os.environ.get('SUPPORT_BOT_TOKEN', '8742060687:AAHfsRrh1EKju-ZZ3CLHb2cBl-CkM63fByc')
ADMIN_USER_ID = os.environ.get('ADMIN_USER_ID')  # ID админа из переменной окружения
TICKETS_DB = 'tickets.json'
USERS_DB = 'users.json'

bot = telebot.TeleBot(TOKEN, threaded=True)

# Состояния пользователей
user_states = {}  # chat_id -> {'state': 'creating_ticket', 'ticket_id': 123, ...}

# Инициализация админа при старте
def init_admin():
    if ADMIN_USER_ID:
        users = get_users()
        admin_id = int(ADMIN_USER_ID)
        if admin_id not in users.get('admins', []):
            if 'admins' not in users:
                users['admins'] = []
            users['admins'].append(admin_id)
            save_users(users)
            print(f"✅ Admin {admin_id} added automatically")

# ── Database ──────────────────────────────────────────────────────────────
def load_json(filename, default=None):
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return default if default is not None else {}

def save_json(filename, data):
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

def get_tickets():
    return load_json(TICKETS_DB, {})

def save_tickets(tickets):
    save_json(TICKETS_DB, tickets)

def get_users():
    return load_json(USERS_DB, {'admins': [], 'blocked': []})

def save_users(users):
    save_json(USERS_DB, users)

def is_admin(user_id):
    users = get_users()
    return user_id in users.get('admins', [])

def is_blocked(user_id):
    users = get_users()
    return user_id in users.get('blocked', [])

def generate_ticket_id():
    tickets = get_tickets()
    if not tickets:
        return 1
    return max(int(k) for k in tickets.keys()) + 1

# ── Keyboards ─────────────────────────────────────────────────────────────
def kb_main(user_id):
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("📝 Создать заявку"), KeyboardButton("📋 Мои заявки"))
    if is_admin(user_id):
        kb.row(KeyboardButton("👨‍💼 Админ-панель"))
    return kb

def kb_admin():
    kb = ReplyKeyboardMarkup(resize_keyboard=True)
    kb.row(KeyboardButton("📊 Все заявки"), KeyboardButton("✅ Активные заявки"))
    kb.row(KeyboardButton("👤 Управление админами"))
    kb.row(KeyboardButton("🔙 Главное меню"))
    return kb

def kb_ticket_actions(ticket_id, user_id, admin_id=None):
    kb = InlineKeyboardMarkup()
    ticket = get_tickets().get(str(ticket_id))
    if not ticket:
        return kb
    
    status = ticket.get('status', 'open')
    assigned = ticket.get('assigned_to')
    
    # Кнопки для админа
    if is_admin(user_id):
        if status == 'open':
            kb.row(InlineKeyboardButton("✅ Принять", callback_data=f"accept_{ticket_id}"))
        if status == 'in_progress' and assigned == user_id:
            kb.row(InlineKeyboardButton("💬 Ответить", callback_data=f"reply_{ticket_id}"))
            kb.row(InlineKeyboardButton("✔️ Закрыть", callback_data=f"close_{ticket_id}"))
            kb.row(InlineKeyboardButton("🚫 Закрыть и заблокировать", callback_data=f"block_{ticket_id}"))
        if status == 'in_progress':
            kb.row(InlineKeyboardButton("👥 Передать другому", callback_data=f"transfer_{ticket_id}"))
    
    return kb

def kb_admin_list():
    users = get_users()
    admins = users.get('admins', [])
    admin_names = users.get('admin_names', {})
    kb = InlineKeyboardMarkup()
    for admin_id in admins:
        name = admin_names.get(str(admin_id), f"ID{admin_id}")
        kb.row(InlineKeyboardButton(f"❌ {name}", callback_data=f"remove_admin_{admin_id}"))
    kb.row(InlineKeyboardButton("➕ Добавить админа", callback_data="add_admin"))
    return kb

# ── Handlers ──────────────────────────────────────────────────────────────
@bot.message_handler(commands=['start'])
def cmd_start(message):
    chat_id = message.chat.id
    user_states.pop(chat_id, None)
    
    if is_blocked(chat_id):
        bot.send_message(chat_id, "🚫 Вы заблокированы в этом боте.")
        return
    
    welcome = (
        "👋 Добро пожаловать в службу поддержки SberPOS!\n\n"
        "📝 Создайте заявку, чтобы получить помощь\n"
        "📋 Просматривайте статус своих заявок"
    )
    
    if is_admin(chat_id):
        welcome += "\n\n👨‍💼 У вас есть доступ к админ-панели"
    
    bot.send_message(chat_id, welcome, reply_markup=kb_main(chat_id))

@bot.message_handler(func=lambda m: m.text == "📝 Создать заявку")
def create_ticket(message):
    chat_id = message.chat.id
    
    if is_blocked(chat_id):
        bot.send_message(chat_id, "🚫 Вы заблокированы в этом боте.")
        return
    
    user_states[chat_id] = {'state': 'creating_ticket'}
    bot.send_message(chat_id, "📝 Опишите вашу проблему или вопрос:")

@bot.message_handler(func=lambda m: m.text == "📋 Мои заявки")
def my_tickets(message):
    chat_id = message.chat.id
    tickets = get_tickets()
    
    user_tickets = {k: v for k, v in tickets.items() if v.get('user_id') == chat_id}
    
    if not user_tickets:
        bot.send_message(chat_id, "📭 У вас нет заявок", reply_markup=kb_main(chat_id))
        return
    
    for ticket_id, ticket in sorted(user_tickets.items(), key=lambda x: x[1].get('created_at', 0), reverse=True):
        status_emoji = {'open': '🆕', 'in_progress': '⏳', 'closed': '✅'}.get(ticket.get('status'), '❓')
        text = (
            f"{status_emoji} Заявка #{ticket_id}\n"
            f"Статус: {ticket.get('status', 'open')}\n"
            f"Создана: {datetime.fromtimestamp(ticket.get('created_at', 0)).strftime('%d.%m.%Y %H:%M')}\n"
            f"Описание: {ticket.get('description', '')[:100]}"
        )
        bot.send_message(chat_id, text, reply_markup=kb_ticket_actions(ticket_id, chat_id))

@bot.message_handler(func=lambda m: m.text == "👨‍💼 Админ-панель")
def admin_panel(message):
    chat_id = message.chat.id
    
    if not is_admin(chat_id):
        bot.send_message(chat_id, "❌ У вас нет доступа")
        return
    
    bot.send_message(chat_id, "👨‍💼 Админ-панель", reply_markup=kb_admin())

@bot.message_handler(func=lambda m: m.text == "📊 Все заявки")
def all_tickets(message):
    chat_id = message.chat.id
    
    if not is_admin(chat_id):
        return
    
    tickets = get_tickets()
    
    if not tickets:
        bot.send_message(chat_id, "📭 Нет заявок")
        return
    
    for ticket_id, ticket in sorted(tickets.items(), key=lambda x: x[1].get('created_at', 0), reverse=True):
        show_ticket_to_admin(chat_id, ticket_id, ticket)

@bot.message_handler(func=lambda m: m.text == "✅ Активные заявки")
def active_tickets(message):
    chat_id = message.chat.id
    
    if not is_admin(chat_id):
        return
    
    tickets = get_tickets()
    active = {k: v for k, v in tickets.items() if v.get('status') in ['open', 'in_progress']}
    
    if not active:
        bot.send_message(chat_id, "📭 Нет активных заявок")
        return
    
    for ticket_id, ticket in sorted(active.items(), key=lambda x: x[1].get('created_at', 0), reverse=True):
        show_ticket_to_admin(chat_id, ticket_id, ticket)

@bot.message_handler(func=lambda m: m.text == "👤 Управление админами")
def manage_admins(message):
    chat_id = message.chat.id
    
    if not is_admin(chat_id):
        return
    
    users = get_users()
    admins = users.get('admins', [])
    
    text = f"👥 Администраторы ({len(admins)}):"
    bot.send_message(chat_id, text, reply_markup=kb_admin_list())

@bot.message_handler(func=lambda m: m.text == "🔙 Главное меню")
def back_to_main(message):
    chat_id = message.chat.id
    user_states.pop(chat_id, None)
    bot.send_message(chat_id, "🏠 Главное меню", reply_markup=kb_main(chat_id))

# ── Text handlers ─────────────────────────────────────────────────────────
@bot.message_handler(func=lambda m: True, content_types=['text'])
def handle_text(message):
    chat_id = message.chat.id
    state = user_states.get(chat_id, {})
    
    # Проверка на reply к сообщению
    if message.reply_to_message:
        reply_text = message.reply_to_message.text or ''
        
        # Админ отвечает на заявку
        if is_admin(chat_id) and ('Ответ на заявку #' in reply_text or 'От:' in reply_text or '📨 Вам передана заявка #' in reply_text):
            import re
            match = re.search(r'#(\d+)', reply_text)
            if match:
                ticket_id = match.group(1)
                tickets = get_tickets()
                ticket = tickets.get(ticket_id)
                
                if ticket:
                    ticket['messages'].append({
                        'from': 'admin',
                        'admin_id': chat_id,
                        'text': message.text,
                        'timestamp': time.time()
                    })
                    save_tickets(tickets)
                    
                    # Отправить пользователю
                    user_id = ticket.get('user_id')
                    try:
                        bot.send_message(user_id, f"💬 Ответ на заявку #{ticket_id}:\n\n{message.text}")
                        bot.send_message(chat_id, "✅ Ответ отправлен")
                    except Exception as e:
                        bot.send_message(chat_id, f"❌ Не удалось отправить: {e}")
                    
                    # Уведомить назначенного админа если это не он
                    assigned_to = ticket.get('assigned_to')
                    if assigned_to and assigned_to != chat_id:
                        try:
                            users = get_users()
                            admin_names = users.get('admin_names', {})
                            responder_name = admin_names.get(str(chat_id), f"ID{chat_id}")
                            bot.send_message(assigned_to, 
                                f"💬 {responder_name} ответил на заявку #{ticket_id}:\n\n{message.text}")
                        except Exception:
                            pass
                    return
        
        # Пользователь отвечает на сообщение от админа
        elif not is_admin(chat_id) and '💬 Ответ на заявку #' in reply_text:
            import re
            match = re.search(r'#(\d+)', reply_text)
            if match:
                ticket_id = match.group(1)
                tickets = get_tickets()
                ticket = tickets.get(ticket_id)
                
                if ticket and ticket.get('user_id') == chat_id:
                    ticket['messages'].append({
                        'from': 'user',
                        'user_id': chat_id,
                        'text': message.text,
                        'timestamp': time.time()
                    })
                    save_tickets(tickets)
                    
                    # Отправить назначенному админу
                    assigned_to = ticket.get('assigned_to')
                    if assigned_to:
                        try:
                            user_info = f"@{ticket.get('username')}" if ticket.get('username') else ticket.get('first_name', 'Пользователь')
                            bot.send_message(assigned_to, 
                                f"💬 {user_info} ответил на заявку #{ticket_id}:\n\n{message.text}")
                            bot.send_message(chat_id, "✅ Ответ отправлен администратору")
                        except Exception:
                            bot.send_message(chat_id, "❌ Администратор не активировал бота")
                    else:
                        # Уведомить всех админов если заявка не назначена
                        users = get_users()
                        admins = users.get('admins', [])
                        user_info = f"@{ticket.get('username')}" if ticket.get('username') else ticket.get('first_name', 'Пользователь')
                        for admin_id in admins:
                            try:
                                bot.send_message(admin_id, 
                                    f"💬 {user_info} ответил на заявку #{ticket_id}:\n\n{message.text}")
                            except Exception:
                                pass
                        bot.send_message(chat_id, "✅ Ответ отправлен")
                    return
    
    if state.get('state') == 'creating_ticket':
        # Создание заявки
        tickets = get_tickets()
        ticket_id = generate_ticket_id()
        
        tickets[str(ticket_id)] = {
            'user_id': chat_id,
            'username': message.from_user.username or '',
            'first_name': message.from_user.first_name or '',
            'description': message.text,
            'status': 'open',
            'created_at': time.time(),
            'messages': []
        }
        
        save_tickets(tickets)
        user_states.pop(chat_id, None)
        
        bot.send_message(chat_id, f"✅ Заявка #{ticket_id} создана!\nОжидайте ответа администратора.", 
                        reply_markup=kb_main(chat_id))
        
        # Уведомить админов
        notify_admins_new_ticket(ticket_id, tickets[str(ticket_id)])
    
    elif state.get('state') == 'replying':
        # Ответ на заявку
        ticket_id = state.get('ticket_id')
        tickets = get_tickets()
        ticket = tickets.get(str(ticket_id))
        
        if ticket:
            ticket['messages'].append({
                'from': 'admin',
                'admin_id': chat_id,
                'text': message.text,
                'timestamp': time.time()
            })
            save_tickets(tickets)
            
            # Отправить пользователю
            user_id = ticket.get('user_id')
            try:
                bot.send_message(user_id, f"💬 Ответ на заявку #{ticket_id}:\n\n{message.text}")
                bot.send_message(chat_id, "✅ Ответ отправлен", reply_markup=kb_admin())
            except Exception as e:
                bot.send_message(chat_id, f"❌ Не удалось отправить ответ: {e}", reply_markup=kb_admin())
            
            # Уведомить назначенного админа если это не он
            assigned_to = ticket.get('assigned_to')
            if assigned_to and assigned_to != chat_id:
                try:
                    users = get_users()
                    admin_names = users.get('admin_names', {})
                    responder_name = admin_names.get(str(chat_id), f"ID{chat_id}")
                    bot.send_message(assigned_to, 
                        f"💬 {responder_name} ответил на заявку #{ticket_id}:\n\n{message.text}")
                except Exception:
                    pass
        
        user_states.pop(chat_id, None)
    
    elif state.get('state') == 'adding_admin':
        # Добавление админа
        try:
            # Формат: ID или ID Имя
            parts = message.text.strip().split(maxsplit=1)
            new_admin_id = int(parts[0])
            admin_name = parts[1] if len(parts) > 1 else f"ID{new_admin_id}"
            
            users = get_users()
            if new_admin_id not in users.get('admins', []):
                users.setdefault('admins', []).append(new_admin_id)
                users.setdefault('admin_names', {})[str(new_admin_id)] = admin_name
                save_users(users)
                bot.send_message(chat_id, f"✅ Админ {admin_name} добавлен", reply_markup=kb_admin())
            else:
                bot.send_message(chat_id, "❌ Уже является админом")
        except ValueError:
            bot.send_message(chat_id, "❌ Неверный формат. Используйте: ID или ID Имя")
        
        user_states.pop(chat_id, None)

# ── Callback handlers ─────────────────────────────────────────────────────
@bot.callback_query_handler(func=lambda call: True)
def callback_handler(call):
    chat_id = call.message.chat.id
    data = call.data
    
    print(f"[DEBUG] Callback: {data} from {chat_id}")
    
    if data.startswith('accept_'):
        ticket_id = data.split('_')[1]
        tickets = get_tickets()
        ticket = tickets.get(ticket_id)
        
        if ticket and ticket.get('status') == 'open':
            ticket['status'] = 'in_progress'
            ticket['assigned_to'] = chat_id
            ticket['assigned_at'] = time.time()
            save_tickets(tickets)
            
            bot.answer_callback_query(call.id, "✅ Заявка принята")
            try:
                bot.edit_message_reply_markup(chat_id, call.message.message_id, 
                                             reply_markup=kb_ticket_actions(ticket_id, chat_id))
            except Exception as e:
                print(f"Error editing message: {e}")
            
            # Уведомить пользователя
            try:
                user_id = ticket.get('user_id')
                bot.send_message(user_id, f"✅ Ваша заявка #{ticket_id} принята в работу")
            except Exception as e:
                print(f"Error notifying user: {e}")
    
    elif data.startswith('reply_'):
        ticket_id = data.split('_')[1]
        user_states[chat_id] = {'state': 'replying', 'ticket_id': ticket_id}
        try:
            bot.answer_callback_query(call.id)
        except Exception as e:
            print(f"Error answering callback: {e}")
        bot.send_message(chat_id, f"💬 Введите ответ на заявку #{ticket_id}:")
    
    elif data.startswith('close_'):
        ticket_id = data.split('_')[1]
        tickets = get_tickets()
        ticket = tickets.get(ticket_id)
        
        if ticket:
            ticket['status'] = 'closed'
            ticket['closed_at'] = time.time()
            ticket['closed_by'] = chat_id
            save_tickets(tickets)
            
            try:
                bot.answer_callback_query(call.id, "✅ Заявка закрыта")
            except Exception as e:
                print(f"Error answering callback: {e}")
            
            try:
                bot.edit_message_reply_markup(chat_id, call.message.message_id, reply_markup=None)
            except Exception as e:
                print(f"Error editing message: {e}")
            
            # Уведомить пользователя
            try:
                user_id = ticket.get('user_id')
                bot.send_message(user_id, f"✅ Ваша заявка #{ticket_id} закрыта")
            except Exception as e:
                print(f"Error notifying user: {e}")
    
    elif data.startswith('block_'):
        ticket_id = data.split('_')[1]
        tickets = get_tickets()
        ticket = tickets.get(ticket_id)
        
        if ticket:
            user_id = ticket.get('user_id')
            users = get_users()
            if user_id not in users.get('blocked', []):
                users.setdefault('blocked', []).append(user_id)
                save_users(users)
            
            ticket['status'] = 'closed'
            ticket['closed_at'] = time.time()
            ticket['closed_by'] = chat_id
            ticket['blocked'] = True
            save_tickets(tickets)
            
            bot.answer_callback_query(call.id, "🚫 Пользователь заблокирован")
            bot.edit_message_reply_markup(chat_id, call.message.message_id, reply_markup=None)
            
            bot.send_message(user_id, "🚫 Вы заблокированы в боте поддержки")
    
    elif data.startswith('transfer_'):
        # Формат: transfer_TICKETID (без "to")
        if '_' not in data[9:]:  # Если это просто transfer_1
            ticket_id = data.split('_')[1]
            users = get_users()
            admins = [a for a in users.get('admins', []) if a != chat_id]
            admin_names = users.get('admin_names', {})
            
            if not admins:
                bot.answer_callback_query(call.id, "❌ Нет других админов")
                return
            
            kb = InlineKeyboardMarkup()
            for admin_id in admins:
                name = admin_names.get(str(admin_id), f"ID{admin_id}")
                # Формат: xfer_TICKETID_ADMINID
                kb.row(InlineKeyboardButton(name, callback_data=f"xfer_{ticket_id}_{admin_id}"))
            
            bot.answer_callback_query(call.id)
            try:
                bot.delete_message(chat_id, call.message.message_id)
            except Exception:
                pass
            bot.send_message(chat_id, "👥 Выберите админа:", reply_markup=kb)
    
    elif data.startswith('xfer_'):
        parts = data.split('_')
        print(f"[DEBUG] Transfer parts: {parts}")
        ticket_id = parts[1]
        new_admin_id = int(parts[2])
        
        print(f"[DEBUG] Transferring ticket {ticket_id} to admin {new_admin_id}")
        
        tickets = get_tickets()
        ticket = tickets.get(ticket_id)
        
        if not ticket:
            print(f"[DEBUG] Ticket {ticket_id} not found")
            bot.answer_callback_query(call.id, "❌ Заявка не найдена")
            return
        
        ticket['assigned_to'] = new_admin_id
        ticket['transferred_at'] = time.time()
        ticket['transferred_by'] = chat_id
        save_tickets(tickets)
        
        users = get_users()
        admin_names = users.get('admin_names', {})
        new_admin_name = admin_names.get(str(new_admin_id), f"ID{new_admin_id}")
        
        print(f"[DEBUG] Transfer complete to {new_admin_name}")
        
        bot.answer_callback_query(call.id, "✅ Заявка передана")
        try:
            bot.edit_message_text(
                f"✅ Заявка #{ticket_id} передана {new_admin_name}",
                chat_id, 
                call.message.message_id,
                reply_markup=None
            )
            print(f"[DEBUG] Message edited successfully")
        except Exception as e:
            print(f"[DEBUG] Edit message error: {e}")
        
        # Уведомить нового админа
        try:
            bot.send_message(new_admin_id, f"📨 Вам передана заявка #{ticket_id}")
            show_ticket_to_admin(new_admin_id, ticket_id, ticket)
            print(f"[DEBUG] Notified new admin {new_admin_id}")
        except Exception as e:
            print(f"[DEBUG] Notify error: {e}")
            bot.send_message(chat_id, f"❌ Не удалось уведомить админа {new_admin_name}")
    
    elif data == 'add_admin':
        user_states[chat_id] = {'state': 'adding_admin'}
        bot.answer_callback_query(call.id)
        bot.send_message(chat_id, "👤 Введите ID нового админа (или ID Имя):\nПример: 123456789 Иван")
    
    elif data.startswith('remove_admin_'):
        admin_id = int(data.split('_')[2])
        users = get_users()
        if admin_id in users.get('admins', []):
            users['admins'].remove(admin_id)
            save_users(users)
            bot.answer_callback_query(call.id, "✅ Админ удалён")
            bot.edit_message_reply_markup(chat_id, call.message.message_id, reply_markup=kb_admin_list())
        else:
            bot.answer_callback_query(call.id, "❌ Не найден")

# ── Helper functions ──────────────────────────────────────────────────────
def show_ticket_to_admin(admin_id, ticket_id, ticket):
    status_emoji = {'open': '🆕', 'in_progress': '⏳', 'closed': '✅'}.get(ticket.get('status'), '❓')
    
    user_info = f"@{ticket.get('username')}" if ticket.get('username') else ticket.get('first_name', 'Unknown')
    assigned = ticket.get('assigned_to')
    assigned_info = ""
    
    if assigned:
        users = get_users()
        admin_names = users.get('admin_names', {})
        assigned_name = admin_names.get(str(assigned), f"ID{assigned}")
        assigned_info = f"\n👤 Назначен: {assigned_name}"
    
    text = (
        f"{status_emoji} Заявка #{ticket_id}\n"
        f"От: {user_info} (ID: {ticket.get('user_id')})\n"
        f"Статус: {ticket.get('status', 'open')}{assigned_info}\n"
        f"Создана: {datetime.fromtimestamp(ticket.get('created_at', 0)).strftime('%d.%m.%Y %H:%M')}\n\n"
        f"📝 {ticket.get('description', '')}"
    )
    
    bot.send_message(admin_id, text, reply_markup=kb_ticket_actions(ticket_id, admin_id))

def notify_admins_new_ticket(ticket_id, ticket):
    users = get_users()
    admins = users.get('admins', [])
    
    for admin_id in admins:
        try:
            show_ticket_to_admin(admin_id, ticket_id, ticket)
        except Exception:
            pass

# ── Entry point ───────────────────────────────────────────────────────────
if __name__ == '__main__':
    print("🤖 Support bot starting...")
    init_admin()  # Инициализируем админа из переменной окружения
    print("✅ Support bot started!")
    bot.infinity_polling()
