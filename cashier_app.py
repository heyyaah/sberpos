"""
Программа-касса для управления терминалами SberPOS
Графический интерфейс на tkinter
"""

import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import requests
import json
import threading
from datetime import datetime

class CashierApp:
    def __init__(self, root):
        self.root = root
        self.root.title("СберЭкран - Касса")
        self.root.geometry("900x700")
        self.root.configure(bg='#f5f5f5')
        
        # Настройки
        self.base_url = "https://sberpos-api.onrender.com"
        self.session = requests.Session()
        self.terminal_id = None
        self.password = None
        self.authenticated = False
        
        # Создаём интерфейс
        self.create_widgets()
        
    def create_widgets(self):
        # Заголовок
        header = tk.Frame(self.root, bg='#667eea', height=80)
        header.pack(fill=tk.X)
        
        title = tk.Label(header, text="💼 СберЭкран - Касса", 
                        font=('Arial', 24, 'bold'), bg='#667eea', fg='white')
        title.pack(pady=20)
        
        # Основной контейнер
        main_container = tk.Frame(self.root, bg='#f5f5f5')
        main_container.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)
        
        # Левая панель - авторизация и управление
        left_panel = tk.Frame(main_container, bg='white', relief=tk.RAISED, bd=2)
        left_panel.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0, 10))
        
        # Авторизация
        auth_frame = tk.LabelFrame(left_panel, text="Авторизация", 
                                   font=('Arial', 12, 'bold'), bg='white', padx=10, pady=10)
        auth_frame.pack(fill=tk.X, padx=10, pady=10)
        
        tk.Label(auth_frame, text="ID терминала:", bg='white').grid(row=0, column=0, sticky=tk.W, pady=5)
        self.terminal_entry = tk.Entry(auth_frame, width=20, font=('Arial', 11))
        self.terminal_entry.grid(row=0, column=1, pady=5, padx=5)
        
        tk.Label(auth_frame, text="Пароль:", bg='white').grid(row=1, column=0, sticky=tk.W, pady=5)
        self.password_entry = tk.Entry(auth_frame, width=20, show='*', font=('Arial', 11))
        self.password_entry.grid(row=1, column=1, pady=5, padx=5)
        
        self.login_btn = tk.Button(auth_frame, text="Войти", command=self.login,
                                   bg='#667eea', fg='white', font=('Arial', 11, 'bold'),
                                   width=15, cursor='hand2')
        self.login_btn.grid(row=2, column=0, columnspan=2, pady=10)
        
        self.status_label = tk.Label(auth_frame, text="Не авторизован", 
                                     bg='white', fg='red', font=('Arial', 10))
        self.status_label.grid(row=3, column=0, columnspan=2)
        
        # Быстрые суммы
        quick_frame = tk.LabelFrame(left_panel, text="Быстрые суммы", 
                                    font=('Arial', 12, 'bold'), bg='white', padx=10, pady=10)
        quick_frame.pack(fill=tk.X, padx=10, pady=10)
        
        amounts = [100, 200, 500, 1000, 2000, 5000]
        for i, amount in enumerate(amounts):
            row = i // 3
            col = i % 3
            btn = tk.Button(quick_frame, text=f"{amount} ₽", 
                          command=lambda a=amount: self.send_payment(a),
                          bg='#28a745', fg='white', font=('Arial', 11, 'bold'),
                          width=8, height=2, cursor='hand2')
            btn.grid(row=row, column=col, padx=5, pady=5)
        
        # Своя сумма
        custom_frame = tk.Frame(left_panel, bg='white', padx=10, pady=10)
        custom_frame.pack(fill=tk.X, padx=10)
        
        tk.Label(custom_frame, text="Своя сумма:", bg='white', font=('Arial', 11)).pack(side=tk.LEFT)
        self.custom_amount = tk.Entry(custom_frame, width=10, font=('Arial', 12))
        self.custom_amount.pack(side=tk.LEFT, padx=5)
        
        tk.Button(custom_frame, text="Отправить", command=self.send_custom_payment,
                 bg='#667eea', fg='white', font=('Arial', 10, 'bold'),
                 cursor='hand2').pack(side=tk.LEFT)
        
        # Управление
        control_frame = tk.LabelFrame(left_panel, text="Управление", 
                                     font=('Arial', 12, 'bold'), bg='white', padx=10, pady=10)
        control_frame.pack(fill=tk.X, padx=10, pady=10)
        
        tk.Button(control_frame, text="✅ Подтвердить карту", 
                 command=lambda: self.confirm_card(True),
                 bg='#28a745', fg='white', font=('Arial', 10, 'bold'),
                 width=20, cursor='hand2').pack(pady=3)
        
        tk.Button(control_frame, text="❌ Отклонить карту", 
                 command=lambda: self.confirm_card(False),
                 bg='#dc3545', fg='white', font=('Arial', 10, 'bold'),
                 width=20, cursor='hand2').pack(pady=3)
        
        tk.Button(control_frame, text="🚫 Отменить операцию", 
                 command=self.cancel_payment,
                 bg='#ffc107', fg='black', font=('Arial', 10, 'bold'),
                 width=20, cursor='hand2').pack(pady=3)
        
        tk.Button(control_frame, text="📊 Статус терминала", 
                 command=self.get_status,
                 bg='#17a2b8', fg='white', font=('Arial', 10, 'bold'),
                 width=20, cursor='hand2').pack(pady=3)
        
        # Правая панель - лог
        right_panel = tk.Frame(main_container, bg='white', relief=tk.RAISED, bd=2)
        right_panel.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)
        
        log_label = tk.Label(right_panel, text="Журнал операций", 
                            font=('Arial', 12, 'bold'), bg='white')
        log_label.pack(pady=10)
        
        self.log_text = scrolledtext.ScrolledText(right_panel, width=40, height=30,
                                                  font=('Consolas', 9), bg='#f8f9fa')
        self.log_text.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Кнопка очистки лога
        tk.Button(right_panel, text="Очистить лог", command=self.clear_log,
                 bg='#6c757d', fg='white', font=('Arial', 9),
                 cursor='hand2').pack(pady=5)
        
        self.log("Программа запущена")
        self.log(f"Сервер: {self.base_url}")
        
    def log(self, message):
        """Добавить сообщение в лог"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.log_text.insert(tk.END, f"[{timestamp}] {message}\n")
        self.log_text.see(tk.END)
        
    def clear_log(self):
        """Очистить лог"""
        self.log_text.delete(1.0, tk.END)
        
    def login(self):
        """Авторизация"""
        self.terminal_id = self.terminal_entry.get().strip()
        self.password = self.password_entry.get().strip()
        
        if not self.terminal_id or not self.password:
            messagebox.showerror("Ошибка", "Введите ID терминала и пароль")
            return
        
        self.log(f"Попытка входа: {self.terminal_id}")
        
        def do_login():
            try:
                response = self.session.post(
                    f"{self.base_url}/login",
                    data={'username': self.terminal_id, 'password': self.password},
                    timeout=10
                )
                
                if response.status_code == 200:
                    try:
                        data = response.json()
                        if data.get('success'):
                            self.authenticated = True
                            self.root.after(0, lambda: self.on_login_success())
                        else:
                            self.root.after(0, lambda: self.on_login_error(data.get('error', 'Неверные данные')))
                    except:
                        self.authenticated = True
                        self.root.after(0, lambda: self.on_login_success())
                else:
                    self.root.after(0, lambda: self.on_login_error(f"Ошибка {response.status_code}"))
            except Exception as e:
                self.root.after(0, lambda: self.on_login_error(str(e)))
        
        threading.Thread(target=do_login, daemon=True).start()
        
    def on_login_success(self):
        """Успешная авторизация"""
        self.status_label.config(text=f"✅ {self.terminal_id}", fg='green')
        self.login_btn.config(state=tk.DISABLED)
        self.terminal_entry.config(state=tk.DISABLED)
        self.password_entry.config(state=tk.DISABLED)
        self.log(f"✅ Авторизация успешна: {self.terminal_id}")
        messagebox.showinfo("Успех", "Авторизация успешна!")
        
    def on_login_error(self, error):
        """Ошибка авторизации"""
        self.log(f"❌ Ошибка авторизации: {error}")
        messagebox.showerror("Ошибка", f"Не удалось войти:\n{error}")
        
    def send_payment(self, amount):
        """Отправить оплату"""
        if not self.authenticated:
            messagebox.showerror("Ошибка", "Сначала авторизуйтесь")
            return
        
        self.log(f"💸 Отправка оплаты: {amount} ₽")
        
        def do_send():
            try:
                response = self.session.post(
                    f"{self.base_url}/api/payload",
                    json={
                        'state': 'pay',
                        'amount': str(amount),
                        'content': '',
                        'buttons': ''
                    },
                    timeout=10
                )
                
                if response.status_code == 200:
                    self.root.after(0, lambda: self.log(f"✅ Оплата {amount} ₽ отправлена"))
                else:
                    try:
                        error_data = response.json()
                        error_msg = error_data.get('error', 'Неизвестная ошибка')
                        self.root.after(0, lambda: self.log(f"❌ {error_msg}"))
                        self.root.after(0, lambda: messagebox.showerror("Ошибка", error_msg))
                    except:
                        self.root.after(0, lambda: self.log(f"❌ Ошибка {response.status_code}"))
            except Exception as e:
                self.root.after(0, lambda: self.log(f"❌ Ошибка: {str(e)}"))
        
        threading.Thread(target=do_send, daemon=True).start()
        
    def send_custom_payment(self):
        """Отправить свою сумму"""
        try:
            amount = int(self.custom_amount.get())
            if amount <= 0:
                raise ValueError
            self.send_payment(amount)
            self.custom_amount.delete(0, tk.END)
        except ValueError:
            messagebox.showerror("Ошибка", "Введите корректную сумму")
            
    def confirm_card(self, approved):
        """Подтвердить/отклонить карту"""
        if not self.authenticated:
            messagebox.showerror("Ошибка", "Сначала авторизуйтесь")
            return
        
        action = "подтверждена" if approved else "отклонена"
        self.log(f"💳 Карта {action}")
        
        def do_confirm():
            try:
                response = self.session.post(
                    f"{self.base_url}/admin/confirm_card",
                    json={'terminal_id': self.terminal_id, 'approved': approved},
                    timeout=10
                )
                
                if response.status_code == 200:
                    self.root.after(0, lambda: self.log(f"✅ Карта {action}"))
                else:
                    self.root.after(0, lambda: self.log(f"❌ Ошибка {response.status_code}"))
            except Exception as e:
                self.root.after(0, lambda: self.log(f"❌ Ошибка: {str(e)}"))
        
        threading.Thread(target=do_confirm, daemon=True).start()
        
    def cancel_payment(self):
        """Отменить операцию"""
        if not self.authenticated:
            messagebox.showerror("Ошибка", "Сначала авторизуйтесь")
            return
        
        self.log("🚫 Отмена операции")
        
        def do_cancel():
            try:
                response = self.session.post(
                    f"{self.base_url}/admin/set_device_payload",
                    json={'terminal_id': self.terminal_id, 'payload': 'idle'},
                    timeout=10
                )
                
                if response.status_code == 200:
                    self.root.after(0, lambda: self.log("✅ Операция отменена"))
                else:
                    self.root.after(0, lambda: self.log(f"❌ Ошибка {response.status_code}"))
            except Exception as e:
                self.root.after(0, lambda: self.log(f"❌ Ошибка: {str(e)}"))
        
        threading.Thread(target=do_cancel, daemon=True).start()
        
    def get_status(self):
        """Получить статус терминала"""
        if not self.authenticated:
            messagebox.showerror("Ошибка", "Сначала авторизуйтесь")
            return
        
        self.log("📊 Запрос статуса...")
        
        def do_status():
            try:
                response = self.session.get(
                    f"{self.base_url}/admin/status",
                    timeout=10
                )
                
                if response.status_code == 200:
                    data = response.json()
                    devices = data.get('devices', [])
                    device = next((d for d in devices if d.get('terminal_id') == self.terminal_id), None)
                    
                    if device:
                        payload = device.get('current_payload', {})
                        state = payload.get('state', 'unknown')
                        amount = payload.get('data', {}).get('amount', 'N/A')
                        
                        status_text = f"Терминал: {self.terminal_id}\nСостояние: {state}\nСумма: {amount} ₽"
                        self.root.after(0, lambda: self.log(f"📊 {status_text.replace(chr(10), ', ')}"))
                        self.root.after(0, lambda: messagebox.showinfo("Статус", status_text))
                    else:
                        self.root.after(0, lambda: self.log("❌ Терминал не найден"))
                else:
                    self.root.after(0, lambda: self.log(f"❌ Ошибка {response.status_code}"))
            except Exception as e:
                self.root.after(0, lambda: self.log(f"❌ Ошибка: {str(e)}"))
        
        threading.Thread(target=do_status, daemon=True).start()

if __name__ == '__main__':
    root = tk.Tk()
    app = CashierApp(root)
    root.mainloop()
