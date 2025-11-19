# Explore → Location Permission → Registration → Amozit Landing Confirmed Flow

## Updated Flow

### Complete Registration Flow
```
Explore Button → Location Access Screen → Permission Request → Registration → OTP → Create Password → Amozit Landing Confirmed ✅
```

### Sign-In Flow
```
Sign In → Enter Credentials → Amozit Landing Confirmed ✅
```

## Code Changes

### 1. Registration Completion Navigation

**File**: `lib/modules/create_password/view/create_password_screen.dart` (line 82)

```dart
// Navigate to Amozit Landing Confirmed after successful registration completion
Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
```

**Previous**: Navigated to `AppRoutes.shopLanding`  
**Updated**: Navigates to `AppRoutes.amozitLandingConfirmed`

### 2. Sign-In Navigation

**File**: `lib/modules/sign_in/view/sign_in_screen.dart` (line 64)

```dart
// Navigate to Amozit Landing Confirmed after successful sign-in
Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
```

**Previous**: Navigated to `AppRoutes.shopLanding`  
**Updated**: Navigates to `AppRoutes.amozitLandingConfirmed`

### 3. Route Protection

**File**: `lib/main.dart` (line 62-64)

```dart
AppRoutes.amozitLandingConfirmed: (context) => const AuthGuard(
  child: AmozitLandingConfirmedScreen(),
),
```

**Updated**: Amozit Landing Confirmed screen is now protected with `AuthGuard` to ensure only authenticated users can access it.

## Explore Button Flow

### Current Implementation

**File**: `lib/modules/location_access/widgets/location_access_base.dart` (line 111-114)

```dart
// Explore Button
Expanded(
  child: OutlinedButton(
    onPressed: () {
      // Navigate to Location Access screen to request permission
      Navigator.of(context).pushReplacementNamed(AppRoutes.locationAccess);
    },
    child: const Text('Explore'),
  ),
),
```

**Also in**: `lib/modules/walkthrough/view/walkthrough_1_screen.dart` (line 113-116)

### Flow Details

1. **Explore Button** → Navigates to `/location-access`
2. **Location Access Screen** → Shows platform-specific permission modal (Android/iOS)
3. **Permission Handler** → Uses `LocationPermissionService` to request permission
4. **After Permission** → Navigates to `/register` (Registration screen)
5. **Registration** → User enters email/phone → Navigates to `/register-otp`
6. **OTP Verification** → User enters 4-digit OTP → Navigates to `/create-password`
7. **Create Password** → User creates password → Marks user as authenticated → Navigates to `/amozit-landing-confirmed`

## Location Permission Service

**File**: `lib/core/services/location_permission_service.dart`

- Singleton service following WDI patterns
- Platform-aware (Android/iOS)
- Currently returns `true` for testing (DEV mode)
- TODO: Replace with actual permission package (`permission_handler` or `geolocator`)

**Usage in Permission Modals**:

**Android** (`lib/modules/location_access/widgets/android_location_modal.dart`):
```dart
void _handlePermission(BuildContext context, String permissionType) async {
  final permissionService = LocationPermissionService.instance;
  final isGranted = await permissionService.requestPermission();
  
  if (isGranted) {
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.register);
    }
  } else {
    // Still allow registration even if permission denied
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.register);
    }
  }
}
```

**iOS** (`lib/modules/location_access/widgets/ios_location_modal.dart`): Same implementation

## Authentication Service

**File**: `lib/core/services/auth_service.dart`

- Singleton service with `ChangeNotifier` (consistent with `CartService`)
- Manages authentication state
- Contains DEV/TEST credentials

### DEV/TEST Credentials

**Primary Test Account**:
- **Email**: `test.user@amozit.dev`
- **Password**: `Test@1234`

**Alternative Test Accounts**:
- `user@amozit.com` / `Amozit123!`
- `test@amozit.com` / `Test123!`
- `shop@amozit.com` / `Shop123!`
- `test@example.com` / `password123` (legacy)

**Key Methods**:
- `signIn(String emailOrPhone, String password)` - Validates credentials and marks user as authenticated
- `markAsAuthenticated(String emailOrPhone)` - Called after successful registration
- `isAuthenticated` - Getter to check auth status

## Route Protection

**File**: `lib/core/widgets/auth_guard.dart`

- Protects routes by checking authentication before allowing access
- If not authenticated → Redirects to Sign In
- If authenticated → Shows protected content

**Protected Routes**:
- ✅ `/amozit-landing-confirmed` - Now protected
- ✅ All Shop module routes - Protected

## Test Credentials Usage

### To Test Sign-In Flow:

1. Navigate to Sign In screen
2. Enter credentials:
   - **Email**: `test.user@amozit.dev`
   - **Password**: `Test@1234`
3. Tap "Sign In"
4. ✅ Should navigate to **Amozit Landing Confirmed** screen

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
10. ✅ Should navigate to **Amozit Landing Confirmed** screen

## Route Definitions

### Public Routes (No Auth Required)
- `/splash`
- `/walkthrough-1`
- `/location-access`
- `/register`
- `/register-otp`
- `/create-password`
- `/sign-in`
- `/forgot-password`
- `/forgot-password-otp`
- `/explore`

### Protected Routes (Auth Required)
- ✅ `/amozit-landing-confirmed` - **Now protected**
- ✅ All Shop module routes - Protected

## Summary

✅ **Explore button** → Location Access → Registration → Amozit Landing Confirmed  
✅ **Sign-In** → Amozit Landing Confirmed  
✅ **Amozit Landing Confirmed** protected with AuthGuard  
✅ **Test credentials** available for development  
✅ **WDI-compliant** architecture throughout  

The flow is now correctly wired to navigate to Amozit Landing Confirmed after both registration and sign-in.

