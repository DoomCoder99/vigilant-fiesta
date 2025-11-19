# Module 11: Search - Asset Manifest

## Overview

This document lists all image assets exported from Figma for Module 11 (Search) and their usage in the Flutter app.

## Asset Directory

All assets are stored in: `assets/search/`

## Assets List

### Search Bar Icons

| Asset Name | Figma Node ID | Local Path | Usage |
|------------|---------------|------------|-------|
| Back Arrow | 1:27221 | `assets/search/icon_arrow_left.png` | Search bar back button |
| Cancel/Close | 1:27226 | `assets/search/icon_cancel.png` | Search bar clear button |

### Service Result Images

| Asset Name | Figma Node ID | Local Path | Usage |
|------------|---------------|------------|-------|
| 1 Switch Service | 1:27336 | `assets/search/service_1_switch.png` | Service result card image |
| 2 Switches Service | 1:27349 | `assets/search/service_2_switches.png` | Service result card image |
| More Than 2 Switches | 1:27362 | `assets/search/service_more_switches.png` | Service result card image |
| Power Switch Service | 1:27375 | `assets/search/service_power_switch.png` | Service result card image |

### Product Result Images

| Asset Name | Figma Node ID | Local Path | Usage |
|------------|---------------|------------|-------|
| Single Pole Switch | 1:27379 | `assets/search/product_single_pole_switch.png` | Product result card image |
| Double Pole Switch | 1:27391 | `assets/search/product_double_pole_switch.png` | Product result card image |
| Mylinc Switch | 1:27402 | `assets/search/product_mylinc_switch.png` | Product result card image |

**Note**: Category tab view uses same product images (different Figma node IDs but same visual content).

### Not Found State Illustration

| Asset Name | Figma Node ID | Local Path | Usage |
|------------|---------------|------------|-------|
| Not Found Illustration | 1:27547 | `assets/search/illustration_not_found.png` | Not found state main illustration |
| Ellipse Overlay | 1:27548 | `assets/search/ellipse_not_found.png` | Not found state decorative overlay |

## Asset Download

Assets were downloaded using the script: `scripts/download_module11_assets.sh`

To re-download assets (if Figma URLs expire after 7 days):

```bash
bash scripts/download_module11_assets.sh
```

## pubspec.yaml Configuration

Assets are registered in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/search/
```

## Usage in Code

Assets are accessed using `AssetHelper.loadImageOrPlaceholder()`:

```dart
AssetHelper.loadImageOrPlaceholder(
  assetPath: 'assets/search/service_1_switch.png',
  width: 72,
  height: 72,
)
```

Or with fallback icon:

```dart
AssetHelper.loadImageOrIcon(
  assetPath: 'assets/search/icon_arrow_left.png',
  fallbackIcon: Icons.arrow_back,
  size: 16,
  color: AppColors.textPrimary,
)
```

## Figma Frame References

All assets extracted from these Figma frames:

1. **Search** (node-id: 1-27201) - Initial state
2. **Search – on type** (node-id: 1-27253) - Typing state
3. **Search – on enter** (node-id: 1-27294) - Results state
4. **Search – category tab** (node-id: 1-27422) - Category filtered results
5. **Search – not found** (node-id: 1-27495) - Empty state

## Notes

- All images are PNG format
- Service images have light blue background (#DAE6ED)
- Product images have light grey background
- Not found illustration is centered with decorative ellipse overlay
- Star icon for ratings reuses existing `assets/images/star_1.png`

