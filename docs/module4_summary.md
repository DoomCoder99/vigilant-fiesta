# Module 4: Rent a Vehicle - Summary & Deliverables

## Executive Summary

This document summarizes the analysis and deliverables for **Module 4: Service Booking – External (Rent a Vehicle)** of the AMOZIT Customer App.

**Analysis Date**: November 18, 2025  
**Figma File**: AMOZIT - Customer App (New)  
**Screens Analyzed**: 16 screens (including state variations)  
**Assets Identified**: 22+ unique images

---

## 📋 DELIVERABLES

### 1. **Module 4 Route Table** 
**File**: `docs/module4_rent_vehicle_implementation.md`

A comprehensive table mapping all 16 Figma screens to:
- Flutter route names
- Widget class names  
- Figma frame URLs
- Reusability indicators (new vs reused components)

**Key Screens**:
- Rent a Vehicle Home → `/rent-vehicle`
- Vehicle Category Listing → `/rent-vehicle/category/:categoryId`
- Vehicle Detail → `/rent-vehicle/vehicle/:vehicleId`
- Duration Selection (Daily/Hourly) → `/rent-vehicle/duration/:type`
- Add-ons Drawer → Modal component
- Cart, Payment, Success → Reuses existing Module 2/3 screens

---

### 2. **Complete Asset Inventory**
**Files**: 
- `docs/module4_rent_vehicle_implementation.md` (detailed list)
- `docs/module4_asset_download_list.md` (download URLs)

**Assets Identified**:

| Category | Count | Location |
|----------|-------|----------|
| Vehicle Category Icons | 6 | `assets/rent_vehicle/categories/` |
| Hero Banners | 5 | `assets/rent_vehicle/banners/` |
| Vehicle Thumbnails | 4 | `assets/rent_vehicle/vehicles/` |
| Vehicle Hero Images | 1 | `assets/rent_vehicle/vehicles/` |
| Add-on Product Images | 3* | `assets/rent_vehicle/addons/` |
| System Icons | ~10 | (Reused from global) |

*Add-on images require further extraction from Figma

**All assets include**:
- Figma node IDs
- Direct download URLs (valid for 7 days)
- Local file paths  
- Recommended export sizes

---

### 3. **User Journey & Navigation Flow**
**File**: `docs/module4_rent_vehicle_implementation.md` (Section: USER JOURNEY FLOW)

Detailed 10-step booking flow:
```
Browse Categories → Select Vehicle → View Details → 
Choose Duration (Daily/Hourly) → Select Pickup Location → 
Add Optional Extras → Review Cart → Select Payment → 
Complete Booking → View Success
```

**Includes**:
- Primary flow diagram
- Alternative flows (cancel, change date, skip add-ons)
- Entry points from main app
- Exit points after completion
- Navigation patterns

---

### 4. **Download Scripts**
**File**: `scripts/download_module4_assets.ps1`

Automated PowerShell script to download all 16 assets in one command:
```powershell
./scripts/download_module4_assets.ps1
```

**Features**:
- Creates folder structure automatically
- Downloads all assets with progress indicators
- Provides next-step instructions
- Color-coded output for easy tracking

---

### 5. **Implementation Checklist**
**File**: `docs/module4_rent_vehicle_implementation.md` (Section: IMPLEMENTATION CHECKLIST)

8-phase implementation plan:
1. Setup & Assets
2. Data Models
3. State Management
4. UI Implementation (Screens)
5. UI Implementation (Modals/Drawers)
6. Navigation & Integration
7. Cart & Payment Integration
8. Testing & Polish

Each phase includes specific tasks with checkboxes.

---

## 🔗 NAVIGATION INTEGRATION

### How Module 4 Connects to the Rest of the App

**Entry Points**:
1. From Explore/Home screen → "Rent a Vehicle" card
2. From Service Categories → External services list
3. From Search Results → Direct to vehicle detail

**Exit Points**:
1. After successful booking:
   - "View Booking" → Navigate to orders/bookings list
   - "Back to Home" → Return to main app home
2. Cancel/Back buttons → Return to previous screen
3. Cart integration → Shared cart with shop products

**Reused Components**:
- Cart Screen (Module 2/3)
- Payment Method Screen (Module 2/3)
- Payment Success Screen (Module 2)
- Location Picker (if exists in Module 1)

---

## 📊 DESIGN SYSTEM ADHERENCE

### Colors (from Figma Variables)
- **Primary Purple**: `#7132F4` (buttons, links, accents)
- **Black**: `#162028` (primary text)
- **Light Grey**: `#D6DEE8` (borders, dividers)
- **White**: `#FFFFFF` (backgrounds, button text)

### Typography
- **Headers**: Product Sans Bold, 18px
- **Titles**: Figtree SemiBold, 14px
- **Body**: Figtree Regular, 10-12px
- **Captions**: Figtree Regular, 8px

### Layout
- **Screen Padding**: 25px horizontal
- **Card Padding**: 16px
- **Element Gaps**: 8-12px
- **Button Heights**: 28px (secondary), 52px (primary)

---

## ⚠️ IMPORTANT NOTES

### 1. Asset Expiry
**Action Required**: Figma MCP asset URLs expire after 7 days!
- ✅ Download assets immediately using provided script
- ✅ Commit assets to version control
- ❌ Do NOT rely on Figma URLs in production code

### 2. Missing Assets
**Add-on Product Images** (3 items) need manual export:
- Sunglasses (Node 1:18897)
- Child Car Seat (Node 1:18910)
- Car Freshener (Node 1:18924)

**Options**:
- Use Figma's direct export (right-click frame → Export PNG)
- Call `get_design_context` on add-on drawer frame
- Use temporary placeholders until export complete

### 3. Additional Vehicle Categories
Current analysis covers **Sedans** only. If implementing all categories:
- Hatchbacks
- 6 Seaters
- Premium Cars
- Vans
- 4x4
- Jet Skis
- Yachts
- Pickups

Additional thumbnails need to be exported for each category's vehicles.

---

## 🚀 NEXT STEPS

### Immediate (Day 1)
1. ✅ **Download Assets**  
   Run: `./scripts/download_module4_assets.ps1`

2. ✅ **Update pubspec.yaml**  
   Add asset paths:
   ```yaml
   flutter:
     assets:
       - assets/rent_vehicle/categories/
       - assets/rent_vehicle/banners/
       - assets/rent_vehicle/vehicles/
   ```

3. ✅ **Verify Assets**  
   Run: `flutter pub get`

### Short-term (Week 1)
4. **Create Data Models**  
   - `Vehicle`, `VehicleCategory`, `RentalBooking`, `AddOn`, `Location`

5. **Setup State Management**  
   - `RentVehicleController` or `RentVehicleBloc`
   - Integrate with existing `CartController`

6. **Implement Core Screens**  
   - Rent Vehicle Home
   - Vehicle Listing
   - Vehicle Detail

### Mid-term (Week 2-3)
7. **Implement Duration Selection**  
   - Daily rental calendar
   - Hourly rental picker
   - Pickup location selector

8. **Implement Add-ons Flow**  
   - Add-ons drawer
   - Cart integration

9. **Wire Up Navigation**  
   - Add routes to `app_routes.dart`
   - Connect entry points from main app

### Long-term (Week 4)
10. **Payment Integration**  
    - Test vehicle booking through existing payment flow
    - Verify mixed cart (vehicles + products)

11. **Testing & Polish**  
    - End-to-end flow testing
    - Error state handling
    - Design fidelity fixes

---

## 📝 QUESTIONS FOR CLARIFICATION

Before proceeding with full implementation, confirm:

### API & Backend
1. What are the exact API endpoints for:
   - Fetching vehicle categories?
   - Fetching vehicles by category?
   - Checking vehicle availability?
   - Creating vehicle bookings?

2. How is pricing calculated?
   - Server-side or client-side?
   - Dynamic pricing based on demand?
   - Separate pricing for add-ons?

### Business Logic
3. Rental duration rules:
   - Minimum rental period (hours/days)?
   - Maximum rental period?
   - Time slot restrictions (e.g., no overnight for hourly)?

4. Booking policies:
   - Can user book multiple vehicles in one cart?
   - Deposit or security fee required?
   - Cancellation policy and refunds?

### User Experience
5. Location handling:
   - Is pickup location mandatory?
   - Can user add new locations, or only choose from saved?
   - Is drop-off location also needed?

6. Availability:
   - What happens if selected vehicle becomes unavailable during checkout?
   - How to handle "sold out" or "not available" states?

---

## 📂 FILE STRUCTURE

```
docs/
├── module4_rent_vehicle_implementation.md    # Main implementation guide
├── module4_asset_download_list.md            # Asset URLs and download instructions
└── module4_summary.md                        # This file

scripts/
└── download_module4_assets.ps1               # Automated download script

assets/rent_vehicle/                          # (To be created)
├── categories/                               # 6 vehicle category icons
├── banners/                                  # 5 promotional banner images
├── vehicles/                                 # 5 vehicle photos (thumbs + hero)
└── addons/                                   # 3 add-on product images (TBD)
```

---

## ✅ QUALITY CHECKLIST

Before considering Module 4 complete:

### Design Fidelity
- [ ] All colors match Figma hex values exactly
- [ ] Typography matches (font family, size, weight)
- [ ] Spacing matches design (±2dp tolerance)
- [ ] Images are not stretched or distorted
- [ ] Rounded corners and shadows match design

### Functionality
- [ ] All navigation flows work correctly
- [ ] Date/time pickers function properly
- [ ] Cart correctly handles vehicle bookings
- [ ] Payment flow completes successfully
- [ ] Booking confirmation appears after payment

### Code Quality (WDI Standards)
- [ ] Follows WDI folder structure
- [ ] Uses GetX or Bloc as specified
- [ ] API calls follow WDI pattern (ApiService, ApiType enum)
- [ ] Error handling implemented
- [ ] No business logic in UI widgets
- [ ] Const constructors used where possible

### Testing
- [ ] Widget tests for each screen
- [ ] Unit tests for controllers/blocs
- [ ] Integration tests for full booking flow
- [ ] Tested on both Android and iOS
- [ ] No linter errors or warnings

---

## 📞 SUPPORT & QUESTIONS

For questions or clarifications about this module:

1. **Design Questions**: Reference specific Figma frame URLs provided in `module4_rent_vehicle_implementation.md`

2. **Asset Issues**: If URLs expire or assets fail to download, call `get_design_context` on the frame again to get fresh URLs

3. **Implementation Guidance**: Follow WDI Flutter Coding Standards as provided in `WDI_Flutter_Coding_Standard_Guide.txt`

4. **Navigation Questions**: Reference existing modules (1-3) for consistent patterns

---

## 🎯 SUCCESS CRITERIA

Module 4 is considered complete when:

1. ✅ All 16 screens are implemented and match Figma designs
2. ✅ All assets are downloaded, optimized, and integrated
3. ✅ Full booking flow works end-to-end (browse → select → book → pay → confirm)
4. ✅ Cart correctly handles mixed items (vehicles + shop products)
5. ✅ Payment integration works seamlessly with existing flow
6. ✅ All navigation entry/exit points are wired up
7. ✅ Code passes linting and follows WDI standards
8. ✅ Tests are written and passing

---

## 📚 RELATED DOCUMENTATION

- **Agent Rules**: See `AGENTS.md` for coding standards and patterns
- **WDI Standards**: See `WDI_Flutter_Coding_Standard_Guide.txt`
- **Design System**: Created via `create_design_system_rules` (Module 0)
- **Module 2 (Shop)**: Reference for cart and payment patterns
- **Module 3 (Service Booking)**: Reference for booking flow patterns

---

**Document Version**: 1.0  
**Last Updated**: November 18, 2025  
**Status**: Analysis Complete, Ready for Implementation

