# AMOZIT Customer App - Gap Analysis Report
**Generated:** November 19, 2025  
**Status:** Initial Analysis (Awaiting Figma file for complete comparison)

---

## 1. Missing Backend Integration (Critical)

### 1.1 No Centralized API Service
**Status:** ❌ **CRITICAL - BLOCKING PRODUCTION**

The project does **NOT** have a centralized `ApiService` as required by WDI Flutter Coding Standards.

**WDI Standard Requirement:**
```dart
enum ApiType { get, post, put, delete }
class ApiService {
  static const String baseUrl = "https://api.example.com/";
  static Future<dynamic> callApi({
    required String endpoint,
    required ApiType type,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async { ... }
}
```

**Current State:** This class does not exist anywhere in the project.

**Impact:** All modules are using mock/placeholder data and cannot function with real backend.

**Location for Implementation:** `lib/core/services/api_service.dart` (needs to be created)

---

### 1.2 Module-Specific Backend Integration Gaps

#### Authentication Module
**Files Affected:**
- `lib/core/services/auth_service.dart`
- `lib/modules/sign_in/controller/sign_in_controller.dart`
- `lib/modules/registration/controller/registration_controller.dart`
- `lib/modules/otp/controller/otp_controller.dart`
- `lib/modules/forgot_password/view/forgot_password_screen.dart`
- `lib/modules/create_password/view/create_password_screen.dart`

**Current State:**
- Uses hardcoded test credentials
- No actual API integration
- Mock authentication with `Future.delayed()` simulating API calls

**TODO Items Found:**
```dart
// lib/core/services/auth_service.dart:9
// TODO: Replace with actual API integration using WDI-approved ApiService pattern.

// Line 48:
// TODO: Replace with actual API call using WDI-approved ApiService pattern.
```

**Required Endpoints:**
1. `POST /auth/register` - User registration
2. `POST /auth/verify-otp` - OTP verification
3. `POST /auth/login` - User login
4. `POST /auth/forgot-password` - Forgot password
5. `POST /auth/reset-password` - Reset password with OTP
6. `POST /auth/logout` - User logout

---

#### Shop Module
**Files Affected:**
- `lib/modules/shop/repository/order_repository.dart`
- `lib/modules/shop/repository/invoice_repository.dart`
- `lib/modules/shop/repository/tracking_repository.dart`
- `lib/modules/shop/services/cart_service.dart`

**Current State:**
- All repositories return mock/empty data
- No actual API calls

**TODO Items Found:**
```dart
// lib/modules/shop/repository/order_repository.dart:18
// TODO: Implement actual API call using WDI-approved ApiService pattern

// Multiple TODOs for:
// - cancelOrder (line 18)
// - getOrderById (line 50)
// - getOrders (line 66)
```

**Required Endpoints:**
1. `GET /products` - Product listing
2. `GET /products/{id}` - Product details
3. `GET /categories` - Categories
4. `POST /cart/add` - Add to cart
5. `GET /cart` - Get cart
6. `POST /orders` - Create order
7. `GET /orders` - Get user orders
8. `GET /orders/{id}` - Order details
9. `POST /orders/{id}/cancel` - Cancel order
10. `GET /orders/{id}/tracking` - Order tracking
11. `GET /orders/{id}/invoice` - Order invoice

---

#### Rent Vehicle Module
**Files Affected:**
- `lib/modules/rent_vehicle/controller/rent_vehicle_controller.dart`
- `lib/modules/rent_vehicle/controller/rent_cart_controller.dart`
- `lib/modules/rent_vehicle/controller/rental_duration_controller.dart`

**Current State:**
- Uses hardcoded mock data for vehicles
- No backend integration for booking, payment, or rental management

**Required Endpoints:**
1. `GET /vehicles` - List available vehicles
2. `GET /vehicles/{id}` - Vehicle details
3. `GET /vehicles/availability` - Check availability
4. `POST /rentals` - Create rental booking
5. `GET /rentals` - Get user rentals
6. `POST /rentals/{id}/cancel` - Cancel rental

---

#### Notifications Module
**Files Affected:**
- `lib/data/repository/notification_repository.dart`
- `lib/modules/profile/controller/notification_controller.dart`

**Current State:**
- Returns hardcoded mock notifications
- Settings stored locally (not synced with backend)

**TODO Items Found:**
```dart
// lib/data/repository/notification_repository.dart:15
// TODO: Replace mock data with actual API call using ApiService.callApi

// Line 78:
// TODO: Replace with actual API call

// Line 99:
// TODO: Replace with SharedPreferences or secure storage for persistence

// Line 114:
// TODO: Sync with backend API
```

**Required Endpoints:**
1. `GET /notifications` - Get notifications
2. `PUT /notifications/{id}/read` - Mark as read
3. `PUT /notifications/read-all` - Mark all as read
4. `GET /notification-settings` - Get settings
5. `PUT /notification-settings` - Update settings

---

#### Search Module
**Files Affected:**
- `lib/modules/search/repository/search_repository.dart`
- `lib/modules/search/controller/search_controller.dart`

**Current State:**
- Uses hardcoded mock search results
- No actual search API integration

**Required Endpoints:**
1. `GET /search?q={query}&category={category}` - Search

---

#### Subscription Module
**Files Affected:**
- `lib/modules/subscription/data/repository/subscription_repository.dart`
- `lib/modules/subscription/controller/subscription_category_controller.dart`
- `lib/modules/subscription/controller/subscription_detail_controller.dart`
- `lib/modules/subscription/controller/subscription_cart_controller.dart`

**Current State:**
- Uses hardcoded mock data for venues and subscriptions
- No backend integration

**Required Endpoints:**
1. `GET /subscriptions/categories` - Subscription categories
2. `GET /subscriptions/venues` - Venue listings
3. `GET /subscriptions/venues/{id}` - Venue details
4. `POST /subscriptions/purchase` - Purchase subscription

---

#### Support Chat Module
**Files Affected:**
- `lib/modules/support_chat/repository/support_repository.dart`
- `lib/modules/support_chat/controller/support_chat_controller.dart`

**Current State:**
- Uses mock chat messages
- No actual chat backend/WebSocket integration

**Required Integration:**
1. WebSocket connection for real-time chat
2. `GET /support/history` - Chat history
3. `POST /support/message` - Send message
4. File upload for attachments

---

#### Profile Module
**Files Affected:**
- `lib/modules/profile/view/profile_edit_screen.dart`
- `lib/modules/profile/view/addresses_screen.dart`
- `lib/modules/profile/view/payment_methods_screen.dart`
- `lib/modules/profile/view/wallet_screen.dart`
- `lib/modules/profile/view/documents_screen.dart`
- `lib/modules/profile/view/coupons_screen.dart`

**Current State:**
- All screens display placeholder/static data
- No backend integration for profile management

**Required Endpoints:**
1. `GET /profile` - Get user profile
2. `PUT /profile` - Update profile
3. `DELETE /profile` - Delete account
4. `GET /addresses` - Get addresses
5. `POST /addresses` - Add address
6. `PUT /addresses/{id}` - Update address
7. `DELETE /addresses/{id}` - Delete address
8. `GET /payment-methods` - Get payment methods
9. `POST /payment-methods` - Add payment method
10. `DELETE /payment-methods/{id}` - Remove payment method
11. `GET /wallet` - Get wallet balance/transactions
12. `GET /documents` - Get documents
13. `GET /coupons` - Get user coupons

---

#### Service Booking Module
**Files Affected:**
- `lib/modules/service_booking/view/*` (8 screens)

**Current State:**
- No repository or service layer exists
- Screens are purely UI with no data integration

**Required Endpoints:**
1. `GET /services/categories` - Service categories
2. `GET /services` - Service listings
3. `GET /services/{id}` - Service details
4. `GET /services/{id}/addons` - Service addons
5. `GET /services/slots` - Available time slots
6. `POST /service-bookings` - Create booking
7. `GET /service-bookings` - Get user bookings

---

## 2. Missing Screens / Incomplete Modules

### 2.1 Module-Level Gaps

#### Missing Modules (Based on Routes)
The following routes exist in `app_routes.dart` but have no corresponding screen implementations:

1. **Amozit Landing (Confirmed State)**
   - Route: `/amozit-landing-confirmed`
   - File: `lib/modules/shop/view/amozit_landing_confirmed_screen.dart` ✅ EXISTS
   - Status: **Implemented**

2. **Wishlist Module** 
   - Route: `/wishlist`
   - File: `lib/modules/shop/view/wishlist_screen.dart` ✅ EXISTS
   - Status: **Implemented**

3. **Invoice Screen**
   - Route: `/invoice`
   - File: `lib/modules/shop/view/invoice_screen.dart` ✅ EXISTS
   - Status: **Implemented**

### 2.2 Screens Missing Controller/Logic

The following screens exist but lack proper controller/business logic:

1. **Forgot Password Screen**
   - File: `lib/modules/forgot_password/view/forgot_password_screen.dart` ✅
   - Controller: ❌ Missing `lib/modules/forgot_password/controller/forgot_password_controller.dart`
   - Impact: No state management for forgot password flow

2. **Service Booking Screens** (All 8 screens)
   - No controllers exist for any service booking screen
   - No state management
   - Purely static UI

3. **Explore Screen**
   - File: `lib/modules/explore/view/explore_screen.dart` ✅
   - Controller: ❌ Missing
   - Impact: No data fetching or state management

---

## 3. Missing Assets / Design Elements

### 3.1 Payment Method Assets (Rent Vehicle Module)
**File:** `lib/modules/rent_vehicle/view/rent_payment_method_screen.dart`

**Missing Assets:**
```
assets/rent_vehicle/payment/mastercard.png
assets/rent_vehicle/payment/amazon_pay.png
assets/rent_vehicle/payment/net_banking.png
assets/rent_vehicle/payment/cash.png
assets/rent_vehicle/payment/add_card.png
assets/rent_vehicle/payment/radio_unchecked.png
assets/rent_vehicle/icons/add_icon.png
assets/rent_vehicle/icons/chevron_forward.png
```

**Fallback:** Screen uses `errorBuilder` to show generic icons if assets missing.

### 3.2 Asset Validation Needed
Cannot validate full asset coverage without Figma file access. Need to:
1. Compare each screen's design with implemented assets
2. Verify icon consistency
3. Check image quality and resolutions

---

## 4. Design Fidelity Issues

### 4.1 Hardcoded Colors
**Violation:** WDI Standards require design tokens

**Files with Inline Colors:**
- `lib/modules/rent_vehicle/view/rent_payment_method_screen.dart`
  - Uses hardcoded hex colors: `0xFF162028`, `0xFFD6DEE8`, `0xFFEBEBEB`
  - Should use: `AppColors.primaryText`, `AppColors.border`, etc.

**Impact:**
- Makes global theme changes difficult
- Inconsistent color usage across app
- Doesn't respect dark mode (if implemented)

### 4.2 Hardcoded Text Styles
**Files Affected:** Most screen files

Example from `rent_payment_method_screen.dart`:
```dart
TextStyle(
  color: Color(0xFF162028),
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Figtree',
)
```

**Should be:**
```dart
Theme.of(context).textTheme.bodyMedium
// or
AppTextStyles.bodyMedium
```

### 4.3 Hardcoded Spacing
**Files Affected:** Most screen files

Example:
```dart
const SizedBox(height: 24)
const EdgeInsets.all(25)
```

**Should use spacing constants:**
```dart
SizedBox(height: AppSpacing.lg)
EdgeInsets.all(AppSpacing.xl)
```

---

## 5. Code Quality Issues

### 5.1 Missing WDI Architecture Compliance

**Issue:** Project uses GetX but doesn't follow WDI GetX folder structure consistently

**WDI Standard:**
```
lib/
├── core/
├── data/
│   ├── models/
│   ├── services/
│   └── repository/
├── modules/
│   ├── home/
│   │   ├── controller/
│   │   ├── view/
│   │   └── widgets/
```

**Current Issues:**
1. Some modules missing `controller/` folders
2. Repository files scattered (some in `data/repository/`, some in module folders)
3. No clear separation between data/domain/presentation layers

### 5.2 Missing Error Handling

Most screens lack proper error handling:
- No error states for failed API calls
- No loading states
- No retry mechanisms
- No offline mode handling

### 5.3 Missing Validators

Missing form validation in:
- Address input screens
- Profile edit screens
- Registration/login forms (basic validation exists but not comprehensive)

---

## 6. Testing Gaps

**Status:** ❌ **CRITICAL**

### 6.1 No Test Files
```bash
# Expected by WDI standards:
test/
├── unit/
├── widget/
└── integration/
```

**Current:** No test directory exists

### 6.2 Required Tests
According to WDI standards, need:
1. **Unit tests** for controllers/blocs/services
2. **Widget tests** for each screen
3. **Integration tests** for user flows

---

## 7. Next Steps - Required for Production

### Priority 1: Critical (Blocking)
1. ✅ **Create centralized ApiService** (`lib/core/services/api_service.dart`)
2. ✅ **Integrate authentication APIs** (login, register, OTP)
3. ✅ **Obtain Figma file for design comparison**
4. ✅ **Download missing assets from Figma**
5. ✅ **Create design token mappings** (colors, typography, spacing)

### Priority 2: High
1. ✅ **Integrate Shop module APIs** (products, cart, orders)
2. ✅ **Integrate Rent Vehicle APIs** (vehicles, bookings)
3. ✅ **Replace hardcoded colors/styles with design tokens**
4. ✅ **Implement error handling patterns**
5. ✅ **Add missing controllers** (forgot password, service booking, explore)

### Priority 3: Medium
1. ✅ **Integrate remaining module APIs** (notifications, search, subscriptions)
2. ✅ **Implement proper state management** for all screens
3. ✅ **Add form validators**
4. ✅ **Set up test infrastructure**
5. ✅ **Write critical path tests**

### Priority 4: Low
1. ✅ **Complete test coverage** (unit + widget)
2. ✅ **Implement offline mode** (where applicable)
3. ✅ **Add analytics**
4. ✅ **Performance optimization**

---

## 8. Figma Integration Required

**Status:** ⏳ **AWAITING FIGMA FILE ACCESS**

To complete this analysis, I need:

1. **Figma file URL or file key**
2. **Access to run Figma MCP tools:**
   - `create_design_system_rules` - Extract design tokens
   - `get_metadata` - Map frames to screens
   - `get_screenshot` - Visual comparison
   - `get_variable_defs` - Verify color/style usage
   - `get_design_context` - Check layout fidelity

**Expected Findings from Figma Analysis:**
- Missing screens/frames
- Design token mismatches
- Layout/spacing discrepancies
- Missing interactive states
- Incorrect navigation flows

---

## Summary Statistics

| Category | Implemented | Missing/Incomplete | Percentage |
|----------|-------------|-------------------|------------|
| **Screens** | ~60 screens | TBD (need Figma) | ~85% |
| **Backend APIs** | 0 modules | All modules | **0%** |
| **Design Tokens** | Partial | Complete mapping | ~30% |
| **Controllers** | ~15 modules | ~5 modules | ~75% |
| **Tests** | 0 | All | **0%** |
| **Assets** | Most | TBD (need Figma) | ~90% |

---

## Conclusion

The AMOZIT Customer App has:

✅ **Good UI Implementation** - Most screens are visually built  
❌ **NO Backend Integration** - All modules use mock data  
⚠️ **Partial Design Fidelity** - Hardcoded styles instead of design tokens  
❌ **NO Tests** - Zero test coverage  
⏳ **Unknown Design Gaps** - Need Figma file for comparison  

**Critical Blocker for Production:** The complete absence of backend API integration means the app cannot function with real data.

---

**Next Action Required:**  
**Please provide the Figma file URL/key to complete the design comparison analysis.**

