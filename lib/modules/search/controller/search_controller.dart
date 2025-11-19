import 'package:get/get.dart';
import '../models/search_result.dart';
import '../models/search_state.dart';
import '../repository/search_repository.dart';

/// Search Controller
/// 
/// Manages search state and business logic.
/// Following WDI Flutter Coding Standards (GetX).
class SearchController extends GetxController {
  final SearchRepository _repository = SearchRepository();
  
  // Observable state
  var searchQuery = ''.obs;
  var uiState = SearchUiState.idle.obs;
  var suggestions = <SearchSuggestion>[].obs;
  var searchResults = <SearchResult>[].obs;
  var trendingSearches = <String>[].obs;
  var recentSearches = <String>[].obs;
  var selectedCategory = 'all'.obs; // 'all', 'services', 'products'
  var isLoading = false.obs;
  
  // Debounce timer
  final _debounceTimer = Rx<Duration?>(null);
  
  @override
  void onInit() {
    super.onInit();
    _loadTrendingSearches();
    _loadRecentSearches();
  }
  
  /// Load trending searches
  Future<void> _loadTrendingSearches() async {
    try {
      final trends = await _repository.getTrendingSearches();
      trendingSearches.value = trends;
    } catch (e) {
      // Handle error
      print('Error loading trending searches: $e');
    }
  }
  
  /// Load recent searches
  Future<void> _loadRecentSearches() async {
    try {
      final recent = await _repository.getRecentSearches();
      recentSearches.value = recent;
    } catch (e) {
      // Handle error
      print('Error loading recent searches: $e');
    }
  }
  
  /// Update search query and trigger suggestions
  void updateQuery(String query) {
    searchQuery.value = query;
    
    // Cancel previous debounce timer
    _debounceTimer.value = null;
    
    if (query.isEmpty) {
      uiState.value = SearchUiState.idle;
      suggestions.clear();
      searchResults.clear();
      return;
    }
    
    // Set typing state
    uiState.value = SearchUiState.typing;
    
    // Debounce suggestions
    Future.delayed(const Duration(milliseconds: 300), () {
      if (searchQuery.value == query) {
        _fetchSuggestions(query);
      }
    });
  }
  
  /// Fetch search suggestions
  Future<void> _fetchSuggestions(String query) async {
    try {
      isLoading.value = true;
      final results = await _repository.getSuggestions(query);
      suggestions.value = results;
    } catch (e) {
      print('Error fetching suggestions: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Perform search
  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      uiState.value = SearchUiState.idle;
      searchResults.clear();
      return;
    }
    
    try {
      isLoading.value = true;
      searchQuery.value = query;
      
      // Save to recent searches
      await _repository.saveRecentSearch(query);
      await _loadRecentSearches();
      
      // Perform search
      final results = await _repository.search(query, category: selectedCategory.value);
      
      if (results.isEmpty) {
        uiState.value = SearchUiState.notFound;
      } else {
        uiState.value = SearchUiState.results;
        searchResults.value = results;
      }
    } catch (e) {
      print('Error performing search: $e');
      uiState.value = SearchUiState.notFound;
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Select a suggestion
  void selectSuggestion(SearchSuggestion suggestion) {
    searchQuery.value = suggestion.text;
    performSearch(suggestion.text);
  }
  
  /// Select a trending search
  void selectTrendingSearch(String query) {
    searchQuery.value = query;
    performSearch(query);
  }
  
  /// Clear search
  void clearSearch() {
    searchQuery.value = '';
    uiState.value = SearchUiState.idle;
    suggestions.clear();
    searchResults.clear();
    selectedCategory.value = 'all';
  }
  
  /// Change category tab
  void changeCategory(String category) {
    selectedCategory.value = category;
    
    // If we have results, filter them
    if (searchQuery.value.isNotEmpty && searchResults.isNotEmpty) {
      performSearch(searchQuery.value);
    }
  }
  
  /// Get filtered results based on selected category
  List<SearchResult> get filteredResults {
    if (selectedCategory.value == 'all') {
      return searchResults;
    } else if (selectedCategory.value == 'services') {
      return searchResults.where((r) => r.type == SearchResultType.service).toList();
    } else if (selectedCategory.value == 'products') {
      return searchResults.where((r) => r.type == SearchResultType.product).toList();
    }
    return searchResults;
  }
}

