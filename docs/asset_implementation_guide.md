# Asset Implementation Guide

This guide explains how to implement assets in the Flutter app after downloading them from Figma.

## Overview

The app uses a two-tier asset system:
1. **Asset Helper** (`lib/core/utils/asset_helper.dart`) - Provides fallback mechanism
2. **Asset Paths** (`AssetPaths` class) - Centralized asset path constants

## How It Works

### 1. Asset Helper with Fallbacks

The `AssetHelper` class provides methods that automatically fall back to Material Icons if assets are not found:

```dart
// Load icon with Material Icon fallback
AssetHelper.loadImageOrIcon(
  assetPath: AssetPaths.iconHome,
  fallbackIcon: Icons.home,
  size: 20,
  color: Colors.white,
)

// Load image with placeholder fallback
AssetHelper.loadImageOrPlaceholder(
  assetPath: AssetPaths.productPlaceholder,
  width: 120,
  height: 120,
)
```

### 2. Current Implementation Status

#### ✅ Implemented with Fallbacks
- **Bottom Navigation Bar**: Icons use `AssetHelper.loadImageOrIcon()` with Material Icon fallbacks
- **Category Icons**: Shop landing screen category icons use asset helper

#### 📋 Ready for Implementation
- App bar icons (back, search, apps, etc.)
- Product images
- Promotional banners
- Payment method icons
- Cart icons

## Step-by-Step Implementation

### Step 1: Download Assets

Use the guide in `scripts/download_figma_assets.md` to download assets from Figma.

### Step 2: Add Assets to Project

1. Place downloaded assets in `assets/images/` directory
2. Ensure `pubspec.yaml` includes:
   ```yaml
   flutter:
     assets:
       - assets/images/
   ```
3. Run `flutter pub get`

### Step 3: Update Code to Use Assets

Replace Material Icons with asset helper calls:

**Before:**
```dart
Icon(Icons.home, size: 20, color: Colors.white)
```

**After:**
```dart
AssetHelper.loadImageOrIcon(
  assetPath: AssetPaths.iconHome,
  fallbackIcon: Icons.home,
  size: 20,
  color: Colors.white,
)
```

### Step 4: Test Asset Loading

1. Run the app
2. Verify assets appear correctly
3. If assets are missing, Material Icons should appear as fallback
4. Check console for any asset loading errors

## Implementation Examples

### Example 1: Bottom Navigation Icon

```dart
// In bottom_navigation_bar.dart
AssetHelper.loadImageOrIcon(
  assetPath: _getIconAssetPath(icon),
  fallbackIcon: icon,
  size: 20,
  color: isSelected ? AppColors.textPrimary : Colors.white,
)
```

### Example 2: Category Icon

```dart
// In shop_landing_screen.dart
AssetHelper.loadImageOrIcon(
  assetPath: _getCategoryIconPath(categoryName),
  fallbackIcon: icon,
  size: 32,
  color: AppColors.primary,
)
```

### Example 3: Product Image

```dart
// In product_card widget
AssetHelper.loadImageOrPlaceholder(
  assetPath: AssetPaths.productPlaceholder,
  width: 120,
  height: 120,
  fit: BoxFit.cover,
)
```

### Example 4: Promotional Banner

```dart
// In promotional banner widget
AssetHelper.loadImageOrPlaceholder(
  assetPath: AssetPaths.bannerCarCare,
  width: double.infinity,
  height: 140,
  fit: BoxFit.cover,
)
```

## Asset Path Mapping

### Navigation Icons
- Home: `AssetPaths.iconHome` → `Icons.home`
- Shop: `AssetPaths.iconShop` → `Icons.shopping_bag`
- Orders: `AssetPaths.iconOrders` → `Icons.checklist`
- Cart: `AssetPaths.iconCart` → `Icons.shopping_cart`

### Category Icons
- Personal Care: `AssetPaths.categoryPersonalCare`
- Electronic Devices: `AssetPaths.categoryElectronicDevices`
- Home Appliances: `AssetPaths.categoryHomeAppliances`
- (See `asset_helper.dart` for full list)

## Benefits of This Approach

1. **Graceful Degradation**: App works even if assets are missing
2. **Easy Testing**: Can test UI without all assets
3. **Gradual Migration**: Can add assets incrementally
4. **Centralized Management**: All asset paths in one place
5. **Type Safety**: Asset paths are constants, reducing typos

## Troubleshooting

### Asset Not Found Error
- Check file exists in `assets/images/`
- Verify filename matches `AssetPaths` constant
- Run `flutter clean` and `flutter pub get`
- Check `pubspec.yaml` includes `assets/images/`

### Asset Appears Blurry
- Export assets at 2x or 3x resolution from Figma
- Ensure proper `BoxFit` is used
- Check image dimensions match expected size

### Fallback Icon Not Showing
- Verify `fallbackIcon` parameter is provided
- Check icon color is visible against background
- Ensure icon size is appropriate

## Next Steps

1. Download all assets from Figma (see `scripts/download_figma_assets.md`)
2. Add assets to `assets/images/` directory
3. Update remaining screens to use `AssetHelper`
4. Test on different screen densities
5. Remove Material Icon fallbacks once all assets are confirmed working

## Priority Order

1. **High Priority**: Bottom nav icons, Product images, Payment success illustration
2. **Medium Priority**: Category icons, App bar icons, Payment method icons
3. **Low Priority**: Service icons, Promotional banners, Social login icons

