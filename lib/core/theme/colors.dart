import 'package:flutter/material.dart';

/// AMOZIT Customer App Color Tokens
/// 
/// All color values are extracted from Figma design system.
/// These colors match the design exactly and should be reused across all screens.
class AppColors {
  AppColors._();

  // Primary Colors
  /// Primary brand color - Purple (#7132f4)
  static const Color primary = Color(0xFF7132F4);

  // Text Colors
  /// Primary text color - Dark gray (#162028)
  static const Color textPrimary = Color(0xFF162028);
  
  /// Secondary text color - Light gray for inactive states (#d6dee8)
  static const Color textSecondary = Color(0xFFD6DEE8);

  // Background Colors
  /// White background
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  // Semantic Colors
  /// Error color - Light red for OTP error borders (#fa9b9b)
  static const Color errorLight = Color(0xFFFA9B9B);
  
  /// Error color - Standard error red
  static const Color error = Color(0xFFE53935);
  
  /// Success color
  static const Color success = Color(0xFF4CAF50);
  
  /// Warning color
  static const Color warning = Color(0xFFFF9800);
  
  // Input Colors
  /// Input border color - Light gray (#cfdce7)
  static const Color inputBorder = Color(0xFFCFDCE7);
  
  /// Input placeholder text color (#7b91a3)
  static const Color inputPlaceholder = Color(0xFF7B91A3);
  
  /// Input border color when filled (#9eaab4)
  static const Color inputBorderFilled = Color(0xFF9EAAB4);
  
  // Text Colors - Additional
  /// Secondary text color for dividers and helper text (#86819b)
  static const Color textTertiary = Color(0xFF86819B);
  
  /// Disabled button background color (rgba(137,160,159,0.44))
  static const Color buttonDisabled = Color(0x7089A09F);
  
  // Password Validation Colors
  /// Success/Check color for password requirements (#4CAF50)
  static const Color validationSuccess = Color(0xFF4CAF50);
  
  /// Password strength indicator dot color
  static const Color passwordDot = Color(0xFF1B1B1D);

  // ColorScheme for Material Design
  static const ColorScheme colorScheme = ColorScheme.light(
    primary: primary,
    onPrimary: backgroundWhite,
    secondary: primary,
    onSecondary: backgroundWhite,
    error: error,
    onError: backgroundWhite,
    surface: backgroundWhite,
    onSurface: textPrimary,
  );
}

