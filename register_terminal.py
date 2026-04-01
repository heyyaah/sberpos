"""
Скрипт для регистрации терминала
"""
import requests
import json

API_URL = "http://localhost:5001"

def register_terminal(terminal_id=None, password=None):
    """Регистрация терминала"""
    data = {}
    
    if terminal_id:
        data['terminal_id'] = terminal_id
    if password:
        data['password'] = password
    
    try:
        response = requests.post(f"{API_URL}/register", json=data)
        result = response.json()
        
        if response.status_code == 201:
            print("✅ Терминал успешно зарегистрирован!")
            print(f"   ID: {result['terminal_id']}")
            print(f"   Пароль: {result['password']}")
            print(f"\n📋 Используй эти данные в боте:")
            print(f"   {result['terminal_id']}, {result['password']}")
        else:
            print(f"❌ Ошибка: {result.get('error', 'Unknown error')}")
    except requests.exceptions.ConnectionError:
        print("❌ Не удалось подключиться к серверу")
        print("   Убедись, что api_server.py запущен")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == '__main__':
    print("🔧 Регистрация терминала\n")
    
    choice = input("1 - Автогенерация ID и пароля\n2 - Указать свои данные\nВыбор: ").strip()
    
    if choice == '1':
        register_terminal()
    elif choice == '2':
        terminal_id = input("Введи ID (TRM-####): ").strip()
        password = input("Введи пароль (6 цифр): ").strip()
        register_terminal(terminal_id, password)
    else:
        print("❌ Неверный выбор")
