"""
Веб-сайт для страниц оплаты СберЭкран
"""
from flask import Flask, render_template, request
import requests
import os

app = Flask(__name__)

# URL API сервера
API_URL = os.environ.get('API_URL', 'http://localhost:5001')

@app.route('/pay/<terminal_id>/key=<key>')
def payment_page(terminal_id, key):
    """Страница оплаты с проверкой ключа"""
    try:
        # Проверяем терминал через API
        response = requests.get(f'{API_URL}/admin/status', timeout=5)
        if response.status_code != 200:
            return render_template('error.html', 
                                 terminal_id=terminal_id,
                                 error='api_error'), 500
        
        data = response.json()
        devices = data.get('devices', {})
        
        # Проверяем существование терминала
        if terminal_id not in devices:
            return render_template('no_terminal.html', 
                                 terminal_id=terminal_id), 404
        
        terminal = devices[terminal_id]
        current = terminal.get('current_payload', {})
        state = current.get('state', 'idle')
        
        # Проверяем что терминал в состоянии оплаты
        if state not in ['pay', 'payPending']:
            return render_template('no_payment.html', 
                                 terminal_id=terminal_id), 404
        
        # Проверяем ключ
        expected_key = terminal.get('qr_password', '')
        if key != expected_key:
            return render_template('bad_key.html'), 403
        
        # Показываем страницу оплаты
        amount = current.get('data', {}).get('amount', '0')
        pay_url = f'https://www.sberbank.com/sms/pbpn?requisiteNumber={terminal_id}'
        
        return render_template('payment.html',
                             terminal_id=terminal_id,
                             amount=amount,
                             pay_url=pay_url)
    
    except requests.RequestException as e:
        print(f"❌ API Error: {e}")
        return render_template('error.html',
                             terminal_id=terminal_id,
                             error='connection'), 500

@app.route('/')
def index():
    """Главная страница"""
    return render_template('index.html')

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5002))
    print(f"🌐 Website запущен на порту {port}")
    app.run(host='0.0.0.0', port=port, debug=True)
