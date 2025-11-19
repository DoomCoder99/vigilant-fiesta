import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Cancellation Confirmation Dialog
/// 
/// Confirmation dialog for order cancellation/return.
/// Design Source: Figma frame "Cancellation confirmation" (node-id: 68-4301)
class CancellationConfirmationDialog extends StatelessWidget {
  const CancellationConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(0, AppSpacing.xxxxxl, 0, AppSpacing.xxxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                Text(
                  'Return Order?',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  'You are about to return this product.\nAre you sure?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.24,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxxxl),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.backgroundWhite,
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999), // Fully rounded
                          ),
                        ),
                        child: Text(
                          'No, Go Back',
                          style: AppTextStyles.button.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: Process cancellation/return via service/repository
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order return requested'),
                            ),
                          );
                          // Navigate back to My Orders
                          Navigator.of(context).pushReplacementNamed(AppRoutes.myOrders);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFF14336)),
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999), // Fully rounded
                          ),
                        ),
                        child: Text(
                          'Yes, Return product',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF14336),
                          ),
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
    );
  }
}
