import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../controller/search_controller.dart';
import '../models/search_result.dart';

/// Search Typing State Widget
/// 
/// Displays search suggestions while user is typing.
class SearchTypingState extends StatelessWidget {
  final SearchController controller;

  const SearchTypingState({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.suggestions.isEmpty && !controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Group suggestions by type
      final serviceSuggestions = controller.suggestions
          .where((s) => s.type == SearchResultType.service)
          .toList();
      final productSuggestions = controller.suggestions
          .where((s) => s.type == SearchResultType.product)
          .toList();

      return SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Services section
            if (serviceSuggestions.isNotEmpty) ...[
              Text(
                'Services',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ...serviceSuggestions.map((suggestion) => _SuggestionItem(
                    text: suggestion.text,
                    onTap: () => controller.selectSuggestion(suggestion),
                  )),
              const SizedBox(height: AppSpacing.lg),
              Divider(
                color: AppColors.inputBorder,
                height: 1,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],

            // Products section
            if (productSuggestions.isNotEmpty) ...[
              Text(
                'Products',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ...productSuggestions.map((suggestion) => _SuggestionItem(
                    text: suggestion.text,
                    onTap: () => controller.selectSuggestion(suggestion),
                  )),
            ],
          ],
        ),
      );
    });
  }
}

class _SuggestionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SuggestionItem({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Text(
          text,
          style: AppTextStyles.bodySmall,
        ),
      ),
    );
  }
}

