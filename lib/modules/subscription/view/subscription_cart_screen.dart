import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_cart_controller.dart';
import '../data/models/subscription_cart_item_model.dart';

/// Subscription Cart Screen
/// 
/// Displays subscription items in cart with payment summary.
/// Design Source: Figma frames "My cart – services only" (node-id: 1-16639, 1-16723)
class SubscriptionCartScreen extends StatelessWidget {
  const SubscriptionCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(SubscriptionCartController());
    
    // Get cart item from arguments if passed
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['cartItem'] != null) {
      final cartItem = args['cartItem'] as SubscriptionCartItemModel;
      cartController.addToCart(cartItem);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: AppColors.textPrimary),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Cart',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your cart is empty',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          );
        }

        final cartItem = cartController.cartItems.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subscription item section
              _buildSubscriptionItem(cartItem),
              
              const SizedBox(height: AppSpacing.lg),
              const Divider(height: 1),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Apply coupon code
              Text(
                'Apply coupon code',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),
              const Divider(height: 1),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Payment summary
              _buildPaymentSummary(cartController),
              
              const SizedBox(height: AppSpacing.lg),
              const Divider(height: 1),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Cancellation policy
              Text(
                'Cancellation policy',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus.',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textPrimary.withValues(alpha: 0.6),
                ),
              ),
              
              const SizedBox(height: 100), // Space for bottom button
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() => _buildBottomBar(cartController)),
    );
  }

  Widget _buildSubscriptionItem(SubscriptionCartItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sports & Fitness',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.venue.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withValues(alpha: 0.6),
                    ),
                  ),
                  if (item.courtType != null)
                    Text(
                      item.courtType!,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: AppColors.textPrimary.withValues(alpha: 0.6),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  // Subscription badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF218FC1), AppColors.primary],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Subscription',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 9,
                        color: AppColors.backgroundWhite,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.plan.name,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              item.plan.description,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 12,
                                color: AppColors.textPrimary.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        child: Text(
                          'OMR ${item.price.toStringAsFixed(0)}',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(SubscriptionCartController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment summary',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Item total', controller.itemTotal),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Platform fee', controller.platformFee.value),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Taxes', controller.taxes.value),
        const SizedBox(height: AppSpacing.md),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Total to pay', controller.totalToPay, isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            fontWeight: isTotal ? FontWeight.normal : FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(
            amount == 0 ? 'OMR -' : 'OMR ${amount.toStringAsFixed(0)}',
            textAlign: TextAlign.right,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary.withValues(alpha: 0.6),
              fontWeight: isTotal ? FontWeight.normal : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(SubscriptionCartController controller) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.subscriptionPaymentMethod);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${controller.itemCount}',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 8,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: 16,
                        color: AppColors.backgroundWhite.withValues(alpha: 0.3),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'OMR ${controller.totalToPay.toStringAsFixed(0)}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Continue',
                        style: AppTextStyles.button.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription mode',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Pay monthly',
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Switch(
                value: controller.payMonthly.value,
                onChanged: (value) => controller.updatePayMonthly(value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

