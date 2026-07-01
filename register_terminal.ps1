# Скрипт для регистрации терминала на Render

$terminalId = Read-Host "Введи Terminal ID (например TRM-9356)"
$password = Read-Host "Введи пароль (6 цифр)"

$body = @{
    terminal_id = $terminalId
    password = $password
} | ConvertTo-Json

Write-Host "`n🔄 Регистрация терминала $terminalId..." -ForegroundColor Yellow

try {
    $response = Invoke-RestMethod -Uri "https://sberpos-api.onrender.com/api/register_device" `
        -Method POST `
        -Body $body `
        -ContentType "application/json"
    
    Write-Host "`n✅ Терминал успешно зарегистрирован!" -ForegroundColor Green
    Write-Host "Terminal ID: $($response.terminal_id)" -ForegroundColor Cyan
    Write-Host "Password: $($response.terminal_password)" -ForegroundColor Cyan
    Write-Host "UUID: $($response.uuid)" -ForegroundColor Cyan
    
} catch {
    Write-Host "`n❌ Ошибка регистрации:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    if ($_.ErrorDetails.Message) {
        $errorJson = $_.ErrorDetails.Message | ConvertFrom-Json
        Write-Host "Детали: $($errorJson.error)" -ForegroundColor Red
    }
}

Write-Host "`nНажми Enter для выхода..."
Read-Host
