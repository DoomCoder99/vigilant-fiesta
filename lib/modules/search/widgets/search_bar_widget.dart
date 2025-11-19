import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../controller/search_controller.dart';

/// Search Bar Widget
/// 
/// Reusable search bar with back button, text input, and clear button.
class SearchBarWidget extends StatelessWidget {
  final SearchController controller;
  final TextEditingController? textController;
  final FocusNode? focusNode;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.textController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final localTextController = textController ?? TextEditingController();
    final localFocusNode = focusNode ?? FocusNode();
    
    // Sync with controller
    localTextController.text = controller.searchQuery.value;
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.inputBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: AssetHelper.loadImageOrIcon(
              assetPath: 'assets/search/icon_arrow_left.png',
              fallbackIcon: Icons.arrow_back,
              size: 16,
              color: AppColors.textPrimary,
            ),
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: AppSpacing.md),
          
          // Search input
          Expanded(
            child: TextField(
              controller: localTextController,
              focusNode: localFocusNode,
              autofocus: true,
              style: AppTextStyles.input,
              decoration: InputDecoration(
                hintText: 'Search for services & products',
                hintStyle: AppTextStyles.input.copyWith(
                  color: AppColors.inputPlaceholder.withOpacity(0.4),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                controller.updateQuery(value);
              },
              onSubmitted: (value) {
                controller.performSearch(value);
              },
              textInputAction: TextInputAction.search,
            ),
          ),
          
          // Clear button
          Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: AssetHelper.loadImageOrIcon(
                assetPath: 'assets/search/icon_cancel.png',
                fallbackIcon: Icons.close,
                size: 16,
                color: AppColors.textPrimary,
              ),
              onPressed: () {
                localTextController.clear();
                controller.clearSearch();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            );
          }),
        ],
      ),
    );
  }
}

