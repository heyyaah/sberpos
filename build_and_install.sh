#!/bin/bash

echo "🔨 Сборка и установка APK"
echo ""

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Имена файлов
APK_UNSIGNED="SberPOS_modified.apk"
APK_SIGNED="SberPOS_modified_signed.apk"
KEYSTORE="my-release-key.jks"
KEYSTORE_ALIAS="my-key-alias"

# Шаг 1: Сборка APK
echo -e "${YELLOW}[1/4]${NC} Сборка APK с помощью apktool..."
java -jar apktool.jar b apktool_out -o "$APK_UNSIGNED"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Ошибка сборки APK${NC}"
    exit 1
fi
echo -e "${GREEN}✅ APK собран: $APK_UNSIGNED${NC}"
echo ""

# Шаг 2: Создание keystore (если не существует)
if [ ! -f "$KEYSTORE" ]; then
    echo -e "${YELLOW}[2/4]${NC} Создание keystore для подписи..."
    keytool -genkey -v -keystore "$KEYSTORE" -alias "$KEYSTORE_ALIAS" -keyalg RSA -keysize 2048 -validity 10000 -storepass android -keypass android -dname "CN=Test, OU=Test, O=Test, L=Test, S=Test, C=US"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Ошибка создания keystore${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Keystore создан${NC}"
else
    echo -e "${YELLOW}[2/4]${NC} Keystore уже существует, пропускаем..."
fi
echo ""

# Шаг 3: Подпись APK
echo -e "${YELLOW}[3/4]${NC} Подпись APK..."
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore "$KEYSTORE" -storepass android -keypass android "$APK_UNSIGNED" "$KEYSTORE_ALIAS"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Ошибка подписи APK${NC}"
    exit 1
fi

# Выравнивание APK (zipalign)
if command -v zipalign &> /dev/null; then
    echo "Выравнивание APK..."
    zipalign -v 4 "$APK_UNSIGNED" "$APK_SIGNED"
    rm "$APK_UNSIGNED"
else
    echo "zipalign не найден, переименовываем файл..."
    mv "$APK_UNSIGNED" "$APK_SIGNED"
fi

echo -e "${GREEN}✅ APK подписан: $APK_SIGNED${NC}"
echo ""

# Шаг 4: Установка на устройство
echo -e "${YELLOW}[4/4]${NC} Установка APK на устройство..."

# Проверка подключенных устройств с ожиданием
MAX_WAIT=10
WAITED=0

while [ $WAITED -lt $MAX_WAIT ]; do
    adb devices | grep -w "device" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✅ Устройство подключено${NC}"
        break
    fi
    
    if [ $WAITED -eq 0 ]; then
        echo -e "${YELLOW}⏳ Устройство не подключено, ожидание $MAX_WAIT секунд...${NC}"
    fi
    
    sleep 1
    WAITED=$((WAITED + 1))
    echo -ne "\r⏳ Ожидание: $WAITED/$MAX_WAIT сек"
done

# Финальная проверка после ожидания
if [ $WAITED -eq $MAX_WAIT ]; then
    echo ""
    echo -e "${RED}❌ Устройство не подключено после $MAX_WAIT секунд${NC}"
    echo "Подключи устройство или запусти эмулятор"
    exit 1
fi

# Удаление старой версии (если есть)
echo "Удаление старой версии..."
adb uninstall com.roder300.kozen 2>/dev/null

# Установка
adb install "$APK_SIGNED"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Ошибка установки APK${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Готово! APK установлен на устройство${NC}"
echo ""
echo "📱 Запусти приложение на устройстве"
echo "🚀 Убедись, что api_server.py запущен"
