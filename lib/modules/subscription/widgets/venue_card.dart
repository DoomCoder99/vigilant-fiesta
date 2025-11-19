import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../data/models/subscription_venue_model.dart';

/// Venue Card Widget
/// 
/// Displays a venue card with details and booking options.
/// Design Source: Figma frame "Sports & fitness" (node-id: 1-15889)
class VenueCard extends StatelessWidget {
  final SubscriptionVenueModel venue;
  final VoidCallback onViewDetails;
  final VoidCallback onBookSlot;

  const VenueCard({
    super.key,
    required this.venue,
    required this.onViewDetails,
    required this.onBookSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: const Color(0xFFD6DEE8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      venue.rating.toStringAsFixed(0),
                      style: AppTextStyles.caption.copyWith(fontSize: 8),
                    ),
                    const Icon(Icons.star, size: 8, color: Color(0xFFFFB800)),
                    Text(
                      ' (${venue.bookingCount} bookings)',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      venue.location,
                      style: AppTextStyles.caption.copyWith(fontSize: 8),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.textPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      venue.earliestAvailability ?? 'Available',
                      style: AppTextStyles.caption.copyWith(fontSize: 8),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onViewDetails,
                  child: Text(
                    'View details',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          ElevatedButton(
            onPressed: onBookSlot,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundWhite,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'book slot',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

