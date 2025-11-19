# Module 5: My Orders - Asset Manifest

## Overview

This document provides a complete mapping of all assets used in Module 5 (My Orders) screens, including their Figma source nodes, local file paths, and usage locations.

## Asset Download Script

**Script**: `scripts/download_module5_assets.ps1`

Run from project root:
```powershell
powershell -ExecutionPolicy Bypass -File scripts/download_module5_assets.ps1
```

## Assets Directory Structure

```
assets/
└── my_orders/
    ├── icon_article.png
    ├── icon_check_circle.png
    ├── product_bose_headphones.png
    ├── product_bose_headphones_variant1.png
    └── product_bose_headphones_variant2.png
```

## Complete Asset Mapping

### Icons

| Figma Node ID | Figma Node Name | Local Asset Path | Used In | Size | Notes |
|---------------|-----------------|------------------|---------|------|-------|
| `1:6360` | `article` | `assets/my_orders/icon_article.png` | My Orders Screen, Order Detail Screen (Invoice button) | 12x12px | Invoice/document icon |
| `68:3792` | `check_circle` | `assets/my_orders/icon_check_circle.png` | Tracking Screen, Order Detail Return Status (completed steps) | 20x20px | Green check circle for completed tracking steps |
| `1:6314` | `arrow-left 1` | `assets/images/icon_back_arrow.png` | All screens (back button) | 16x16px | Back navigation arrow - **Already exists** |
| `68:3847` | `share` | `assets/images/icon_share.png` | Order Detail Screen (share button) | 16x16px | Share icon - **Already exists** |
| `68:3786` | `close_small` | `assets/service_booking/icon_close_small.png` | Tracking Screen (close button) | 20x20px | Close/X icon - **Already exists** |
| `1:6350`, `1:6380`, `1:6418` | `home` | `assets/service_booking/icon_home.png` | My Orders Screen, Order Detail Screen (address icon) | 12x12px | Home address icon - **Already exists** |
| `68:3808`, `68:3816` | `radio_button_unchecked` | `assets/service_booking/icon_radio_unchecked.png` | Tracking Screen, Order Detail Return Status (pending steps) | 20x20px | Orange radio button for pending steps - **Already exists** |
| `68:4053` | `radio_button_checked` | `assets/service_booking/icon_radio_checked.png` | Order Detail Return Flow (selected reason) | 16x16px | Selected radio button - **Already exists** |
| `68:4090` | `chevron_forward` | `assets/service_booking/icon_chevron_forward.png` | Order Detail Return Flow (continue button) | 20x20px | Forward arrow - **Already exists** |

### Product Images

| Figma Node ID | Figma Node Name | Local Asset Path | Used In | Size | Notes |
|---------------|-----------------|------------------|---------|------|-------|
| `68:3852` | `Frame 1171275543` | `assets/my_orders/product_bose_headphones.png` | Order Detail Screen (standard variant) | 52x52px | Bose QuietComfort® 45 Headphones thumbnail |
| `68:4044` | `Frame 1171275543` | `assets/my_orders/product_bose_headphones_variant1.png` | Order Detail Screen (return flow variant) | 52x52px | Same product, different variant |
| `68:4124` | `Frame 1171275543` | `assets/my_orders/product_bose_headphones_variant2.png` | Order Detail Screen (return status variant) | 52x52px | Same product, different variant |

**Note**: All three product images are the same product (Bose QuietComfort® 45 Headphones) but from different Figma frames. The primary image (`product_bose_headphones.png`) is used as the main product thumbnail, with fallback to `assets/images/product_image_9.png` if not found.

### Divider Lines (Optional)

| Figma Node ID | Figma Node Name | Usage | Implementation |
|---------------|-----------------|-------|----------------|
| `1:6343`, `1:6373`, `1:6411` | `Line 933` | Order cards divider | Flutter `Divider` widget |
| `1:6357`, `1:6387`, `1:6425` | `Line 934` | Order cards divider | Flutter `Divider` widget |
| `68:3797`, `68:3805`, `68:3813` | `Line 938` | Tracking timeline divider | Flutter `Divider` widget |
| `68:4132`, `68:4140`, `68:4148` | `Line 943` | Return status divider | Flutter `Divider` widget |

**Note**: Divider lines are implemented using Flutter's `Divider` widget with appropriate styling, so no image assets are needed.

## Asset Usage by Screen

### My Orders Screen (`my_orders_screen.dart`)

**Icons Used**:
- `icon_article.png` - Invoice button (2 instances)
- `icon_home.png` - Address icon (multiple instances)
- `icon_back_arrow.png` - Back button

**Product Images**: None (product names are text-only in order cards)

### Order Detail Screen (`order_detail_screen.dart`)

**Icons Used**:
- `icon_article.png` - Invoice button
- `icon_home.png` - Address icon
- `icon_back_arrow.png` - Back button
- `icon_share.png` - Share button
- `icon_check_circle.png` - Return status completed steps
- `icon_radio_unchecked.png` - Return status pending steps
- `icon_radio_checked.png` - Return flow selected reason
- `icon_chevron_forward.png` - Continue button arrow

**Product Images**:
- `product_bose_headphones.png` - Main product thumbnail (with fallback chain)

### Tracking Screen (`tracking_screen.dart`)

**Icons Used**:
- `icon_check_circle.png` - Completed tracking steps (green)
- `icon_radio_unchecked.png` - Pending tracking steps (orange)
- `icon_close_small.png` - Close button

**Product Images**: None

### Cancellation Confirmation Dialog (`cancellation_confirmation_dialog.dart`)

**Icons Used**: None (text-only dialog)

**Product Images**: None

## Figma MCP Asset URLs

All assets were downloaded from Figma MCP API. URLs expire after 7 days. To regenerate:

1. Run Figma MCP `get_design_context` for each screen
2. Extract image URLs from the response
3. Update `scripts/download_module5_assets.ps1` with new URLs
4. Re-run the download script

### Current Asset URLs (as of implementation date)

- **Article Icon**: `https://www.figma.com/api/mcp/asset/9f7244f7-f776-4606-b4d6-0bdc7800bbb2`
- **Check Circle Icon**: `https://www.figma.com/api/mcp/asset/ad6672a8-a3dc-43bb-a88b-8086b5575929`
- **Product Image (Main)**: `https://www.figma.com/api/mcp/asset/74f67f2a-4ea6-43ea-bb3b-0cd9b18d8f85`
- **Product Image (Variant 1)**: `https://www.figma.com/api/mcp/asset/344179cc-7ddf-44c3-9002-e7f9407f0db7`
- **Product Image (Variant 2)**: `https://www.figma.com/api/mcp/asset/b56aeff4-fa08-42da-b48e-05703e293a0d`

## Asset Fallback Strategy

All image assets in the code include `errorBuilder` callbacks that provide fallbacks:

1. **Primary Asset**: Try loading from `assets/my_orders/`
2. **Fallback Asset**: Try loading from `assets/service_booking/` or `assets/images/`
3. **Material Icon Fallback**: Use Flutter Material Icons if image loading fails

This ensures the app continues to function even if assets are missing or corrupted.

## pubspec.yaml Configuration

The following asset path has been added to `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/my_orders/
```

This allows Flutter to access all assets in the `my_orders` directory.

## Asset Export Checklist

- [x] Article icon (Invoice) - `icon_article.png`
- [x] Check circle icon - `icon_check_circle.png`
- [x] Product image (main) - `product_bose_headphones.png`
- [x] Product image (variant 1) - `product_bose_headphones_variant1.png`
- [x] Product image (variant 2) - `product_bose_headphones_variant2.png`
- [x] Updated `pubspec.yaml` with asset path
- [x] Updated code to use new asset paths
- [x] Verified fallback mechanisms work

## Notes

1. **Shared Assets**: Many icons are shared across modules and already exist in `assets/service_booking/` or `assets/images/`. Only Module 5-specific assets were downloaded to `assets/my_orders/`.

2. **Product Images**: The same product appears in multiple Figma frames with slight variations. All variants were downloaded, but the primary image (`product_bose_headphones.png`) is used in the code with fallback to existing product images.

3. **Icon Sizes**: All icons maintain their original Figma dimensions (12x12px, 16x16px, 20x20px) for pixel-perfect rendering.

4. **Color Tinting**: Some icons (like `icon_check_circle.png`) are tinted with colors in code (green for completed, orange for pending). The base icon is white/transparent.

5. **Asset Organization**: Module 5 assets are organized in their own directory (`assets/my_orders/`) for better maintainability and to avoid conflicts with other modules.

