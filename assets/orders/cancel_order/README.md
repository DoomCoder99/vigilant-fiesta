# Cancel Order Assets

This directory contains assets for the Cancel Order flow (Module 8).

## Required Assets

The following assets need to be exported from Figma and placed in this directory:

### 1. icon_remove.png
- **Size**: 128x128px
- **Figma Node**: "remove 1" (node-id: 1-7046)
- **Used in**: `ProductCancellationConfirmationScreen`
- **Description**: Shopping cart icon with remove/cancel overlay

### 2. icon_mic.png
- **Size**: 16x16px
- **Figma Node**: "mic" (node-id: 1-7494)
- **Used in**: `CancelOrderScreen` comments field
- **Description**: Microphone icon for voice input

## Export Instructions

1. Open Figma file: `xu7kp6yBV1qiPwK77Hq7tl`
2. Select the node by ID:
   - For icon_remove.png: Select node `1:7046`
   - For icon_mic.png: Select node `1:7494`
3. Export as PNG:
   - Right-click → Export → PNG
   - Use the sizes specified above
   - Save to this directory

## Fallback Behavior

Both screens have error builders that will show Material Icons if the assets are missing:
- `icon_remove.png` → Falls back to `Icons.remove_shopping_cart`
- `icon_mic.png` → Falls back to `Icons.mic`

This ensures the app continues to function even if assets are not yet exported.

