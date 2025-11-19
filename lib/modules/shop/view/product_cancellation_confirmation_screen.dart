import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Product Cancellation Confirmation Screen
/// 
/// Bottom sheet dialog for confirming product order cancellation.
/// This is shown before navigating to the full Cancel Order screen (reason selection).
/// Design Source: Figma frame "Cancellation confirmation" (node-id: 1-7043)
class ProductCancellationConfirmationScreen extends StatelessWidget {
  final String? orderId;

  const ProductCancellationConfirmationScreen({
    super.key,
    this.orderId,
  });

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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.xxxxxl,
            AppSpacing.lg,
            AppSpacing.xxxxl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shopping cart with remove icon
              Image.asset(
                'assets/orders/cancel_order/icon_remove.png',
                width: 128,
                height: 128,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove_shopping_cart,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxxxl),
              // Title
              Text(
                'Cancel Order?',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Message
              Text(
                'You are about to cancel this order.\nAre you sure?',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  letterSpacing: 0.24,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxxl),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.backgroundWhite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxxxl,
                          vertical: AppSpacing.lg,
                        ),
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
                        // Navigate to Cancel Order screen (reason selection)
                        Navigator.of(context).pushNamed(
                          AppRoutes.cancelOrder,
                          arguments: {
                            'orderId': orderId,
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF14336)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxxxl,
                          vertical: AppSpacing.lg,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999), // Fully rounded
                        ),
                      ),
                      child: Text(
                        'Yes, Cancel Order',
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
      ),
    );
  }
}

