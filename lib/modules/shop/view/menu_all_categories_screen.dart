import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import 'menu_all_sub_categories_screen.dart';

/// Menu All Categories Screen
/// 
/// Displays all available product categories.
/// Design Source: Figma frame "Menu - All categories" (node-id: 1-4101)
/// Note: This is typically shown as a modal/drawer
class MenuAllCategoriesScreen extends StatelessWidget {
  const MenuAllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Personal care',
      'Electronic devices',
      'Home appliances',
      'Cloths & Apparels',
      'Sports & games',
      'Beauty & grooming',
      'cleaning products',
      'Bath & hygiene',
    ];
    final icons = [
      Icons.person,
      Icons.devices_other,
      Icons.home_work,
      Icons.checkroom,
      Icons.sports_soccer,
      Icons.face,
      Icons.cleaning_services,
      Icons.bathtub,
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
                  'All Categories',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Categories grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem(context, categories[0], icons[0]),
                    _buildCategoryItem(context, categories[1], icons[1]),
                    _buildCategoryItem(context, categories[2], icons[2]),
                    _buildCategoryItem(context, categories[3], icons[3]),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem(context, categories[4], icons[4]),
                    _buildCategoryItem(context, categories[5], icons[5]),
                    _buildCategoryItem(context, categories[6], icons[6]),
                    _buildCategoryItem(context, categories[7], icons[7]),
                  ],
                ),
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
        // Show sub-categories for Electronic devices, otherwise go to category listing
        if (name == 'Electronic devices') {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => MenuAllSubCategoriesScreen(categoryName: name),
          );
        } else {
          Navigator.of(context).pushNamed(
            AppRoutes.categoryListing,
            arguments: {'categoryName': name},
          );
        }
      },
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1EBFE),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  child: Icon(icon, color: AppColors.primary, size: 32),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.2,
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

