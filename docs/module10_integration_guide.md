# Module 10: Profile & More - Integration Guide

## Backend Integration TODOs

This document outlines all backend integration points that need to be implemented.

### 1. Profile Management

#### Profile Update API
**Location**: `profile_edit_screen.dart`
**TODO**: Line ~60 in `_updateProfile()`

```dart
// TODO: Implement profile update via repository
// Example:
// final profileRepo = Get.find<ProfileRepository>();
// await profileRepo.updateProfile({
//   'name': _nameController.text,
//   'email': _emailController.text,
//   'phone': _phoneController.text,
// });
```

**Required Endpoints**:
- `PUT /api/profile` - Update profile
- `GET /api/profile` - Get current profile

#### Profile Avatar Upload
**Location**: `profile_edit_screen.dart`
**TODO**: Add image picker integration

**Required**:
- Add `image_picker` package
- Implement image upload to backend
- Update avatar URL in profile

### 2. Account Deletion

**Location**: `account_delete_confirmation_screen.dart`
**TODO**: Line ~20 in `_deleteAccount()`

```dart
// TODO: Implement account deletion via repository
// Example:
// final authRepo = Get.find<AuthRepository>();
// await authRepo.deleteAccount();
// await authRepo.logout();
```

**Required Endpoints**:
- `DELETE /api/account` - Delete user account

### 3. Address Management

**Location**: `addresses_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/addresses` - List user addresses
- `POST /api/addresses` - Create new address
- `PUT /api/addresses/{id}` - Update address
- `DELETE /api/addresses/{id}` - Delete address
- `PATCH /api/addresses/{id}/default` - Set default address

**Models Needed**:
```dart
class Address {
  final String id;
  final String type; // 'Home', 'Work', 'Other'
  final String address;
  final bool isDefault;
  // ... other fields
}
```

### 4. Wallet Management

**Location**: `wallet_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/wallet/balance` - Get wallet balance
- `GET /api/wallet/transactions` - Get transaction history
- `POST /api/wallet/add-money` - Add money to wallet
- `GET /api/wallet/stats` - Get invites/refunds stats

**Models Needed**:
```dart
class WalletBalance {
  final double total;
  final int invites;
  final double refunds;
}

class Transaction {
  final String id;
  final String type; // 'credit', 'debit'
  final double amount;
  final String description;
  final DateTime date;
}
```

### 5. Payment Methods

**Location**: `payment_methods_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/payment-methods` - List saved cards
- `POST /api/payment-methods` - Add new card
- `PUT /api/payment-methods/{id}` - Update card
- `DELETE /api/payment-methods/{id}` - Remove card
- `PATCH /api/payment-methods/{id}/default` - Set default card

**Security**: Use secure tokenization service (e.g., Stripe, Square)

### 6. Documents

**Location**: `documents_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/documents` - List user documents
- `POST /api/documents` - Upload document
- `GET /api/documents/{id}` - View document
- `DELETE /api/documents/{id}` - Delete document

**File Upload**: Implement multipart/form-data upload

### 7. Notifications

**Location**: `notifications_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/notifications` - List notifications
- `PATCH /api/notifications/{id}/read` - Mark as read
- `DELETE /api/notifications/{id}` - Delete notification

**Real-time**: Consider WebSocket for push notifications

### 8. Coupons & Loyalty

**Location**: `coupons_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/coupons` - List available coupons
- `POST /api/coupons/{id}/apply` - Apply coupon
- `GET /api/loyalty-cards` - List loyalty cards
- `GET /api/loyalty-cards/{id}` - Get loyalty card details

### 9. Help & Support

**Location**: `help_faq_screen.dart`, `help_contact_screen.dart`
**TODO**: Multiple locations

**Required Endpoints**:
- `GET /api/help/faq` - Get FAQ list
- `GET /api/help/policies` - Get policy list
- `GET /api/help/policies/{id}` - Get policy detail
- `POST /api/help/query` - Submit support query

### 10. Localization

**Location**: `language_selection_screen.dart`
**TODO**: Line ~30 in `_switchLanguage()`

**Required**:
- Implement `flutter_localizations`
- Add translation files (en.json, ar.json)
- Update app locale on language change

### 11. Theme Management

**Location**: `theme_selection_screen.dart`
**TODO**: Line ~30 in `_switchTheme()`

**Required**:
- Create ThemeController/Service
- Persist theme preference (SharedPreferences)
- Apply theme globally

## State Management Recommendations

### Controllers to Create

1. **ProfileController** (GetX)
   - Manage profile state
   - Handle profile updates
   - Avatar upload

2. **AddressController** (GetX)
   - Manage address list
   - CRUD operations
   - Default address selection

3. **WalletController** (GetX)
   - Manage wallet balance
   - Transaction history
   - Add money flow

4. **NotificationController** (GetX)
   - Manage notification list
   - Read/unread states
   - Real-time updates

5. **CouponController** (GetX)
   - Manage coupons list
   - Apply coupon logic
   - Loyalty card tracking

## Error Handling

All API calls should include:
- Loading states
- Error handling with user-friendly messages
- Retry logic for network failures
- Offline state handling

## Testing Checklist

- [ ] Profile update flow
- [ ] Address CRUD operations
- [ ] Wallet balance display
- [ ] Payment method management
- [ ] Document upload/view
- [ ] Notification display
- [ ] Coupon application
- [ ] Language switching
- [ ] Theme switching
- [ ] Account deletion flow

## Security Considerations

1. **Payment Cards**: Never store full card numbers, use tokenization
2. **Documents**: Encrypt sensitive documents
3. **Profile Data**: Validate and sanitize all inputs
4. **API Keys**: Store securely, never commit to repo
5. **Authentication**: Verify user session for all operations

