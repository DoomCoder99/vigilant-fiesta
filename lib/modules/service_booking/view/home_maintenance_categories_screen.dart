import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;

/// Home Maintenance Categories Screen
/// 
/// Displays home maintenance service categories as a modal bottom sheet.
/// Design Source: Figma frame "Home maintenance categories" (node-id: 1-8459)
class HomeMaintenanceCategoriesScreen extends StatelessWidget {
  const HomeMaintenanceCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Electrical',
      'Plumbing',
      'Carpentry',
      'light & fan',
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
                  'Home maintenance',
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
          // Categories grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryItem(context, categories[0], Icons.electrical_services),
                _buildCategoryItem(context, categories[1], Icons.plumbing),
                _buildCategoryItem(context, categories[2], Icons.handyman),
                _buildCategoryItem(context, categories[3], Icons.lightbulb_outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String name, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // Navigate to Electrical Services screen
        if (name == 'Electrical') {
          Navigator.of(context).pushNamed(
            AppRoutes.homeServicesElectrical,
            arguments: {'category': name},
          );
        } else {
          // TODO: Navigate to other category screens when implemented
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name category coming soon'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                height: 1.2, // 12px / 10px
                letterSpacing: 0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

