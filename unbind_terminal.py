"""
Скрипт для принудительной отвязки терминала
"""
import requests

# URL сервера
BASE_URL = "https://sberpos-api.onrender.com"

# Данные для входа (используй любой существующий терминал)
TERMINAL_ID = input("Введите ID терминала для входа (например TRM-0001): ").strip()
PASSWORD = input("Введите пароль терминала: ").strip()

# ID терминала для отвязки
UNBIND_TERMINAL_ID = input("Введите ID терминала для отвязки: ").strip()

def unbind_terminal():
    # Создаём сессию
    session = requests.Session()
    
    # Логинимся
    print(f"🔐 Вход в систему как {TERMINAL_ID}...")
    login_response = session.post(
        f"{BASE_URL}/login",
        data={
            'username': TERMINAL_ID,
            'password': PASSWORD
        }
    )
    
    if login_response.status_code != 200:
        print(f"❌ Ошибка входа: {login_response.text}")
        return
    
    print("✅ Вход выполнен успешно")
    
    # Отвязываем терминал
    print(f"🔓 Отвязка терминала {UNBIND_TERMINAL_ID}...")
    unbind_response = session.post(
        f"{BASE_URL}/admin/force_unbind_terminal",
        json={'terminal_id': UNBIND_TERMINAL_ID}
    )
    
    if unbind_response.status_code == 200:
        data = unbind_response.json()
        print(f"✅ {data.get('message')}")
    else:
        print(f"❌ Ошибка: {unbind_response.text}")

if __name__ == '__main__':
    confirm = input(f"⚠️  Вы уверены что хотите отвязать терминал {UNBIND_TERMINAL_ID}? (yes/no): ")
    if confirm.lower() == 'yes':
        unbind_terminal()
    else:
        print("❌ Отменено")
