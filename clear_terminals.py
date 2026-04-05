"""
Скрипт для очистки всех терминалов
"""
import requests

# URL сервера
BASE_URL = "http://localhost:5001"  # Или https://sberpos-api.onrender.com

# Данные для входа (используй свой терминал)
TERMINAL_ID = "TRM-0001"  # Замени на свой ID
PASSWORD = "123456"       # Замени на свой пароль

def clear_all_terminals():
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
    
    # Очищаем все терминалы
    print("🗑️  Удаление всех терминалов...")
    clear_response = session.post(f"{BASE_URL}/admin/clear_all_terminals")
    
    if clear_response.status_code == 200:
        data = clear_response.json()
        print(f"✅ {data.get('message')}")
    else:
        print(f"❌ Ошибка: {clear_response.text}")

if __name__ == '__main__':
    confirm = input("⚠️  Вы уверены что хотите удалить ВСЕ терминалы? (yes/no): ")
    if confirm.lower() == 'yes':
        clear_all_terminals()
    else:
        print("❌ Отменено")
