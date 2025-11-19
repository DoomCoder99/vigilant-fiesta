# Missing Assets for Module 2 (Shop)

This document lists all image assets that need to be exported from Figma and added to the project for Module 2 (Shop) screens.

## Asset Export Instructions

1. Export assets from Figma at **2x** and **3x** resolutions for iOS (@2x, @3x)
2. Export assets as **PNG** format
3. Place all assets in `assets/images/` directory
4. Update `pubspec.yaml` to include new asset paths (if needed - currently uses wildcard `assets/images/`)

## Navigation & UI Icons

### Bottom Navigation Bar Icons
- [ ] `icon_home.png` - Home icon (active/inactive states)
- [ ] `icon_shop.png` - Shop icon (active/inactive states)  
- [ ] `icon_orders.png` - Orders icon (active/inactive states)
- [ ] `icon_cart.png` - Cart icon (active/inactive states)

**Figma Reference**: Bottom navigation bar in Shop landing screens
**Current Status**: Using Material Icons (`Icons.home`, `Icons.shopping_bag`, etc.)
**Priority**: High

### App Bar Icons
- [ ] `icon_back_arrow.png` - Back arrow icon (16x16px)
- [ ] `icon_apps.png` - Apps/menu icon for category listing (16x16px)
- [ ] `icon_search.png` - Search icon (16x16px)
- [ ] `icon_favorite.png` - Favorite/heart icon (16x16px)
- [ ] `icon_share.png` - Share icon (16x16px)
- [ ] `icon_mic.png` - Microphone icon for input fields (16x16px)

**Figma Reference**: Various app bars across Shop screens
**Current Status**: Using Material Icons
**Priority**: Medium

## Category & Product Icons

### Category Icons (64x64px circles)
- [ ] `category_personal_care.png`
- [ ] `category_electronic_devices.png`
- [ ] `category_home_appliances.png`
- [ ] `category_clothing.png`
- [ ] `category_mobiles_computers.png`
- [ ] `category_sports_games.png`
- [ ] `category_beauty_grooming.png`
- [ ] `category_cleaning_products.png`
- [ ] `category_bath_hygiene.png`

**Figma Reference**: Shop landing screen, Category listing screen
**Current Status**: Using Material Icons with colored backgrounds
**Priority**: Medium

### Service Icons (64x64px circles)
- [ ] `service_home_maintenance.png`
- [ ] `service_cleaning_pest.png`
- [ ] `service_sports_fitness.png`
- [ ] `service_rent_vehicle.png`
- [ ] `service_driving_instructor.png`
- [ ] `service_women_salon.png`
- [ ] `service_gas_cylinder.png`
- [ ] `service_painting.png`

**Figma Reference**: Amozit Landing Confirmed screen - Quick Services section
**Current Status**: Using Material Icons with colored backgrounds
**Priority**: Medium

## Product Images

### Product Thumbnails (Placeholders)
- [ ] `product_placeholder_1.png` - Generic product placeholder (92x92px or 120x120px)
- [ ] `product_placeholder_2.png`
- [ ] `product_placeholder_3.png`
- [ ] `product_bose_headphones.png` - Bose QuietComfort 45 Headphones (if available)

**Figma Reference**: Category listing, Product detail screens
**Current Status**: Using `Icons.image` placeholder
**Priority**: High

### Product Detail Images
- [ ] `product_detail_carousel_1.png` - Product detail carousel image 1
- [ ] `product_detail_carousel_2.png` - Product detail carousel image 2
- [ ] `product_detail_carousel_3.png` - Product detail carousel image 3

**Figma Reference**: Product detail screen
**Current Status**: Using placeholder colors
**Priority**: High

## Promotional & Banner Images

### Promotional Banners
- [ ] `banner_car_care.png` - Premium car care banner (full width)
- [ ] `banner_music_speaker.png` - Bluetooth speaker banner (full width)
- [ ] `banner_sibert.png` - SIBERT consultation banner (146x140px)
- [ ] `banner_refresh.png` - REFRSH cleaning services banner (full width)
- [ ] `banner_bose.png` - BOSE music banner (221x188px)

**Figma Reference**: Amozit Landing Confirmed screen, Shop landing screen
**Current Status**: Using colored containers with placeholder icons
**Priority**: Medium

## Cart & Payment Icons

### Cart & Checkout
- [ ] `icon_cart_badge.png` - Cart badge/indicator (16x16px)
- [ ] `icon_chevron_forward.png` - Chevron forward icon (20x20px)
- [ ] `icon_radio_checked.png` - Radio button checked (16x16px)
- [ ] `icon_radio_unchecked.png` - Radio button unchecked (16x16px)
- [ ] `icon_home_address.png` - Home address icon (12x12px)
- [ ] `icon_work_address.png` - Work address icon (12x12px)
- [ ] `icon_add.png` - Add icon (16x16px)

**Figma Reference**: Cart screen, Payment method screen
**Current Status**: Using Material Icons
**Priority**: Medium

### Payment Method Icons
- [ ] `icon_mastercard.png` - Mastercard logo
- [ ] `icon_visa.png` - Visa logo (if used)
- [ ] `icon_amazon_pay.png` - Amazon Pay logo
- [ ] `icon_credit_card.png` - Generic credit card icon
- [ ] `icon_wallet.png` - Wallet icon
- [ ] `icon_bank.png` - Bank icon
- [ ] `icon_cash.png` - Cash icon

**Figma Reference**: Payment method screen
**Current Status**: Using Material Icons
**Priority**: Medium

## Order & Tracking Icons

### Order Status Icons
- [ ] `icon_order_active.png` - Active order status icon
- [ ] `icon_order_delivered.png` - Delivered order status icon
- [ ] `icon_order_cancelled.png` - Cancelled order status icon
- [ ] `icon_tracking.png` - Tracking icon
- [ ] `icon_location_pin.png` - Location pin icon

**Figma Reference**: My Orders screen, Order detail screen, Tracking screen
**Current Status**: Using Material Icons
**Priority**: Medium

### Tracking Progress Icons
- [ ] `icon_tracking_step_completed.png` - Completed tracking step
- [ ] `icon_tracking_step_active.png` - Active tracking step
- [ ] `icon_tracking_step_pending.png` - Pending tracking step

**Figma Reference**: Tracking screen
**Current Status**: Using Material Icons
**Priority**: Low

## Success & Status Icons

### Payment Success
- [ ] `illustration_payment_success.png` - Payment success robot illustration (200x200px)
- [ ] `icon_check_success.png` - Success checkmark icon (60x60px)

**Figma Reference**: Payment success screen
**Current Status**: Using Material Icons (`Icons.smart_toy`, `Icons.check`)
**Priority**: High

## Social Login Icons

### Social Login Buttons
- [ ] `icon_google.png` - Google logo (20x20px)
- [ ] `icon_apple.png` - Apple logo (20x20px)

**Figma Reference**: Registration screen, Sign In screen
**Current Status**: Using Material Icons (`Icons.search` for Google, `Icons.apple` for Apple)
**Priority**: Medium

## Status Bar Icons (Already Present)

These are already in `assets/images/`:
- ✅ `status_bar_chart.png`
- ✅ `status_wifi.png`
- ✅ `status_battery.png`

## Implementation Notes

1. **Icon Sizes**: Most icons should be exported at multiple resolutions:
   - 1x: Base size (e.g., 16x16px)
   - 2x: 32x32px for high-density displays
   - 3x: 48x48px for very high-density displays

2. **Naming Convention**: Use lowercase with underscores (e.g., `icon_home.png`)

3. **Format**: PNG with transparency for icons, PNG/JPG for product images

4. **Replacement Strategy**: 
   - Replace Material Icons gradually
   - Keep Material Icons as fallback
   - Use `Image.asset()` with proper asset paths

5. **Asset Paths**: All assets should be referenced as:
   ```dart
   Image.asset('assets/images/icon_home.png')
   ```

## Priority Summary

- **High Priority**: Product images, Payment success illustration, Bottom navigation icons
- **Medium Priority**: Category icons, Service icons, Payment method icons, Cart icons
- **Low Priority**: Tracking step icons, Social login icons (if Material Icons are acceptable)

## Next Steps

1. Export assets from Figma at required resolutions
2. Add assets to `assets/images/` directory
3. Update Flutter code to use `Image.asset()` instead of Material Icons
4. Test on different screen densities
5. Update this document as assets are added

