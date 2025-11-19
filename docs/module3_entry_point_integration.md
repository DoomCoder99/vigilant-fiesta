# Module 3: Entry Point Integration

## Overview

This document explains how Module 3 (Service Booking) integrates with the existing app flow, specifically how users navigate from **Amozit Landing Confirmed** (Module 2) into the service booking flow.

## Entry Point: Amozit Landing Confirmed Screen

### Current Implementation

The `AmozitLandingConfirmedScreen` already exists in Module 2 and includes a **Quick Services** section with 8 service cards:

1. Home maintenance
2. Cleaning & pest control
3. Sports & fitness
4. Rent a vehicle
5. Driving instructor
6. Women's salon & spa
7. Gas cylinder booking
8. Painting services

### Required Change

**File**: `lib/modules/shop/view/amozit_landing_confirmed_screen.dart`

**Method**: `_buildServiceCard()` or `_buildQuickServices()`

**Action**: Wire the "Home maintenance" service card to navigate to the Module 3 flow.

### Implementation

```dart
// In _buildServiceCard() method
Widget _buildServiceCard(
  BuildContext context,
  String name,
  IconData icon,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: () {
      // Check if this is "Home maintenance" service
      if (name.toLowerCase().contains('home maintenance')) {
        // Show Home Maintenance Categories modal
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => const HomeMaintenanceCategoriesScreen(),
        );
      } else {
        // For other services, use existing onTap handler
        onTap();
      }
    },
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 32, color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: 64,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
```

### Alternative: Direct Navigation

If preferred, navigate directly to the Electrical Services screen:

```dart
if (name.toLowerCase().contains('home maintenance')) {
  Navigator.of(context).pushNamed(
    AppRoutes.homeServicesElectrical,
    arguments: {'category': 'Home Maintenance'},
  );
}
```

## Flow Continuity

### From Module 2 → Module 3

```
Amozit Landing Confirmed (Module 2)
  ↓ [User taps "Home maintenance" service card]
Home Maintenance Categories (Module 3 - Modal)
  ↓ [User taps "Electrical" category]
Home Services - Electrical (Module 3)
  ↓ [Continue with Module 3 flow...]
```

### Back Navigation

Users can navigate back from Module 3 screens to Module 2 screens:

- **Home Maintenance Categories** → Close modal → Back to Amozit Landing Confirmed
- **Home Services - Electrical** → Back button → Back to Amozit Landing Confirmed
- **Service Detail** → Back button → Back to Home Services - Electrical
- **Add Location** → Back button → Back to Service Detail
- **Add Address** → Back button → Back to Add Location
- **Slot Selection** → Close drawer → Back to Add Address
- **Addons** → Close drawer → Back to Slot Selection

### Integration with Module 2 Components

Module 3 reuses the following Module 2 components:

1. **Cart Screen** (`CartScreen`)
   - Already handles both products and services
   - No changes needed

2. **Payment Method Screen** (`PaymentMethodScreen`)
   - Already handles payment for both products and services
   - No changes needed

3. **Payment Success Screen** (`PaymentSuccessScreen`)
   - Already handles success for both products and services
   - No changes needed

## Route Protection

**Current Status**: `AmozitLandingConfirmedScreen` is protected by `AuthGuard`

**Module 3 Screens**: All Module 3 screens should also be protected by `AuthGuard` since they require authentication:

```dart
// In main.dart routes
AppRoutes.homeMaintenanceCategories: (context) => const AuthGuard(
  child: HomeMaintenanceCategoriesScreen(),
),
AppRoutes.homeServicesElectrical: (context) => const AuthGuard(
  child: HomeServicesElectricalScreen(),
),
// ... etc for all Module 3 screens
```

## State Management Integration

### Cart Service Extension

The existing `CartService` from Module 2 should be extended to handle service items:

```dart
// In lib/modules/shop/services/cart_service.dart
class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final CartItemType type; // Product or Service
  
  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.type = CartItemType.product,
  });
}

enum CartItemType {
  product,
  service,
}
```

### Address Service (New)

Create a new service to manage addresses:

```dart
// In lib/core/services/address_service.dart
class AddressService extends ChangeNotifier {
  AddressService._();
  static final AddressService instance = AddressService._();
  
  Address? _selectedAddress;
  
  Address? get selectedAddress => _selectedAddress;
  
  void setSelectedAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }
  
  // TODO: Add methods to save/load addresses from storage
}
```

## Testing the Integration

### Test Flow

1. **Start**: Launch app → Sign in → Land on Amozit Landing Confirmed
2. **Navigate**: Scroll to Quick Services → Tap "Home maintenance"
3. **Verify**: Home Maintenance Categories modal appears
4. **Continue**: Tap "Electrical" → Verify navigation to Home Services - Electrical
5. **Complete Flow**: Complete the entire service booking flow
6. **Verify Cart**: Check that service items appear in cart
7. **Verify Payment**: Complete payment and verify success

### Edge Cases

1. **Back Navigation**: Ensure back navigation works correctly at each step
2. **Modal Dismissal**: Ensure modals can be dismissed by tapping outside or swiping down
3. **State Persistence**: Ensure selected service, address, and slot persist when navigating back
4. **Cart Integration**: Ensure service items are added to cart correctly
5. **Payment Integration**: Ensure payment flow works with service items

## Summary

- **Entry Point**: Amozit Landing Confirmed → "Home maintenance" service card
- **Navigation**: Modal bottom sheet for categories, full screen for service listing
- **Reused Components**: Cart, Payment Method, Payment Success (from Module 2)
- **New Components**: All service booking screens (Module 3 specific)
- **State Management**: Extend CartService, create AddressService
- **Route Protection**: All Module 3 screens protected by AuthGuard

