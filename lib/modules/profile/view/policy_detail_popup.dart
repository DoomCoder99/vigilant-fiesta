import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Policy Detail Popup
/// 
/// Displays policy details in a modal.
/// Design Source: Figma frame "policy detail - Pop up" (node-id: 1-25900)
class PolicyDetailPopup extends StatelessWidget {
  final String policyName;

  const PolicyDetailPopup({super.key, required this.policyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  policyName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/profile/close_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.close, size: 20);
                  },
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _getPolicyContent(policyName),
                style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPolicyContent(String policy) {
    // TODO: Fetch actual policy content from backend
    return '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
''';
  }
}

