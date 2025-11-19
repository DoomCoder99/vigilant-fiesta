import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Theme Selection Screen
/// 
/// Allows users to select app theme (Light/Dark/System).
/// Design Source: Figma frame "Choose app theme" (node-id: 1-26965)
class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  String _selectedTheme = 'Light';

  final List<String> _themes = ['Light', 'Dark'];

  void _switchTheme() {
    // TODO: Implement theme switching via theme controller
    Get.back();
    Get.snackbar('Theme Changed', 'App theme changed to $_selectedTheme');
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
                const Text(
                  'Choose app Theme',
                  style: TextStyle(
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
          // Theme List
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: Column(
              children: _themes.map((theme) {
                return Column(
                  children: [
                    RadioListTile<String>(
                      value: theme,
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        setState(() {
                          _selectedTheme = value!;
                        });
                      },
                      title: Text(
                        theme,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.28,
                        ),
                      ),
                      activeColor: AppColors.primary,
                    ),
                    if (theme != _themes.last)
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
                onPressed: _switchTheme,
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
                    const Text(
                      'Switch',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.figtree,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/profile/chevron_forward.png',
                      width: 20,
                      height: 20,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.chevron_right, size: 20, color: Colors.white);
                      },
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

