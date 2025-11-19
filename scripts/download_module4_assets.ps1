# Module 4: Rent a Vehicle - Asset Downloader
# Run from project root: ./scripts/download_module4_assets.ps1

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Module 4: Rent a Vehicle - Asset Downloader" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Create directory structure
Write-Host "Creating directory structure..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "assets/rent_vehicle/categories" | Out-Null
New-Item -ItemType Directory -Force -Path "assets/rent_vehicle/banners" | Out-Null
New-Item -ItemType Directory -Force -Path "assets/rent_vehicle/vehicles" | Out-Null

# Category Icons (6 items)
Write-Host ""
Write-Host "Downloading Category Icons..." -ForegroundColor Green
Write-Host "  ├─ Car..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/4f7a964d-7b63-45b2-9d0e-94019b3ac0d8" -OutFile "assets/rent_vehicle/categories/icon_car.png"

Write-Host "  ├─ Van..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/7566b75b-d0a2-4bb2-8ac3-7a8bb1d0b340" -OutFile "assets/rent_vehicle/categories/icon_van.png"

Write-Host "  ├─ 4x4..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/ef66ed7e-0a73-4eeb-a12e-313b342bd5e3" -OutFile "assets/rent_vehicle/categories/icon_4x4.png"

Write-Host "  ├─ Jet Ski..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/695db48b-947f-4385-a571-5a671436638a" -OutFile "assets/rent_vehicle/categories/icon_jetski.png"

Write-Host "  ├─ Yachts..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/9ed2818e-aee0-46aa-913d-267cf9fef2ee" -OutFile "assets/rent_vehicle/categories/icon_yachts.png"

Write-Host "  └─ Pickup..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/afdd46b6-38cb-4bbe-9765-d2c539f997be" -OutFile "assets/rent_vehicle/categories/icon_pickup.png"

# Banners (5 items)
Write-Host ""
Write-Host "Downloading Banners..." -ForegroundColor Green
Write-Host "  ├─ Services Banner Background..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/0fcb5d32-bffc-4017-8347-016f104ebe09" -OutFile "assets/rent_vehicle/banners/banner_services_bg.png"

Write-Host "  ├─ Banner Graphic..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/20bf908f-168e-4088-9a3a-e042063a6863" -OutFile "assets/rent_vehicle/banners/banner_graphic.png"

Write-Host "  ├─ Decorator Ellipse 1..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/ae9cc0e7-52ee-4238-bf32-c9483c1133aa" -OutFile "assets/rent_vehicle/banners/decorator_ellipse_1.png"

Write-Host "  ├─ Decorator Ellipse 2..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/a2761db1-9795-4280-a102-07cd2be18fe2" -OutFile "assets/rent_vehicle/banners/decorator_ellipse_2.png"

Write-Host "  └─ Decorator Ellipse 3..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/37122a87-cdf2-4197-8046-0d33bae2d7f2" -OutFile "assets/rent_vehicle/banners/decorator_ellipse_3.png"

# Vehicle Thumbnails (4 items)
Write-Host ""
Write-Host "Downloading Vehicle Thumbnails..." -ForegroundColor Green
Write-Host "  ├─ Toyota Camry..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/0377f71a-5793-4386-a0f7-33791c042dd5" -OutFile "assets/rent_vehicle/vehicles/thumb_toyota_camry.png"

Write-Host "  ├─ Hyundai Sonata..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/2ff7d7e4-0a4d-4483-9393-75f0c9ad99b5" -OutFile "assets/rent_vehicle/vehicles/thumb_hyundai_sonata.png"

Write-Host "  ├─ Kia K3..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/838cb3bc-dd2f-49f2-8e8f-70006db4dd17" -OutFile "assets/rent_vehicle/vehicles/thumb_kia_k3.png"

Write-Host "  └─ Toyota Camry (Alt)..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/b2c90883-d246-4014-96aa-ce86c58d5152" -OutFile "assets/rent_vehicle/vehicles/thumb_toyota_camry_2.png"

# Vehicle Hero (1 item)
Write-Host ""
Write-Host "Downloading Vehicle Hero Image..." -ForegroundColor Green
Write-Host "  └─ Vehicle Detail Hero..." -ForegroundColor Gray
Invoke-WebRequest -Uri "https://www.figma.com/api/mcp/asset/542b47c7-793f-41b6-83d5-03ba98e2936e" -OutFile "assets/rent_vehicle/vehicles/hero_vehicle_detail.png"

# Summary
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "✅ Download Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Downloaded Assets:" -ForegroundColor Yellow
Write-Host "  • 6 Category Icons" -ForegroundColor White
Write-Host "  • 5 Banner Images" -ForegroundColor White
Write-Host "  • 4 Vehicle Thumbnails" -ForegroundColor White
Write-Host "  • 1 Vehicle Hero Image" -ForegroundColor White
Write-Host "  ─────────────────────" -ForegroundColor Gray
Write-Host "  📦 Total: 16 assets" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Update pubspec.yaml with asset paths:" -ForegroundColor White
Write-Host "     flutter:" -ForegroundColor Gray
Write-Host "       assets:" -ForegroundColor Gray
Write-Host "         - assets/rent_vehicle/categories/" -ForegroundColor Gray
Write-Host "         - assets/rent_vehicle/banners/" -ForegroundColor Gray
Write-Host "         - assets/rent_vehicle/vehicles/" -ForegroundColor Gray
Write-Host ""
Write-Host "  2. Run: flutter pub get" -ForegroundColor White
Write-Host ""
Write-Host "  3. Verify assets in your app" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  NOTE: Add-on product images need separate export from Figma" -ForegroundColor Magenta
Write-Host ""

