# Module 6: Service Agent Actions - Asset Manifest

## Overview
This document lists all image assets exported from Figma for Module 6 screens. All assets should be placed in `assets/my_orders/service_actions/` directory.

## Asset List

### 1. Order Detail - Service - Upcoming (node-id: 1-30580)
- **Agent Avatar** (`agent_avatar.png`)
  - Figma node: `1:30673` (animoji instance)
  - Figma URL: `https://www.figma.com/api/mcp/asset/d60924a0-a04b-4006-b7ef-5516743f2f6b`
  - Usage: Service order detail screens (all states), Call screens
  - Size: 40x40px (small), 120x120px (call screen)

### 2. Cancellation Confirmation (node-id: 1-31084)
- **Speech Bubble Icon** (`speech_bubble.png`)
  - Figma node: `1:31087` (speech-bubble 1)
  - Figma URL: `https://www.figma.com/api/mcp/asset/4df7ba79-972a-4344-b383-87e67930bf40`
  - Usage: ServiceCancellationConfirmationDialog
  - Size: 128x128px

### 3. Review - Blank (node-id: 1-31096)
- **Rating Icon** (`rating_icon.png`)
  - Figma node: `1:31099` (rating 1)
  - Figma URL: `https://www.figma.com/api/mcp/asset/81fb439e-6414-4897-ba94-d9778f5c8afc`
  - Usage: ServiceReviewScreen
  - Size: 128x128px

- **Star Empty** (`star_empty.png`)
  - Figma node: `1:31102-1:31106` (star icons)
  - Figma URL: `https://www.figma.com/api/mcp/asset/fa7bb4c5-a505-4ca6-9af7-0711209258ac`
  - Usage: ServiceReviewScreen (unselected stars)
  - Size: 32x32px

- **Star Filled** (`star_filled.png`)
  - Figma node: `1:31105` (selected star)
  - Figma URL: `https://www.figma.com/api/mcp/asset/a271635f-6d1c-4c18-abd7-051927f82dd5`
  - Usage: ServiceReviewScreen (selected stars)
  - Size: 32x32px

### 4. Review - Star & Review Box (node-id: 1-31109)
- **Mic Icon** (`icon_mic.png`)
  - Figma node: `1:31125` (mic)
  - Figma URL: `https://www.figma.com/api/mcp/asset/c5cdddd6-9f1f-4176-8809-93805d9d200c`
  - Usage: ServiceReviewScreen (review text input suffix)
  - Size: 16x16px

### 5. Outgoing Call - Waiting to Pickup (node-id: 1-30911)
- **Volume Up Icon** (`icon_volume_up.png`)
  - Figma node: `1:30940` (volume_up)
  - Figma URL: `https://www.figma.com/api/mcp/asset/a83c3614-a4f5-4ce5-8ed8-d1a566a77873`
  - Usage: ServiceCallScreen (speaker button)
  - Size: 24x24px

- **Call End Icon** (`icon_call_end.png`)
  - Figma node: `1:30944` (call_end)
  - Figma URL: `https://www.figma.com/api/mcp/asset/dfe660c5-c169-41d7-bc63-a92237987e2d`
  - Usage: ServiceCallScreen (end call button)
  - Size: 24x24px

### 6. Outgoing Call - On Call (node-id: 1-31002)
- **Mic Off Icon** (`icon_mic_off.png`)
  - Figma node: `1:31028` (mic_off)
  - Figma URL: `https://www.figma.com/api/mcp/asset/f81cf27b-4cba-4bb1-b66e-7eea58e14ba5`
  - Usage: ServiceCallScreen (mute button when muted)
  - Size: 24x24px

### 7. Incoming Call - Ringing (node-id: 1-30951)
- **Call Icon** (`icon_call.png`)
  - Figma node: `1:30985` (call)
  - Figma URL: `https://www.figma.com/api/mcp/asset/b6f2bbf5-0091-4fb0-b7f4-09f500cb4199`
  - Usage: ServiceCallScreen (accept call button)
  - Size: 24x24px

## Asset Organization

All assets should be organized as follows:

```
assets/
  my_orders/
    service_actions/
      agent_avatar.png
      speech_bubble.png
      rating_icon.png
      star_empty.png
      star_filled.png
      icon_mic.png
      icon_volume_up.png
      icon_call_end.png
      icon_mic_off.png
      icon_call.png
```

## Notes

1. **Agent Avatar**: Used across multiple screens (order detail, call screens). Export at multiple sizes if needed (40x40, 120x120).

2. **Star Icons**: Used in review screen. Ensure proper contrast for selected/unselected states.

3. **Call Icons**: Used in call screen controls. Ensure proper sizing for touch targets (72x72px buttons).

4. **Temporary URLs**: Figma asset URLs are valid for 7 days. Download and save locally before they expire.

## Implementation Status

- [ ] Download all assets from Figma URLs
- [ ] Place assets in `assets/my_orders/service_actions/` directory
- [ ] Update `pubspec.yaml` to include asset paths
- [ ] Verify all assets load correctly in Flutter app
- [ ] Test on both Android and iOS

