import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Notification Blank Widget
/// 
/// Empty state widget displayed when there are no notifications.
/// Design Source: Figma frame "Notification - blank" (node-id: 1-11315)
/// 
/// Layout matches Figma exactly:
/// - Illustration: 160x160px, centered
/// - Text: 14px, medium weight, letter-spacing 0.28px, centered
/// - Vertical spacing: 24px between illustration and text
class NotificationBlank extends StatelessWidget {
  const NotificationBlank({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state illustration - 160x160px
          // Figma node: Frame 1171275638 (node-id: 1:11334)
          // Image: image 35 (node-id: 1:11335)
          Image.asset(
            'assets/blank_states/notifications_empty.png',
            width: 160,
            height: 160,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to old asset path
              return Image.asset(
                'assets/notifications/empty_state.png',
                width: 160,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Final fallback icon if image is missing
                  return Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_none,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24), // Matches Figma spacing (24px)
          // Empty state text - "No notifications till now."
          // Figma node: text (node-id: 1:11336)
          Text(
            'No notifications till now.',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.figtree,
              color: AppColors.textPrimary,
              letterSpacing: 0.28,
              height: 16 / 14, // Line height 16px
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

