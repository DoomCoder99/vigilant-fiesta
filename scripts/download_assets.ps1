# Figma Asset Download Script (PowerShell)
# Downloads assets from Figma MCP asset URLs and saves them to assets/images/ directory.
# Asset URLs expire after 7 days - regenerate by running Figma MCP get_design_context.

$ErrorActionPreference = "Stop"

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$AssetsDir = Join-Path (Join-Path $ProjectRoot "assets") "images"
$AssetUrlsFile = Join-Path $ScriptDir "figma_asset_urls.json"

# Create assets directory if it doesn't exist
if (-not (Test-Path $AssetsDir)) {
    New-Item -ItemType Directory -Path $AssetsDir -Force | Out-Null
}
Write-Host "Assets directory: $AssetsDir" -ForegroundColor Green

# Load asset URLs from JSON
try {
    $assetData = Get-Content $AssetUrlsFile -Raw | ConvertFrom-Json
    Write-Host "Loaded asset URLs from $AssetUrlsFile" -ForegroundColor Green
} catch {
    Write-Host "Error loading asset URLs: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
$separator = "=" * 60
Write-Host $separator -ForegroundColor Cyan
Write-Host "Figma Asset Downloader" -ForegroundColor Cyan
Write-Host $separator -ForegroundColor Cyan
Write-Host ""

if ($assetData.note) {
    Write-Host "Note: $($assetData.note)" -ForegroundColor Yellow
    Write-Host ""
}

$totalDownloaded = 0
$totalFailed = 0

# Download assets from each category
foreach ($category in $assetData.assets.PSObject.Properties) {
    $categoryName = $category.Name -replace '_', ' '
    $categoryName = (Get-Culture).TextInfo.ToTitleCase($categoryName)
    
    Write-Host "Category: $categoryName" -ForegroundColor Cyan
    $dashLine = "-" * 60
    Write-Host $dashLine -ForegroundColor Gray
    
    foreach ($asset in $category.Value.PSObject.Properties) {
        $filename = $asset.Name
        $url = $asset.Value
        
        try {
            Write-Host "  Downloading $filename..." -NoNewline
            
            $filePath = Join-Path $AssetsDir $filename
            Invoke-WebRequest -Uri $url -OutFile $filePath -TimeoutSec 30 -ErrorAction Stop | Out-Null
            
            $fileSize = (Get-Item $filePath).Length
            $fileSizeFormatted = $fileSize.ToString('N0')
            Write-Host " OK ($fileSizeFormatted bytes)" -ForegroundColor Green
            $totalDownloaded++
        } catch {
            Write-Host " ERROR: $_" -ForegroundColor Red
            $totalFailed++
        }
    }
    
    Write-Host ""
}

# Summary
$separator = "=" * 60
Write-Host $separator -ForegroundColor Cyan
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Downloaded: $totalDownloaded" -ForegroundColor Green
Write-Host "  Failed: $totalFailed" -ForegroundColor Red
$total = $totalDownloaded + $totalFailed
Write-Host "  Total: $total" -ForegroundColor White
Write-Host $separator -ForegroundColor Cyan
Write-Host ""

if ($totalDownloaded -gt 0) {
    Write-Host "Assets saved to: $AssetsDir" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Run 'flutter pub get'" -ForegroundColor White
    Write-Host "  2. Verify assets in the app" -ForegroundColor White
    Write-Host "  3. Check for any missing assets" -ForegroundColor White
}

