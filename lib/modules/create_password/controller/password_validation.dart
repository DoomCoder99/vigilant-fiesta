/// Password Validation Controller
/// 
/// Handles password validation logic with real-time feedback.
/// Following WDI Flutter Coding Standards.
class PasswordValidation {
  /// Validates password and returns validation result
  PasswordValidationResult validate(String password) {
    return PasswordValidationResult(
      hasMinLength: password.length >= 8,
      hasNumberOrSymbol: _hasNumberOrSymbol(password),
      hasUppercase: _hasUppercase(password),
    );
  }

  bool _hasNumberOrSymbol(String password) {
    return password.contains(RegExp(r'[0-9]')) ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool _hasUppercase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }
}

/// Password Validation Result
/// 
/// Contains the validation state for each password requirement.
class PasswordValidationResult {
  final bool hasMinLength;
  final bool hasNumberOrSymbol;
  final bool hasUppercase;

  PasswordValidationResult({
    required this.hasMinLength,
    required this.hasNumberOrSymbol,
    required this.hasUppercase,
  });

  /// Empty validation result (all false)
  factory PasswordValidationResult.empty() {
    return PasswordValidationResult(
      hasMinLength: false,
      hasNumberOrSymbol: false,
      hasUppercase: false,
    );
  }

  /// Returns true if all requirements are met
  bool get isValid {
    return hasMinLength && hasNumberOrSymbol && hasUppercase;
  }
}

