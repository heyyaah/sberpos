# SberPOS Terminal Management System

Система управления терминалами SberPOS с API сервером и Telegram ботом.

## Компоненты

- **api_server.py** - Flask API сервер для управления терминалами
- **bot.py** - Telegram бот для удобного управления через мессенджер

## Деплой на Render.com

### Шаг 1: Подготовка репозитория

1. Создайте новый репозиторий на GitHub
2. Загрузите файлы:
   - `api_server.py`
   - `bot.py`
   - `requirements.txt`
   - `render.yaml`
   - `.gitignore`

### Шаг 2: Подключение к Render

1. Зайдите на [render.com](https://render.com)
2. Создайте новый аккаунт или войдите
3. Нажмите "New" → "Blueprint"
4. Подключите ваш GitHub репозиторий
5. Render автоматически обнаружит `render.yaml` и создаст оба сервиса

### Шаг 3: Настройка переменных окружения

#### Для API Server (sberpos-api):
- `PORT` - автоматически установлен на 5001

#### Для Telegram Bot (sberpos-bot):
- `BOT_TOKEN` - токен вашего Telegram бота (получите у @BotFather)
- `BASE_URL` - автоматически установлен на `https://sberpos-api.onrender.com`
- `WEBHOOK_URL` - URL вашего бота (например: `https://sberpos-bot.onrender.com`)

### Шаг 4: Получение токена бота

1. Откройте Telegram и найдите @BotFather
2. Отправьте команду `/newbot`
3. Следуйте инструкциям для создания бота
4. Скопируйте полученный токен
5. Добавьте токен в переменную окружения `BOT_TOKEN` в Render

### Шаг 5: Обновление URL в приложении

После деплоя обновите URL сервера в приложении:

```bash
python update_server_url.py
```

Введите новый URL: `https://sberpos-api.onrender.com`

Затем пересоберите и установите APK:

```bash
.\build_and_install.ps1
```

## Локальная разработка

### Запуск API сервера:

```bash
python api_server.py
```

### Запуск бота:

```bash
export BOT_TOKEN="your_token_here"
export BASE_URL="http://localhost:5001"
python bot.py
```

## API Endpoints

- `POST /api/register_device` - Регистрация терминала
- `POST /login` - Авторизация
- `GET /api/payload` - Получить payload
- `POST /api/payload` - Установить payload
- `GET /api/card/status` - Статус карты
- `GET /api/face/status` - Статус лица
- `POST /api/face/upload` - Загрузка фото лица
- `POST /admin/confirm_card` - Подтвердить карту
- `POST /admin/confirm_face` - Подтвердить лицо

## Формат терминалов

- ID: `TRM-####` (4 цифры)
- Пароль: 6 цифр

## Особенности

- Автоматическая отмена оплаты при отключении терминала (10 сек)
- Защита от двойного подтверждения
- Автоматический сброс в idle через 5 секунд после подтверждения
- Персистентное хранение терминалов
