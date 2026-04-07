"""
Веб-сайт для страниц оплаты СберЭкран
"""
from flask import Flask, render_template, request, send_file
import requests
import os
from io import BytesIO

app = Flask(__name__)

# URL API сервера
API_URL = os.environ.get('API_URL', 'http://localhost:5001')

# Пробуем импортировать qrcode
try:
    import qrcode
    QRCODE_AVAILABLE = True
    print("✅ qrcode загружен успешно")
except ImportError:
    QRCODE_AVAILABLE = False
    print("⚠️  qrcode не доступен, QR-коды не будут генерироваться")
    print("⚠️  Установите: pip install qrcode[pil]")

@app.route('/pay/<terminal_id>/key=<key>')
def payment_page(terminal_id, key):
    """Страница оплаты с проверкой ключа"""
    try:
        # Проверяем терминал через публичный API (без авторизации)
        response = requests.get(f'{API_URL}/api/terminal/check', 
                              params={'terminal_id': terminal_id},
                              timeout=5)
        
        if response.status_code == 404:
            return render_template('no_terminal.html', 
                                 terminal_id=terminal_id), 404
        
        if response.status_code != 200:
            return render_template('error.html', 
                                 terminal_id=terminal_id,
                                 error='api_error'), 500
        
        data = response.json()
        
        # Проверяем что терминал в состоянии оплаты
        if not data.get('in_payment', False):
            return render_template('no_payment.html', 
                                 terminal_id=terminal_id), 404
        
        # Проверяем ключ
        expected_key = data.get('qr_password', '')
        if key != expected_key:
            return render_template('bad_key.html'), 403
        
        # Показываем страницу оплаты
        amount = data.get('amount', '0')
        pay_url = f'https://www.sberbank.com/sms/pbpn?requisiteNumber={terminal_id}'
        
        return render_template('payment.html',
                             terminal_id=terminal_id,
                             amount=amount,
                             pay_url=pay_url,
                             key=key)
    
    except requests.RequestException as e:
        print(f"❌ API Error: {e}")
        return render_template('error.html',
                             terminal_id=terminal_id,
                             error='connection'), 500

@app.route('/qr/<terminal_id>')
def generate_qr(terminal_id):
    """Генерация QR-кода для терминала"""
    if not QRCODE_AVAILABLE:
        return "QR code generation not available. Install qrcode[pil]", 503
    
    try:
        # Получаем информацию о терминале
        response = requests.get(f'{API_URL}/api/terminal/check',
                              params={'terminal_id': terminal_id},
                              timeout=5)
        
        if response.status_code != 200:
            return "Terminal not found or API error", 404
        
        data = response.json()
        
        # Проверяем что терминал в режиме оплаты
        if not data.get('in_payment', False):
            return "Terminal not in payment mode", 400
        
        qr_password = data.get('qr_password', '')
        
        # Генерируем URL для оплаты
        base_url = request.host_url.rstrip('/')
        payment_url = f"{base_url}/pay/{terminal_id}/key={qr_password}"
        
        # Генерируем QR-код
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(payment_url)
        qr.make(fit=True)
        
        img = qr.make_image(fill_color="black", back_color="white")
        
        # Сохраняем в BytesIO
        img_io = BytesIO()
        img.save(img_io, 'PNG')
        img_io.seek(0)
        
        print(f"🔲 [QR GENERATE] {terminal_id}: Generated QR for {payment_url}")
        
        return send_file(img_io, mimetype='image/png')
    
    except requests.RequestException as e:
        print(f"❌ API Error: {e}")
        return "API connection error", 500
    except Exception as e:
        print(f"❌ QR Generation Error: {e}")
        return "QR generation error", 500

@app.route('/')
def index():
    """Главная страница"""
    return render_template('index.html')

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5002))
    print(f"🌐 Website запущен на порту {port}")
    app.run(host='0.0.0.0', port=port, debug=True)
