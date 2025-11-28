import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/rtl_helper.dart';
import '../controller/localization_controller.dart';
import '../widgets/bottom_sheet.dart';
import 'language_selection_screen.dart';
import 'theme_selection_screen.dart';

/// Profile & More Screen
/// Main hub screen for user profile and settings.
/// Design Source: Figma frame "Profile & more" (node-id: 1-25349)

class ProfileAndMoreScreen extends StatelessWidget {
  const ProfileAndMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leadingWidth: 45,
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD6DEE8)),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Profile & more',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
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
                  const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'payment_methods'.tr,
                    onTap: () => Get.toNamed(AppRoutes.paymentMethods),
                  ),
                  const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'wallet'.tr,
                    onTap: () => Get.toNamed(AppRoutes.wallet),
                  ),
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'coupons_loyalty'.tr,
                    onTap: () => Get.toNamed(AppRoutes.coupons),
                  ),
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'documents'.tr,
                    onTap: () => Get.toNamed(AppRoutes.documents),
                  ),
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'help'.tr,
                    onTap: () => Get.toNamed(AppRoutes.helpFaq),
                  ),
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
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
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
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
                   const Divider(height: 1,color: Color(0xffD6DEE8),),
                  _SettingsListItem(
                    title: 'logout'.tr,
                      onTap: showSignOutSheet,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Refer & Earn Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildReferAndEarn(),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
  void showSignOutSheet() {
    showConfirmationSheet(
      title: "Sign Out",
      subtitle: "You are about to sign out of Amozit.\nAre you sure to do this?",
      cancelText: "No, Go Back",
      confirmText: "Yes, Sign out",
      confirmColor: const Color(0xFFF14336),
      icon: Image.asset(
        "assets/profile/exit 1.png",
        height: 140,
      ),
      onConfirm: () {
        // your sign-out logic
        Get.back();
      },
    );
  }







  Widget _buildReferAndEarn() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                "Refer & Earn Big!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              Text(
                "Invite your friends and earn rewards.\n"
                    "The more you share, the more you gain.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              /// Referral link box
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "www.amozit.com/referral/483BBJ78xh64",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Icon(Icons.copy, size: 22, color: Colors.grey.shade600),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Share button
              SizedBox(
                width: 200,
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff7132F4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: AppSpacing.xl,),
                      Text(
                        "Share With Friends",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// Top-right gift
          Positioned(
            top: 20,
            right: 10,
            child: Image.asset(
              "assets/home/image-removebg-preview (4) 2.png",
              scale: 4,
            ),
          ),

          /// Bottom-right gift
          Positioned(
            bottom: -100,
            right: -10,
            child: Image.asset(
              "assets/home/image-removebg-preview (4) 1.png",
              scale: 4,
            ),
          ),
        ],
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

