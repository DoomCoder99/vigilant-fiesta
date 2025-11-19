import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;

/// Quick Menu Electrical Screen
/// 
/// Displays quick menu for electrical services as a modal bottom sheet.
/// Design Source: Figma frame "Quick menu - Electrical services" (node-id: 1-10299)
class QuickMenuElectricalScreen extends StatelessWidget {
  const QuickMenuElectricalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Switch & Socket',
        'icon': Icons.power,
      },
      {
        'title': 'Doorbell & Security',
        'icon': Icons.doorbell,
      },
      {
        'title': 'Wiring',
        'icon': Icons.cable,
      },
      {
        'title': 'Light & Fan',
        'icon': Icons.lightbulb,
      },
      {
        'title': 'MCB / Fuse',
        'icon': Icons.electrical_services,
      },
      {
        'title': 'Appliance Installation',
        'icon': Icons.build,
      },
      {
        'title': 'Other Consultation',
        'icon': Icons.chat_bubble_outline,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(0, AppSpacing.xxl, 0, AppSpacing.xxxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Electrical Services',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: AssetHelper.loadImageOrIcon(
                    assetPath: assets.AssetPaths.iconCloseSmall,
                    fallbackIcon: Icons.close,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Menu items list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: menuItems.map((item) => _buildMenuItem(context, item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        // TODO: Navigate to service detail when implemented
        // Navigator.of(context).pushNamed(
        //   AppRoutes.serviceDetail,
        //   arguments: {'serviceName': item['title']},
        // );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Text(
                item['title'] as String,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

