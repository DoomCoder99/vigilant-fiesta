import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../controller/search_controller.dart';

/// Search Idle State Widget
/// 
/// Displays trending searches when search screen is first opened.
class SearchIdleState extends StatelessWidget {
  final SearchController controller;

  const SearchIdleState({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending searches title
          Text(
            'Trending searches',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Trending searches chips
          Obx(() => Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: controller.trendingSearches.map((search) {
              return _TrendingSearchChip(
                text: search,
                onTap: () => controller.selectTrendingSearch(search),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}

class _TrendingSearchChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _TrendingSearchChip({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: AppTextStyles.caption.copyWith(
            fontSize: 10,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

