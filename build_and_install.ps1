# Build and install APK (simplified version)
Write-Host "Build and install APK" -ForegroundColor Cyan
Write-Host ""

# File names
$APK_UNSIGNED = "SberPOS_modified.apk"
$APK_SIGNED = "SberPOS_modified_signed.apk"
$ORIGINAL_SIGNED = "SberPOS_gesture_fix_signed.apk"

# Step 1: Build APK
Write-Host "[1/3] Building APK with apktool..." -ForegroundColor Yellow
java -jar apktool.jar b apktool_out -o $APK_UNSIGNED

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error building APK" -ForegroundColor Red
    exit 1
}
Write-Host "APK built: $APK_UNSIGNED" -ForegroundColor Green
Write-Host ""

# Step 2: Sign APK using original signature
Write-Host "[2/3] Signing APK..." -ForegroundColor Yellow

if (-not (Test-Path $ORIGINAL_SIGNED)) {
    Write-Host "Original signed APK not found: $ORIGINAL_SIGNED" -ForegroundColor Red
    Write-Host "Trying to use unsigned APK (may fail on device)..." -ForegroundColor Yellow
    Copy-Item $APK_UNSIGNED $APK_SIGNED -Force
} else {
    Write-Host "Downloading uber-apk-signer..." -ForegroundColor Yellow
    
    $signerUrl = "https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar"
    $signerJar = "uber-apk-signer.jar"
    
    if (-not (Test-Path $signerJar)) {
        try {
            Invoke-WebRequest -Uri $signerUrl -OutFile $signerJar -UseBasicParsing
            Write-Host "Downloaded uber-apk-signer" -ForegroundColor Green
        } catch {
            Write-Host "Failed to download uber-apk-signer" -ForegroundColor Red
            Write-Host "Using unsigned APK..." -ForegroundColor Yellow
            Copy-Item $APK_UNSIGNED $APK_SIGNED -Force
        }
    }
    
    if (Test-Path $signerJar) {
        Write-Host "Signing with uber-apk-signer..." -ForegroundColor Yellow
        java -jar $signerJar --apks $APK_UNSIGNED --allowResign --overwrite
        
        # Find signed APK
        $signedApk = Get-ChildItem -Filter "*-aligned-debugSigned.apk" | Select-Object -First 1
        
        if ($signedApk) {
            Move-Item $signedApk.FullName $APK_SIGNED -Force
            Write-Host "APK signed successfully" -ForegroundColor Green
        } else {
            Write-Host "Signing failed, using unsigned APK" -ForegroundColor Yellow
            Copy-Item $APK_UNSIGNED $APK_SIGNED -Force
        }
    }
}

Write-Host ""

# Step 3: Install on device
Write-Host "[3/3] Installing APK on device..." -ForegroundColor Yellow

# Check connected devices with waiting
$MAX_WAIT = 10
$WAITED = 0

while ($WAITED -lt $MAX_WAIT) {
    $devices = adb devices
    
    if ($devices -match "device$") {
        Write-Host ""
        Write-Host "Device connected" -ForegroundColor Green
        break
    }
    
    if ($WAITED -eq 0) {
        Write-Host "Device not connected, waiting $MAX_WAIT seconds..." -ForegroundColor Yellow
    }
    
    Start-Sleep -Seconds 1
    $WAITED++
    Write-Host "`rWaiting: $WAITED/$MAX_WAIT sec" -NoNewline
}

# Final check after waiting
if ($WAITED -eq $MAX_WAIT) {
    Write-Host ""
    Write-Host "Device not connected after $MAX_WAIT seconds" -ForegroundColor Red
    Write-Host "Connect device or start emulator" -ForegroundColor Yellow
    exit 1
}

# Uninstall old version (if exists)
Write-Host "Uninstalling old version..." -ForegroundColor Gray
adb uninstall com.roder300.kozen 2>$null

# Install
Write-Host "Installing APK..." -ForegroundColor Yellow
adb install $APK_SIGNED

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error installing APK" -ForegroundColor Red
    Write-Host ""
    Write-Host "Try installing manually:" -ForegroundColor Yellow
    Write-Host "  adb install -r $APK_SIGNED" -ForegroundColor Cyan
    exit 1
}

Write-Host ""
Write-Host "Done! APK installed on device" -ForegroundColor Green
Write-Host ""
Write-Host "Launch the app on device" -ForegroundColor Cyan
Write-Host "Make sure api_server.py is running on port 5001" -ForegroundColor Cyan
Write-Host "Server should be accessible at: http://192.168.0.14:5001" -ForegroundColor Cyan
