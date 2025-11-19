# Module 16: Subscription Asset Manifest

## Overview

This document maps Figma node IDs to local asset paths for Module 16 (Subscription – From Category).

## Asset Organization

All subscription assets are organized under `assets/subscriptions/`:
- `assets/subscriptions/sports/` - Sports & Fitness category icons and images
- `assets/subscriptions/turf/` - Turf/venue-specific images
- `assets/subscriptions/salon/` - Salon category assets (future)
- `assets/subscriptions/icons/` - Common icons used across subscription screens

## Figma Frame → Asset Mapping

### Frame 1: Select slot drawer – explore (node-id: 1-16608)

**Icons:**
- `close_small` (1:16611) → `assets/subscriptions/icons/close_small.png`
- `bolt` (1:16617) → `assets/subscriptions/icons/bolt.png`
- `calendar_clock` (1:16628) → `assets/subscriptions/icons/calendar_clock.png`
- `radio_button_checked` (1:16623) → `assets/subscriptions/icons/radio_button_checked.png`
- `radio_button_unchecked` (1:16634) → `assets/subscriptions/icons/radio_button_unchecked.png`

### Frame 2: Sports & fitness (node-id: 1-15889)

**Category Icons:**
- `image 9` (Tennis courts) (1:15935) → `assets/subscriptions/sports/tennis_icon.png`
- `image 9` (Football courts) (1:15938) → `assets/subscriptions/sports/football_icon.png`
- `image 9` (Cricket courts) (1:15941) → `assets/subscriptions/sports/cricket_icon.png`
- `image 9` (Badminton courts) (1:15944) → `assets/subscriptions/sports/badminton_icon.png`
- `image 9` (Golf courses) (1:15948) → `assets/subscriptions/sports/golf_icon.png`
- `image 9` (Basketball courts) (1:15951) → `assets/subscriptions/sports/basketball_icon.png`
- `image 9` (Volleyball courts) (1:15954) → `assets/subscriptions/sports/volleyball_icon.png`

**Promotional Banner:**
- `—Pngtree—soccer ball bola_14541664 1` (1:16091) → `assets/subscriptions/turf/promotional_banner.png`
- `Rectangle 3` (banner background) (1:16077) → Included in promotional_banner.png

**Icons:**
- `sheild 1` / `Layer 1` (1:15927, 1:15928) → `assets/subscriptions/sports/shield_verified.png`
- `Star 1` (1:15924) → Use Material Icons star (already available)
- `arrow-left 1` (1:15911) → Use Material Icons arrow_back (already available)
- `discover_tune` (1:15916) → Use Material Icons tune (already available)
- `list 1` (1:16098) → Use Material Icons list (already available)

**Status Bar Icons:**
- `bar-chart` (1:15896) → Use Material Icons (already available)
- `wifi` (1:15900) → Use Material Icons (already available)
- `battery-charging` (1:15905) → Use Material Icons (already available)

### Frame 3-5: Turf detail variants (node-id: 1-16106, 1-16341, 1-16472)

**Venue Images:**
- Hero images for venues → `assets/subscriptions/turf/wimbledon_hero.png`
- Additional venue images → `assets/subscriptions/turf/wimbledon_1.png`, `wimbledon_2.png`, etc.

**Icons:**
- `chevron_forward` (1:16469, 1:16600) → Use Material Icons chevron_right (already available)
- `calendar_clock` (1:16425, 1:16556) → `assets/subscriptions/icons/calendar_clock.png`
- `radio_button_checked` (1:16413, 1:16551) → `assets/subscriptions/icons/radio_button_checked.png`
- `radio_button_unchecked` (1:16402, 1:16420, 1:16533, 1:16544) → `assets/subscriptions/icons/radio_button_unchecked.png`
- `sheild 1` / `Layer 1` → `assets/subscriptions/sports/shield_verified.png`

**Switch Component:**
- `Ellipse 1299` (switch thumb) (1:16595) → Use Material Switch widget (no asset needed)

### Frame 6-7: My cart – services only (node-id: 1-16639, 1-16723)

**Icons:**
- `chevron_forward` (1:16715) → Use Material Icons chevron_right (already available)
- `Line 896` (divider) (1:16711) → Use Material Divider widget (no asset needed)
- `Line 930` (divider) → Use Material Divider widget (no asset needed)
- `Line 937` (divider) → Use Material Divider widget (no asset needed)

**Switch Component:**
- `Ellipse 1299` (switch thumb) → Use Material Switch widget (no asset needed)

### Frame 8: Payment method – card added (node-id: 1-16815)

**Icons:**
- Payment method icons → Use Material Icons (credit_card, account_balance_wallet, etc.)
- Chevron icons → Use Material Icons chevron_right (already available)

### Frame 9: Payment success (node-id: 1-16890)

**Illustrations:**
- Success robot illustration → `assets/subscriptions/payment/success_robot.png` (if custom)
- Checkmark badge → Use Material Icons check (already available)

### Frame 10-12: Quick menu variants & Select tennis court (node-id: 1-15524, 1-15558, 1-15600)

**Icons:**
- Same sport category icons as Frame 2
- Venue images → `assets/subscriptions/turf/[venue_name]_hero.png`

## Asset Export Instructions

### Using Figma MCP

1. For each image node identified above:
   - Use `get_design_context` to get image URLs
   - Download images using the provided Figma API URLs
   - Save to appropriate local path

2. Image formats:
   - Icons: PNG format, 1x resolution (32x32px for category icons)
   - Hero images: PNG format, 2x resolution for retina displays
   - Promotional banners: PNG format, full resolution

3. Naming convention:
   - Use snake_case for file names
   - Include descriptive names (e.g., `tennis_icon.png`, not `image_9.png`)

## Assets Already Using Material Icons

The following assets don't need to be exported as they use Material Icons:
- Arrow icons (arrow_back, chevron_right)
- Status bar icons (signal, wifi, battery)
- Common UI icons (star, close, add, etc.)
- Switch components (use Material Switch widget)

## TODO: Export Required Assets

### High Priority (Required for UI)
1. Sport category icons (7 icons)
2. Shield verified icon
3. Promotional banner image
4. Venue hero images (Wimbledon, Rolland Garos, etc.)

### Medium Priority (Nice to Have)
1. Custom radio button icons (if not using Material)
2. Custom calendar clock icon (if not using Material)
3. Bolt icon for slot drawer

### Low Priority (Can Use Material Icons)
1. Close icon
2. Divider lines (use Material Divider)
3. Switch components (use Material Switch)

## Asset Paths in Code

All asset paths are referenced in:
- `lib/modules/subscription/widgets/quick_menu_sports_fitness.dart`
- `lib/modules/subscription/widgets/turf_promotional_banner.dart`
- `lib/modules/subscription/widgets/venue_card.dart`
- `lib/modules/subscription/view/sports_fitness_category_screen.dart`
- `lib/modules/subscription/view/turf_detail_screen.dart`

## Notes

- All assets should be exported at appropriate resolutions (1x, 2x, 3x for different screen densities)
- Update `pubspec.yaml` asset paths if folder structure changes
- Use error builders in Flutter code to handle missing assets gracefully
- Consider using SVG format for icons if available in Figma

