import 'package:flutter/material.dart';
import 'colors.dart';

/// AMOZIT Customer App Typography Tokens
/// 
/// All typography styles are extracted from Figma design system.
/// These text styles match the design exactly and should be reused across all screens.

// Font Families
class AppFonts {
  AppFonts._();

  /// Primary font family - Figtree
  static const String figtree = 'Figtree';
  
  /// Secondary font family - Arial (used for status bar)
  static const String arial = 'Arial';
}

/// Text style helpers matching Figma design tokens
class AppTextStyles {
  AppTextStyles._();

  // Status Bar Text (Arial Regular, 10px, line-height 12px, letter-spacing -0.4px)
  static const TextStyle statusBar = TextStyle(
    fontFamily: AppFonts.arial,
    fontSize: 10.0,
    height: 1.2, // 12px / 10px
    letterSpacing: -0.4,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  // Body Text Styles (Figtree Regular, 12px, line-height 16px)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.33, // 16px / 12px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  // Body Text Styles (Figtree Medium, 12px, line-height 20px)
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.67, // 20px / 12px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
  );

  // Button Text (Figtree Bold, 14px, line-height 16px)
  static const TextStyle button = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 14.0,
    height: 1.14, // 16px / 14px
    color: AppColors.backgroundWhite,
    fontWeight: FontWeight.bold,
  );

  // Button Text Secondary (Figtree Medium, 14px, line-height 16px)
  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 14.0,
    height: 1.14, // 16px / 14px
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  // Heading Styles (Figtree Regular, 32px, line-height 32px)
  static const TextStyle headingLarge = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 32.0,
    height: 1.0, // 32px / 32px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  // Heading Medium (Figtree SemiBold, 24px, line-height 24px)
  static const TextStyle headingMedium = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 24.0,
    height: 1.0, // 24px / 24px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  // Caption/Helper Text (Figtree Regular, 10px, line-height 12px)
  static const TextStyle caption = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 10.0,
    height: 1.2, // 12px / 10px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  // Input Text (Figtree Regular, 12px, line-height 16px)
  static const TextStyle input = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.33, // 16px / 12px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  // OTP Digit Text (Figtree Medium, 12px, line-height 16px)
  static const TextStyle otpDigit = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.33, // 16px / 12px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
  );

  // Heading Small (Figtree SemiBold, 16px, line-height 16px)
  static const TextStyle headingSmall = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 16.0,
    height: 1.0, // 16px / 16px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  // Link Text (Figtree Medium, 12px, line-height 20px, primary color)
  static const TextStyle link = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.67, // 20px / 12px
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  // Divider Text (Figtree Regular, 12px, line-height 16px, tertiary color, 0.24px letter spacing)
  static const TextStyle dividerText = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12.0,
    height: 1.33, // 16px / 12px
    color: AppColors.textTertiary,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.24,
  );
}

/// Material Design TextTheme based on Figma design tokens
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme => const TextTheme(
        // Display styles
        displayLarge: AppTextStyles.headingLarge,
        
        // Headline styles
        headlineLarge: AppTextStyles.headingLarge,
        
        // Title styles
        titleMedium: AppTextStyles.bodyMedium,
        
        // Body styles
        bodyLarge: AppTextStyles.bodyMedium,
        bodyMedium: AppTextStyles.bodySmall,
        bodySmall: AppTextStyles.bodySmall,
        
        // Label styles (for buttons)
        labelLarge: AppTextStyles.button,
        labelMedium: AppTextStyles.buttonSecondary,
        labelSmall: AppTextStyles.bodySmall,
      );
}

