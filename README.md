# SberPOS Terminal Management System

Система управления терминалами SberPOS с API сервером, веб-сайтом и Telegram ботом.

## Структура проекта

- `api_server.py` - API сервер для терминалов
- `website/` - Веб-сайт для страниц оплаты
- `support_bot.py` - Telegram бот поддержки
- `cashier_app.py` - Приложение кассира

## API Endpoints

- `POST /api/register_device` - Регистрация терминала
- `POST /login` - Авторизация
- `GET /api/payload` - Получить payload
- `POST /api/payload` - Установить payload
- `GET /api/card/status` - Статус карты
- `GET /api/face/status` - Статус лица
- `POST /api/face/upload` - Загрузка фото лица
- `GET /api/qr/generate` - Генерация QR-кода для оплаты
- `POST /admin/confirm_card` - Подтвердить карту
- `POST /admin/confirm_face` - Подтвердить лицо

## Переменные окружения

### API Server
- `PORT` - Порт API сервера (по умолчанию 5001)
- `DATABASE_URL` - URL PostgreSQL базы данных
- `WEBSITE_URL` - URL веб-сайта для QR-кодов (например: https://sberpos-web.onrender.com)

### Website
- `PORT` - Порт веб-сайта (по умолчанию 5002)
- `API_URL` - URL API сервера (например: https://sberpos-api.onrender.com)

## Формат терминалов

- ID: `TRM-####` (4 цифры)
- Пароль: 6 цифр

## Особенности

- Автоматическая отмена оплаты при отключении терминала (10 сек)
- Защита от двойного подтверждения
- Автоматический сброс в idle через 5 секунд после подтверждения
- Персистентное хранение терминалов
- Отдельный веб-сайт для страниц оплаты
- QR-коды с уникальными ключами для безопасности
