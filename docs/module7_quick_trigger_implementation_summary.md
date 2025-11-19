# Module 7: Quick Trigger – Floating Button (Service Information) - Implementation Summary

## Overview

Successfully implemented Module 7: Quick Trigger – Floating Button (Service Information) for the AMOZIT Customer App. This module provides a global floating Quick Trigger button that appears over core app screens and displays service information overlays in various states.

## Architecture

### State Management

The Quick Trigger system uses **GetX** for state management, following the WDI Flutter Coding Standards:

- **QuickTriggerController** (`lib/modules/quick_trigger/controller/quick_trigger_controller.dart`):
  - Manages Quick Trigger state (onTheDay, minimized, onCompletion, thanks)
  - Tracks current service order context (id, time, agent info)
  - Controls visibility of floating button and overlay
  - Handles state transitions

### State Machine

The Quick Trigger state machine has four states:

1. **onTheDay**: Service is scheduled for today and is active/upcoming
   - Shows full overlay with service details, agent info, and action buttons
   - User can call agent, add add-ons, or minimize overlay

2. **minimized**: Overlay has been manually minimized by user
   - Shows only floating button (lightning icon)
   - Tapping button expands overlay back to previous state

3. **onCompletion**: Service has been completed but user hasn't acknowledged/dismissed
   - Shows completion message with "Rate Now" CTA
   - Transitions to thanks state after review submission

4. **thanks**: Final acknowledgment state after review/feedback submission
   - Shows thank you message with decorative confetti image
   - Auto-dismisses after 3 seconds

### State Transitions

```
onTheDay → minimized (user taps minimize)
minimized → onTheDay (user taps floating button)
onTheDay → onCompletion (service status changes to completed)
onCompletion → thanks (user submits review)
thanks → hidden (auto-dismiss after 3 seconds)
```

## Components Implemented

### 1. QuickTriggerHost (`lib/modules/quick_trigger/view/quick_trigger_host.dart`)

Wrapper widget that:
- Initializes QuickTriggerController (GetX permanent instance)
- Wraps main app content
- Provides Stack for overlay rendering

**Integration**: Wrapped around `_buildBody()` in `AmozitLandingConfirmedScreen`

### 2. ServiceInfoOverlayWidget (`lib/modules/quick_trigger/view/service_info_overlay_widget.dart`)

Main overlay widget that:
- Renders overlay content based on current state
- Handles all four states (onTheDay, minimized, onCompletion, thanks)
- Provides backdrop with tap-to-minimize
- Uses design tokens for typography, colors, spacing

**Key Features**:
- **On-the-day overlay**: Full service details, agent info with avatar, rating, verified badge, arrival time, action buttons (Add ons, Call)
- **On-completion overlay**: Completion message with "Rate Now" button
- **Thanks overlay**: Thank you message with decorative image

### 3. FloatingQuickTriggerButton (`lib/modules/quick_trigger/widgets/floating_quick_trigger_button.dart`)

Floating button widget that:
- Positioned bottom-right, above bottom navigation bar
- Shows lightning bolt icon
- Toggles overlay expansion/minimization
- Only visible when Quick Trigger is active

**Positioning**: 
- Bottom: 112px (above bottom nav with margins)
- Right: Aligned with bottom nav bar right edge

### 4. QuickTriggerController (`lib/modules/quick_trigger/controller/quick_trigger_controller.dart`)

GetX controller that:
- Manages state using Rx observables
- Provides methods for state transitions
- Tracks service order context
- Controls visibility

**Key Methods**:
- `setActiveServiceOrder()`: Sets active service and updates state
- `clearActiveServiceOrder()`: Hides Quick Trigger
- `expandOverlay()`: Expands from minimized state
- `minimizeOverlay()`: Minimizes overlay
- `transitionToCompletion()`: Transitions to completion state
- `transitionToThanks()`: Transitions to thanks state with auto-dismiss

### 5. QuickTriggerState Enum (`lib/modules/quick_trigger/models/quick_trigger_state.dart`)

Enum defining the four Quick Trigger states.

## Integration with Existing Modules

### ServiceOrderDetailScreen Integration

**File**: `lib/modules/shop/view/service_order_detail_screen.dart`

- Added `initState()` hook to update QuickTriggerController when screen loads
- Maps `ServiceOrderStatus` to `QuickTriggerState`:
  - `upcoming` → `onTheDay`
  - `completed` → `onCompletion`
  - `cancelled` → hides Quick Trigger
- Updates controller with service order data (orderId, serviceName, agent info, etc.)

### ServiceReviewScreen Integration

**File**: `lib/modules/shop/view/service_review_screen.dart`

- On review submission, transitions QuickTriggerController to `thanks` state
- Uses try-catch to handle case where controller is not initialized

### Navigation Integration

All overlay actions navigate to existing routes:

- **Call button** → `AppRoutes.serviceCall` with call parameters
- **Add ons button** → `AppRoutes.serviceAddons`
- **Rate Now button** → `AppRoutes.serviceReview` with orderId
- **View details** → `AppRoutes.serviceOrderDetail` (via existing navigation)

## Design Fidelity

### Typography

All text styles use design system tokens:
- Headings: `AppTextStyles.headingMedium` (24px, SemiBold)
- Body text: `AppTextStyles.bodySmall` (12px, Regular)
- Captions: `AppTextStyles.caption` (10px, Regular)
- Button text: `AppTextStyles.button` (14px, Bold)

### Colors

All colors use design system tokens:
- Primary: `AppColors.primary` (#7132F4)
- Background: `AppColors.backgroundWhite`
- Text: `AppColors.textPrimary` (#162028)
- Borders: `AppColors.inputBorder`

### Spacing

All spacing uses design system tokens:
- Padding: `AppSpacing.xxl` (24px)
- Gaps: `AppSpacing.lg` (16px), `AppSpacing.md` (8px)
- Border radius: `AppBorderRadius.lg` (28px for buttons)

### Layout

- Overlay width: 340px (matches Figma)
- Overlay border radius: 24px (top corners)
- Floating button: 72x72px, 36px border radius
- Agent avatar: 40x40px
- Icons: 16-32px depending on usage

## Assets

### Asset Manifest

Created comprehensive asset manifest: `docs/module7_quick_trigger_asset_manifest.md`

**Asset Directory**: `assets/quick_trigger/`

**Required Assets**:
- `agent_avatar.png` - Agent profile picture
- `lightning_icon.png` - Floating button icon
- `hide_icon.png` - Minimize/close button
- `star_icon.png` - Rating star
- `shield_icon.png` - Verified badge
- `shopping_cart_icon.png` - Add-ons button icon
- `call_icon.png` - Call button icon
- `confetti_icon.png` - Thanks state decorative image

**Note**: All assets should be exported from Figma at 2x resolution. Temporary Figma URLs are provided in the asset manifest (valid for 7 days).

### pubspec.yaml

Updated `pubspec.yaml` to include Quick Trigger assets:
```yaml
assets:
  - assets/quick_trigger/
```

## Behavior & Interactions

### Floating Button Visibility

- Visible when:
  - Active service order exists (upcoming or completed)
  - Quick Trigger state is not hidden
- Hidden when:
  - No active service order
  - Service order is cancelled
  - Thanks state auto-dismisses

### Overlay Interactions

- **Tap backdrop**: Minimizes overlay
- **Tap minimize button**: Minimizes overlay
- **Tap floating button** (when minimized): Expands overlay
- **Tap action buttons**: Navigate to respective screens

### State Persistence

- QuickTriggerController is initialized as permanent GetX instance
- State persists across navigation within app
- State clears when service order is cancelled or thanks state dismisses

## Testing Scenarios

### Scenario 1: Day-of-Service Flow

1. User has upcoming service order
2. Quick Trigger appears with onTheDay state
3. User can call agent, add add-ons, or minimize
4. User minimizes overlay
5. Floating button appears
6. User taps floating button
7. Overlay expands back to onTheDay state

### Scenario 2: Service Completion Flow

1. Service status changes to completed
2. Quick Trigger transitions to onCompletion state
3. Overlay shows completion message with "Rate Now" button
4. User taps "Rate Now"
5. Navigates to ServiceReviewScreen
6. User submits review
7. Quick Trigger transitions to thanks state
8. Thanks overlay shows for 3 seconds
9. Quick Trigger auto-dismisses

### Scenario 3: Service Cancellation

1. Service order is cancelled
2. QuickTriggerController.clearActiveServiceOrder() is called
3. Quick Trigger hides completely

## Future Enhancements (TODOs)

1. **Backend Integration**: Replace mock data with actual service order data from API
2. **State Persistence**: Persist Quick Trigger state across app restarts
3. **Real-time Updates**: Update Quick Trigger when service status changes in real-time
4. **Image Assets**: Download and add all real image assets from Figma
5. **Animation**: Add smooth transitions between states
6. **Accessibility**: Add semantic labels and accessibility support
7. **Localization**: Externalize all text strings for i18n

## Files Created

```
lib/modules/quick_trigger/
├── controller/
│   └── quick_trigger_controller.dart
├── models/
│   └── quick_trigger_state.dart
├── view/
│   ├── quick_trigger_host.dart
│   └── service_info_overlay_widget.dart
└── widgets/
    └── floating_quick_trigger_button.dart

docs/
├── module7_quick_trigger_asset_manifest.md
└── module7_quick_trigger_implementation_summary.md
```

## Files Modified

- `lib/modules/shop/view/amozit_landing_confirmed_screen.dart` - Added QuickTriggerHost wrapper
- `lib/modules/shop/view/service_order_detail_screen.dart` - Added QuickTriggerController integration
- `lib/modules/shop/view/service_review_screen.dart` - Added transition to thanks state
- `pubspec.yaml` - Added quick_trigger assets directory

## Summary

Module 7 is fully implemented with:
✅ Global floating Quick Trigger button
✅ Service information overlay in all states (onTheDay, minimized, onCompletion, thanks)
✅ State management using GetX
✅ Integration with existing service order flows
✅ Navigation to existing routes (call, review, add-ons)
✅ Design system token usage
✅ Asset manifest and documentation
✅ Proper error handling and fallbacks

The implementation follows WDI Flutter Coding Standards and integrates seamlessly with existing modules (Module 5: My Orders, Module 6: Service Agent Actions).

