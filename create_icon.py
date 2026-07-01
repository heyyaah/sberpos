from PIL import Image, ImageDraw, ImageFont

# Создаем иконку 192x192 (hdpi)
img = Image.new('RGB', (192, 192), color='#667eea')
draw = ImageDraw.Draw(img)

# Рисуем круг
draw.ellipse([20, 20, 172, 172], fill='#764ba2')

# Добавляем текст
try:
    font = ImageFont.truetype("arial.ttf", 80)
except:
    font = ImageFont.load_default()

draw.text((96, 96), "💼", fill='white', anchor='mm', font=font)

# Сохраняем
img.save('cabinet_app/res/mipmap-hdpi/ic_launcher.png')
print("✅ Icon created!")
