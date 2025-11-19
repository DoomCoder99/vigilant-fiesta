import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/search_controller.dart';
import '../models/search_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_idle_state.dart';
import '../widgets/search_typing_state.dart';
import '../widgets/search_results_state.dart';
import '../widgets/search_not_found_state.dart';

/// Search Screen
/// 
/// Main search screen handling all search states:
/// - Idle (trending searches)
/// - Typing (suggestions)
/// - Results (search results with category tabs)
/// - Not Found (empty state)
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            SearchBarWidget(controller: controller),
            
            // Content based on state
            Expanded(
              child: Obx(() {
                switch (controller.uiState.value) {
                  case SearchUiState.idle:
                    return SearchIdleState(controller: controller);
                  case SearchUiState.typing:
                    return SearchTypingState(controller: controller);
                  case SearchUiState.results:
                  case SearchUiState.categoryTab:
                    return SearchResultsState(controller: controller);
                  case SearchUiState.notFound:
                    return SearchNotFoundState(controller: controller);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

