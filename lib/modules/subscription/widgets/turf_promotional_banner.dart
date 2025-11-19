import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Turf Promotional Banner Widget
/// 
/// Displays promotional banner for turf bookings.
/// Design Source: Figma frame "Sports & fitness" (node-id: 1-15889)
class TurfPromotionalBanner extends StatelessWidget {
  const TurfPromotionalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: const AssetImage('assets/subscriptions/turf/promotional_banner.png'),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
      ),
      child: Stack(
        children: [
          // Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Book Turfs as low as OMR 18 / hr',
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: 18,
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Enjoy your sports time, book at your preferred time slot.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppColors.backgroundWhite,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to turf listing or category
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundWhite,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Carousel indicators (bottom center)
          Positioned(
            bottom: AppSpacing.lg,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(true),
                const SizedBox(width: 4),
                _buildIndicator(false),
                const SizedBox(width: 4),
                _buildIndicator(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      width: isActive ? 20 : 4,
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.backgroundWhite
            : AppColors.backgroundWhite.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

