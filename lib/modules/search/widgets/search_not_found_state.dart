import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../controller/search_controller.dart';

/// Search Not Found State Widget
/// 
/// Displays empty state when no search results are found.
class SearchNotFoundState extends StatelessWidget {
  final SearchController controller;

  const SearchNotFoundState({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          
          // Illustration
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/blank_states/search_not_found.png',
                width: 160,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return AssetHelper.loadImageOrPlaceholder(
                    assetPath: 'assets/search/illustration_not_found.png',
                    width: 160,
                    height: 160,
                  );
                },
              ),
              Positioned(
                top: 2,
                child: Image.asset(
                  'assets/blank_states/search_not_found_ellipse.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return AssetHelper.loadImageOrPlaceholder(
                      assetPath: 'assets/search/ellipse_not_found.png',
                      width: 60,
                      height: 60,
                    );
                  },
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // Message
          Text(
            'Oops. Nothing found\nfor your search.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.28,
            ),
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // Suggestions
          Obx(() {
            if (controller.trendingSearches.isEmpty) {
              return const SizedBox.shrink();
            }
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maybe, try these instead:',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: controller.trendingSearches.take(10).map((search) {
                    return _SuggestionChip(
                      text: search,
                      onTap: () => controller.selectTrendingSearch(search),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SuggestionChip({
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

