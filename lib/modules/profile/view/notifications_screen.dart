import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../data/models/notification_model.dart';
import '../controller/notification_controller.dart';
import '../widgets/notification_blank.dart';
import '../widgets/notification_tile.dart';

/// Notifications Screen
/// 
/// Displays user notifications with multiple visual states.
/// Supports empty state, list view, and filtering.
/// Design Source: Figma frames "Notifications" (node-id: 1-11457, 1-11702, 1-11347)
/// 
/// Three visual states:
/// - State A/B: List view with notifications (different read/unread mixes)
/// - State C: Detailed notification list (node-id: 1-11347)
/// - Empty State: Blank state when no notifications (node-id: 1-11315)
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

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
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
        actions: [
          // Filter/Sort icon (matching Figma design - discover_tune icon)
          IconButton(
            icon: Image.asset(
              'assets/images/discover_tune.png',
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.tune, color: AppColors.textPrimary, size: 16);
              },
            ),
            onPressed: () {
              // TODO: Show filter/sort options if needed
            },
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
        ],
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Error state with retry
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    controller.errorMessage.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Obx(() => ElevatedButton(
                    onPressed: controller.isRetrying.value
                        ? null
                        : () => controller.retryFetchNotifications(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isRetrying.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Retry'),
                  )),
                ],
              ),
            ),
          );
        }

        // Empty state
        if (controller.filteredNotifications.isEmpty) {
          return const NotificationBlank();
        }

        // List state (State A, B, C from Figma)
        // Padding matches Figma: 25px horizontal (AppSpacing.xl = 25)
        return RefreshIndicator(
          onRefresh: () => controller.fetchNotifications(),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 25, // Matches Figma design (node-id: 1-11347)
              vertical: 24, // Matches Figma spacing between items
            ),
            itemCount: controller.filteredNotifications.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
            itemBuilder: (context, index) {
              final notification = controller.filteredNotifications[index];
              return NotificationTile(
                notification: notification,
                onTap: () {
                  controller.markAsRead(notification.id);
                  // Handle navigation based on notification type
                  if (notification.actionRoute != null) {
                    if (notification.actionArguments != null) {
                      Get.toNamed(
                        notification.actionRoute!,
                        arguments: notification.actionArguments,
                      );
                    } else {
                      Get.toNamed(notification.actionRoute!);
                    }
                  } else {
                    // Default navigation based on notification type
                    _handleNotificationNavigation(notification);
                  }
                },
              );
            },
          ),
        );
      }),
    );
  }

  /// Handle navigation based on notification type
  void _handleNotificationNavigation(notification) {
    switch (notification.type) {
      case NotificationType.order:
        // Navigate to order detail or tracking
        Get.toNamed(AppRoutes.tracking, arguments: {'orderId': notification.id});
        break;
      case NotificationType.rental:
        // Navigate to rental order detail
        // TODO: Add rental order detail route when available
        break;
      case NotificationType.service:
        // Navigate to service order detail
        Get.toNamed(AppRoutes.serviceOrderDetail, arguments: {'orderId': notification.id});
        break;
      case NotificationType.profile:
        // Navigate to profile edit
        Get.toNamed(AppRoutes.profileEdit);
        break;
      case NotificationType.promotion:
        // Navigate to coupons/promotions
        Get.toNamed(AppRoutes.coupons);
        break;
      case NotificationType.wishlist:
        // Navigate to wishlist
        // TODO: Add wishlist route when available
        break;
      case NotificationType.system:
        // Navigate to settings or help
        Get.toNamed(AppRoutes.helpFaq);
        break;
    }
  }
}

