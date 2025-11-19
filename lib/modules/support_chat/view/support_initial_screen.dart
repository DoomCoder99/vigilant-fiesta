import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Support Initial Screen
/// 
/// Initial screen for support that shows order context and quick actions.
/// Design Source: Figma frame "Support - initial" (node-id: 1:29648)
/// Following WDI Flutter Coding Standards.
class SupportInitialScreen extends StatelessWidget {
  final String? orderId;
  final String? productName;

  const SupportInitialScreen({
    super.key,
    this.orderId,
    this.productName,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final displayOrderId = orderId ?? args?['orderId'] as String?;
    final displayProductName = productName ?? args?['productName'] as String? ?? 'Product';

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
        title: Text(
          'Support',
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
            // Product context header
            ...[
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.inputBorder,
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      child: Image.asset(
                        'assets/my_orders/product_bose_headphones.png',
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, size: 30, color: AppColors.textPrimary);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Support for',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary.withValues(alpha: 0.6),
                            letterSpacing: 0.24,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          displayProductName,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                            letterSpacing: 0.28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
            ],

            // Product support helpline section
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.textSecondary),
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product support helpline',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildSupportLinkRow(
                    'Bose Support Website',
                    'www.support.bose.ae',
                    onTap: () {
                      // TODO: Open URL
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSupportLinkRow(
                    'Email Support',
                    'support@bose.ae',
                    onTap: () {
                      // TODO: Open email client
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSupportLinkRow(
                    'Toll - free number',
                    '1800 - 080 - 011',
                    onTap: () {
                      // TODO: Make phone call
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Start chat button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.supportChat,
                    arguments: {
                      'orderId': displayOrderId,
                      'productName': displayProductName,
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Start chat now',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportLinkRow(String label, String value, {required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: AppColors.textPrimary.withValues(alpha: 0.6),
              letterSpacing: 0.2,
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

