# Module 13: Notifications - Asset Manifest

## Overview

This document lists all image assets required for Module 13: Notifications, extracted from Figma frames.

## Figma Frames Analyzed

1. **Notifications - State A** (node-id: 1-11457)
2. **Notifications - State B** (node-id: 1-11702)
3. **Notifications - State C** (node-id: 1-11347) - Primary design reference
4. **Notification Settings** (node-id: 1-11405)
5. **Notification Blank** (node-id: 1-11315)

## Asset List

### Notification Icons

| Figma Node ID | Node Name | Asset Path | Used In | Description |
|--------------|-----------|------------|---------|-------------|
| 1:11379 | image 9 | `assets/notifications/rent_vehicle_icon.png` | NotificationsScreen (State C) | Rent vehicle notification icon - car with key |
| 1:11389 | Frame 1171275636 | `assets/notifications/delivery_icon.png` | NotificationsScreen (State C) | Delivery/order notification icon - sunglasses product |
| 1:11398 | Frame 1171275637 | `assets/notifications/profile_icon.png` | NotificationsScreen (State C) | Profile notification icon - avatar illustration |

**Note**: These icons are 24x24px inside a 48x48px container with 12px padding and 1px border (#d6dee8).

### Empty State Illustration

| Figma Node ID | Node Name | Asset Path | Used In | Description |
|--------------|-----------|------------|---------|-------------|
| 1:11335 | image 35 | `assets/notifications/empty_state.png` | NotificationBlank widget | Empty state illustration - person with phone showing "0" notifications (160x160px) |

### Existing Assets (Already in Repository)

| Asset Path | Used In | Description |
|------------|---------|-------------|
| `assets/notifications/delivery.png` | NotificationsScreen | Delivery notification icon (existing) |
| `assets/notifications/empty_state.png` | NotificationBlank | Empty state illustration (existing) |
| `assets/notifications/profile.png` | NotificationsScreen | Profile notification icon (existing) |
| `assets/notifications/rent_vehicle.png` | NotificationsScreen | Rent vehicle notification icon (existing) |

### App Bar Icons

| Icon | Asset Path | Used In | Description |
|------|------------|---------|-------------|
| Back Arrow | `assets/images/icon_back_arrow.png` | NotificationsScreen, NotificationSettingsScreen | Back navigation button (16x16px) |
| Filter/Sort | `assets/images/discover_tune.png` ✅ | NotificationsScreen | Filter/sort icon (16x16px) - **Exported from Figma** |

**Note**: The filter/sort icon (discover_tune) has been exported from Figma node 1:11372 and saved as `assets/images/discover_tune.png`.

## Figma Asset URLs (7-Day Expiry)

These URLs are temporary and expire after 7 days. Assets should be downloaded and saved locally.

### From Notifications State C (1:11347)
- Empty state illustration: `https://www.figma.com/api/mcp/asset/391c53d8-7062-497b-9fbf-9fbdda38aff2`
- Rent vehicle icon: `https://www.figma.com/api/mcp/asset/1d46c15a-e056-4a10-855d-5db077c386a4`
- Delivery icon: `https://www.figma.com/api/mcp/asset/5f48d3e7-8e2f-41f4-a26c-da9fe76a65a2`
- Profile icon: `https://www.figma.com/api/mcp/asset/2ee94f6a-0557-449a-8000-048045879ed0`

### From Notification Settings (1:11405)
- Switch thumb icon: `https://www.figma.com/api/mcp/asset/162fb0d7-e858-403c-8eb8-8a5082b7b7d9`

### From Notification Blank (1:11315)
- Empty state illustration: `https://www.figma.com/api/mcp/asset/391c53d8-7062-497b-9fbf-9fbdda38aff2`

## Asset Export Instructions

1. **Download from Figma URLs**: Use the temporary URLs above to download assets (valid for 7 days)
2. **Save to assets folder**: Place all notification icons in `assets/notifications/`
3. **Update pubspec.yaml**: Ensure all asset paths are listed under `flutter: assets:`
4. **Verify dimensions**: 
   - Notification icons: 24x24px (will be displayed in 48x48px containers)
   - Empty state illustration: 160x160px
   - App bar icons: 16x16px

## Current Status

✅ **All Assets Available**: All required assets are now in the repository:
- `assets/notifications/delivery.png` ✅
- `assets/notifications/empty_state.png` ✅
- `assets/notifications/profile.png` ✅
- `assets/notifications/rent_vehicle.png` ✅
- `assets/images/discover_tune.png` ✅ (filter/sort icon - exported from Figma)

## Integration Notes

- All notification icons are referenced in `NotificationModel.iconPath`
- Empty state illustration is used in `NotificationBlank` widget
- App bar icons are used in both `NotificationsScreen` and `NotificationSettingsScreen`
- All assets have fallback error handlers that display Material icons if images fail to load

