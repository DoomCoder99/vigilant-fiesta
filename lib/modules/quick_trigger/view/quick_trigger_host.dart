import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quick_trigger_controller.dart';
import '../view/service_info_overlay_widget.dart';

/// Quick Trigger Host Widget
/// 
/// Wraps the main app content and provides the Quick Trigger floating button
/// and Service Information overlay functionality.
/// 
/// This widget should wrap screens that need Quick Trigger functionality
/// (typically screens with bottom navigation bar).
class QuickTriggerHost extends StatelessWidget {
  final Widget child;

  const QuickTriggerHost({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already initialized
    Get.put(QuickTriggerController(), permanent: true);

    return Stack(
      children: [
        // Main content
        child,
        // Quick Trigger overlay (floating button + service info overlay)
        const ServiceInfoOverlayWidget(),
      ],
    );
  }
}

