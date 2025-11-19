import '../../../../core/services/auth_service.dart';

/// Sign In Controller
/// 
/// Handles sign-in logic and authentication.
/// Following WDI Flutter Coding Standards.
/// 
/// Uses AuthService for authentication state management.
class SignInController {
  final AuthService _authService = AuthService.instance;

  /// Signs in the user with email/phone and password
  /// 
  /// Uses AuthService which contains DEV/TEST credentials.
  /// TODO: Replace AuthService implementation with actual API call using WDI-approved ApiService pattern.
  Future<SignInResult> signIn(String emailOrPhone, String password) async {
    final result = await _authService.signIn(emailOrPhone, password);
    
    return SignInResult(
      success: result.success,
      errorMessage: result.errorMessage,
    );
  }
}

/// Sign In Result
/// 
/// Contains the result of a sign-in attempt.
class SignInResult {
  final bool success;
  final String? errorMessage;

  SignInResult({
    required this.success,
    this.errorMessage,
  });
}

