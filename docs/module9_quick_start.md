# Module 9: Track Order & Invoice - Quick Start Guide

## 🚀 Quick Setup

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Download Assets (Optional but Recommended)

**Option A: Automated Script**
```bash
./scripts/download_module9_assets.sh
```

**Option B: Manual Export**
1. Open Figma: https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-
2. See `docs/module9_track_order_invoice_assets.md` for asset list and URLs
3. Export assets to `assets/orders/track_invoice/`

**Note**: The app works without these assets (uses fallbacks), but exported assets provide better visual fidelity.

### 3. Verify Build
```bash
flutter analyze
flutter build
```

## 📱 Testing the Implementation

### Quick Test Flow

1. **Launch App** → Navigate to My Orders
2. **Track Order**:
   - Tap "Track order" button on any product order
   - Verify full-screen TrackingScreen displays
   - Check back navigation works
3. **View Invoice**:
   - Tap "Invoice" button on any order
   - Verify InvoiceScreen displays
   - Test Download/Share buttons (show placeholder messages)

### Entry Points

- **My Orders Screen** → Track/Invoice buttons on order cards
- **Order Detail Screen** → Track Order button (full-width) and Invoice button

## 🔧 Key Files

### Screens
- `lib/modules/shop/view/tracking_screen.dart` - Full-screen tracking timeline
- `lib/modules/shop/view/invoice_screen.dart` - Invoice display and actions

### Models & Repositories
- `lib/modules/shop/models/tracking_step.dart` - Tracking step data model
- `lib/modules/shop/repository/tracking_repository.dart` - Tracking API (stubbed)
- `lib/modules/shop/repository/invoice_repository.dart` - Invoice API (stubbed)

### Routes
- `/tracking` - TrackingScreen
- `/invoice` - InvoiceScreen

## 📋 Next Steps for Backend Integration

### 1. TrackingRepository Integration

Replace stubbed `getTrackingTimeline()` in `lib/modules/shop/repository/tracking_repository.dart`:

```dart
Future<List<TrackingStep>> getTrackingTimeline(String orderId) async {
  final response = await ApiService.callApi(
    endpoint: 'orders/$orderId/tracking',
    type: ApiType.get,
  );
  
  // Parse response and map to TrackingStep objects
  return (response['steps'] as List)
      .map((json) => TrackingStep.fromJson(json))
      .toList();
}
```

### 2. InvoiceRepository Integration

**Download Invoice**:
```dart
Future<String?> downloadInvoice(String orderId) async {
  final response = await ApiService.callApi(
    endpoint: 'orders/$orderId/invoice/download',
    type: ApiType.get,
  );
  
  // Save PDF to device storage
  // Return file path
}
```

**Share Invoice**:
```dart
Future<bool> shareInvoice(String orderId) async {
  final invoiceUrl = await getInvoiceUrl(orderId);
  // Use share_plus package to share invoice
  await Share.share(invoiceUrl);
  return true;
}
```

### 3. Add Dependencies (if needed)

For invoice sharing, add to `pubspec.yaml`:
```yaml
dependencies:
  share_plus: ^7.0.0  # For sharing functionality
  path_provider: ^2.1.0  # For file storage
```

## 🐛 Troubleshooting

### Assets Not Loading
- Check `pubspec.yaml` includes `assets/orders/track_invoice/`
- Verify assets exist in the directory
- App will use fallback assets if missing

### Navigation Issues
- Verify routes are registered in `lib/main.dart`
- Check route arguments are passed correctly
- Ensure AuthGuard wraps routes if authentication is required

### Build Errors
- Run `flutter clean` then `flutter pub get`
- Check for linting errors: `flutter analyze`
- Verify all imports are correct

## 📚 Documentation

- **Implementation Details**: `docs/module9_track_order_invoice_implementation.md`
- **Asset Manifest**: `docs/module9_track_order_invoice_assets.md`
- **Testing Guide**: `docs/module9_testing_guide.md`

## ✅ Checklist

- [ ] Dependencies installed (`flutter pub get`)
- [ ] Assets downloaded (or fallbacks working)
- [ ] App builds successfully
- [ ] Track Order flow works from My Orders
- [ ] Track Order flow works from Order Detail
- [ ] Invoice flow works from My Orders
- [ ] Invoice flow works from Order Detail
- [ ] Back navigation works correctly
- [ ] Loading states display properly
- [ ] Error handling works

## 🎯 Ready for Production?

Before deploying:
- [ ] Backend APIs integrated
- [ ] All assets exported and verified
- [ ] Full testing completed (see `module9_testing_guide.md`)
- [ ] Error handling tested
- [ ] Performance verified
- [ ] Accessibility tested

