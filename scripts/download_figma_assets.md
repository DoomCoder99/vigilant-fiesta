# Figma Asset Download Guide

This guide helps you download assets from Figma using the asset URLs extracted from the design context.

## Method 1: Manual Download from Figma

1. Open the Figma file: https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-
2. Select the frame/screen you need assets from
3. Right-click on the image/icon element
4. Select "Export" or "Copy/Paste as PNG"
5. Choose resolution (2x or 3x for high-density displays)
6. Save to `assets/images/` directory

## Method 2: Using Figma API Asset URLs

The Figma MCP tool provides temporary asset URLs (valid for 7 days). These can be downloaded programmatically.

### Asset URLs from Design Context

The following asset URLs were extracted from Figma design context. These URLs are temporary and expire after 7 days.

**Note**: To get fresh URLs, run the Figma MCP `get_design_context` tool again.

### Download Script (Python)

Create a Python script to download assets:

```python
import requests
import os
from pathlib import Path

# Asset URLs from Figma (replace with fresh URLs from get_design_context)
ASSET_URLS = {
    'icon_home.png': 'https://www.figma.com/api/mcp/asset/...',
    'icon_shop.png': 'https://www.figma.com/api/mcp/asset/...',
    # Add more URLs here
}

ASSETS_DIR = Path('assets/images')

def download_asset(name, url):
    """Download an asset from Figma URL"""
    try:
        response = requests.get(url, timeout=30)
        if response.status_code == 200:
            file_path = ASSETS_DIR / name
            file_path.parent.mkdir(parents=True, exist_ok=True)
            with open(file_path, 'wb') as f:
                f.write(response.content)
            print(f"✓ Downloaded {name}")
            return True
        else:
            print(f"✗ Failed to download {name}: HTTP {response.status_code}")
            return False
    except Exception as e:
        print(f"✗ Error downloading {name}: {e}")
        return False

if __name__ == '__main__':
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    
    for name, url in ASSET_URLS.items():
        download_asset(name, url)
    
    print("\nDownload complete!")
```

### Download Script (PowerShell - Windows)

```powershell
# Create assets directory if it doesn't exist
$assetsDir = "assets\images"
if (-not (Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force
}

# Asset URLs (replace with fresh URLs from get_design_context)
$assets = @{
    "icon_home.png" = "https://www.figma.com/api/mcp/asset/..."
    "icon_shop.png" = "https://www.figma.com/api/mcp/asset/..."
    # Add more URLs here
}

foreach ($asset in $assets.GetEnumerator()) {
    $fileName = $asset.Key
    $url = $asset.Value
    $filePath = Join-Path $assetsDir $fileName
    
    try {
        Write-Host "Downloading $fileName..."
        Invoke-WebRequest -Uri $url -OutFile $filePath -TimeoutSec 30
        Write-Host "✓ Downloaded $fileName" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to download $fileName: $_" -ForegroundColor Red
    }
}

Write-Host "`nDownload complete!" -ForegroundColor Cyan
```

## Method 3: Extract from Figma Design Context

1. Run Figma MCP `get_design_context` for each screen
2. Extract asset URLs from the generated file
3. Use the download scripts above to fetch assets

## Asset Naming Convention

Follow this naming convention:
- Icons: `icon_[name].png` (e.g., `icon_home.png`)
- Categories: `category_[name].png` (e.g., `category_personal_care.png`)
- Services: `service_[name].png` (e.g., `service_home_maintenance.png`)
- Products: `product_[name].png` (e.g., `product_bose_headphones.png`)
- Banners: `banner_[name].png` (e.g., `banner_car_care.png`)

## Resolution Guidelines

- **Icons (16x16px)**: Export at 1x, 2x, 3x (16px, 32px, 48px)
- **Category Icons (64x64px)**: Export at 1x, 2x, 3x (64px, 128px, 192px)
- **Product Images**: Export at 2x and 3x for high-density displays
- **Banners**: Export at 2x for full-width banners

## Flutter Asset Declaration

After downloading assets, ensure they're declared in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

The wildcard `assets/images/` will include all files in that directory.

## Verification

After downloading assets:

1. Run `flutter pub get`
2. Check for asset errors: `flutter analyze`
3. Test asset loading in the app
4. Verify assets appear correctly on different screen densities

## Troubleshooting

- **Asset not found errors**: Check file paths match `AssetPaths` constants
- **Blurry images**: Ensure exporting at 2x/3x resolution
- **Wrong colors**: Check if assets need transparency (PNG) vs solid colors
- **Missing assets**: Use `AssetHelper.loadImageOrIcon()` for graceful fallbacks

