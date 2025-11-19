# Module 12: Notifications & Notification Settings - Asset Manifest

## Overview

This document lists all image assets required for Module 12: Notifications & Notification Settings, extracted from Figma frames.

## Figma Frames Analyzed

1. **Notifications (State A)** - node-id: 1-11457
2. **Notifications (State B)** - node-id: 1-11702
3. **Notifications (State C)** - node-id: 1-11347
4. **Notification Settings** - node-id: 1-11405
5. **Notification Blank (Empty State)** - node-id: 1-11315

## Required Assets

### Notification Icons

| Figma Node ID | Node Name | Asset Path | Used In | Notes |
|---------------|-----------|------------|---------|-------|
| 1:11379 | image 9 | `assets/notifications/rent_vehicle.png` | NotificationsScreen (State C) | Rent vehicle notification icon |
| 1:11389 | Frame 1171275636 | `assets/notifications/delivery.png` | NotificationsScreen (State C) | Order delivery notification icon |
| 1:11398 | Frame 1171275637 | `assets/notifications/profile.png` | NotificationsScreen (State C) | Profile incomplete notification icon |

### Empty State Illustration

| Figma Node ID | Node Name | Asset Path | Used In | Notes |
|---------------|-----------|------------|---------|-------|
| 1:11335 | image 35 | `assets/notifications/empty_state.png` | NotificationBlank widget | Empty state illustration (160x160) |

## Asset URLs from Figma MCP

### Notification Icons (from State C - node-id: 1-11347)

1. **Rent Vehicle Icon**
   - URL: `https://www.figma.com/api/mcp/asset/dc683897-d7d8-4b6f-a78c-ddcc294d5e43`
   - Local Path: `assets/notifications/rent_vehicle.png`
   - Size: 24x24 (within 48x48 container)

2. **Delivery Icon**
   - URL: `https://www.figma.com/api/mcp/asset/85ad231e-d41d-4b45-9975-8a22bd554e09`
   - Local Path: `assets/notifications/delivery.png`
   - Size: 24x24 (within 48x48 container)

3. **Profile Icon**
   - URL: `https://www.figma.com/api/mcp/asset/d13c2977-3b71-44fe-af33-793639b03caf`
   - Local Path: `assets/notifications/profile.png`
   - Size: 24x24 (within 48x48 container)

### Empty State Illustration

- **Empty State Image**
  - URL: `https://www.figma.com/api/mcp/asset/3c1d2529-99ab-4f76-aa06-574a806fe327`
  - Local Path: `assets/notifications/empty_state.png`
  - Size: 160x160

## Download Instructions

### Option 1: Manual Download

1. Open each Figma asset URL in a browser
2. Right-click and "Save Image As"
3. Save to `assets/notifications/` directory
4. Ensure filenames match the paths listed above

### Option 2: Automated Download Script

Create a script `download_module12_assets.sh`:

```bash
#!/bin/bash

# Create assets directory if it doesn't exist
mkdir -p assets/notifications

# Download notification icons
curl -L "https://www.figma.com/api/mcp/asset/dc683897-d7d8-4b6f-a78c-ddcc294d5e43" -o assets/notifications/rent_vehicle.png
curl -L "https://www.figma.com/api/mcp/asset/85ad231e-d41d-4b45-9975-8a22bd554e09" -o assets/notifications/delivery.png
curl -L "https://www.figma.com/api/mcp/asset/d13c2977-3b71-44fe-af33-793639b03caf" -o assets/notifications/profile.png

# Download empty state illustration
curl -L "https://www.figma.com/api/mcp/asset/3c1d2529-99ab-4f76-aa06-574a806fe327" -o assets/notifications/empty_state.png

echo "Module 12 assets downloaded successfully!"
```

**Note:** Figma asset URLs expire after 7 days. If URLs are expired, re-export from Figma using the node IDs listed above.

## Asset Usage in Code

### Notification Icons

Icons are used in `NotificationTile` widget:
- `rent_vehicle.png` - For rental/vehicle-related notifications
- `delivery.png` - For order delivery notifications
- `profile.png` - For profile/account-related notifications

### Empty State Illustration

Used in `NotificationBlank` widget when `notifications.isEmpty`:
- `empty_state.png` - Displayed with "No notifications till now." text

## Fallback Behavior

All assets have error builders that display fallback icons if images are missing:
- Notification icons → `Icons.notifications_outlined`
- Empty state → Circular container with `Icons.notifications_none`

## pubspec.yaml

Assets are already registered in `pubspec.yaml`:
```yaml
assets:
  - assets/notifications/
```

## Next Steps

1. ✅ Download all assets using URLs above
2. ✅ Verify assets are in `assets/notifications/` directory
3. ✅ Test notification screens with real assets
4. ✅ Replace fallback icons once assets are available

