import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_cart_controller.dart';

/// Subscription Payment Method Screen
/// 
/// Displays payment method selection for subscription checkout.
/// Design Source: Figma frame "Payment method – card added" (node-id: 1-16815)
class SubscriptionPaymentMethodScreen extends StatefulWidget {
  const SubscriptionPaymentMethodScreen({super.key});

  @override
  State<SubscriptionPaymentMethodScreen> createState() =>
      _SubscriptionPaymentMethodScreenState();
}

class _SubscriptionPaymentMethodScreenState
    extends State<SubscriptionPaymentMethodScreen> {
  String? _selectedPaymentMethod = 'mastercard';
  final SubscriptionCartController _cartController =
      Get.find<SubscriptionCartController>();

  @override
  Widget build(BuildContext context) {
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
          'Select payment method',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount to pay
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount to pay',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textPrimary.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Obx(() => Text(
                      'OMR ${_cartController.totalToPay.toStringAsFixed(0)}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14,
                      ),
                    )),
                // Subscription context message
                const SizedBox(height: AppSpacing.sm),
                Obx(() => Text(
                  _cartController.payMonthly.value
                      ? 'You will be charged monthly'
                      : 'One-time payment',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppColors.textPrimary.withValues(alpha: 0.6),
                  ),
                )),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.xxl),
            // Cards section
            _buildPaymentSection(
              'Cards',
              [
                _buildPaymentOption(
                  'Master Card',
                  '5600 **** **** **62',
                  Icons.credit_card,
                  value: 'mastercard',
                  isSelected: _selectedPaymentMethod == 'mastercard',
                ),
                _buildPaymentOption(
                  'Add new card',
                  null,
                  Icons.add,
                  value: 'add_card',
                  isSelected: false,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.xxl),
            // Wallets section
            _buildPaymentSection(
              'Wallets',
              [
                _buildPaymentOption(
                  'Amazon Pay',
                  'OMR 242',
                  Icons.account_balance_wallet,
                  value: 'amazon_pay',
                  isSelected: _selectedPaymentMethod == 'amazon_pay',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.xxl),
            // Net banking section
            _buildPaymentSection(
              'Net banking',
              [
                _buildPaymentOption(
                  'Add your bank',
                  null,
                  Icons.account_balance,
                  value: 'add_bank',
                  isSelected: false,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.xxl),
            // Pay after service section
            _buildPaymentSection(
              'Pay after service',
              [
                _buildPaymentOption(
                  'Pay by cash',
                  null,
                  Icons.money,
                  value: 'cash',
                  isSelected: _selectedPaymentMethod == 'cash',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.xxl),
            // Pay Now button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedPaymentMethod != null
                    ? () async {
                        try {
                          await _cartController.createSubscription(
                            paymentMethodId: _selectedPaymentMethod!,
                          );
                          Get.offNamed(AppRoutes.subscriptionPaymentSuccess);
                        } catch (e) {
                          // Handle error
                          Get.snackbar(
                            'Error',
                            'Failed to create subscription. Please try again.',
                            backgroundColor: AppColors.error,
                            colorText: AppColors.backgroundWhite,
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.backgroundWhite,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Pay now',
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection(String title, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ...options,
      ],
    );
  }

  Widget _buildPaymentOption(
    String title,
    String? subtitle,
    IconData icon, {
    required String value,
    required bool isSelected,
  }) {
    final isAddOption = value == 'add_card' || value == 'add_bank';

    return InkWell(
      onTap: () {
        if (isAddOption) {
          // TODO: Navigate to add card/bank screen
        } else {
          setState(() {
            _selectedPaymentMethod = value;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            if (!isAddOption)
              Radio<String>(
                value: value,
                groupValue: _selectedPaymentMethod,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedPaymentMethod = val;
                    });
                  }
                },
                activeColor: AppColors.primary,
              )
            else
              const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.textSecondary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(icon, size: 24, color: AppColors.textPrimary),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textPrimary),
          ],
        ),
      ),
    );
  }
}

