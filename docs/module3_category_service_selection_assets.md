# Module 3: Category & Service Selection - Asset List

## Overview

This document lists all image assets identified from Figma for the **Category and Service Selection** portion of Module 3.

## Asset Export Status

**Status**: ⚠️ Assets need to be exported from Figma MCP URLs (valid for 7 days)

**Storage Location**: `assets/service_booking/`

**Export Script**: Use `scripts/module3_asset_urls.json` with `scripts/download_assets.py` or `scripts/download_assets.ps1`

---

## Assets by Screen

### 1. Home Maintenance Categories (1-8459)

**Screen Type**: Modal Bottom Sheet

| Asset Name | Figma Node | Asset URL | Local Path | Usage |
|------------|------------|-----------|------------|-------|
| `category_electrical.png` | 1-8468 | `https://www.figma.com/api/mcp/asset/0b2a347e-20d7-412b-bb63-af6321a4ca16` | `assets/service_booking/category_electrical.png` | Electrical category icon |
| `category_plumbing.png` | 1-8471 | `https://www.figma.com/api/mcp/asset/410de3dc-622e-42fa-81e1-1f39efc78d35` | `assets/service_booking/category_plumbing.png` | Plumbing category icon |
| `category_carpentry.png` | 1-8474 | `https://www.figma.com/api/mcp/asset/fe6445a4-8695-418b-a6d0-b2a210b140eb` | `assets/service_booking/category_carpentry.png` | Carpentry category icon |
| `category_light_fan.png` | 1-8477 | `https://www.figma.com/api/mcp/asset/721d071a-1ca8-46f7-a399-1e9e387e44e9` | `assets/service_booking/category_light_fan.png` | Light & Fan category icon |
| `icon_close_small.png` | 1-8462 | `https://www.figma.com/api/mcp/asset/509e3393-cc22-49d3-8a4e-6521f503a0bf` | `assets/service_booking/icon_close_small.png` | Close button icon |

---

### 2. Home Services - Electrical (1-8479, 1-8716)

**Screen Type**: Full Screen (with expanded/collapsed states)

| Asset Name | Figma Node | Asset URL | Local Path | Usage |
|------------|------------|-----------|------------|-------|
| `service_switch_sockets.png` | 1-8550 | `https://www.figma.com/api/mcp/asset/ff2fbefa-3fef-4ff1-8d81-074e19f0891f` | `assets/service_booking/service_switch_sockets.png` | Switch & Sockets service icon |
| `service_doorbell_security.png` | 1-8553 | `https://www.figma.com/api/mcp/asset/6bf88acb-74c3-4def-8222-62947d3272fb` | `assets/service_booking/service_doorbell_security.png` | Doorbell & Security service icon |
| `service_wiring.png` | 1-8556 | `https://www.figma.com/api/mcp/asset/da19eb67-7c76-4bc6-a4dc-e1114d41f731` | `assets/service_booking/service_wiring.png` | Wiring service icon |
| `service_light_fan.png` | 1-8559 | `https://www.figma.com/api/mcp/asset/9078e801-f12d-4d64-97a9-53cc57f6703d` | `assets/service_booking/service_light_fan.png` | Light & Fan service icon |
| `service_mcb_fuse.png` | 1-8563 | `https://www.figma.com/api/mcp/asset/110a85ec-490a-43c7-9b44-25012658061f` | `assets/service_booking/service_mcb_fuse.png` | MCB / Fuse service icon |
| `service_appliance_installation.png` | 1-8566 | `https://www.figma.com/api/mcp/asset/830d5e3d-f6ec-4cb5-8959-03dfbb8478af` | `assets/service_booking/service_appliance_installation.png` | Appliance Installation service icon |
| `service_other_consultation.png` | 1-8569 | `https://www.figma.com/api/mcp/asset/678aa58f-cb16-4148-89d4-81f25ab7660f` | `assets/service_booking/service_other_consultation.png` | Other Consultation service icon |
| `banner_electrical_services.png` | 1-8688 | `https://www.figma.com/api/mcp/asset/f7405eb5-53e0-472b-b21d-00bfffe15bf7` | `assets/service_booking/banner_electrical_services.png` | Banner image |
| `icon_menu.png` | 1-8708 | `https://www.figma.com/api/mcp/asset/bc7fb617-1071-4556-967d-9311c9891278` | `assets/service_booking/icon_menu.png` | Menu button icon |
| `icon_arrow_up.png` | Multiple | `https://www.figma.com/api/mcp/asset/518e6260-8372-4615-8591-465dfa0dc855` | `assets/service_booking/icon_arrow_up.png` | Expand/collapse arrow icon |
| `icon_filter.png` | 1-8531 | `https://www.figma.com/api/mcp/asset/3b17bf0e-b48e-455b-9d2f-bed7c94c9d5c` | `assets/service_booking/icon_filter.png` | Filter/tune icon |
| `decoration_ellipse_1.png` | 1-8685 | `https://www.figma.com/api/mcp/asset/11668ee4-707f-4a5e-bdba-95bef08da7f0` | `assets/service_booking/decoration_ellipse_1.png` | Decorative element |
| `decoration_ellipse_2.png` | 1-8686 | `https://www.figma.com/api/mcp/asset/58bc24fc-5e1c-4f36-b96b-a1faac8145c2` | `assets/service_booking/decoration_ellipse_2.png` | Decorative element |

---

### 3. Quick Menu - Electrical Services (1-10299)

**Screen Type**: Modal Bottom Sheet

| Asset Name | Figma Node | Asset URL | Local Path | Usage |
|------------|------------|-----------|------------|-------|
| `icon_close_small.png` | Multiple | Reuse from Home Maintenance Categories | `assets/service_booking/icon_close_small.png` | Close button icon |

**Note**: Quick Menu uses the same close icon as Home Maintenance Categories.

---

## Shared Assets (Reused from Module 2)

The following assets are already exported in Module 2 and can be reused:

- `icon_back_arrow.png` - Back arrow icon (`assets/images/icon_back_arrow.png`)
- `star_1.png` - Star rating icon (`assets/images/star_1.png`)
- Status bar icons (bar-chart, wifi, battery-charging) - Already in `assets/images/`

---

## Asset Export Instructions

1. **Update Download Script**: Copy `scripts/module3_asset_urls.json` to the scripts directory (or update existing `figma_asset_urls.json`)

2. **Run Download Script**:
   ```powershell
   # PowerShell (Windows)
   cd scripts
   .\download_assets.ps1
   
   # Or Python
   python scripts/download_assets.py
   ```

3. **Verify Assets**: Check that all assets are in `assets/service_booking/`

4. **Update AssetHelper**: Asset paths are already defined in `lib/core/utils/asset_helper.dart` under `AssetPaths` class

---

## Asset Count Summary

- **Total Unique Assets**: 15 assets
- **Category Icons**: 4 (Electrical, Plumbing, Carpentry, Light & Fan)
- **Service Icons**: 7 (Switch & Sockets, Doorbell, Wiring, etc.)
- **UI Icons**: 4 (close, arrow up, menu, filter)
- **Banner Images**: 1 (Electrical services banner)
- **Decorative Elements**: 2 (ellipses)

---

## Current Implementation Status

### Assets Currently Using Fallbacks

The following assets are currently using Material Icons as fallbacks until exported:

1. **Category Icons**: Using Material Icons (`Icons.electrical_services`, `Icons.plumbing`, etc.)
2. **Service Icons**: Using Material Icons (`Icons.power`, `Icons.doorbell`, etc.)
3. **UI Icons**: 
   - Close button: Using `Icons.close` (fallback)
   - Arrow up: Using `Icons.keyboard_arrow_up` (fallback)
   - Menu: Using `Icons.list` (fallback)
   - Filter: Using `Icons.tune` (fallback)
4. **Banner**: Using colored container placeholder

### After Asset Export

Once assets are exported, update the screens to use `AssetHelper.loadImageOrIcon()` with the proper asset paths:

```dart
// Example: Replace Material Icon with asset
AssetHelper.loadImageOrIcon(
  assetPath: assets.AssetPaths.categoryElectrical,
  fallbackIcon: Icons.electrical_services,
  size: 32,
  color: AppColors.primary,
)
```

---

## Notes

1. **Asset URLs Expiry**: All Figma MCP asset URLs expire after 7 days. Export assets promptly or regenerate URLs before expiry.

2. **Fallback Strategy**: All screens use `AssetHelper.loadImageOrIcon()` which provides Material Icon fallbacks, ensuring the app remains functional even without exported assets.

3. **Asset Naming**: Use descriptive names that match the service/category names for easier maintenance.

4. **Icon Consistency**: Some icons (back arrow, star) are reused from Module 2. Check `assets/images/` first before exporting duplicates.

