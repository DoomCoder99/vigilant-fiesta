# Onboarding → Shop Flow Implementation

## Overview

This document describes the implementation of the complete onboarding → Shop flow with proper permissions and authentication, following WDI Flutter Coding Standards.

## Flow Architecture

### Complete User Journey

```
1. User taps "Explore" button
   ↓
2. Location Permission Screen (Android/iOS specific)
   ↓
3. Permission Request (via LocationPermissionService)
   ↓
4. Registration Screen
   ↓
5. OTP Verification
   ↓
6. Create Password
   ↓
7. User marked as authenticated (via AuthService)
   ↓
8. Shop Landing Screen (protected route)
```

### Sign-In Flow

```
1. User navigates to Sign In screen
   ↓
2. Enters test credentials
   ↓
3. AuthService validates credentials
   ↓
4. User marked as authenticated
   ↓
5. Shop Landing Screen (protected route)
```

## Implementation Details

### 1. Location Permission Service

**File**: `lib/core/services/location_permission_service.dart`

- **Pattern**: Singleton service (following WDI patterns)
- **Purpose**: Handles location permission requests
- **Platform Support**: Android and iOS
- **Current Status**: DEV/TEST stub that returns `true` for testing
- **TODO**: Replace with actual permission package (e.g., `permission_handler` or `geolocator`)

**Usage**:
```dart
final permissionService = LocationPermissionService.instance;
final isGranted = await permissionService.requestPermission();
```

### 2. Authentication Service

**File**: `lib/core/services/auth_service.dart`

- **Pattern**: Singleton service with `ChangeNotifier` (consistent with `CartService`)
- **Purpose**: Manages authentication state across the app
- **State Management**: Uses `ChangeNotifier` to notify listeners of auth state changes

**DEV/TEST Credentials**:

| Email | Password | Purpose |
|-------|----------|---------|
| `test.user@amozit.dev` | `Test@1234` | **Primary test account** |
| `user@amozit.com` | `Amozit123!` | Alternative test account |
| `test@amozit.com` | `Test123!` | Alternative test account |
| `shop@amozit.com` | `Shop123!` | Shop-specific test account |
| `test@example.com` | `password123` | Legacy (backward compatibility) |

**Key Methods**:
- `signIn(String emailOrPhone, String password)` - Validates credentials and marks user as authenticated
- `markAsAuthenticated(String emailOrPhone)` - Called after successful registration
- `signOut()` - Clears authentication state
- `isAuthenticated` - Getter to check auth status

**TODO**: Replace hardcoded credentials with actual API integration using WDI-approved `ApiService` pattern.

### 3. Auth Guard Widget

**File**: `lib/core/widgets/auth_guard.dart`

- **Purpose**: Protects Shop routes by checking authentication before allowing access
- **Behavior**: 
  - If user is authenticated → Shows protected content
  - If user is not authenticated → Redirects to Sign In screen

**Usage** (in `main.dart` routes):
```dart
AppRoutes.shopLanding: (context) => const AuthGuard(
  child: ShopLandingScreen(),
),
```

### 4. Updated Components

#### Location Permission Modals

**Files**:
- `lib/modules/location_access/widgets/android_location_modal.dart`
- `lib/modules/location_access/widgets/ios_location_modal.dart`

**Changes**:
- Now use `LocationPermissionService` to request permissions
- Navigate to Registration screen after permission handling (granted or denied)

#### Sign-In Controller

**File**: `lib/modules/sign_in/controller/sign_in_controller.dart`

**Changes**:
- Now uses `AuthService` instead of hardcoded credentials
- Delegates authentication logic to `AuthService`

#### Create Password Screen

**File**: `lib/modules/create_password/view/create_password_screen.dart`

**Changes**:
- Calls `AuthService.markAsAuthenticated()` after successful password creation
- Ensures user is authenticated before navigating to Shop Landing

#### Main App Routes

**File**: `lib/main.dart`

**Changes**:
- All Shop module routes wrapped with `AuthGuard`
- Ensures unauthenticated users cannot access Shop pages

## Route Protection

All Shop module routes are protected with `AuthGuard`:

- ✅ `shopLanding`
- ✅ `categoryListing`
- ✅ `productDetail`
- ✅ `cart`
- ✅ `paymentMethod`
- ✅ `paymentSuccess`
- ✅ `myOrders`
- ✅ `orderDetail`
- ✅ `tracking`
- ✅ `cancellationConfirmation`
- ✅ `menuAllCategories`
- ✅ `menuAllSubCategories`

## Test Credentials Usage

### To Test Sign-In Flow:

1. Navigate to Sign In screen
2. Enter credentials:
   - **Email**: `test.user@amozit.dev`
   - **Password**: `Test@1234`
3. Tap "Sign In"
4. Should navigate to Shop Landing screen

### To Test Registration Flow:

1. Tap "Explore" button
2. Location permission modal appears
3. Select any permission option (While using app, Only this time, etc.)
4. Registration screen appears
5. Enter email (e.g., `newuser@amozit.dev`)
6. Tap "Get OTP"
7. Enter any 4-digit OTP (e.g., `1234`)
8. Create password meeting requirements (e.g., `NewUser123!`)
9. Tap "Update & Sign in"
10. Should navigate to Shop Landing screen

## Navigation Flow Verification

### Explore Button → Shop Landing

✅ **Explore Button** (in `location_access_base.dart` and `walkthrough_1_screen.dart`)
- Navigates to Location Access screen

✅ **Location Access Screen**
- Shows platform-specific permission modal (Android/iOS)
- Uses `LocationPermissionService` to request permission
- Navigates to Registration screen after permission handling

✅ **Registration Screen**
- User enters email/phone
- Navigates to OTP screen

✅ **OTP Screen**
- Accepts any 4-digit OTP for testing
- Navigates to Create Password screen

✅ **Create Password Screen**
- Validates password requirements
- Calls `AuthService.markAsAuthenticated()`
- Navigates to Shop Landing screen

✅ **Shop Landing Screen**
- Protected by `AuthGuard`
- Only accessible if user is authenticated

### Sign-In → Shop Landing

✅ **Sign In Screen**
- User enters credentials
- Uses `SignInController` which delegates to `AuthService`
- On success, navigates to Shop Landing screen

✅ **Shop Landing Screen**
- Protected by `AuthGuard`
- Only accessible if user is authenticated

## TODOs for Backend Integration

### Location Permission Service

```dart
// TODO: Replace with actual permission package
// Example with permission_handler:
// final status = await Permission.location.request();
// return status.isGranted;
```

### Authentication Service

```dart
// TODO: Replace hardcoded credentials with actual API call
// Example:
// final response = await ApiService.callApi(
//   endpoint: 'auth/signin',
//   type: ApiType.post,
//   body: {'email': emailOrPhone, 'password': password},
// );
```

### Registration Flow

- OTP verification should call backend API
- Password creation should call backend API
- Registration completion should receive auth token from backend

## Files Created/Modified

### New Files

1. `lib/core/services/location_permission_service.dart` - Location permission handling
2. `lib/core/services/auth_service.dart` - Authentication state management
3. `lib/core/widgets/auth_guard.dart` - Route protection widget
4. `docs/onboarding_shop_flow_implementation.md` - This documentation

### Modified Files

1. `lib/modules/location_access/widgets/android_location_modal.dart` - Uses permission service
2. `lib/modules/location_access/widgets/ios_location_modal.dart` - Uses permission service
3. `lib/modules/sign_in/controller/sign_in_controller.dart` - Uses AuthService
4. `lib/modules/create_password/view/create_password_screen.dart` - Marks user as authenticated
5. `lib/main.dart` - Added AuthGuard to Shop routes

## Summary

✅ **Explore button** → Location permission → Registration → Shop Landing  
✅ **Sign-In** → Shop Landing (with test credentials)  
✅ **Route protection** for all Shop routes  
✅ **Authentication state management** via AuthService  
✅ **WDI-compliant** architecture and patterns  
✅ **DEV/TEST credentials** clearly marked and documented  

The flow is now complete and ready for backend integration when APIs are available.

