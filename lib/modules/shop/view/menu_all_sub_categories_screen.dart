import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Menu All Sub Categories Screen
/// 
/// Displays sub-categories for a specific category.
/// Design Source: Figma frame "Menu - All sub categories" (node-id: 1-4142)
/// Note: This is typically shown as a modal/drawer
class MenuAllSubCategoriesScreen extends StatelessWidget {
  final String? categoryName;

  const MenuAllSubCategoriesScreen({
    super.key,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final displayCategoryName = categoryName ?? 'Electronic Devices';
    final subCategories = ['Tablets', 'mobiles', 'laptops', 'headphones', 'Speakers', 'More'];

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
                Expanded(
                  child: Text(
                    'All Sections in $displayCategoryName',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
          // Sub-categories list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: subCategories.map((subCategory) {
                final isLast = subCategory == subCategories.last;
                return Column(
                  children: [
                    _buildSubCategoryItem(context, subCategory),
                    if (!isLast) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryItem(BuildContext context, String name) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(
          AppRoutes.categoryListing,
          arguments: {'categoryName': name},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Text(
          name,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

