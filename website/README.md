# СберЭкран - Веб-сайт

Отдельный веб-сайт для страниц оплаты СберЭкран.

## Структура

```
website/
├── app.py              # Flask приложение
├── requirements.txt    # Зависимости
├── templates/          # HTML шаблоны
│   ├── base.html       # Базовый шаблон
│   ├── index.html      # Главная страница
│   ├── payment.html    # Страница оплаты
│   ├── no_terminal.html # Терминал не найден
│   ├── no_payment.html  # Нет активной оплаты
│   ├── bad_key.html     # Неверный ключ
│   └── error.html       # Ошибка подключения
└── README.md
```

## Установка

```bash
cd website
pip install -r requirements.txt
```

## Запуск локально

```bash
# По умолчанию подключается к API на localhost:5001
python app.py

# Или указать URL API сервера
API_URL=https://sberpos-api.onrender.com python app.py
```

Сайт будет доступен на `http://localhost:5002`

## Деплой на Render

1. Создать новый Web Service на Render.com
2. Подключить репозиторий
3. Настройки:
   - Build Command: `pip install -r website/requirements.txt`
   - Start Command: `cd website && gunicorn app:app`
   - Environment Variables:
     - `API_URL` = `https://sberpos-api.onrender.com`

## Роуты

- `GET /` - Главная страница
- `GET /pay/<terminal_id>/key=<key>` - Страница оплаты с проверкой ключа

## Состояния страниц

1. **Терминал не найден** - терминал не зарегистрирован
2. **Нет активной оплаты** - терминал не в состоянии оплаты
3. **Неверный ключ** - QR-код устарел или неверный
4. **Оплата** - страница с кнопкой оплаты через СберПей
5. **Ошибка** - проблема с подключением к API

## Дизайн

Современный Sber-стиль:
- Шрифт: Manrope
- Цвета: зелёный (#21A038), красный (#E5383B), жёлтый (#F5A623)
- Анимации: плавное появление карточек и иконок
- Адаптивный дизайн для мобильных устройств
