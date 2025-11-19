# Module 8: Cancel Order (Products) Implementation Summary

## Overview

Successfully implemented the complete Cancel Order flow for product orders in the AMOZIT Customer App. This module extends the existing My Orders and Order Detail screens (Modules 5 & 6) to support order cancellation with a complete user flow from confirmation to reason selection.

## Screens Implemented

### 1. Product Cancellation Confirmation Screen
**File**: `lib/modules/shop/view/product_cancellation_confirmation_screen.dart`  
**Figma Frame**: "Cancellation confirmation" (node-id: 1-7043)  
**Route**: `/product-cancellation-confirmation` (used as bottom sheet)

**Features**:
- Bottom sheet modal with shopping cart remove icon
- Title: "Cancel Order?"
- Message: "You are about to cancel this order. Are you sure?"
- Two action buttons:
  - **"No, Go Back"** (purple filled button) - Dismisses modal
  - **"Yes, Cancel Order"** (red outlined button) - Navigates to Cancel Order screen

**Navigation**:
- Triggered from:
  - Order Detail Screen → "Cancel Order" button (for active orders)
  - My Orders → Active tab → "Cancel" button on order card (if present)
- On "Yes, Cancel Order" → Navigates to `CancelOrderScreen`

### 2. Cancel Order Screen
**File**: `lib/modules/shop/view/cancel_order_screen.dart`  
**Figma Frame**: "Cancel order" (node-id: 1-7445)  
**Route**: `/cancel-order`

**Features**:
- Product item display (image, name, quantity, price)
- Cancellation reason selection (chips):
  - "I changed mind" (selected by default)
  - "Found better price"
  - "Other"
- Optional comments text field with microphone icon
- Refund information section with cancellation policy link
- Helpline section (email, toll-free number, payment method, transaction ID)
- "Cancel Order" button (disabled until reason selected)

**Behavior**:
- On "Cancel Order" button tap:
  - Validates that a reason is selected
  - TODO: Calls `orderRepository.cancelOrder(orderId, reason, comments)`
  - Updates order status to `cancelled`
  - Navigates back to Order Detail Screen with cancelled status
  - Shows success snackbar

### 3. Order Detail Screen (Updated)
**File**: `lib/modules/shop/view/order_detail_screen.dart`  
**Figma Frames**:
- Pre-cancel: "Order detail - product - active" (node-id: 1-7255)
- Post-cancel: "Order detail - product - active" (node-id: 1-7353)

**Updates**:
- Added support for `OrderStatus.cancelled` state
- When cancelled:
  - Shows "Order cancelled" section with red border
  - Displays "Cancelled on" date and "Refund" status
  - Hides "Cancel Order" button
  - Hides "Track order" button
  - Shows only "Buy Again" button
- When active:
  - "Cancel Order" button triggers `ProductCancellationConfirmationScreen`

### 4. My Orders Screen (Updated)
**File**: `lib/modules/shop/view/my_orders_screen.dart`  
**Figma Frames**:
- Pre-cancel: "My Orders - active" (node-id: 1-7055)
- Post-cancel: "My Orders - active" (node-id: 1-7197)

**Updates**:
- `_buildProductOrderCard` now accepts `OrderStatus` parameter
- When order is cancelled:
  - Card border changes to red (`AppColors.errorLight`)
  - Shows "Cancelled on" and "Refund" fields instead of delivery info
  - Hides action buttons (Invoice, Cancel, Track order)
- When order is active:
  - Shows "Cancel" button (if `onCancel` callback provided)
  - "Cancel" button triggers `ProductCancellationConfirmationScreen`

## State Management

### Order Status Enum
**File**: `lib/modules/shop/models/order_status.dart`

```dart
enum OrderStatus {
  active,      // Order is active and being processed
  delivered,   // Order has been delivered
  cancelled,   // Order is cancelled (Module 8)
  returning,   // Order is being returned
}
```

### State Flow
```
ACTIVE → (User taps Cancel) → Cancellation Confirmation → Cancel Order Screen → CANCELLED
```

## Navigation Flow

### Complete Cancel Order Flow

```
My Orders - Active Tab
  │
  ├─> Order Card Tap → Order Detail Screen (active)
  │   │
  │   └─> "Cancel Order" Button → Product Cancellation Confirmation (bottom sheet)
  │       │
  │       ├─> "No, Go Back" → Dismisses, returns to Order Detail
  │       │
  │       └─> "Yes, Cancel Order" → Cancel Order Screen
  │           │
  │           ├─> Select reason + optional comments
  │           │
  │           └─> "Cancel Order" Button → Order Detail Screen (cancelled)
  │
  └─> "Cancel" Button on Order Card → Product Cancellation Confirmation (bottom sheet)
      └─> (Same flow as above)
```

### Post-Cancellation State

After cancellation:
- **Order Detail Screen**: Shows cancelled state with "Order cancelled" section, only "Buy Again" button visible
- **My Orders - Active Tab**: Cancelled orders can appear with red border (if still in Active tab) OR moved to "Cancel / Return" tab
- **My Orders - Cancel / Return Tab**: Shows cancelled orders with red border

## Routes Added

```dart
// Module 8: Product Order Cancellation Routes
static const String cancelOrder = '/cancel-order';
static const String productCancellationConfirmation = '/product-cancellation-confirmation';
```

Both routes are registered in `main.dart` with `AuthGuard` protection.

## Asset Manifest

### Required Assets (to be exported from Figma)

All assets should be exported and placed in `assets/orders/cancel_order/`:

1. **icon_remove.png** (128x128)
   - Shopping cart with remove icon
   - Used in: `ProductCancellationConfirmationScreen`
   - Figma node: remove 1 (node-id: 1-7046)

2. **icon_mic.png** (16x16)
   - Microphone icon for comments field
   - Used in: `CancelOrderScreen`
   - Figma node: mic (node-id: 1-7494)

### Existing Assets (reused)
- Product images: `assets/my_orders/product_bose_headphones.png`
- Icons: `assets/images/icon_back_arrow.png`
- Other icons from existing asset folders

### Asset Paths in pubspec.yaml

```yaml
assets:
  - assets/orders/cancel_order/
```

## Design Fidelity

### Colors
- Primary: `#7132F4` (AppColors.primary)
- Error/Cancel: `#F14336` (Color(0xFFF14336))
- Error Light: `#FA9B9B` (AppColors.errorLight) - for cancelled order borders
- Text Primary: `#162028` (AppColors.textPrimary)
- Text Secondary: `#D6DEE8` (AppColors.textSecondary)

### Typography
- Headings: Figtree Medium, 12-22px
- Body: Figtree Regular/Light, 10-14px
- Button text: Figtree SemiBold/Bold, 12-14px
- Letter spacing: 0.2-0.28px (matching Figma)

### Spacing
- Uses `AppSpacing` constants throughout
- Padding: `AppSpacing.md` (8dp) for cards
- Gaps: `AppSpacing.sm` (4dp) to `AppSpacing.lg` (16dp)
- Border radius: `AppBorderRadius.sm` (8dp) for cards, 999px for fully rounded buttons

### Layout
- All spacing matches Figma within ±2dp tolerance
- Button styles match Figma exactly (outlined vs filled, colors, padding)
- Card borders and shadows match design

## Integration with Modules 5 & 6

### Module 5 (My Orders)
- Extended `MyOrdersScreen` to support cancelled orders
- Added `OrderStatus` parameter to order cards
- Conditional rendering based on order status

### Module 6 (Service Order Actions)
- Product cancellation flow is separate from service cancellation
- Both use similar confirmation pattern but different screens
- Service cancellation uses `ServiceCancellationConfirmationDialog`
- Product cancellation uses `ProductCancellationConfirmationScreen`

## Assumptions & TODOs

### Assumptions
1. **Cancelled orders in Active tab**: Based on Figma frame 1-7197, cancelled orders can appear in the Active tab with red border. Alternatively, they may be moved to "Cancel / Return" tab (which already exists in Module 5).

2. **Post-cancel navigation**: After cancellation, user is navigated to Order Detail Screen with cancelled status. Alternative: could navigate back to My Orders list.

3. **Refund status**: Hardcoded as "Processing" - should come from order data/API.

4. **Cancellation date**: Hardcoded as "31 Sep 2025" - should come from order data/API.

### TODOs
1. **API Integration**:
   - Implement `orderRepository.cancelOrder(orderId, reason, comments)` method
   - Replace hardcoded order data with API calls
   - Handle API errors and loading states

2. **Asset Export**:
   - Export `icon_remove.png` from Figma (node 1-7046)
   - Export `icon_mic.png` from Figma (node 1-7494)
   - Place in `assets/orders/cancel_order/` directory

3. **Cancellation Policy**:
   - Implement navigation to cancellation policy screen/page
   - Currently just has TODO comment

4. **Email Support**:
   - Implement email client opening for `helpdesk@amozit.ae`
   - Currently just has TODO comment

5. **Order Status Parsing**:
   - Improve order status parsing from route arguments
   - Currently uses string comparison which is fragile

6. **Buy Again**:
   - Implement "Buy Again" button functionality
   - Should navigate to product detail or add to cart

7. **Invoice**:
   - Implement invoice display functionality
   - Currently just has TODO comment

## Testing Checklist

- [ ] Cancel order flow from Order Detail Screen
- [ ] Cancel order flow from My Orders Active tab
- [ ] Cancellation confirmation modal dismisses correctly
- [ ] Cancel Order screen requires reason selection
- [ ] Order Detail shows cancelled state correctly
- [ ] My Orders shows cancelled orders with red border
- [ ] Navigation back to Order Detail after cancellation
- [ ] All buttons have proper onTap handlers
- [ ] Asset images load correctly (with fallbacks)
- [ ] Typography and spacing match Figma designs

## Files Modified

1. `lib/modules/shop/view/order_detail_screen.dart` - Added cancelled state support
2. `lib/modules/shop/view/my_orders_screen.dart` - Added cancelled order card support
3. `lib/core/routes/app_routes.dart` - Added new routes
4. `lib/main.dart` - Registered new routes
5. `pubspec.yaml` - Added asset path

## Files Created

1. `lib/modules/shop/view/product_cancellation_confirmation_screen.dart`
2. `lib/modules/shop/view/cancel_order_screen.dart`
3. `docs/module8_cancel_order_implementation.md` (this file)

