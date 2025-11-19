# Module 6: Service Agent Actions - Asset Downloader
# Run from project root: ./scripts/download_module6_assets.ps1

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Module 6: Service Agent Actions - Asset Downloader" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Create directory structure
Write-Host "Creating directory structure..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "assets/my_orders/service_actions" | Out-Null

# Agent Avatar (from Order Detail - Service - Upcoming)
Write-Host ""
Write-Host "Downloading Agent Avatar..." -ForegroundColor Green
Write-Host "  └─ Agent Avatar..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/d60924a0-a04b-4006-b7ef-5516743f2f6b" -OutFile "assets/my_orders/service_actions/agent_avatar.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

# Cancellation Confirmation Assets
Write-Host ""
Write-Host "Downloading Cancellation Confirmation Assets..." -ForegroundColor Green
Write-Host "  └─ Speech Bubble Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/4df7ba79-972a-4344-b383-87e67930bf40" -OutFile "assets/my_orders/service_actions/speech_bubble.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

# Review Screen Assets
Write-Host ""
Write-Host "Downloading Review Screen Assets..." -ForegroundColor Green
Write-Host "  ├─ Rating Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/81fb439e-6414-4897-ba94-d9778f5c8afc" -OutFile "assets/my_orders/service_actions/rating_icon.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  ├─ Star Empty..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/fa7bb4c5-a505-4ca6-9af7-0711209258ac" -OutFile "assets/my_orders/service_actions/star_empty.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  ├─ Star Filled..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/a271635f-6d1c-4c18-abd7-051927f82dd5" -OutFile "assets/my_orders/service_actions/star_filled.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  └─ Mic Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/c5cdddd6-9f1f-4176-8809-93805d9d200c" -OutFile "assets/my_orders/service_actions/icon_mic.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

# Call Screen Assets
Write-Host ""
Write-Host "Downloading Call Screen Assets..." -ForegroundColor Green
Write-Host "  ├─ Volume Up Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/a83c3614-a4f5-4ce5-8ed8-d1a566a77873" -OutFile "assets/my_orders/service_actions/icon_volume_up.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  ├─ Call End Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/dfe660c5-c169-41d7-bc63-a92237987e2d" -OutFile "assets/my_orders/service_actions/icon_call_end.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  ├─ Mic Off Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/f81cf27b-4cba-4bb1-b66e-7eea58e14ba5" -OutFile "assets/my_orders/service_actions/icon_mic_off.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

Write-Host "  └─ Call Icon..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/b6f2bbf5-0091-4fb0-b7f4-09f500cb4199" -OutFile "assets/my_orders/service_actions/icon_call.png"
    Write-Host "    ✅ Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "    ❌ Failed to download: $_" -ForegroundColor Red
}

# Summary
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "✅ Download Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Downloaded Assets:" -ForegroundColor Yellow
Write-Host "  • 1 Agent Avatar" -ForegroundColor White
Write-Host "  • 1 Speech Bubble Icon" -ForegroundColor White
Write-Host "  • 1 Rating Icon" -ForegroundColor White
Write-Host "  • 2 Star Icons (empty, filled)" -ForegroundColor White
Write-Host "  • 1 Mic Icon" -ForegroundColor White
Write-Host "  • 4 Call Control Icons (volume, call end, mic off, call)" -ForegroundColor White
Write-Host "  ─────────────────────" -ForegroundColor Gray
Write-Host "  📦 Total: 10 assets" -ForegroundColor Cyan
Write-Host ""
Write-Host "Asset Location:" -ForegroundColor Yellow
Write-Host "  📁 assets/my_orders/service_actions/" -ForegroundColor White
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. ✅ pubspec.yaml already includes assets/my_orders/ path" -ForegroundColor Green
Write-Host "  2. Run: flutter pub get" -ForegroundColor White
Write-Host "  3. Verify assets load correctly in your app" -ForegroundColor White
Write-Host "  4. Test all Module 6 screens" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  NOTE: Figma asset URLs are valid for 7 days" -ForegroundColor Magenta
Write-Host "   If download fails, check the asset manifest for updated URLs" -ForegroundColor Magenta
Write-Host ""
