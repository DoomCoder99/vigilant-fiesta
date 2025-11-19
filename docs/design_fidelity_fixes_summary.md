# Design Fidelity Fixes Summary

## Overview

This document tracks the systematic fixes applied to bring Module 1 (Onboarding) and Module 2 (Shop) screens to pixel-accurate design fidelity with Figma designs.

## Completed Fixes

### 1. Bottom Navigation Bar (Module 2)

**Status**: ✅ **FIXED**

**Changes Made**:
- Created shared `AppBottomNavigationBar` widget (`lib/core/widgets/bottom_navigation_bar.dart`)
- Matches Figma specs exactly:
  - Container: 280px width, 30px border radius, 24px bottom margin
  - Background: #7132f4 (primary color)
  - Padding: 8px left, 20px right, 8px vertical
  - Active item: White background, 24px border radius, 20px horizontal padding, 12px vertical padding
  - Icons: 20px size
  - Text: 12px, SemiBold (#162028), 0.24px letter spacing
  - Gap between items: 4px

**Files Modified**:
- ✅ `lib/core/widgets/bottom_navigation_bar.dart` (NEW)
- ✅ `lib/modules/shop/view/amozit_landing_confirmed_screen.dart`
- ✅ `lib/modules/shop/view/shop_landing_screen.dart`

**Note**: `product_detail_screen.dart` and `cart_screen.dart` use action buttons in their bottom bars (not navigation), so they don't need the navigation bar widget.

## Remaining Fixes Required

### 2. Typography & Text Alignment (Modules 1 & 2)

**Status**: ⚠️ **PENDING**

**Issues Identified**:
- Text styles may not match Figma exactly (font sizes, weights, line heights, letter spacing)
- Text alignment may be incorrect (left/center/right)
- Missing text styles for specific use cases

**Action Required**:
1. For each screen, compare text styles with Figma `get_variable_defs` output
2. Update `AppTextStyles` to include all required text styles
3. Replace inline `TextStyle` definitions with design system tokens
4. Fix text alignment to match Figma auto-layout

**Screens Affected**:
- **Module 1**: All onboarding screens (Splash, Walkthrough, Location Access, Register, OTP, Create Password, Sign In, Forgot Password)
- **Module 2**: All Shop screens (Amozit Landing Confirmed, Shop Landing, Category Listing, Product Detail, Cart, Payment, Orders, Tracking, etc.)

### 3. Button Sizes & States (Modules 1 & 2)

**Status**: ⚠️ **PENDING**

**Issues Identified**:
- Button heights/widths may not match Figma
- Padding values may be incorrect
- Border radius may not match design
- Button text styles may not match

**Action Required**:
1. Extract button specs from Figma for each screen
2. Update button widgets to match exact dimensions
3. Ensure button states (default, disabled, pressed) match Figma variants
4. Use design system tokens for button styles

**Screens Affected**:
- **Module 1**: All screens with buttons (Explore, Register, Sign In, etc.)
- **Module 2**: All screens with buttons (Add to Cart, Checkout, Pay Now, etc.)

### 4. Missing Image Assets (Module 2)

**Status**: ⚠️ **PENDING**

**Issues Identified**:
- Product thumbnails are placeholders
- Category icons are using Material icons instead of Figma assets
- Status icons (cart, payment, tracking) are using Material icons
- Illustrations (empty states, success screens) are missing

**Action Required**:
1. Export all required images from Figma
2. Add images to `assets/images/` directory
3. Update `pubspec.yaml` to declare assets
4. Replace placeholder icons with actual asset images
5. Add TODOs for assets that cannot be programmatically generated

**Assets Needed** (from Figma design context):
- Navigation icons: `home-smile-angle-svgrepo-com`, `bag-3-svgrepo-com`, `clipboard-check-svgrepo-com`, `shopping-cart`
- Status bar icons: `bar-chart`, `wifi`, `battery-charging`
- Location icons: `location_on`, `keyboard_arrow_down`
- Search icon: `search`
- Product images: Multiple product thumbnails
- Category icons: Various category icons
- Service icons: Various service icons
- Promotional banners: Banner images
- Success/error illustrations: Payment success, tracking, etc.

**Files Affected**:
- All Module 2 screens that display images/icons

### 5. Layout & Spacing (Modules 1 & 2)

**Status**: ⚠️ **PENDING**

**Issues Identified**:
- Padding/margin values may not match Figma (±2dp tolerance)
- Spacing between elements may be incorrect
- Layout alignment may not match Figma auto-layout

**Action Required**:
1. Extract spacing values from Figma `get_design_context`
2. Replace magic numbers with design system spacing constants
3. Ensure padding/margins match Figma within ±2dp
4. Fix alignment to match Figma auto-layout (MainAxisAlignment, CrossAxisAlignment)

**Screens Affected**:
- All screens in Module 1 and Module 2

## Systematic Fix Approach

### Phase 1: Design System Audit ✅
- [x] Review existing design system tokens
- [x] Identify gaps in design system
- [x] Create shared components (bottom navigation bar)

### Phase 2: Typography Fixes ⚠️
- [ ] Audit all text styles against Figma
- [ ] Add missing text styles to `AppTextStyles`
- [ ] Replace inline styles with design tokens
- [ ] Fix text alignment

### Phase 3: Button Fixes ⚠️
- [ ] Extract button specs from Figma
- [ ] Update button widgets to match specs
- [ ] Ensure button states match design

### Phase 4: Asset Management ⚠️
- [ ] Export images from Figma
- [ ] Add assets to project
- [ ] Update `pubspec.yaml`
- [ ] Replace placeholders with assets
- [ ] Add TODOs for missing assets

### Phase 5: Layout & Spacing ⚠️
- [ ] Fix padding/margins
- [ ] Fix alignment
- [ ] Replace magic numbers with constants

### Phase 6: Quality Check ⚠️
- [ ] Visual comparison with Figma screenshots
- [ ] Runtime asset check
- [ ] Navigation flow verification
- [ ] Linter/analyzer check

## Files Modified (So Far)

### Module 1 (Onboarding)
- None yet (pending typography and button fixes)

### Module 2 (Shop)
- ✅ `lib/core/widgets/bottom_navigation_bar.dart` (NEW)
- ✅ `lib/modules/shop/view/amozit_landing_confirmed_screen.dart`
- ✅ `lib/modules/shop/view/shop_landing_screen.dart`

## Next Steps

1. **Typography Fixes**: Start with Module 1 screens, then Module 2
2. **Button Fixes**: Extract specs from Figma and update systematically
3. **Asset Management**: Export and add images, update code references
4. **Layout Fixes**: Fix spacing and alignment issues
5. **Final Quality Check**: Verify all fixes against Figma designs

## Notes

- All navigation logic remains intact - only visual fixes are being applied
- Design system tokens are the single source of truth
- Figma MCP tools (`get_design_context`, `get_variable_defs`) should be used for each screen
- Tolerance: ±2dp for spacing/dimensions
- Assets should be exported from Figma and added to the project manually

