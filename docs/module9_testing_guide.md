# Module 9: Track Order & Invoice - Testing Guide

## Overview

This guide provides comprehensive testing instructions for Module 9: Track Order & Invoice functionality.

## Pre-Testing Checklist

- [ ] All assets are exported and placed in `assets/orders/track_invoice/`
- [ ] Flutter dependencies are installed (`flutter pub get`)
- [ ] App builds successfully (`flutter build`)
- [ ] No linting errors (`flutter analyze`)

## Test Scenarios

### 1. Track Order Flow - From My Orders

**Steps**:
1. Navigate to My Orders screen
2. Ensure "Active" tab is selected
3. Locate a product order card in the "Deliver to" section
4. Tap the "Track order" button

**Expected Results**:
- ✅ Navigates to full-screen TrackingScreen
- ✅ AppBar shows "Track order" title
- ✅ Back button returns to My Orders
- ✅ Tracking timeline displays with:
  - "Order placed on" (completed, green checkmark)
  - "Order accepted on" (completed, green checkmark)
  - "Dispatch" (pending, orange radio button)
  - "Delivery expected on" (pending, orange radio button)
- ✅ Completed steps show black text
- ✅ Pending steps show orange text (#FA643B)
- ✅ Dividers separate each step

**Test Data**: Use order ID `order_123` (stubbed in MyOrdersScreen)

---

### 2. Track Order Flow - From Order Detail

**Steps**:
1. Navigate to My Orders screen
2. Tap on a product order card
3. Verify OrderDetailScreen displays
4. Scroll to bottom
5. Tap the "Track order" button (full-width button)

**Expected Results**:
- ✅ Navigates to full-screen TrackingScreen
- ✅ TrackingScreen shows same timeline as Test 1
- ✅ Back button returns to OrderDetailScreen
- ✅ Order ID is passed correctly

**Test Data**: Use order ID from the order detail screen

---

### 3. Invoice Flow - From My Orders

**Steps**:
1. Navigate to My Orders screen
2. Ensure "Active" tab is selected
3. Locate a product order card
4. Tap the "Invoice" button (left side, with document icon)

**Expected Results**:
- ✅ Navigates to InvoiceScreen
- ✅ AppBar shows "Invoice" title
- ✅ Share icon visible in AppBar
- ✅ Product thumbnail displays (Bose headphones)
- ✅ Product name and details display correctly
- ✅ Large invoice content area displays (placeholder)
- ✅ Download and Share buttons visible at bottom
- ✅ Back button returns to My Orders

**Test Data**: Use order ID `order_123` (stubbed in MyOrdersScreen)

---

### 4. Invoice Flow - From Order Detail

**Steps**:
1. Navigate to My Orders screen
2. Tap on a product order card
3. Verify OrderDetailScreen displays
4. Locate the "Invoice" button (in action buttons row)
5. Tap the "Invoice" button

**Expected Results**:
- ✅ Navigates to InvoiceScreen
- ✅ Same display as Test 3
- ✅ Back button returns to OrderDetailScreen

---

### 5. Invoice Download Functionality

**Steps**:
1. Navigate to InvoiceScreen (from any entry point)
2. Tap the "Download" button

**Expected Results**:
- ✅ Button shows loading indicator while processing
- ✅ Button is disabled during download
- ✅ Snackbar message appears:
  - If not implemented: "Invoice download not yet implemented..."
  - If implemented: Success message with file path
- ✅ Button returns to normal state after completion

**Note**: Currently shows placeholder message. Will show success when backend is integrated.

---

### 6. Invoice Share Functionality

**Steps**:
1. Navigate to InvoiceScreen
2. Tap the "Share" button (or AppBar share icon)

**Expected Results**:
- ✅ Button shows loading indicator while processing
- ✅ Button is disabled during share
- ✅ Snackbar message appears:
  - If not implemented: "Invoice sharing not yet implemented..."
  - If implemented: Success message
- ✅ Button returns to normal state after completion

**Note**: Currently shows placeholder message. Will show success when backend is integrated.

---

### 7. Back Navigation

**Steps**:
1. Navigate to TrackingScreen from My Orders
2. Tap back button
3. Navigate to TrackingScreen from Order Detail
4. Tap back button
5. Navigate to InvoiceScreen from My Orders
6. Tap back button
7. Navigate to InvoiceScreen from Order Detail
8. Tap back button

**Expected Results**:
- ✅ All back navigations return to the correct previous screen
- ✅ Previous screen state is preserved
- ✅ No navigation stack issues

---

### 8. Asset Fallback Behavior

**Steps**:
1. Temporarily remove one asset from `assets/orders/track_invoice/`
2. Navigate to TrackingScreen
3. Verify the screen still displays correctly

**Expected Results**:
- ✅ App doesn't crash
- ✅ Fallback assets are used (from `assets/my_orders/` or Material Icons)
- ✅ UI remains functional

**Test Assets to Remove**:
- `icon_check_circle.png` → Should fallback to `assets/my_orders/icon_check_circle.png`
- `icon_radio_unchecked.png` → Should fallback to `assets/service_booking/icon_radio_unchecked.png`
- `icon_article.png` → Should fallback to `assets/my_orders/icon_article.png`

---

### 9. Empty State Handling

**Steps**:
1. Navigate to TrackingScreen with an invalid/empty order ID
2. Verify behavior

**Expected Results**:
- ✅ Loading indicator shows initially
- ✅ Empty state message displays: "No tracking information available"
- ✅ App doesn't crash

---

### 10. Service Orders (My Orders - Active Tab)

**Steps**:
1. Navigate to My Orders screen
2. Ensure "Active" tab is selected
3. Locate a service order card in the "Service booked for" section
4. Tap "Track Service" button
5. Tap "Invoice" button

**Expected Results**:
- ✅ Track Service navigates to TrackingScreen
- ✅ Invoice navigates to InvoiceScreen
- ✅ Both work correctly for service orders

**Test Data**: Use order ID `service_123` (stubbed in MyOrdersScreen)

---

## Edge Cases

### 1. Missing Order ID
- Navigate directly to TrackingScreen/InvoiceScreen without orderId
- Expected: Handles gracefully, shows empty state or error message

### 2. Network Error Simulation
- Simulate network failure in TrackingRepository
- Expected: Error handling, user-friendly message

### 3. Rapid Button Taps
- Rapidly tap Download/Share buttons
- Expected: Prevents duplicate requests, proper loading states

---

## Visual Regression Testing

Compare screens against Figma designs:

### TrackingScreen
- [ ] Matches Figma frame "Tracking" (node-id: 1-6714)
- [ ] Typography matches (font sizes, weights, letter spacing)
- [ ] Colors match (green for completed, orange for pending)
- [ ] Spacing matches (±2dp tolerance)

### InvoiceScreen
- [ ] Matches Figma frame "Order detail - product - active" (node-id: 1-6993)
- [ ] Product thumbnail displays correctly
- [ ] Invoice content area size matches (580px height)
- [ ] Button styles match Figma

### My Orders - Active Tab
- [ ] Matches Figma frame "My Orders - active" (node-id: 1-6752)
- [ ] Track/Invoice buttons positioned correctly
- [ ] Order cards match design

### Order Detail Screen
- [ ] Matches Figma frame "Order detail - product - active" (node-id: 1-6895)
- [ ] Track Order button positioned correctly
- [ ] Invoice button in action row matches design

---

## Performance Testing

1. **Navigation Speed**: Track time to navigate between screens
2. **Loading States**: Verify loading indicators appear promptly
3. **Memory**: Check for memory leaks during navigation
4. **Asset Loading**: Verify assets load without delay

---

## Accessibility Testing

- [ ] Screen readers can navigate all screens
- [ ] All buttons have proper labels/tooltips
- [ ] Color contrast meets WCAG standards
- [ ] Text scales properly with system font size

---

## Integration Testing

### With Module 5 (My Orders)
- [ ] My Orders screen displays correctly
- [ ] Tab switching works
- [ ] Order cards display correctly

### With Module 8 (Cancel Order)
- [ ] Cancel Order functionality still works
- [ ] Tracking only available for active orders
- [ ] Invoice available for all order statuses

---

## Known Issues / TODOs

1. **Backend Integration**: TrackingRepository and InvoiceRepository use stubbed data
2. **Asset Export**: Some assets may need manual export from Figma
3. **Invoice PDF**: Invoice content area is placeholder - needs actual PDF/image display
4. **Share Functionality**: Requires share_plus or similar package integration

---

## Test Results Template

```
Test Date: ___________
Tester: ___________

Test Scenario | Status | Notes
-------------|--------|-------
1. Track from My Orders | ☐ Pass ☐ Fail | 
2. Track from Order Detail | ☐ Pass ☐ Fail | 
3. Invoice from My Orders | ☐ Pass ☐ Fail | 
4. Invoice from Order Detail | ☐ Pass ☐ Fail | 
5. Invoice Download | ☐ Pass ☐ Fail | 
6. Invoice Share | ☐ Pass ☐ Fail | 
7. Back Navigation | ☐ Pass ☐ Fail | 
8. Asset Fallback | ☐ Pass ☐ Fail | 
9. Empty State | ☐ Pass ☐ Fail | 
10. Service Orders | ☐ Pass ☐ Fail | 

Visual Regression: ☐ Pass ☐ Fail
Performance: ☐ Pass ☐ Fail
Accessibility: ☐ Pass ☐ Fail

Overall Status: ☐ Ready for Production ☐ Needs Fixes

Issues Found:
1. 
2. 
3. 
```

