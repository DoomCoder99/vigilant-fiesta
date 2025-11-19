import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../controller/notification_controller.dart';

/// Notification Settings Screen
/// 
/// Allows users to configure notification preferences.
/// Design Source: Figma frame "Notification settings" (node-id: 1-11405)
/// 
/// Layout matches Figma exactly:
/// - Padding: 25px horizontal (AppSpacing.xl)
/// - Item height: 48px
/// - Divider: 1px height between items
/// - Switch: 28x16px, purple when on (#7132f4), gray when off (#cac7d0)
class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icon_back_arrow.png',
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 16);
            },
          ),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: AppColors.textSecondary),
            ),
          ),
        ),
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final settings = controller.settings.value;
        
        // Show error message if settings failed to save
        if (controller.settingsErrorMessage.value.isNotEmpty) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.settingsErrorMessage.value,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                          fontFamily: AppFonts.figtree,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.retryUpdateSettings(),
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildSettingsList(settings, controller),
              ),
            ],
          );
        }

        return _buildSettingsList(settings, controller);
      }),
    );
  }

  Widget _buildSettingsList(settings, controller) {
    return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 25, // Matches Figma design (node-id: 1-11405)
            vertical: 24, // Matches Figma spacing
          ),
          itemCount: 4,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _NotificationSettingItem(
                  title: 'Push notifications',
                  description:
                      'Get timely alerts on your phone, enable push notifications.',
                  value: settings.pushNotificationsEnabled,
                  isSaving: controller.isSavingSettings.value,
                  onChanged: (value) async {
                    try {
                      await controller.updateSettings(
                        settings.copyWith(pushNotificationsEnabled: value),
                      );
                    } catch (e) {
                      // Error handling is done in controller
                    }
                  },
                );
              case 1:
                return _NotificationSettingItem(
                  title: 'Wishlist updates',
                  description:
                      'Get notified if a product in your Wishlist gets a price drop or gets back in stock.',
                  value: settings.wishlistUpdatesEnabled,
                  isSaving: controller.isSavingSettings.value,
                  onChanged: (value) async {
                    try {
                      await controller.updateSettings(
                        settings.copyWith(wishlistUpdatesEnabled: value),
                      );
                    } catch (e) {
                      // Error handling is done in controller
                    }
                  },
                );
              case 2:
                return _NotificationSettingItem(
                  title: 'Service notifications',
                  description:
                      'Get alerts whenever a booked / scheduled service gets a new update',
                  value: settings.serviceNotificationsEnabled,
                  isSaving: controller.isSavingSettings.value,
                  onChanged: (value) async {
                    try {
                      await controller.updateSettings(
                        settings.copyWith(serviceNotificationsEnabled: value),
                      );
                    } catch (e) {
                      // Error handling is done in controller
                    }
                  },
                );
              case 3:
                return _NotificationSettingItem(
                  title: 'Email notifications',
                  description:
                      'Send all the notifications to my email too, for a backup tracking.',
                  value: settings.emailNotificationsEnabled,
                  isSaving: controller.isSavingSettings.value,
                  onChanged: (value) async {
                    try {
                      await controller.updateSettings(
                        settings.copyWith(emailNotificationsEnabled: value),
                      );
                    } catch (e) {
                      // Error handling is done in controller
                    }
                  },
                );
              default:
                return const SizedBox.shrink();
            }
          },
        );
  }
}

/// Notification Setting Item Widget
/// 
/// Individual setting row with title, description, and toggle switch.
/// Design Source: Figma frame "Notification settings" (node-id: 1-11405)
/// 
/// Layout matches Figma exactly:
/// - Row height: 48px
/// - Title: 12px, bold, capitalize
/// - Description: 12px, regular, letter-spacing 0.24px
/// - Switch: 28x16px, positioned on the right
class _NotificationSettingItem extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final bool isSaving;
  final ValueChanged<bool> onChanged;

  const _NotificationSettingItem({
    required this.title,
    required this.description,
    required this.value,
    this.isSaving = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // Matches Figma item height
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text content - 300px width in Figma, flexible here
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title - 12px, bold, capitalize
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.textPrimary,
                    height: 16 / 12, // Line height 16px
                  ),
                ),
                const SizedBox(height: 0), // No spacing between title and description in Figma
                // Description - 12px, regular, letter-spacing 0.24px
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.24,
                    height: 16 / 12, // Line height 16px
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12), // Matches Figma spacing (312px - 300px = 12px)
          // Toggle switch - 28x16px
          // Active: #7132f4 (AppColors.primary)
          // Inactive: #cac7d0
          // Show loading indicator when saving
          isSaving
              ? const SizedBox(
                  width: 28,
                  height: 16,
                  child: Center(
                    child: SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                )
              : Switch(
                  value: value,
                  onChanged: onChanged,
                  activeTrackColor: AppColors.primary, // #7132f4
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFCAC7D0), // Matches Figma inactive color
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
        ],
      ),
    );
  }
}

