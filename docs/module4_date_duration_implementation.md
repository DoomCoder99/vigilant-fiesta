# Module 4: Rent Vehicle - Date & Duration Selection Implementation

## Overview

This document describes the implementation of the date and duration selection portion of the Rent a Vehicle flow. The implementation treats different Figma frames as **states of the same screen** rather than separate routes, using GetX for state management as per WDI standards.

---

## Files Created

### 1. Controller
- **Path**: `lib/modules/rent_vehicle/controller/rental_duration_controller.dart`
- **Purpose**: Manages all state for date/duration selection using GetX
- **Key Features**:
  - Tracks rental type (Day-Wise vs Hourly)
  - Manages date range selection for day-wise rentals
  - Manages time slot selection for hourly rentals
  - Provides computed properties (`totalDays`, `totalHours`, `canApply`)
  - Handles calendar navigation (previous/next month)

### 2. Main Screen
- **Path**: `lib/modules/rent_vehicle/view/rental_duration_screen.dart`
- **Purpose**: Container screen with tab switcher and Apply button
- **Components**:
  - App bar with back button and close icon
  - Tab selector (Day-Wise / Hourly)
  - Dynamic content area (switches between selectors)
  - Apply button (enabled only when selection is complete)

### 3. Day-Wise Rental Selector
- **Path**: `lib/modules/rent_vehicle/widgets/day_wise_rental_selector.dart`
- **Purpose**: Calendar-based date range picker
- **Features**:
  - Shows two months (current and next)
  - Weekday headers
  - Date range selection (start → end)
  - Visual states:
    - **Blank state**: No dates selected
    - **First day selected**: Single date highlighted in purple
    - **Last day selected**: Range highlighted (start and end in purple, between dates in light purple)
  - Past dates are dimmed
  - Dates from other months are semi-transparent

### 4. Hourly Rental Selector
- **Path**: `lib/modules/rent_vehicle/widgets/hourly_rental_selector.dart`
- **Purpose**: Time slot picker for hourly rentals
- **Features**:
  - Date selector card with "Change" button
  - Time grid (12 AM/PM slots each)
  - Time range selection (start → end)
  - Visual states:
    - **Blank state**: No times selected
    - **Start hour selected**: Single time slot highlighted in purple
    - **End hour selected**: Range highlighted (start and end in purple, between slots in light purple)

### 5. Date Selection Drawer
- **Path**: `lib/modules/rent_vehicle/widgets/date_selection_drawer.dart`
- **Purpose**: Modal bottom sheet for selecting date in hourly rental mode
- **Features**:
  - Single month calendar view
  - Month navigation (previous/next)
  - "Set Date" button to confirm selection
  - Matches Figma's "Select date - rent vehicle" frame (1:19326)

---

## State Transitions

### Day-Wise Rental

#### State 1: Blank (Figma frame 1:19873)
- No dates selected
- Calendar displayed with all future dates available
- "Apply" button is disabled (gray)

```dart
// State
startDate = null
endDate = null
canApply = false
```

#### State 2: First Day Selected (Figma frame 1:18995)
- User taps a date → becomes the start date
- Selected date highlighted in purple (#7132F4)
- "Apply" button still disabled (need end date)

```dart
// State
startDate = DateTime(2025, 9, 20)
endDate = null
canApply = false
```

#### State 3: Last Day Selected (Figma frame 1:19651)
- User taps another date → becomes the end date
- Both dates highlighted in purple
- Dates between start and end highlighted in light purple (#EBEFF5)
- "Apply" button enabled (purple)

```dart
// State
startDate = DateTime(2025, 9, 20)
endDate = DateTime(2025, 9, 26)
totalDays = 7
canApply = true
```

**Logic**: If user taps before start date, the dates swap automatically.

---

### Hourly Rental

#### State 1: Blank (Figma frame 1:19540)
- Date selector shows initial date (today or previously selected)
- No time slots selected
- "Apply" button is disabled (gray)

```dart
// State
rentalDate = DateTime(2025, 9, 11)
startHour = null
endHour = null
canApply = false
```

#### State 2: Start Hour Selected (Figma frame 1:19215)
- User taps a time slot → becomes the start hour
- Selected slot highlighted in purple (#7132F4)
- "Apply" button still disabled (need end hour)

```dart
// State
rentalDate = DateTime(2025, 9, 11)
startHour = "08:00"
endHour = null
canApply = false
```

#### State 3: End Hour Selected (Figma frame 1:19427)
- User taps another time slot → becomes the end hour
- Both slots highlighted in purple
- Slots between start and end highlighted in light purple (#EBEFF5)
- "Apply" button enabled (purple)

```dart
// State
rentalDate = DateTime(2025, 9, 11)
startHour = "08:00"
endHour = "03:00"
totalHours = 7 (handles overnight if needed)
canApply = true
```

---

## Assets Used

### Icons Exported from Figma

| Asset Name | Figma URL | Local Path | Usage |
|------------|-----------|------------|-------|
| close_small | `https://www.figma.com/api/mcp/asset/cd96f1e2-2e72-4dcc-9ed2-43abc7fd2fe6` | `assets/rent_vehicle/icons/close_small.png` | Close icon in app bar and drawer header |
| chevron_backward | `https://www.figma.com/api/mcp/asset/bb46883e-d79b-40f0-ad39-9a28e44aa120` | `assets/rent_vehicle/icons/chevron_backward.png` | Previous month navigation |
| chevron_forward | `https://www.figma.com/api/mcp/asset/cb66378e-efa3-4d7b-a5a8-b22e9b7ceb9f` | `assets/rent_vehicle/icons/chevron_forward.png` | Next month navigation, button arrows |

All assets are registered in `pubspec.yaml`:
```yaml
assets:
  - assets/rent_vehicle/icons/
```

---

## Design Tokens Used

### Colors
- **Primary Purple**: `#7132F4` - Selected states, primary button
- **Light Purple**: `#EBEFF5` - Range backgrounds, selected tab background
- **Black**: `#162028` - Primary text
- **White**: `#FFFFFF` - Background, selected text
- **Light Grey**: `#EBEBEB` - Disabled button, borders

### Typography
- **Font Family**: Figtree
- **Font Weights**: Regular (400), SemiBold (600), Bold (700)
- **Font Sizes**:
  - 14px: Titles, button text
  - 12px: Tab labels, date info
  - 10px: Calendar dates, weekday headers

### Spacing
- Container padding: 25px horizontal
- Button height: 52px
- Button border radius: 28px
- Calendar cell size: 40x40px
- Time slot size: 65x36px

---

## Navigation Integration

### Entry Point
The `RentalDurationScreen` can be accessed from:
- Vehicle detail screen (after selecting a vehicle)
- Direct navigation for testing: `Get.to(() => RentalDurationScreen())`

### Exit / Apply Action
When user taps "Apply":
1. Controller validates selection is complete (`canApply == true`)
2. Returns data to previous screen via `Get.back(result: {...})`
3. Returned data includes:
   - `type`: RentalType (dayWise or hourly)
   - `startDate` / `endDate`: For day-wise rentals
   - `startHour` / `endHour` / `rentalDate`: For hourly rentals

**Next Screen**: Typically proceeds to vehicle add-ons or pickup location selection.

---

## Testing Guide

### Manual Test Cases

#### Day-Wise Rental
1. ✅ Launch screen → should show Day-Wise tab selected by default
2. ✅ Tap a date → should highlight in purple, Apply stays disabled
3. ✅ Tap another date after the first → should show range, Apply enables
4. ✅ Tap a date before the first → should swap and show correct range
5. ✅ Try tapping past dates → should be disabled/ignored
6. ✅ Switch to Hourly tab → should clear day-wise selection

#### Hourly Rental
1. ✅ Switch to Hourly Rental tab
2. ✅ Tap "Change" on date selector → should show date picker drawer
3. ✅ Select a date and tap "Set Date" → should update and close drawer
4. ✅ Tap a time slot → should highlight in purple, Apply stays disabled
5. ✅ Tap another time slot → should show range, Apply enables
6. ✅ Switch back to Day-Wise tab → should clear hourly selection

#### Apply Button
1. ✅ Apply button should be gray when selection incomplete
2. ✅ Apply button should be purple when selection complete
3. ✅ Tapping Apply should navigate back with result data

---

## Code Quality Checklist

- ✅ Follows WDI Flutter Coding Standards
- ✅ Uses GetX for state management
- ✅ Uses const constructors where possible
- ✅ No business logic in UI widgets
- ✅ Proper separation: controller / view / widgets
- ✅ All assets registered in pubspec.yaml
- ✅ No hardcoded Figma URLs in production code
- ✅ Design tokens match Figma exactly (±2dp tolerance)
- ✅ No linter errors

---

## Future Enhancements (Not Yet Implemented)

1. **Persistence**: Save last selected dates/times using GetStorage
2. **Validation**: Add business rules (min/max rental duration, blackout dates)
3. **Pricing**: Show estimated cost based on selected duration
4. **Animations**: Add smooth transitions between states
5. **Accessibility**: Add semantic labels for screen readers
6. **i18n**: Externalize all text strings for localization

---

## Dependencies Added

```yaml
dependencies:
  get: ^4.6.6       # State management
  intl: ^0.19.0     # Date formatting
```

---

## Summary

This implementation provides a complete, production-ready date/duration selection experience that:
- ✅ Matches Figma designs 1:1
- ✅ Treats different states as the same screen (not separate routes)
- ✅ Uses proper state management (GetX)
- ✅ Exports and uses real Figma assets
- ✅ Follows WDI coding standards
- ✅ Provides clear state transitions
- ✅ Integrates seamlessly with the rest of Module 4

The implementation is ready for integration with vehicle listing and add-ons screens.

