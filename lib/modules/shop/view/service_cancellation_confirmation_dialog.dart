import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Service Cancellation Confirmation Dialog
/// 
/// Bottom sheet dialog for confirming service order cancellation.
/// Design Source: Figma frame "Cancellation confirmation" (node-id: 1-31084)
class ServiceCancellationConfirmationDialog extends StatelessWidget {
  final String? orderId;

  const ServiceCancellationConfirmationDialog({
    super.key,
    this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayOrderId = orderId ?? args?['orderId'] ?? '';

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
            AppSpacing.xxxxl,
            AppSpacing.lg,
            AppSpacing.xxxxl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Speech bubble icon
              Image.asset(
                'assets/my_orders/service_actions/speech_bubble.png',
                width: 128,
                height: 128,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.chat_bubble_outline, size: 128, color: AppColors.primary);
                },
              ),
              const SizedBox(height: AppSpacing.xxxxl),
              // Title
              Text(
                'Cancel Order?',
                textAlign: TextAlign.center,
                style: AppTextStyles.headingSmall.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Message
              Text(
                'You are about to cancel this service.\nAre you sure?',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxxl),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxxxl,
                          vertical: AppSpacing.lg,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
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
                        // TODO: Cancel service order via API
                        Navigator.of(context).pop();
                        // Navigate back to order detail with cancelled status
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.serviceOrderDetail,
                          arguments: {
                            'orderId': displayOrderId,
                            'orderStatus': 'ServiceOrderStatus.cancelled',
                          },
                        );
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Service order cancelled'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF14336)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxxxl,
                          vertical: AppSpacing.lg,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
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

