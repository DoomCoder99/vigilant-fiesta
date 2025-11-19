import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/quick_trigger_controller.dart';

/// Floating Quick Trigger Button
/// 
/// A floating action button that appears above the bottom navigation bar.
/// Displays a lightning bolt icon and opens the Service Information overlay when tapped.
/// 
/// Design Source: Figma - Quick Trigger button (minimized state)
/// Position: Bottom-right, above bottom navigation bar
class FloatingQuickTriggerButton extends StatelessWidget {
  const FloatingQuickTriggerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuickTriggerController>();

    return Obx(() {
      if (!controller.isVisible.value) {
        return const SizedBox.shrink();
      }

      // Calculate position relative to bottom navigation bar
      // Bottom nav: 280px wide, centered, 24px bottom margin
      // Nav bar height: ~48px (8px padding top + ~32px content + 8px padding bottom)
      // Button should be positioned above nav bar, aligned with nav bar's right edge
      final screenWidth = MediaQuery.of(context).size.width;
      final navBarWidth = 280.0;
      final navBarCenter = screenWidth / 2;
      final navBarRightEdge = navBarCenter + (navBarWidth / 2); // Right edge of centered nav bar
      final buttonSize = 72.0;
      final bottomNavMargin = 24.0; // AppSpacing.xxl
      final navBarHeight = 48.0; // Approximate nav bar height
      final spacingAboveNav = 16.0; // Space between button and nav bar
      
      return Positioned(
        bottom: bottomNavMargin + navBarHeight + spacingAboveNav, // ~88px from bottom
        right: screenWidth - navBarRightEdge + (buttonSize / 2), // Aligned with nav bar right edge, centered on button
        child: GestureDetector(
          onTap: () => controller.toggleOverlay(),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                'assets/quick_trigger/lightning_icon.png',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if image not available
                  return const Icon(
                    Icons.bolt,
                    color: Colors.white,
                    size: 32,
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

