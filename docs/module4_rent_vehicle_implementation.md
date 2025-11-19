# Module 4: Rent a Vehicle - Implementation Guide

## Overview
Module 4 implements the external service booking flow for vehicle rentals, allowing users to browse vehicle categories, select specific vehicles, choose rental duration (hourly or daily), add optional extras, and complete the booking through the cart and payment system.

---

## MODULE 4 ROUTE TABLE

| Screen Name | Figma Frame | Figma URL | Flutter Route | Widget Class | Reuses Existing |
|------------|-------------|-----------|---------------|--------------|-----------------|
| **Rent a Vehicle Home** | 1-17745 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-17745) | `/rent-vehicle` | `RentVehicleScreen` | New |
| **Vehicle Category Listing (Sedans)** | 1-17971 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-17971) | `/rent-vehicle/category/:categoryId` | `VehicleCategoryListingScreen` | New |
| **Vehicle Detail** | 1-20093 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-20093) | `/rent-vehicle/vehicle/:vehicleId` | `VehicleDetailScreen` | New |
| **Date Selection** | 1-19326 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19326) | Drawer/Modal | `RentDatePickerDrawer` | New (Modal) |
| **Day-wise Rental (Blank)** | 1-19873 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19873) | `/rent-vehicle/duration/daily` | `DailyRentalSelectionScreen` | New |
| **Day-wise Rental (First Day)** | 1-18995 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18995) | (State of above) | (Same widget) | State variation |
| **Day-wise Rental (Last Day)** | 1-19651 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19651) | (State of above) | (Same widget) | State variation |
| **Hourly Rental (Blank)** | 1-19540 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19540) | `/rent-vehicle/duration/hourly` | `HourlyRentalSelectionScreen` | New |
| **Hourly Rental (Start Hour)** | 1-19215 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19215) | (State of above) | (Same widget) | State variation |
| **Hourly Rental (End Hour)** | 1-19427 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-19427) | (State of above) | (Same widget) | State variation |
| **Select Duration & Pickup** | 1-18238 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18238) | Drawer/Modal | `DurationPickupDrawer` | New (Modal) |
| **Add-ons Drawer (Blank)** | 1-18891 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18891) | Drawer/Modal | `VehicleAddOnsDrawer` | New (Modal) |
| **Add-ons Drawer (Added)** | 1-18936 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18936) | (State of above) | (Same widget) | State variation |
| **Cart (Services Only)** | 1-18311 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18311) | `/cart` | `CartScreen` | **Reuses Module 2/3** |
| **Payment Method** | 1-18395 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18395) | `/payment` | `PaymentMethodScreen` | **Reuses Module 2/3** |
| **Payment Success** | 1-18495 | [View](https://www.figma.com/design/xu7kp6yBV1qiPwK77Hq7tl/AMOZIT---Customer-App--New-?node-id=1-18495) | `/payment-success` | `PaymentSuccessScreen` | **Reuses Module 2** |

---

## USER JOURNEY FLOW

### Primary Flow
```
1. User lands on "Rent a Vehicle" home screen
   ├─ Sees vehicle category icons (Car, Van, 4x4, Jet ski, Yachts, Pick up)
   ├─ Sees promotional banners
   └─ Can select date range (default: 7 days shown)

2. User taps a category (e.g., "Cars" → "Sedans")
   ├─ Navigates to Vehicle Category Listing screen
   ├─ Shows filtered vehicles in that category
   └─ Each vehicle card shows: thumbnail, name, rating, price, "Rent vehicle" button

3. User taps "Rent vehicle" button on a vehicle card
   └─ Navigates to Vehicle Detail screen

4. User views Vehicle Detail
   ├─ Sees vehicle images (carousel)
   ├─ Views car details (Year, Seating, Transmission, Fuel, Engine)
   ├─ Reads description
   ├─ Reviews ratings & reviews
   └─ Taps "Continue" button at bottom

5. User selects rental duration
   ├─ Opens Duration selection screen/modal
   ├─ Chooses: Day-wise Rental OR Hourly Rental
   │
   ├─ If Day-wise:
   │   ├─ Selects start date (first day)
   │   ├─ Selects end date (last day)
   │   └─ System calculates total days & price
   │
   └─ If Hourly:
       ├─ Selects start hour
       ├─ Selects end hour
       └─ System calculates total hours & price

6. User selects pickup location
   ├─ Opens "Select Duration & Pickup Location" drawer
   ├─ Chooses from saved locations (Home, Work, etc.) or adds new
   └─ Confirms selection

7. User adds optional extras (Add-ons)
   ├─ Opens "Add-ons" drawer
   ├─ Views available extras:
   │   ├─ Sunglasses
   │   ├─ Child car seat
   │   └─ Car freshener
   ├─ Taps "add to cart" for desired items
   └─ Drawer updates to show added state

8. User proceeds to cart
   ├─ Navigates to Cart screen (reused from Module 2/3)
   ├─ Sees:
   │   ├─ "Rent a vehicle" section with vehicle & duration
   │   └─ "Shopping Cart" section with add-ons
   ├─ Can apply coupon codes
   ├─ Views payment summary (item total, platform fee, taxes, total)
   └─ Taps "Continue" button

9. User selects payment method
   ├─ Navigates to Payment Method screen (reused from Module 2/3)
   ├─ Chooses: Card, Wallet, Cash on Delivery
   └─ Confirms payment

10. Payment Success
    ├─ Navigates to Payment Success screen (reused from Module 2)
    ├─ Shows confirmation message
    ├─ Displays booking details
    └─ Offers options: "View Booking" or "Back to Home"
```

### Alternative Flows
- **Change Date Range**: User can tap "Change" button on date selector at any point before checkout
- **Filter/Sort**: User can use filter icon on category listing to refine vehicle selection
- **View All Categories**: User can expand/collapse categories on home screen using arrow icons
- **Skip Add-ons**: User can tap "Skip" on add-ons drawer to proceed without extras

---

## MODULE 4 ASSET INVENTORY

### A. Vehicle Category Icons (Home Screen)
These are circular icon images representing different vehicle types:

| Asset Name | Figma Node | Purpose | Export Size | Local Path |
|------------|-----------|---------|-------------|------------|
| Car Icon | image 9 (1:17791) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_car.png` |
| Van Icon | image 9 (1:17794) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_van.png` |
| 4x4 Icon | image 9 (1:17797) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_4x4.png` |
| Jet Ski Icon | image 9 (1:17800) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_jetski.png` |
| Yachts Icon | image 9 (1:17804) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_yachts.png` |
| Pickup Icon | image 9 (1:17807) | Category selector | 32×32 @ 2x-3x | `assets/rent_vehicle/categories/icon_pickup.png` |

**Figma URLs for Export:**
- Car: `https://www.figma.com/api/mcp/asset/4f7a964d-7b63-45b2-9d0e-94019b3ac0d8`
- Van: `https://www.figma.com/api/mcp/asset/7566b75b-d0a2-4bb2-8ac3-7a8bb1d0b340`
- 4x4: `https://www.figma.com/api/mcp/asset/ef66ed7e-0a73-4eeb-a12e-313b342bd5e3`
- Jet Ski: `https://www.figma.com/api/mcp/asset/695db48b-947f-4385-a571-5a671436638a`
- Yachts: `https://www.figma.com/api/mcp/asset/9ed2818e-aee0-46aa-913d-267cf9fef2ee`
- Pickup: `https://www.figma.com/api/mcp/asset/afdd46b6-38cb-4bbe-9765-d2c539f997be`

### B. Hero Banners (Home Screen)
Promotional carousel images:

| Asset Name | Figma Node | Purpose | Export Size | Local Path |
|------------|-----------|---------|-------------|------------|
| Services Banner | Rectangle 3 (1:17920) + Image | Promote services | 358×180 @ 2x-3x | `assets/rent_vehicle/banners/banner_services.png` |
| Vehicles Banner | Rectangle 3 (1:17938) | Promote vehicle rentals | 358×180 @ 2x-3x | `assets/rent_vehicle/banners/banner_vehicles.png` |
| Banner Decorator 1 | Ellipse 1293 (1:17933) | Banner decoration | Auto | (SVG or part of banner) |
| Banner Decorator 2 | Ellipse 1294 (1:17934) | Banner decoration | Auto | (SVG or part of banner) |
| Banner Decorator 3 | Ellipse 1295 (1:17935) | Banner decoration | Auto | (SVG or part of banner) |
| Banner Image | 34f4f4e5... (1:17936) | Banner graphic | Auto | `assets/rent_vehicle/banners/banner_graphic.png` |

**Figma URLs for Export:**
- Banner 1 Background: `https://www.figma.com/api/mcp/asset/0fcb5d32-bffc-4017-8347-016f104ebe09`
- Banner Graphic: `https://www.figma.com/api/mcp/asset/20bf908f-168e-4088-9a3a-e042063a6863`
- Decorator Ellipse 1: `https://www.figma.com/api/mcp/asset/ae9cc0e7-52ee-4238-bf32-c9483c1133aa`
- Decorator Ellipse 2: `https://www.figma.com/api/mcp/asset/a2761db1-9795-4280-a102-07cd2be18fe2`
- Decorator Ellipse 3: `https://www.figma.com/api/mcp/asset/37122a87-cdf2-4197-8046-0d33bae2d7f2`

### C. Vehicle Thumbnails (Listing Screen)
Rectangle images for vehicle cards:

| Asset Name | Figma Node | Purpose | Export Size | Local Path |
|------------|-----------|---------|-------------|------------|
| Toyota Camry Thumb | Rectangle 3463387 (1:18016) | Sedan listing card | 72×72 @ 2x-3x | `assets/rent_vehicle/vehicles/thumb_toyota_camry.png` |
| Hyundai Sonata Thumb | Rectangle 3463388 (1:18031) | Sedan listing card | 72×72 @ 2x-3x | `assets/rent_vehicle/vehicles/thumb_hyundai_sonata.png` |
| Kia K3 Thumb | Rectangle 3463389 (1:18046) | Sedan listing card | 72×72 @ 2x-3x | `assets/rent_vehicle/vehicles/thumb_kia_k3.png` |
| Toyota Camry Thumb 2 | Rectangle 3463390 (1:18061) | Sedan listing card | 72×72 @ 2x-3x | `assets/rent_vehicle/vehicles/thumb_toyota_camry_2.png` |

**Figma URLs for Export:**
- Toyota Camry: `https://www.figma.com/api/mcp/asset/0377f71a-5793-4386-a0f7-33791c042dd5`
- Hyundai Sonata: `https://www.figma.com/api/mcp/asset/2ff7d7e4-0a4d-4483-9393-75f0c9ad99b5`
- Kia K3: `https://www.figma.com/api/mcp/asset/838cb3bc-dd2f-49f2-8e8f-70006db4dd17`
- Toyota Camry 2: `https://www.figma.com/api/mcp/asset/b2c90883-d246-4014-96aa-ce86c58d5152`

### D. Vehicle Hero Images (Detail Screen)
Large banner images for vehicle detail carousel:

| Asset Name | Figma Node | Purpose | Export Size | Local Path |
|------------|-----------|---------|-------------|------------|
| Vehicle Hero Image | Rectangle 3 (1:20287) | Detail screen carousel | 358×180 @ 2x-3x | `assets/rent_vehicle/vehicles/hero_vehicle_detail.png` |

**Figma URL for Export:**
- Hero Image: `https://www.figma.com/api/mcp/asset/542b47c7-793f-41b6-83d5-03ba98e2936e`

### E. Add-on Product Images
Thumbnails for optional extras:

| Asset Name | Figma Node | Purpose | Export Size | Local Path |
|------------|-----------|---------|-------------|------------|
| Sunglasses | Frame 1171275522 (1:18897) | Add-on product image | 102×102 @ 2x-3x | `assets/rent_vehicle/addons/addon_sunglasses.png` |
| Child Car Seat | Frame 1171275520 (1:18910) | Add-on product image | 102×102 @ 2x-3x | `assets/rent_vehicle/addons/addon_car_seat.png` |
| Car Freshener | Frame 1171275517 (1:18924) | Add-on product image | 102×102 @ 2x-3x | `assets/rent_vehicle/addons/addon_freshener.png` |

**Note**: Add-on images need to be identified and exported from frames 1:18897, 1:18910, 1:18924

### F. System Icons (Reused from Global Design System)
These icons are already available in the project:

| Icon | Purpose | Screens Used |
|------|---------|--------------|
| `arrow-left` | Back navigation | All screens |
| `discover_tune` | Filter/settings | Home, Listing |
| `calendar_clock` | Date/time selector | Home, Listing, Detail |
| `share` | Share vehicle | Detail |
| `chevron_forward` | Navigate forward | Detail (Continue button) |
| `star` | Rating indicator | All screens |
| `sheild` (verified badge) | Amozit Verified label | Home, Listing, Detail |
| `close_small` | Close modal/drawer | Date picker, Duration, Add-ons |
| `keyboard_arrow_up/down` | Expand/collapse | Home (categories) |
| `radio_button_checked/unchecked` | Selection | Duration, Pickup location |

---

## INTEGRATION WITH EXISTING APP

### Entry Points to Module 4

1. **From Explore/Home Screen**:
   - User taps on "Rent a Vehicle" card/button
   - Navigates to: `/rent-vehicle`

2. **From Service Categories**:
   - "Rent a Vehicle" appears as an external service option
   - Navigates to: `/rent-vehicle`

3. **From Search Results**:
   - Vehicle rental results can appear in global search
   - Tapping result navigates to specific vehicle detail: `/rent-vehicle/vehicle/:vehicleId`

### Exit Points from Module 4

1. **Successful Booking**:
   - After payment success, user can:
     - Tap "View Booking" → Navigate to bookings/orders list
     - Tap "Back to Home" → Navigate to main app home (`/explore` or `/`)

2. **Cancel/Back**:
   - Back button on any screen returns to previous screen
   - From home screen, back returns to previous entry point

3. **Cart Integration**:
   - Vehicle rentals add to shared cart (Module 2/3)
   - Cart can contain both vehicles and shop products simultaneously
   - Cart icon in app bar shows badge with item count

### Data Flow

**State Management** (GetX/Bloc as per WDI):
```
RentVehicleController/Bloc:
  - selectedCategory: String?
  - selectedVehicle: Vehicle?
  - rentalType: 'daily' | 'hourly'
  - startDate: DateTime?
  - endDate: DateTime?
  - startHour: int?
  - endHour: int?
  - pickupLocation: Location?
  - selectedAddOns: List<AddOn>
  - totalPrice: double

CartController/Bloc (shared):
  - vehicleBookings: List<VehicleBooking>
  - shopItems: List<ShopItem>
  - addOns: List<AddOn>
  - couponCode: String?
  - totalAmount: double
```

**API Endpoints** (examples, to be confirmed):
```
GET  /api/v1/rent-vehicle/categories
GET  /api/v1/rent-vehicle/vehicles?category={id}
GET  /api/v1/rent-vehicle/vehicles/{id}
GET  /api/v1/rent-vehicle/addons
GET  /api/v1/locations
POST /api/v1/cart/add-vehicle
POST /api/v1/bookings/vehicle
```

### Shared Components/Patterns

Module 4 reuses these existing patterns:

1. **Cart Screen** (Module 2/3):
   - Layout: Item sections, payment summary, coupon field
   - Behavior: Add/remove items, quantity controls, proceed to payment

2. **Payment Flow** (Module 2/3):
   - Payment method selection
   - Card input forms
   - Payment processing
   - Success/failure screens

3. **Location Picker** (Module 1?):
   - If location access module exists, reuse picker UI
   - Show saved locations, add new location

4. **Date/Time Pickers**:
   - Calendar widget for date range selection
   - Time picker for hourly rental
   - Custom styling as per design system

---

## IMPLEMENTATION CHECKLIST

### Phase 1: Setup & Assets
- [ ] Create folder structure: `lib/modules/rent_vehicle/`
- [ ] Download and place all assets in `assets/rent_vehicle/`
- [ ] Update `pubspec.yaml` with asset paths
- [ ] Verify all asset files are correctly referenced

### Phase 2: Data Models
- [ ] Create `Vehicle` model
- [ ] Create `VehicleCategory` model
- [ ] Create `RentalBooking` model
- [ ] Create `AddOn` model
- [ ] Create `Location` model (or import if exists)

### Phase 3: State Management
- [ ] Create `RentVehicleController` or `RentVehicleBloc`
- [ ] Implement vehicle listing logic
- [ ] Implement duration selection logic
- [ ] Implement add-on selection logic
- [ ] Integrate with shared `CartController/Bloc`

### Phase 4: UI Implementation (Screens)
- [ ] Implement `RentVehicleScreen` (home)
- [ ] Implement `VehicleCategoryListingScreen`
- [ ] Implement `VehicleDetailScreen`
- [ ] Implement `DailyRentalSelectionScreen`
- [ ] Implement `HourlyRentalSelectionScreen`

### Phase 5: UI Implementation (Modals/Drawers)
- [ ] Implement `RentDatePickerDrawer`
- [ ] Implement `DurationPickupDrawer`
- [ ] Implement `VehicleAddOnsDrawer`

### Phase 6: Navigation & Integration
- [ ] Add routes to `app_routes.dart`
- [ ] Wire up navigation handlers
- [ ] Test deep linking to vehicle details
- [ ] Integrate entry points from main app

### Phase 7: Cart & Payment Integration
- [ ] Test adding vehicle to cart
- [ ] Test cart with mixed items (vehicles + shop products)
- [ ] Test payment flow with vehicle bookings
- [ ] Verify payment success navigation

### Phase 8: Testing & Polish
- [ ] Test all user flows end-to-end
- [ ] Test error states (network, invalid selections)
- [ ] Test empty states (no vehicles available)
- [ ] Verify design fidelity (spacing, colors, fonts)
- [ ] Test on both Android and iOS
- [ ] Fix any linter errors

---

## DESIGN FIDELITY NOTES

### Colors (from Figma variable defs)
- Primary: `#7132F4` (purple for buttons, links)
- Black: `#162028` (text)
- Light Grey: `#D6DEE8` (borders, dividers)
- White: `#FFFFFF` (backgrounds)

### Typography
- Header: Product Sans Bold, 18px
- Title: Figtree SemiBold, 14px
- Body: Figtree Regular, 10-12px
- Caption: Figtree Regular, 8px

### Spacing
- Screen padding: 25px
- Card padding: 16px
- Element gap: 8-12px
- Button height: 28-52px

### Interaction States
- Buttons: 
  - Primary: `#7132F4` background, white text
  - Secondary: White background, `#7132F4` border and text
  - Disabled: Reduced opacity
- Selection indicators:
  - Radio buttons for single choice
  - Checkboxes or toggle for add-ons
  - Date/time cells highlight on selection

---

## QUESTIONS FOR USER/PM

Before proceeding with full implementation, clarify:

1. **API Contracts**:
   - What are the exact API endpoints and response formats?
   - How is vehicle availability checked in real-time?
   - How are pricing calculations handled (server vs client)?

2. **Business Logic**:
   - Minimum/maximum rental duration rules?
   - Hourly rental time restrictions (e.g., must be during business hours)?
   - Can user book multiple vehicles in one cart?
   - Cancellation policy and refund logic?

3. **Location Handling**:
   - Is pickup location required or optional?
   - Can user add a new location, or only choose from saved?
   - Is delivery/drop-off location also needed?

4. **Payment**:
   - Is payment required upfront or on pickup?
   - Are there deposits or security fees?
   - How are add-ons billed (separate or bundled)?

5. **Fallbacks**:
   - What happens if selected vehicle becomes unavailable during checkout?
   - Error messages for common failure scenarios?

---

## NOTES

- **Asset Export**: Use Figma's export feature with 2x and 3x scales for mobile.
- **Image Optimization**: Compress all assets before adding to project (use tools like TinyPNG).
- **Responsive Design**: All layouts should adapt to different screen sizes (phones, tablets).
- **Accessibility**: Ensure sufficient color contrast, semantic labels, and tap target sizes.
- **Performance**: Lazy-load vehicle images, cache category icons, optimize list scrolling.

---

## Summary

Module 4 introduces **16 screens** (including state variations) for vehicle rental booking. Key deliverables:

1. **Route Table**: 16 screens mapped to Flutter routes and widgets
2. **Asset Inventory**: 30+ image assets categorized by type and usage
3. **User Journey**: Detailed flow from browsing to payment success
4. **Integration Plan**: Clear entry/exit points and shared component reuse
5. **Implementation Checklist**: Phased approach to building the module

**Next Steps**:
1. Download and organize all assets into `assets/rent_vehicle/`
2. Update `pubspec.yaml` with asset paths
3. Begin implementation with Phase 1-2 (setup & models)
4. Proceed to UI implementation following WDI standards

