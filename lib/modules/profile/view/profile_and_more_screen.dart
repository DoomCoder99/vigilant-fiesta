import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/rtl_helper.dart';
import '../controller/localization_controller.dart';
import 'language_selection_screen.dart';
import 'theme_selection_screen.dart';

/// Profile & More Screen
/// 
/// Main hub screen for user profile and settings.
/// Design Source: Figma frame "Profile & more" (node-id: 1-25349)
class ProfileAndMoreScreen extends StatelessWidget {
  const ProfileAndMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(RtlHelper.getBackIcon(), color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          'profile_and_more'.tr,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/profile/notification_icon.png',
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.notifications_outlined, color: AppColors.textPrimary);
              },
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.notifications);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: Row(
                children: [
                  // Profile Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE6D1B0),
                      image: DecorationImage(
                        image: AssetImage('assets/profile/profile_avatar.png'),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Fallback to placeholder
                        },
                      ),
                    ),
                    child: Image.asset(
                      'assets/profile/profile_avatar.png',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person, size: 40, color: AppColors.textPrimary);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Faisal Ali',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.figtree,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'faisalali@ymail.com',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '+968 0202 4848',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit Button
                  IconButton(
                    icon: Image.asset(
                      'assets/profile/edit_icon.png',
                      width: 16,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.edit, size: 16, color: AppColors.textPrimary);
                      },
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.profileEdit);
                    },
                  ),
                ],
              ),
            ),

            // Quick Access Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: _QuickAccessCard(
                      icon: Icons.calendar_today_outlined,
                      label: 'my_orders'.tr,
                      onTap: () => Get.toNamed(AppRoutes.myOrders),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickAccessCard(
                      icon: Icons.favorite_border,
                      label: 'my_wishlist'.tr,
                      onTap: () => Get.toNamed(AppRoutes.wishlist),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickAccessCard(
                      icon: Icons.notifications_outlined,
                      label: 'notifications'.tr,
                      onTap: () => Get.toNamed(AppRoutes.notifications),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Settings List
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Column(
                children: [
                  _SettingsListItem(
                    title: 'addresses'.tr,
                    onTap: () => Get.toNamed(AppRoutes.addresses),
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'payment_methods'.tr,
                    onTap: () => Get.toNamed(AppRoutes.paymentMethods),
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'wallet'.tr,
                    onTap: () => Get.toNamed(AppRoutes.wallet),
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'coupons_loyalty'.tr,
                    onTap: () => Get.toNamed(AppRoutes.coupons),
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'documents'.tr,
                    onTap: () => Get.toNamed(AppRoutes.documents),
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'help'.tr,
                    onTap: () => Get.toNamed(AppRoutes.helpFaq),
                  ),
                  const Divider(height: 1),
                  Obx(() {
                    final controller = Get.find<LocalizationController>();
                    return _SettingsListItem(
                      title: '${'language'.tr}: ${controller.getCurrentLanguageName()}',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const LanguageSelectionScreen(),
                        );
                      },
                    );
                  }),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: '${'theme'.tr}: ${'theme_light'.tr}',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ThemeSelectionScreen(),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _SettingsListItem(
                    title: 'logout'.tr,
                    onTap: () {
                      // TODO: Implement logout logic
                      Get.dialog(
                        AlertDialog(
                          title: Text('logout'.tr),
                          content: Text('logout_confirmation'.tr),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text('cancel'.tr),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Clear session and navigate to sign in
                                Get.back();
                              },
                              child: Text('logout'.tr),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Refer & Earn Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'refer_earn'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.figtree,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'refer_earn_desc'.tr,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Referral Link
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      border: Border.all(color: const Color(0xFFDADADA)),
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'www.amozit.com/referral/483BBJ78xh64',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/profile/copy_icon.png',
                            width: 16,
                            height: 16,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.copy, size: 16);
                            },
                          ),
                          onPressed: () {
                            // TODO: Copy to clipboard
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('referral_link_copied'.tr)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Share Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement share functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/profile/share_icon.png',
                            width: 12,
                            height: 12,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.share, size: 12, color: Colors.white);
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'share_with_friends'.tr,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.figtree,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: const Color(0xFFD6DEE8)),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SettingsListItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              RtlHelper.getChevronIcon(),
              size: 20,
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

