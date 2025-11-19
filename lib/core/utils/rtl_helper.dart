import 'package:flutter/material.dart';
import '../services/localization_service.dart';

/// RTL Helper Utilities
/// 
/// Provides utilities for RTL-aware layouts and widgets.
class RtlHelper {
  RtlHelper._();

  /// Check if current locale is RTL (Right-to-Left)
  static bool get isRTL => LocalizationService.isArabic();

  /// Get text direction based on current locale
  static TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;

  /// Get opposite text direction
  static TextDirection get oppositeTextDirection => isRTL ? TextDirection.ltr : TextDirection.rtl;

  /// Get directional edge insets
  /// 
  /// Use this instead of EdgeInsets for RTL-aware padding/margins
  static EdgeInsetsDirectional directionalOnly({
    double? start,
    double? top,
    double? end,
    double? bottom,
  }) {
    return EdgeInsetsDirectional.only(
      start: start ?? 0,
      top: top ?? 0,
      end: end ?? 0,
      bottom: bottom ?? 0,
    );
  }

  /// Get directional symmetric edge insets
  static EdgeInsetsDirectional directionalSymmetric({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsetsDirectional.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );
  }

  /// Get RTL-aware icon
  /// 
  /// Returns chevron_right for LTR, chevron_left for RTL
  static IconData getChevronIcon() {
    return isRTL ? Icons.chevron_left : Icons.chevron_right;
  }

  /// Get RTL-aware arrow icon
  /// 
  /// Returns arrow_back for LTR, arrow_forward for RTL
  static IconData getBackIcon() {
    return isRTL ? Icons.arrow_forward : Icons.arrow_back;
  }

  /// Get RTL-aware alignment
  /// 
  /// Returns Alignment.centerRight for RTL, Alignment.centerLeft for LTR
  static Alignment getStartAlignment() {
    return isRTL ? Alignment.centerRight : Alignment.centerLeft;
  }

  /// Get RTL-aware alignment
  /// 
  /// Returns Alignment.centerLeft for RTL, Alignment.centerRight for LTR
  static Alignment getEndAlignment() {
    return isRTL ? Alignment.centerLeft : Alignment.centerRight;
  }

  /// Wrap widget with RTL-aware directionality
  static Widget withDirectionality(Widget child) {
    return Directionality(
      textDirection: textDirection,
      child: child,
    );
  }
}

