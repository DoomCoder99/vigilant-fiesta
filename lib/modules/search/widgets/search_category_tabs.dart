import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../controller/search_controller.dart';

/// Search Category Tabs Widget
/// 
/// Displays category filter tabs (All, Services, Products).
class SearchCategoryTabs extends StatelessWidget {
  final SearchController controller;

  const SearchCategoryTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD9D9D9),
            width: 1,
          ),
        ),
      ),
      child: Obx(() => Row(
        children: [
          _CategoryTab(
            label: 'All',
            isSelected: controller.selectedCategory.value == 'all',
            onTap: () => controller.changeCategory('all'),
          ),
          _CategoryTab(
            label: 'Services',
            isSelected: controller.selectedCategory.value == 'services',
            onTap: () => controller.changeCategory('services'),
          ),
          _CategoryTab(
            label: 'Products',
            isSelected: controller.selectedCategory.value == 'products',
            onTap: () => controller.changeCategory('products'),
          ),
        ],
      )),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Column(
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.5),
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

