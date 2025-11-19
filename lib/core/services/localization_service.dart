import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

/// Localization Service
/// 
/// Handles app translations for English and Arabic.
/// Uses GetX Translations with JSON files.
class LocalizationService extends Translations {
  static const String _translationsPath = 'assets/translations/';
  
  // Translation maps
  static Map<String, String> _enJson = {};
  static Map<String, String> _arJson = {};

  /// Initialize translations by loading JSON files
  static Future<void> init() async {
    try {
      // Load English translations
      final enString = await rootBundle.loadString('$_translationsPath/en_US.json');
      _enJson = Map<String, String>.from(jsonDecode(enString));

      // Load Arabic translations
      final arString = await rootBundle.loadString('$_translationsPath/ar_SA.json');
      _arJson = Map<String, String>.from(jsonDecode(arString));
    } catch (e) {
      debugPrint('Error loading translations: $e');
      // Fallback to empty maps if loading fails
      _enJson = {};
      _arJson = {};
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': _enJson,
    'ar_SA': _arJson,
  };

  /// Get current locale
  static Locale getCurrentLocale() {
    return Get.locale ?? const Locale('en', 'US');
  }

  /// Check if current language is Arabic
  static bool isArabic() {
    return Get.locale?.languageCode == 'ar';
  }

  /// Check if current language is English
  static bool isEnglish() {
    return Get.locale?.languageCode == 'en';
  }

  /// Get current language code
  static String getCurrentLanguageCode() {
    return Get.locale?.languageCode ?? 'en';
  }
}

