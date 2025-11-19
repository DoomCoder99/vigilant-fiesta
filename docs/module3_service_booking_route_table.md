# Module 3: Service Booking – Route Table & Flow

## Overview

Module 3 implements the **first-time service booking flow** where users:
1. Navigate from Amozit Landing Confirmed into Home Maintenance categories
2. Select Electrical services
3. Choose a service and configure details/add-ons
4. Add location & address (first time, no saved address)
5. Select slot
6. Review cart and pay
7. See payment success

## Route Table

| Logical Screen | Figma Frame(s) | Flutter Route Name | Widget Name | Module | Notes |
|----------------|----------------|-------------------|-------------|--------|-------|
| **Amozit Landing Confirmed** | 1-8220 | `/amozit-landing-confirmed` | `AmozitLandingConfirmedScreen` | Module 2 (Reused) | Entry point - already implemented |
| **Home Maintenance Categories** | 1-8459 | `/home-maintenance-categories` | `HomeMaintenanceCategoriesScreen` | Module 3 (New) | Modal/bottom sheet with category grid |
| **Home Services - Electrical** | 1-8479 | `/home-services-electrical` | `HomeServicesElectricalScreen` | Module 3 (New) | Main listing screen with expandable sections |
| **Home Services - Electrical (Collapsed)** | 1-8716 | `/home-services-electrical` | `HomeServicesElectricalScreen` | Module 3 (New) | Same screen, different state |
| **Quick Menu - Electrical** | 1-10299 | `/quick-menu-electrical` | `QuickMenuElectricalScreen` | Module 3 (New) | Quick menu drawer/modal |
| **Switch & Sockets Detail** | 1-8903 | `/service-detail` | `ServiceDetailScreen` | Module 3 (New) | Service detail with options (1 Switch, 2 Switches, etc.) |
| **Switch & Sockets Detail - Item Added** | 1-9156 | `/service-detail` | `ServiceDetailScreen` | Module 3 (New) | Same screen, "added to cart" state |
| **Add Location** | 1-9422 | `/add-location` | `AddLocationScreen` | Module 3 (New) | Map-based location picker |
| **Add Address** | 1-9488 | `/add-address` | `AddAddressScreen` | Module 3 (New) | Address form (City, Street, Landmark, House #) |
| **Add Address (Confirmation)** | 1-9703 | `/add-address` | `AddAddressScreen` | Module 3 (New) | Same screen, confirmation state |
| **Slot Selection** | 1-9576 | `/slot-selection` | `SlotSelectionScreen` | Module 3 (New) | Slot selection drawer (Immediate vs Schedule) |
| **Select Slot Drawer - Bool Slot (Variant 1)** | 1-10152 | `/slot-selection` | `SlotSelectionScreen` | Module 3 (New) | Drawer variant 1 |
| **Select Slot Drawer - Bool Slot (Variant 2)** | 1-10219 | `/slot-selection` | `SlotSelectionScreen` | Module 3 (New) | Drawer variant 2 |
| **Addons** | 1-9876 | `/addons` | `AddonsScreen` | Module 3 (New) | Add-ons drawer with product cards |
| **Addons - Added** | 1-10008 | `/addons` | `AddonsScreen` | Module 3 (New) | Same screen, "added" state |
| **My Cart - Services Only** | 1-10332 | `/cart` | `CartScreen` | Module 2 (Reused) | Reuses existing cart screen |
| **Payment Method - Blank** | 1-10441 | `/payment-method` | `PaymentMethodScreen` | Module 2 (Reused) | Reuses existing payment screen |
| **Add Card Details** | 1-10785 | `/add-card-details` | `AddCardDetailsScreen` | Module 3 (New) | Card entry form (can be modal) |
| **Payment Method - Card Added** | 1-10528 | `/payment-method` | `PaymentMethodScreen` | Module 2 (Reused) | Same screen, card added state |
| **Payment Success** | 1-10628 | `/payment-success` | `PaymentSuccessScreen` | Module 2 (Reused) | Reuses existing success screen |

## Navigation Flow

### Primary Flow: First-Time Service Booking

```
Amozit Landing Confirmed (Module 2)
  ↓ [Tap "Home Maintenance" service card]
Home Maintenance Categories (Modal)
  ↓ [Tap "Electrical" category]
Home Services - Electrical
  ↓ [Tap "Switch & Sockets" category OR tap service item]
Switch & Sockets Detail
  ↓ [Tap "Add" button]
Switch & Sockets Detail - Item Added
  ↓ [Tap "Add Location" button OR continue]
Add Location (Map picker)
  ↓ [Tap "Add Address" button]
Add Address
  ↓ [Fill form, tap "Continue To Select Slot"]
Slot Selection (Drawer)
  ↓ [Select slot, tap "Continue"]
Addons (Drawer) [Optional - can skip]
  ↓ [Tap "Continue" OR "Skip"]
My Cart - Services Only (Module 2)
  ↓ [Tap "Continue" / "Proceed to payment"]
Payment Method - Blank (Module 2)
  ↓ [Tap "Add Card" OR select existing]
Add Card Details [If adding new card]
  ↓ [Fill card details, save]
Payment Method - Card Added (Module 2)
  ↓ [Tap "Pay now"]
Payment Success (Module 2)
```

### Entry Point: Amozit Landing Confirmed → Service Booking

**Navigation Element**: "Home Maintenance" service card in Quick Services section

**Location**: `AmozitLandingConfirmedScreen._buildServiceCard()` method

**Current Implementation**: Needs to be wired to navigate to `/home-maintenance-categories`

**Required Change**:
```dart
// In _buildServiceCard() when service name is "Home maintenance"
onTap: () {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const HomeMaintenanceCategoriesScreen(),
  );
}
```

## Screen Categories

### New Screens (Module 3 Specific)
- Home Maintenance Categories
- Home Services - Electrical
- Quick Menu - Electrical
- Service Detail (Switch & Sockets)
- Add Location
- Add Address
- Slot Selection
- Addons
- Add Card Details

### Reused Screens (Module 2)
- Amozit Landing Confirmed (entry point)
- Cart (services only variant)
- Payment Method (blank and card added states)
- Payment Success

## Route Definitions Required

Add to `lib/core/routes/app_routes.dart`:

```dart
// Service Booking Module Routes
static const String homeMaintenanceCategories = '/home-maintenance-categories';
static const String homeServicesElectrical = '/home-services-electrical';
static const String quickMenuElectrical = '/quick-menu-electrical';
static const String serviceDetail = '/service-detail';
static const String addLocation = '/add-location';
static const String addAddress = '/add-address';
static const String slotSelection = '/slot-selection';
static const String addons = '/addons';
static const String addCardDetails = '/add-card-details';
```

## Implementation Notes

1. **Modal/Drawer Screens**: Several screens (Home Maintenance Categories, Quick Menu, Slot Selection, Addons) should be implemented as modal bottom sheets or drawers, not full-screen routes.

2. **State Management**: Service Detail, Add Address, and Addons screens have multiple states (default, added, confirmation). Use state management (setState or service) to handle these transitions.

3. **Location Services**: Add Location screen requires map integration. Use `google_maps_flutter` or similar package. For now, can be stubbed with a placeholder map.

4. **Cart Integration**: The existing `CartService` from Module 2 should be extended to handle service items in addition to product items.

5. **Address Management**: Consider creating an `AddressService` to manage saved addresses for future use (not first-time flow).

6. **Slot Selection**: The slot selection drawer should integrate with a backend service to fetch available slots. For now, can be stubbed with mock data.

