import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Subscription Banner Widget
/// 
/// Displays "Subscribe to sports?" banner with View Plans button.
/// Design Source: Figma frame "Sports & fitness" (node-id: 1-15889)
class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF218FC1), AppColors.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subscribe to sports?',
            style: AppTextStyles.caption.copyWith(
              fontSize: 10,
              color: AppColors.backgroundWhite,
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to subscription plans screen
              // Navigator.of(context).pushNamed(AppRoutes.subscriptionPlans);
            },
            child: Row(
              children: [
                Container(
                  width: 1,
                  height: 12,
                  color: AppColors.backgroundWhite.withValues(alpha: 0.3),
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  'View Plans',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10,
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

