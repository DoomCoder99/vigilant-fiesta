import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../controller/quick_trigger_controller.dart';
import '../models/quick_trigger_state.dart';
import '../widgets/floating_quick_trigger_button.dart';

/// Service Information Overlay Widget
/// 
/// Displays service information in various states:
/// - onTheDay: Full overlay with service details, agent info, and action buttons
/// - minimized: Small pill button (handled by FloatingQuickTriggerButton)
/// - onCompletion: Completion message with rating CTA
/// - thanks: Thank you message after review submission
/// 
/// Design Source: Figma frames:
/// - "Service information - on the day" (node-id: 1-22819)
/// - "Service information - minimized" (node-id: 1-24836)
/// - "Service information - on completion" (node-id: 1-23365, 1-23637, 1-23904, 1-23091, 1-24183)
/// - "Service information - thanks" (node-id: 1-24465)
class ServiceInfoOverlayWidget extends StatelessWidget {
  const ServiceInfoOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuickTriggerController>();

    return Obx(() {
      if (!controller.isVisible.value) {
        return const SizedBox.shrink();
      }

      // If minimized, show only the floating button
      if (controller.currentState.value == QuickTriggerState.minimized) {
        return const FloatingQuickTriggerButton();
      }

      // Otherwise show the overlay
      return Stack(
        children: [
          // Backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: () => controller.minimizeOverlay(),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Overlay content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildOverlayContent(context, controller),
          ),
        ],
      );
    });
  }

  Widget _buildOverlayContent(BuildContext context, QuickTriggerController controller) {
    switch (controller.currentState.value) {
      case QuickTriggerState.onTheDay:
        return _buildOnTheDayOverlay(context, controller);
      case QuickTriggerState.onCompletion:
        return _buildOnCompletionOverlay(context, controller);
      case QuickTriggerState.thanks:
        return _buildThanksOverlay(context, controller);
      case QuickTriggerState.minimized:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOnTheDayOverlay(BuildContext context, QuickTriggerController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xxl),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with minimize button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20), // Spacer for centering
              Expanded(
                child: Text(
                  'Service scheduled for today!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.minimizeOverlay(),
                child: Image.asset(
                  'assets/quick_trigger/hide_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.close, size: 20);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Service description
          Text(
            'Your service for ${controller.serviceName.value ?? "Service"} is on the way!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Divider
          const Divider(color: AppColors.inputBorder, height: 1),
          const SizedBox(height: AppSpacing.lg),
          // Agent info
          Row(
            children: [
              // Agent avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6D1B0),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: controller.agentAvatarUrl.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          controller.agentAvatarUrl.value!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 24);
                          },
                        ),
                      )
                    : const Icon(Icons.person, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              // Agent details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.agentName.value ?? 'Agent Name',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.28,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${controller.agentId.value ?? "Executive ID"} ${controller.agencyName.value ?? "Service agency name"}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        color: AppColors.textPrimary.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Rating and verified badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Rating
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.agentRating.value?.toStringAsFixed(1) ?? "4.5",
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Image.asset(
                          'assets/quick_trigger/star_icon.png',
                          width: 8,
                          height: 8,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.star, size: 8, color: Colors.amber);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Verified badge
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/quick_trigger/shield_icon.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.verified, size: 20, color: AppColors.primary);
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Amozit\nVerified',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Arrival time
          Text(
            'Reaching to your location by ${controller.arrivalTime.value ?? "08:00 am"}',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Action buttons
          Row(
            children: [
              // Add ons button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to add-ons screen
                    Navigator.of(context).pushNamed(AppRoutes.serviceAddons);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxxxl,
                      vertical: AppSpacing.lg,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add ons',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Image.asset(
                        'assets/quick_trigger/shopping_cart_icon.png',
                        width: 16,
                        height: 16,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.shopping_cart, size: 16, color: Colors.white);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + AppSpacing.sm),
              // Call button
              Container(
                width: 80,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.serviceCall,
                      arguments: {
                        'orderId': controller.currentOrderId.value,
                        'callType': 'outgoing',
                        'callState': 'ringing',
                        'agentName': controller.agentName.value,
                      },
                    );
                  },
                  icon: Image.asset(
                    'assets/quick_trigger/call_icon.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.call, size: 16, color: AppColors.primary);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOnCompletionOverlay(BuildContext context, QuickTriggerController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xxl),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Close button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => controller.minimizeOverlay(),
                child: Image.asset(
                  'assets/quick_trigger/hide_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.close, size: 20);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Completion message
          Text(
            'Service Completed!',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Your service for ${controller.serviceName.value ?? "Service"} has been completed successfully.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Rating CTA button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.serviceReview,
                  arguments: {
                    'orderId': controller.currentOrderId.value,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                ),
                elevation: 0,
              ),
              child: Text(
                'Rate Now',
                style: AppTextStyles.button.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThanksOverlay(BuildContext context, QuickTriggerController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xxl),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Confetti/decorative image
          Image.asset(
            'assets/quick_trigger/confetti_icon.png',
            width: 128,
            height: 128,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.celebration, size: 128, color: AppColors.primary);
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          // Thanks message
          Text(
            'Thanks!',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Your feedback helps us improve our services.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              letterSpacing: 0.24,
            ),
          ),
        ],
      ),
    );
  }
}

