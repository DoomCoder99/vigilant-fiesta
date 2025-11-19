import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_cart_controller.dart';

/// Subscription Payment Success Screen
/// 
/// Displays success confirmation after subscription payment.
/// Design Source: Figma frame "Payment success" (node-id: 1-16890)
class SubscriptionPaymentSuccessScreen extends StatelessWidget {
  const SubscriptionPaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<SubscriptionCartController>();
    final cartItem = cartController.cartItems.isNotEmpty
        ? cartController.cartItems.first
        : null;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.xxxxxl),
                // Success illustration card
                Container(
                  width: 320,
                  height: 380,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // Success message text
                      Positioned(
                        top: AppSpacing.xxxxxl,
                        left: 0,
                        right: 0,
                        child: Text(
                          'Yay! That was\nsmooth!',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backgroundWhite,
                            height: 1.17,
                          ),
                        ),
                      ),
                      // Robot illustration placeholder
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Checkmark badge
                              Positioned(
                                right: AppSpacing.xxl,
                                top: AppSpacing.xxl,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              // Robot placeholder
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.smart_toy,
                                  size: 120,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxxxl),
                // Subscription confirmation message
                Text(
                  cartItem != null
                      ? 'Your subscription to\n${cartItem.venue.name}\n${cartItem.plan.name}\nhas been activated!'
                      : 'Your subscription has been activated!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    height: 1.33,
                  ),
                ),
                if (cartItem != null && cartItem.slotSelection != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Slot: ${cartItem.slotSelection!.timeRange}\nStarting: ${cartItem.slotSelection!.startDate.toString().split(' ')[0]}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textPrimary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxxxxl),
                // View my subscriptions button (future screen)
                SizedBox(
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to my subscriptions screen
                      Get.offAllNamed(AppRoutes.explore);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.backgroundWhite,
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'View my subscriptions',
                      style: AppTextStyles.button.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // Go to Home button
                SizedBox(
                  width: 320,
                  child: OutlinedButton(
                    onPressed: () {
                      cartController.clearCart();
                      Get.offAllNamed(AppRoutes.explore);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Go to Home',
                      style: AppTextStyles.buttonSecondary.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

