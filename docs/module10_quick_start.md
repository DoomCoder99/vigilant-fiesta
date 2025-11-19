# Module 10: Profile & More - Quick Start Guide

## 🚀 Getting Started

Module 10 is fully implemented and ready for use. Follow these steps to get started.

## ✅ What's Complete

- ✅ 15 screens fully implemented
- ✅ 14 routes configured and wired
- ✅ Navigation flow complete
- ✅ Asset structure created
- ✅ 11 profile assets downloaded
- ✅ Documentation complete

## 📱 Accessing Profile & More

### From Bottom Navigation
Add Profile tab to your bottom navigation bar:
```dart
BottomNavigationBarItem(
  icon: Icon(Icons.person),
  label: 'Profile',
)
```

### Direct Navigation
```dart
Get.toNamed(AppRoutes.profileAndMore);
```

## 🎨 Assets

### Download Remaining Assets

Run the download script:
```bash
bash scripts/download_module10_assets.sh
```

Or manually download from:
- `docs/module10_asset_manifest.md` - Contains all Figma URLs

### Asset Status
- ✅ Profile assets: 11/11 downloaded
- ⚠️ Wallet, Notifications, Documents, Coupons: Download script available

## 🔌 Backend Integration

### Quick Integration Checklist

1. **Profile API**
   - [ ] `GET /api/profile` - Get user profile
   - [ ] `PUT /api/profile` - Update profile
   - [ ] `POST /api/profile/avatar` - Upload avatar

2. **Address API**
   - [ ] `GET /api/addresses` - List addresses
   - [ ] `POST /api/addresses` - Create address
   - [ ] `PUT /api/addresses/{id}` - Update address
   - [ ] `DELETE /api/addresses/{id}` - Delete address

3. **Wallet API**
   - [ ] `GET /api/wallet/balance` - Get balance
   - [ ] `GET /api/wallet/transactions` - Get transactions
   - [ ] `POST /api/wallet/add-money` - Add money

4. **Payment Methods API**
   - [ ] `GET /api/payment-methods` - List cards
   - [ ] `POST /api/payment-methods` - Add card
   - [ ] `DELETE /api/payment-methods/{id}` - Remove card

5. **Documents API**
   - [ ] `GET /api/documents` - List documents
   - [ ] `POST /api/documents` - Upload document
   - [ ] `GET /api/documents/{id}` - View document

6. **Notifications API**
   - [ ] `GET /api/notifications` - List notifications
   - [ ] `PATCH /api/notifications/{id}/read` - Mark read

7. **Coupons API**
   - [ ] `GET /api/coupons` - List coupons
   - [ ] `POST /api/coupons/{id}/apply` - Apply coupon

See `docs/module10_integration_guide.md` for detailed API specifications.

## 🧪 Testing

### Manual Testing Checklist

- [ ] Navigate to Profile & More from bottom nav
- [ ] Edit profile (name, email, phone)
- [ ] View addresses list
- [ ] Add new address
- [ ] View wallet balance
- [ ] Add payment method
- [ ] View documents
- [ ] View notifications
- [ ] Change language (English/Arabic)
- [ ] Change theme (Light/Dark)
- [ ] View coupons
- [ ] View help FAQ
- [ ] Contact support
- [ ] Delete account flow

## 📝 Code Examples

### Navigate to Profile & More
```dart
Get.toNamed(AppRoutes.profileAndMore);
```

### Navigate to Edit Profile
```dart
Get.toNamed(AppRoutes.profileEdit);
```

### Show Language Selection Bottom Sheet
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const LanguageSelectionScreen(),
);
```

### Show Theme Selection Bottom Sheet
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const ThemeSelectionScreen(),
);
```

## ⚠️ Known Issues / Notes

1. **Deprecation Warnings**: 
   - `withOpacity()` deprecation warnings (info-level, not errors)
   - `RadioListTile` deprecation warnings (info-level, not errors)
   - These are consistent with existing codebase patterns

2. **Missing Assets**: 
   - Some wallet/notification/document assets may need manual download
   - Fallback icons are implemented

3. **Mock Data**: 
   - All screens currently use mock data
   - Replace with API calls as per integration guide

4. **Image Picker**: 
   - Avatar upload needs `image_picker` package
   - Add to `pubspec.yaml` when implementing

## 📚 Documentation Files

1. `module10_profile_more_implementation.md` - Full implementation details
2. `module10_asset_manifest.md` - Asset download guide
3. `module10_integration_guide.md` - Backend integration guide
4. `module10_completion_summary.md` - Completion status

## 🎯 Next Steps

1. ✅ **Done**: Screen implementation
2. ✅ **Done**: Navigation wiring
3. ✅ **Done**: Asset structure
4. ⏳ **Next**: Download remaining assets
5. ⏳ **Next**: Backend API integration
6. ⏳ **Next**: Add image picker for avatar
7. ⏳ **Next**: Implement localization
8. ⏳ **Next**: Implement theme switching

## 💡 Tips

- All screens are protected with `AuthGuard` - ensure user is logged in
- Bottom sheets are used for Language/Theme/Policy Detail (per Figma)
- Payment methods reuse existing card components
- Address screens reuse Module 3 implementations
- Check `docs/module10_integration_guide.md` for detailed backend requirements

---

**Status**: ✅ Ready for backend integration and testing!

