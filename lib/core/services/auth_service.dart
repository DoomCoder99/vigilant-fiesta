import 'package:flutter/foundation.dart';

/// Authentication Service
/// 
/// Manages user authentication state following WDI patterns.
/// Uses ChangeNotifier for state management consistency with other services.
/// 
/// DEV/TEST: Contains hardcoded test credentials for development.
/// TODO: Replace with actual API integration using WDI-approved ApiService pattern.
class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  bool _isAuthenticated = false;
  String? _currentUserEmail;

  /// Check if user is authenticated
  bool get isAuthenticated => _isAuthenticated;

  /// Get current user email (if authenticated)
  String? get currentUserEmail => _currentUserEmail;

  /// DEV/TEST Credentials
  /// 
  /// These credentials are for development/testing only.
  /// Remove or disable in production builds.
  /// 
  /// Primary test account:
  /// - Email: test.user@amozit.dev
  /// - Password: Test@1234
  /// 
  /// Alternative test accounts:
  /// - Email: user@amozit.com / Password: Amozit123!
  /// - Email: test@amozit.com / Password: Test123!
  /// - Email: shop@amozit.com / Password: Shop123!
  static const List<Map<String, String>> _testCredentials = [
    {'email': 'test.user@amozit.dev', 'password': 'Test@1234'},
    {'email': 'user@amozit.com', 'password': 'Amozit123!'},
    {'email': 'test@amozit.com', 'password': 'Test123!'},
    {'email': 'shop@amozit.com', 'password': 'Shop123!'},
    // Legacy test credentials (for backward compatibility)
    {'email': 'test@example.com', 'password': 'password123'},
  ];

  /// Sign in with email/phone and password
  /// 
  /// DEV/TEST: Validates against hardcoded test credentials.
  /// TODO: Replace with actual API call using WDI-approved ApiService pattern.
  Future<AuthResult> signIn(String emailOrPhone, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // DEV/TEST: Check against test credentials
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

      if (kDebugMode) {
        print('[AuthService] User signed in: $emailOrPhone');
      }

      return AuthResult(
        success: true,
        errorMessage: null,
      );
    }

    if (kDebugMode) {
      print('[AuthService] Sign in failed: Invalid credentials');
    }

    return AuthResult(
      success: false,
      errorMessage: 'Wrong password!',
    );
  }

  /// Sign out the current user
  void signOut() {
    _isAuthenticated = false;
    _currentUserEmail = null;
    notifyListeners();

    if (kDebugMode) {
      print('[AuthService] User signed out');
    }
  }

  /// Mark user as authenticated (for registration completion)
  /// 
  /// Called after successful registration to mark user as authenticated.
  void markAsAuthenticated(String emailOrPhone) {
    _isAuthenticated = true;
    _currentUserEmail = emailOrPhone;
    notifyListeners();

    if (kDebugMode) {
      print('[AuthService] User authenticated: $emailOrPhone');
    }
  }
}

/// Authentication Result
/// 
/// Contains the result of an authentication attempt.
class AuthResult {
  final bool success;
  final String? errorMessage;

  AuthResult({
    required this.success,
    this.errorMessage,
  });
}

