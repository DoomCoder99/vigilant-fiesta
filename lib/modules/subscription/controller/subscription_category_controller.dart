import 'package:get/get.dart';
import '../data/models/subscription_category_model.dart';
import '../data/models/subscription_venue_model.dart';
import '../data/repository/subscription_repository.dart';

/// Subscription Category Controller
/// 
/// Manages state for Sports & Fitness category screen and venue listings.
/// Following WDI Flutter Coding Standards (GetX).
class SubscriptionCategoryController extends GetxController {
  final SubscriptionRepository _repository = SubscriptionRepository();

  // Categories
  final RxList<SubscriptionCategoryModel> categories =
      <SubscriptionCategoryModel>[].obs;

  // Selected category
  final RxString selectedCategoryId = 'sports_fitness'.obs;

  // Venues for selected category
  final RxList<SubscriptionVenueModel> venues = <SubscriptionVenueModel>[].obs;

  // Loading states
  final RxBool isLoadingCategories = false.obs;
  final RxBool isLoadingVenues = false.obs;

  // Quick menu selection (for Sports & Fitness)
  final RxString selectedQuickMenu = 'all'.obs; // 'all', 'turf', 'tennis', etc.

  // Expanded sections (for collapsible venue lists)
  final RxSet<String> expandedSections = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadVenues();
  }

  /// Load all categories
  Future<void> loadCategories() async {
    isLoadingCategories.value = true;
    try {
      final cats = await _repository.getCategories();
      categories.value = cats;
    } catch (e) {
      // Handle error
      // TODO: Implement proper error logging
    } finally {
      isLoadingCategories.value = false;
    }
  }

  /// Load venues for selected category
  Future<void> loadVenues() async {
    isLoadingVenues.value = true;
    try {
      final vs = await _repository.getVenuesByCategory(selectedCategoryId.value);
      venues.value = vs;
    } catch (e) {
      // Handle error
      // TODO: Implement proper error logging
    } finally {
      isLoadingVenues.value = false;
    }
  }

  /// Select a category
  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
    loadVenues();
  }

  /// Select quick menu item
  void selectQuickMenu(String menuId) {
    selectedQuickMenu.value = menuId;
    // Filter venues based on quick menu selection
    // TODO: Implement filtering logic
  }

  /// Toggle section expansion
  void toggleSection(String sectionId) {
    if (expandedSections.contains(sectionId)) {
      expandedSections.remove(sectionId);
    } else {
      expandedSections.add(sectionId);
    }
  }

  /// Check if section is expanded
  bool isSectionExpanded(String sectionId) {
    return expandedSections.contains(sectionId);
  }

  /// Get venues grouped by sport type (for Sports & Fitness)
  Map<String, List<SubscriptionVenueModel>> get venuesBySport {
    final Map<String, List<SubscriptionVenueModel>> grouped = {};
    for (final venue in venues) {
      // Extract sport type from venue name or metadata
      // For now, use a simple grouping
      final key = venue.name.toLowerCase().contains('tennis')
          ? 'tennis'
          : venue.name.toLowerCase().contains('football')
              ? 'football'
              : 'other';
      grouped.putIfAbsent(key, () => []).add(venue);
    }
    return grouped;
  }
}

