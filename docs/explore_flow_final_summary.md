# Explore → Location Permission → Registration → Amozit Landing Confirmed - Final Summary

## Updated Code Snippets

### 1. Explore Button Handler

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

### 2. Location Permission Handler

**File**: `lib/modules/location_access/widgets/android_location_modal.dart` (line 156-181)

```dart
void _handlePermission(BuildContext context, String permissionType) async {
  // Import location permission service
  final permissionService = LocationPermissionService.instance;

  // Request actual permission (or stub for testing)
  final isGranted = await permissionService.requestPermission();

  if (isGranted) {
    // Permission granted - navigate to Registration
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.register);
    }
  } else {
    // Permission denied - still allow user to proceed to registration
    // (Some apps allow registration without location)
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied. You can still register.'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacementNamed(AppRoutes.register);
    }
  }
}
```

**Same implementation in**: `lib/modules/location_access/widgets/ios_location_modal.dart`

### 3. Location Permission Service

**File**: `lib/core/services/location_permission_service.dart`

```dart
class LocationPermissionService {
  LocationPermissionService._();
  static final LocationPermissionService instance = LocationPermissionService._();

  /// Request location permission
  /// 
  /// DEV/TEST: Currently returns true for testing purposes.
  /// TODO: Implement actual permission request using permission_handler or geolocator
  Future<bool> requestPermission() async {
    // Simulate permission request delay
    await Future.delayed(const Duration(milliseconds: 500));

    // DEV/TEST: For now, accept any permission choice as granted
    if (kDebugMode) {
      print('[LocationPermissionService] Permission granted (DEV mode)');
    }
    return true;
  }

  /// Get platform type
  bool get isAndroid => Platform.isAndroid;
  bool get isIOS => Platform.isIOS;
}
```

### 4. Registration Completion Handler

**File**: `lib/modules/create_password/view/create_password_screen.dart` (line 62-84)

```dart
Future<void> _handleCreatePassword() async {
  if (!_validationResult.isValid) {
    return;
  }

  // TODO: Implement actual password creation API call
  // For now, mark user as authenticated and navigate to Amozit Landing Confirmed
  if (mounted) {
    // Mark user as authenticated after successful registration
    final authService = AuthService.instance;
    authService.markAsAuthenticated(widget.emailOrPhone);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password created successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
    
    // Navigate to Amozit Landing Confirmed after successful registration completion
    Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
  }
}
```

### 5. Sign-In Handler

**File**: `lib/modules/sign_in/view/sign_in_screen.dart` (line 40-71)

```dart
Future<void> _handleSignIn() async {
  if (_emailPhoneController.text.isEmpty ||
      _passwordController.text.isEmpty) {
    return;
  }

  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  // Uses SignInController which delegates to AuthService
  final result = await _controller.signIn(
    _emailPhoneController.text,
    _passwordController.text,
  );

  if (mounted) {
    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      // Navigate to Amozit Landing Confirmed after successful sign-in
      Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
    } else {
      setState(() {
        _errorMessage = result.errorMessage ?? 'Wrong password!';
      });
    }
  }
}
```

**Sign-In Controller** (`lib/modules/sign_in/controller/sign_in_controller.dart`):

```dart
class SignInController {
  final AuthService _authService = AuthService.instance;

  Future<SignInResult> signIn(String emailOrPhone, String password) async {
    final result = await _authService.signIn(emailOrPhone, password);
    
    return SignInResult(
      success: result.success,
      errorMessage: result.errorMessage,
    );
  }
}
```

### 6. Authentication Service

**File**: `lib/core/services/auth_service.dart`

```dart
class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  bool _isAuthenticated = false;
  String? _currentUserEmail;

  /// DEV/TEST Credentials
  /// 
  /// These credentials are for development/testing only.
  /// Remove or disable in production builds.
  static const List<Map<String, String>> _testCredentials = [
    {'email': 'test.user@amozit.dev', 'password': 'Test@1234'},
    {'email': 'user@amozit.com', 'password': 'Amozit123!'},
    {'email': 'test@amozit.com', 'password': 'Test123!'},
    {'email': 'shop@amozit.com', 'password': 'Shop123!'},
    {'email': 'test@example.com', 'password': 'password123'}, // Legacy
  ];

  Future<AuthResult> signIn(String emailOrPhone, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final isValid = _testCredentials.any(
      (cred) =>
          (emailOrPhone.toLowerCase() == cred['email']?.toLowerCase() ||
              emailOrPhone == cred['email']) &&
          password == cred['password'],
    );

    if (isValid) {
      _isAuthenticated = true;
      _currentUserEmail = emailOrPhone;
      notifyListeners();
      return AuthResult(success: true, errorMessage: null);
    }

    return AuthResult(success: false, errorMessage: 'Wrong password!');
  }

  void markAsAuthenticated(String emailOrPhone) {
    _isAuthenticated = true;
    _currentUserEmail = emailOrPhone;
    notifyListeners();
  }
}
```

### 7. Route Definitions with Auth Guard

**File**: `lib/main.dart` (line 62-64)

```dart
AppRoutes.amozitLandingConfirmed: (context) => const AuthGuard(
  child: AmozitLandingConfirmedScreen(),
),
```

**Auth Guard** (`lib/core/widgets/auth_guard.dart`):

```dart
class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;

    if (!authService.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
        }
      });

      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return child;
  }
}
```

## Dev Sign-In Credentials

### Primary Test Account (Recommended)

- **Email**: `test.user@amozit.dev`
- **Password**: `Test@1234`

**Location**: `lib/core/services/auth_service.dart` (line 36)

### Alternative Test Accounts

| Email | Password | Location |
|-------|----------|----------|
| `user@amozit.com` | `Amozit123!` | `lib/core/services/auth_service.dart` (line 38) |
| `test@amozit.com` | `Test123!` | `lib/core/services/auth_service.dart` (line 39) |
| `shop@amozit.com` | `Shop123!` | `lib/core/services/auth_service.dart` (line 40) |
| `test@example.com` | `password123` | `lib/core/services/auth_service.dart` (line 42) |

**All credentials are defined in**: `lib/core/services/auth_service.dart` in the `_testCredentials` constant (lines 36-43)

**Important**: These credentials are clearly marked as **DEV/TEST only** with comments indicating they must not be shipped to production.

## Complete Flow Explanation

### Step-by-Step Flow

#### 1. Explore Button Tap
- **Location**: `lib/modules/location_access/widgets/location_access_base.dart` (line 111-114)
- **Action**: Navigates to `/location-access` route
- **Handler**: `onPressed` → `Navigator.of(context).pushReplacementNamed(AppRoutes.locationAccess)`

#### 2. Location Access Screen
- **Location**: `lib/modules/location_access/view/location_access_screen.dart`
- **Behavior**: Shows platform-specific modal (Android/iOS) via `LocationAccessBase` widget
- **Platform Detection**: Uses `Platform.isAndroid` / `Platform.isIOS` to show correct modal

#### 3. Permission Request
- **Location**: `lib/modules/location_access/widgets/android_location_modal.dart` (line 156-181)
- **Service**: Uses `LocationPermissionService.instance.requestPermission()`
- **Current Behavior**: Returns `true` for testing (DEV mode)
- **After Permission**: Navigates to `/register` route

#### 4. Registration Flow
- **Register Screen**: User enters email/phone → Navigates to `/register-otp`
- **OTP Screen**: User enters 4-digit OTP (any 4 digits accepted for testing) → Navigates to `/create-password`
- **Create Password Screen**: User creates password → Calls `AuthService.markAsAuthenticated()` → Navigates to `/amozit-landing-confirmed`

#### 5. Sign-In Flow
- **Sign In Screen**: User enters credentials → `SignInController.signIn()` → `AuthService.signIn()`
- **Validation**: Checks against `_testCredentials` in `AuthService`
- **On Success**: Marks user as authenticated → Navigates to `/amozit-landing-confirmed`

#### 6. Amozit Landing Confirmed Screen
- **Route**: `/amozit-landing-confirmed`
- **Protection**: Wrapped with `AuthGuard` to ensure only authenticated users can access
- **Navigation**: Contains bottom navigation bar with links to Shop, Orders, Cart

## Assumptions Made

### 1. Permission Denied Behavior
- **Assumption**: If location permission is denied, user can still proceed to registration
- **Implementation**: Shows snackbar message but still navigates to Registration screen
- **Reason**: Some apps allow registration without location; location can be requested later

### 2. OTP Verification
- **Assumption**: Any 4-digit OTP is accepted for testing
- **Implementation**: `OtpController.verifyOtp()` accepts any 4-digit numeric code
- **Reason**: Backend API not yet integrated; allows easy testing of registration flow

### 3. Password Validation
- **Assumption**: Password requirements match the validation rules shown in Create Password screen
- **Implementation**: Uses existing `PasswordValidation` class
- **Requirements**: Minimum 8 characters, number/symbol, uppercase letter

### 4. Authentication State Persistence
- **Assumption**: Authentication state is not persisted across app restarts (in-memory only)
- **Implementation**: `AuthService` uses in-memory state
- **Reason**: Backend integration will handle token persistence; current implementation is for testing

### 5. Amozit Landing Confirmed as Entry Point
- **Assumption**: Amozit Landing Confirmed is the main landing screen after authentication
- **Implementation**: Both registration and sign-in navigate to this screen
- **Reason**: Based on Figma design flow and user requirements

## Route Definitions

### Public Routes (No Auth Required)
- `/splash`
- `/walkthrough-1`
- `/location-access` - Shows permission modal
- `/register` - Registration start
- `/register-otp` - OTP verification
- `/create-password` - Password creation
- `/sign-in` - Sign-in screen
- `/forgot-password` - Password recovery
- `/forgot-password-otp` - Password recovery OTP
- `/explore` - Explore screen (placeholder)

### Protected Routes (Auth Required)
- ✅ `/amozit-landing-confirmed` - **Main landing screen after auth**
- ✅ `/shop-landing` - Shop module entry
- ✅ All other Shop module routes

## Files Modified

1. ✅ `lib/modules/create_password/view/create_password_screen.dart` - Updated navigation target
2. ✅ `lib/modules/sign_in/view/sign_in_screen.dart` - Updated navigation target
3. ✅ `lib/main.dart` - Added AuthGuard to Amozit Landing Confirmed route
4. ✅ `lib/core/services/auth_service.dart` - Already contains test credentials
5. ✅ `lib/core/services/location_permission_service.dart` - Already implemented
6. ✅ `lib/modules/location_access/widgets/android_location_modal.dart` - Already uses permission service
7. ✅ `lib/modules/location_access/widgets/ios_location_modal.dart` - Already uses permission service

## Summary

✅ **Explore button** → Location Access → Registration → Amozit Landing Confirmed  
✅ **Sign-In** → Amozit Landing Confirmed  
✅ **Amozit Landing Confirmed** protected with AuthGuard  
✅ **Test credentials** available: `test.user@amozit.dev` / `Test@1234`  
✅ **Location permission** handled via `LocationPermissionService`  
✅ **Authentication** managed via `AuthService`  
✅ **WDI-compliant** architecture throughout  

The flow is complete and ready for testing!

