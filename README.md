# SberPOS Terminal Management System

Система управления терминалами SberPOS с API сервером и Telegram ботом.

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
