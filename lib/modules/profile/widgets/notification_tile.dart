import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../data/models/notification_model.dart';

/// Notification Tile Widget
/// 
/// Reusable widget for displaying a single notification item.
/// Design Source: Figma frame "Notifications" (node-id: 1-11347)
/// 
/// Layout matches Figma exactly:
/// - Icon: 48x48px with 12px padding (24x24px icon inside)
/// - Border: 1px solid #d6dee8, 8px border radius
/// - Title: 12px, bold, capitalize
/// - Message: 12px, regular, letter-spacing 0.24px, max 2 lines
/// - Timestamp: 10px, regular, opacity 40%, letter-spacing 0.2px
/// - Action link: 12px, underline, right-aligned
class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? _handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8), // Matches Figma spacing
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns action link to bottom
          children: [
            // Notification Icon - 48x48px container with 12px padding
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // Matches Figma padding
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFD6DEE8), // Matches Figma border color
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8), // Matches Figma border radius
              ),
              child: Image.asset(
                notification.iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.notifications_outlined,
                    size: 24,
                    color: AppColors.textPrimary,
                  );
                },
              ),
            ),
            const SizedBox(width: 8), // Matches Figma spacing between icon and content
            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title - 12px, bold, capitalize
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.figtree,
                      color: AppColors.textPrimary,
                      height: 16 / 12, // Line height 16px
                    ),
                  ),
                  const SizedBox(height: 0), // No spacing between title and message in Figma
                  // Message - 12px, regular, letter-spacing 0.24px
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.figtree,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.24,
                      height: 16 / 12, // Line height 16px
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 0), // No spacing between message and timestamp
                  // Timestamp - 10px, opacity 40%, letter-spacing 0.2px
                  Text(
                    notification.timestamp,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppFonts.figtree,
                      color: AppColors.textPrimary.withValues(alpha: 0.4),
                      letterSpacing: 0.2,
                      height: 16 / 10, // Line height 16px
                    ),
                  ),
                ],
              ),
            ),
            // Action Link (if present) - Right-aligned, underlined
            if (notification.actionText != null) ...[
              const SizedBox(width: 12), // Matches Figma spacing
              GestureDetector(
                onTap: () => _handleActionTap(),
                child: Text(
                  notification.actionText!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.textPrimary,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    height: 16 / 12, // Line height 16px
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    // Mark as read when tapped
    // Navigation will be handled by parent if needed
  }

  void _handleActionTap() {
    if (notification.actionRoute != null) {
      if (notification.actionArguments != null) {
        Get.toNamed(
          notification.actionRoute!,
          arguments: notification.actionArguments,
        );
      } else {
        Get.toNamed(notification.actionRoute!);
      }
    }
  }
}

