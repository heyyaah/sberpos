@echo off
echo ========================================
echo   СберЭкран - Программа-касса
echo ========================================
echo.
echo Проверка зависимостей...
pip install -r cashier_requirements.txt >nul 2>&1
echo.
echo Запуск программы...
python cashier_app.py
pause
