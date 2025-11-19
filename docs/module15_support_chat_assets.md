# Module 15: Support Chat Asset Manifest

## Overview

This document lists all image assets required for the Support Chat module. These assets need to be exported from Figma and placed in `assets/support_chat/`.

## Asset List

### Icons

| Asset Name | Figma Node ID | Usage | Expected Path |
|------------|---------------|-------|---------------|
| `icon_add.png` | Multiple frames | Add attachment button in input field | `assets/support_chat/icon_add.png` |
| `icon_more_vert.png` | Multiple frames | Overflow menu button in AppBar | `assets/support_chat/icon_more_vert.png` |
| `icon_check_done_all.png` | 1:29835, 1:29948, etc. | Message delivered/read status icon | `assets/support_chat/icon_check_done_all.png` |
| `icon_check.png` | 1:29783 | Message sent status icon | `assets/support_chat/icon_check.png` |
| `icon_mic.png` | 1:30442 | Voice input button in feedback sheet | `assets/support_chat/icon_mic.png` |
| `icon_check_circle.png` | 1:30222, 1:30198 | Mark as resolved icon | `assets/support_chat/icon_check_circle.png` |
| `icon_stat_2.png` | 1:30203 | Escalate icon | `assets/support_chat/icon_stat_2.png` |
| `icon_flag.png` | 1:30208, 1:30236 | Report icon | `assets/support_chat/icon_flag.png` |
| `icon_download.png` | 1:30243 | Download chat icon | `assets/support_chat/icon_download.png` |
| `icon_keyboard_double_arrow_up.png` | 1:30229 | Escalate icon (alternative) | `assets/support_chat/icon_keyboard_double_arrow_up.png` |

### Product Images

| Asset Name | Figma Node ID | Usage | Expected Path |
|------------|---------------|-------|---------------|
| `product_bose_headphones.png` | 1:29585, 1:29679, etc. | Product thumbnail in headers | `assets/support_chat/product_bose_headphones.png` |

**Note**: This image is already available at `assets/my_orders/product_bose_headphones.png` and is reused.

### Status Bar Icons

These are already available in the project:
- `icon_bar_chart.png` - Status bar signal icon
- `icon_wifi.png` - Status bar WiFi icon  
- `icon_battery_charging.png` - Status bar battery icon

### Navigation Icons

These are already available in the project:
- `icon_back_arrow.png` - Back button (from `assets/images/`)
- `icon_share.png` - Share button (from `assets/images/`)

## Export Instructions

### From Figma MCP

For each asset listed above:

1. Identify the node ID from the Figma frame
2. Use `get_design_context` to get the image URL
3. Download the image using the provided URL
4. Save to the appropriate path in `assets/support_chat/`

### Export Settings

- **Format**: PNG
- **Scale**: 2x (for @2x) and 3x (for @3x) if needed
- **Background**: Transparent (for icons)
- **Size**: Match the design specifications

### Example Export Command

```bash
# Create directory structure
mkdir -p assets/support_chat

# Download images (example - replace URLs with actual Figma MCP URLs)
# curl -o assets/support_chat/icon_add.png "https://www.figma.com/api/mcp/asset/..."
```

## Current Status

All image references in the code include `errorBuilder` callbacks that provide fallback icons from Material Icons. This ensures the app will function even if assets are missing, but visual fidelity will be reduced.

## Asset Usage by Screen

### Support Initial Screen
- Product image (reused from my_orders)
- Back arrow icon (reused from images)

### Support Chat Screen
- Product image (reused from my_orders)
- Back arrow icon (reused from images)
- More vert icon (`icon_more_vert.png`)
- Add icon (`icon_add.png`)
- Check/done_all icons (`icon_check_done_all.png`)

### Overflow Menu
- Check circle icon (`icon_check_circle.png`)
- Keyboard double arrow up icon (`icon_keyboard_double_arrow_up.png`)
- Flag icon (`icon_flag.png`)
- Download icon (`icon_download.png`)

### Feedback Sheet
- Star icons (using Material Icons - no export needed)
- Mic icon (`icon_mic.png`)

### Suggested Actions Row
- Check circle icon (`icon_check_circle.png`)
- Stat 2 icon (`icon_stat_2.png`)
- Flag icon (`icon_flag.png`)

## Notes

1. **Reused Assets**: Some assets (like product images and navigation icons) are reused from other modules to maintain consistency.

2. **Material Icons Fallback**: All icon references have Material Icons fallbacks, so the app will function without these assets, but design fidelity will be reduced.

3. **Image Sizes**: 
   - Icons: 16x16px (base), 32x32px (2x), 48x48px (3x)
   - Product images: 52x52px (base)

4. **Priority**: 
   - High: `icon_add.png`, `icon_more_vert.png`, `icon_check_done_all.png`
   - Medium: `icon_mic.png`, `icon_check_circle.png`, `icon_flag.png`
   - Low: `icon_stat_2.png`, `icon_download.png`, `icon_keyboard_double_arrow_up.png`

