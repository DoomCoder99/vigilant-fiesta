import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/rtl_helper.dart';
import '../controller/localization_controller.dart';

/// Language Selection Screen
/// 
/// Allows users to select app language.
/// Design Source: Figma frame "Choose app language" (node-id: 1-26192, 1-26235)
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late final LocalizationController _controller;
  String _selectedLanguage = 'en';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'language_english'},
    {'code': 'ar', 'name': 'language_arabic'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = Get.find<LocalizationController>();
    _selectedLanguage = _controller.currentLanguage.value;
  }

  Future<void> _switchLanguage() async {
    await _controller.switchLanguage(_selectedLanguage);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'choose_app_language'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/profile/close_icon.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.close, size: 20);
                    },
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          // Language List
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: Column(
              children: _languages.map((language) {
                return Column(
                  children: [
                    RadioListTile<String>(
                      value: language['code']!,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                      title: Text(
                        language['name']!.tr,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.28,
                        ),
                      ),
                      activeColor: AppColors.primary,
                    ),
                    if (language != _languages.last)
                      const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          // Switch Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _switchLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'switch'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.figtree,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      RtlHelper.getChevronIcon(),
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

