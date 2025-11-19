# Module 9: Track Order & Invoice - Asset Manifest

## Overview

This document lists all image assets required for Module 9: Track Order & Invoice implementation.

## Asset Directory Structure

All Module 9 assets are stored in: `assets/orders/track_invoice/`

## Required Assets

### Icons

| Asset Name | Figma Node ID | Local Path | Used In | Status |
|------------|---------------|------------|---------|--------|
| `icon_check_circle.png` | 1:6723, 1:6731 | `assets/orders/track_invoice/icon_check_circle.png` | TrackingScreen (completed steps) | ⚠️ Needs export |
| `icon_radio_unchecked.png` | 1:6739, 1:6747 | `assets/orders/track_invoice/icon_radio_unchecked.png` | TrackingScreen (pending steps) | ⚠️ Needs export |
| `icon_close_small.png` | 1:6717 | `assets/orders/track_invoice/icon_close_small.png` | TrackingScreen (header close button) | ⚠️ Needs export |
| `icon_article.png` | 1:6820, 1:6850, 1:6888, 1:6980 | `assets/orders/track_invoice/icon_article.png` | MyOrdersScreen, OrderDetailScreen, InvoiceScreen (Invoice button) | ⚠️ Needs export |
| `icon_home.png` | 1:6810, 1:6840, 1:6878, 1:6943 | `assets/orders/track_invoice/icon_home.png` | MyOrdersScreen, OrderDetailScreen (address icon) | ⚠️ Needs export |

### Product Images

| Asset Name | Figma Node ID | Local Path | Used In | Status |
|------------|---------------|------------|---------|--------|
| `product_bose_headphones.png` | 1:6926 | `assets/orders/track_invoice/product_bose_headphones.png` | OrderDetailScreen (product thumbnail) | ⚠️ Needs export |
| `product_bose_headphones_invoice.png` | 1:7024 | `assets/orders/track_invoice/product_bose_headphones_invoice.png` | InvoiceScreen (product thumbnail) | ⚠️ Needs export |

## Figma Asset URLs (Temporary - 7 days)

The following URLs were extracted from Figma MCP `get_design_context` calls. These are temporary and expire after 7 days. **These assets must be downloaded and saved to the local paths above.**

### Frame 1: My Orders - Active (node-id: 1-6752)
- `icon_article`: https://www.figma.com/api/mcp/asset/5a1eb652-c670-4772-8631-0b29ffc569ea
- `icon_home`: https://www.figma.com/api/mcp/asset/6079063e-2d27-49e7-ab36-d24c7ed33988

### Frame 2: Order Detail - Product - Active (node-id: 1-6895)
- `product_bose_headphones`: https://www.figma.com/api/mcp/asset/79967cbb-5052-4e09-9bc4-6f15258df414
- `icon_article`: https://www.figma.com/api/mcp/asset/d2fb6e13-5599-421a-9aa6-637f8c35d69e
- `icon_home`: https://www.figma.com/api/mcp/asset/4f77ee61-10dc-4c90-b3bc-4cdce0859cb2

### Frame 3: Tracking (node-id: 1-6714)
- `icon_close_small`: https://www.figma.com/api/mcp/asset/430362ee-b878-46b5-bccf-978540d8feb9
- `icon_check_circle`: https://www.figma.com/api/mcp/asset/0debb2d8-fef1-4061-a32f-58e479ed8c78
- `icon_radio_unchecked`: https://www.figma.com/api/mcp/asset/d0197aa9-e3a0-4488-b911-bb95e730f5a9

### Frame 4: Order Detail - Product - Active (Invoice variant) (node-id: 1-6993)
- `product_bose_headphones_invoice`: https://www.figma.com/api/mcp/asset/b9e9091a-b0e7-4a69-9833-2af024f23e39

## Fallback Assets

The implementation includes fallback logic to use existing assets if Module 9 assets are not yet exported:

- `icon_check_circle` → Falls back to `assets/my_orders/icon_check_circle.png`
- `icon_radio_unchecked` → Falls back to `assets/service_booking/icon_radio_unchecked.png`
- `icon_article` → Falls back to `assets/my_orders/icon_article.png`
- `icon_close_small` → Falls back to `assets/service_booking/icon_close_small.png`
- `product_bose_headphones` → Falls back to `assets/my_orders/product_bose_headphones.png`
- `product_bose_headphones_invoice` → Falls back to `assets/my_orders/product_bose_headphones.png`

## Export Instructions

1. Open Figma file: https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-
2. For each asset listed above:
   - Select the node by ID (or find it visually)
   - Right-click → Export → PNG (or SVG if appropriate)
   - Save to the corresponding local path in `assets/orders/track_invoice/`
3. Ensure all assets are added to `pubspec.yaml` under `assets/orders/track_invoice/`

## Notes

- All icons should be exported at 1x, 2x, and 3x resolutions for proper display on different screen densities
- Product images should be exported at appropriate sizes (52x52dp for thumbnails)
- The code includes error builders to gracefully handle missing assets during development

