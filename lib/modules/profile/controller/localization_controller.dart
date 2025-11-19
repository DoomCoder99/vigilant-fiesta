import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Localization Controller
/// 
/// Manages language switching and persistence.
class LocalizationController extends GetxController {
  static const String _languageKey = 'app_language';
  
  final RxString currentLanguage = 'en'.obs;
  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    // Language is loaded in main.dart before app starts
  }

  /// Load saved language preference from SharedPreferences
  /// Made public for initialization in main.dart
  Future<void> loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey) ?? 'en';
      
      currentLanguage.value = savedLanguage;
      
      if (savedLanguage == 'ar') {
        currentLocale.value = const Locale('ar', 'SA');
        Get.updateLocale(const Locale('ar', 'SA'));
      } else {
        currentLocale.value = const Locale('en', 'US');
        Get.updateLocale(const Locale('en', 'US'));
      }
    } catch (e) {
      debugPrint('Error loading saved language: $e');
      // Default to English on error
      currentLanguage.value = 'en';
      currentLocale.value = const Locale('en', 'US');
    }
  }

  /// Switch language
  /// 
  /// [lang] should be 'en' for English or 'ar' for Arabic
  Future<void> switchLanguage(String lang) async {
    try {
      if (lang == 'ar') {
        currentLanguage.value = 'ar';
        currentLocale.value = const Locale('ar', 'SA');
        Get.updateLocale(const Locale('ar', 'SA'));
      } else {
        currentLanguage.value = 'en';
        currentLocale.value = const Locale('en', 'US');
        Get.updateLocale(const Locale('en', 'US'));
      }

      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, lang);

      // Show success message
      Get.snackbar(
        'language_changed'.tr,
        '${'app_language_changed_to'.tr} ${lang == 'ar' ? 'language_arabic'.tr : 'language_english'.tr}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      debugPrint('Error switching language: $e');
      Get.snackbar(
        'Error',
        'Failed to change language',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Get current language display name
  String getCurrentLanguageName() {
    return currentLanguage.value == 'ar' 
        ? 'language_arabic'.tr 
        : 'language_english'.tr;
  }

  /// Check if current language is Arabic
  bool get isArabic => currentLanguage.value == 'ar';

  /// Check if current language is English
  bool get isEnglish => currentLanguage.value == 'en';
}

