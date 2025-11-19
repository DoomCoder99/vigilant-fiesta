# Module 5: My Orders - Asset Downloader
# Run from project root: ./scripts/download_module5_assets.ps1

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Module 5: My Orders - Asset Downloader" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Create directory structure
Write-Host "Creating directory structure..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "assets/my_orders" | Out-Null

# Icons
Write-Host ""
Write-Host "Downloading Icons..." -ForegroundColor Green

# Article icon (Invoice) - from node 1:6360
Write-Host "  Downloading Article icon (Invoice)..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/9f7244f7-f776-4606-b4d6-0bdc7800bbb2" -OutFile "assets/my_orders/icon_article.png" -ErrorAction Stop
    Write-Host "      Success" -ForegroundColor Green
} catch {
    Write-Host "      Failed: $_" -ForegroundColor Red
}

# Check circle icon - from node 68:3792
Write-Host "  Downloading Check circle icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/ad6672a8-a3dc-43bb-a88b-8086b5575929" -OutFile "assets/my_orders/icon_check_circle.png" -ErrorAction Stop
    Write-Host "      Success" -ForegroundColor Green
} catch {
    Write-Host "      Failed: $_" -ForegroundColor Red
}

# Product Images
Write-Host ""
Write-Host "Downloading Product Images..." -ForegroundColor Green

# Bose QuietComfort Headphones - from node 68:3852
Write-Host "  Downloading Bose QuietComfort Headphones..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/74f67f2a-4ea6-43ea-bb3b-0cd9b18d8f85" -OutFile "assets/my_orders/product_bose_headphones.png" -ErrorAction Stop
    Write-Host "      Success" -ForegroundColor Green
} catch {
    Write-Host "      Failed: $_" -ForegroundColor Red
}

# Bose Headphones Variant 1 - from node 68:4044
Write-Host "  Downloading Bose Headphones Variant 1..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/344179cc-7ddf-44c3-9002-e7f9407f0db7" -OutFile "assets/my_orders/product_bose_headphones_variant1.png" -ErrorAction Stop
    Write-Host "      Success" -ForegroundColor Green
} catch {
    Write-Host "      Failed: $_" -ForegroundColor Red
}

# Bose Headphones Variant 2 - from node 68:4124
Write-Host "  Downloading Bose Headphones Variant 2..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/b56aeff4-fa08-42da-b48e-05703e293a0d" -OutFile "assets/my_orders/product_bose_headphones_variant2.png" -ErrorAction Stop
    Write-Host "      Success" -ForegroundColor Green
} catch {
    Write-Host "      Failed: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Download Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
