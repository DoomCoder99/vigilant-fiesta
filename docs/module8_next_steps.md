# Module 8: Next Steps - Asset Export & API Integration

## ✅ Completed Steps

1. **Order Repository Created** (`lib/modules/shop/repository/order_repository.dart`)
   - Follows WDI Flutter Coding Standards
   - Includes placeholder implementation with TODO comments
   - Ready for API integration

2. **Cancel Order Screen Updated**
   - Integrated with `OrderRepository`
   - Added loading state (`_isCancelling`)
   - Added error handling with user-friendly messages
   - Shows loading indicator during cancellation

3. **Asset Directory Created**
   - Created `assets/orders/cancel_order/` directory
   - Added README with export instructions

## 📋 Remaining Steps

### Step 1: Export Assets from Figma

**Required Assets:**

1. **icon_remove.png** (128x128px)
   - **Figma File**: `xu7kp6yBV1qiPwK77Hq7tl`
   - **Node ID**: `1:7046` (remove 1)
   - **Location**: `assets/orders/cancel_order/icon_remove.png`
   - **Usage**: `ProductCancellationConfirmationScreen`

2. **icon_mic.png** (16x16px)
   - **Figma File**: `xu7kp6yBV1qiPwK77Hq7tl`
   - **Node ID**: `1:7494` (mic)
   - **Location**: `assets/orders/cancel_order/icon_mic.png`
   - **Usage**: `CancelOrderScreen` comments field

**Export Instructions:**
1. Open Figma file: `xu7kp6yBV1qiPwK77Hq7tl`
2. Use Figma's "Export" feature:
   - Right-click on the node → Export → PNG
   - Or use the Export panel on the right sidebar
3. Export at the specified sizes
4. Save files to `assets/orders/cancel_order/`

**Note**: Both screens have fallback Material Icons, so the app will work even without these assets, but the design won't match Figma exactly.

### Step 2: API Integration

**Update `OrderRepository.cancelOrder()`:**

Replace the placeholder implementation in `lib/modules/shop/repository/order_repository.dart` with actual API call:

```dart
Future<bool> cancelOrder({
  required String orderId,
  required String reason,
  String? comments,
}) async {
  try {
    final response = await ApiService.callApi(
      endpoint: 'orders/$orderId/cancel',
      type: ApiType.post,
      body: {
        'reason': reason,
        'comments': comments,
      },
      headers: {
        'Authorization': 'Bearer ${AuthService.instance.token}',
        'Content-Type': 'application/json',
      },
    );
    
    if (response['success'] == true) {
      return true;
    } else {
      throw Exception(response['message'] ?? 'Failed to cancel order');
    }
  } catch (e) {
    // Log error
    print('Error cancelling order: $e');
    rethrow;
  }
}
```

**Prerequisites:**
- Ensure `ApiService` is implemented following WDI standards (see `.cursor/rules/flutter-project.mdc`)
- Ensure authentication token is available via `AuthService`
- Update base URL in `ApiService` to match your backend

### Step 3: Testing Checklist

- [ ] Export both assets from Figma
- [ ] Verify assets load correctly in both screens
- [ ] Test cancel order flow end-to-end:
  - [ ] From Order Detail Screen
  - [ ] From My Orders Active tab
- [ ] Test error handling:
  - [ ] Network error
  - [ ] API error response
  - [ ] Invalid order ID
- [ ] Test loading states:
  - [ ] Button shows loading indicator
  - [ ] Button is disabled during cancellation
- [ ] Test navigation:
  - [ ] Returns to Order Detail with cancelled status
  - [ ] Shows success/error messages
- [ ] Test cancelled order display:
  - [ ] Order Detail shows cancelled state
  - [ ] My Orders shows cancelled orders correctly

### Step 4: Additional Enhancements (Optional)

1. **Cancellation Policy Screen**
   - Implement navigation to cancellation policy
   - Currently has TODO in `CancelOrderScreen._buildRefundSection()`

2. **Email Support**
   - Implement email client opening for `helpdesk@amozit.ae`
   - Currently has TODO in `CancelOrderScreen._buildHelplineRow()`

3. **Order Status Management**
   - Consider using GetX controller or Bloc for order state management
   - Update order list when cancellation succeeds
   - Refresh My Orders screen after cancellation

4. **Analytics/Logging**
   - Add analytics events for cancellation flow
   - Log cancellation reasons for business insights

## 📝 Notes

- The implementation follows WDI Flutter Coding Standards
- All screens have proper error handling and loading states
- Asset fallbacks ensure the app works even without exported images
- The repository pattern makes API integration straightforward
- All navigation flows are properly wired

## 🎯 Current Status

**Ready for:**
- ✅ Asset export (manual step)
- ✅ API integration (replace TODO in repository)
- ✅ End-to-end testing

**Blocked on:**
- Asset export (requires manual Figma export)
- API endpoint availability (backend dependency)

