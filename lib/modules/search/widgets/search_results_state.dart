import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../controller/search_controller.dart';
import '../models/search_result.dart';
import 'search_category_tabs.dart';
import 'search_result_item.dart';

/// Search Results State Widget
/// 
/// Displays search results with category tabs and result list.
class SearchResultsState extends StatelessWidget {
  final SearchController controller;

  const SearchResultsState({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category tabs
        SearchCategoryTabs(controller: controller),
        
        // Results list
        Expanded(
          child: Obx(() {
            final filteredResults = controller.filteredResults;
            
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (filteredResults.isEmpty) {
              return const SizedBox.shrink();
            }
            
            // Group results by type
            final serviceResults = filteredResults
                .where((r) => r.type == SearchResultType.service)
                .toList();
            final productResults = filteredResults
                .where((r) => r.type == SearchResultType.product)
                .toList();
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Services section
                  if (serviceResults.isNotEmpty && 
                      (controller.selectedCategory.value == 'all' || 
                       controller.selectedCategory.value == 'services')) ...[
                    Text(
                      'Services',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...serviceResults.map((result) => SearchResultItem(
                          result: result,
                          onTap: () => _handleServiceTap(context, result),
                        )),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(
                      color: AppColors.inputBorder,
                      height: 1,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  
                  // Products section
                  if (productResults.isNotEmpty && 
                      (controller.selectedCategory.value == 'all' || 
                       controller.selectedCategory.value == 'products')) ...[
                    Text(
                      'Products',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...productResults.map((result) => SearchResultItem(
                          result: result,
                          onTap: () => _handleProductTap(context, result),
                        )),
                  ],
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
  
  void _handleServiceTap(BuildContext context, SearchResult result) {
    // Navigate to service detail
    Navigator.of(context).pushNamed(
      AppRoutes.serviceDetail,
      arguments: {'serviceId': result.id},
    );
  }
  
  void _handleProductTap(BuildContext context, SearchResult result) {
    // Navigate to product detail
    Navigator.of(context).pushNamed(
      AppRoutes.productDetail,
      arguments: {'productId': result.id},
    );
  }
}

