import '../models/search_result.dart';

/// Search Repository
/// 
/// Handles search API calls and data management.
/// Following WDI Flutter Coding Standards.
class SearchRepository {
  // TODO: Replace with actual API service
  // static const String baseUrl = "https://api.example.com/";
  
  /// Get search suggestions based on query
  /// 
  /// [query] - The search query text
  /// Returns list of suggestions
  Future<List<SearchSuggestion>> getSuggestions(String query) async {
    // TODO: Implement actual API call
    // For now, return mock data
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate debounce
    
    if (query.isEmpty) {
      return [];
    }
    
    // Mock suggestions based on query
    final queryLower = query.toLowerCase();
    final suggestions = <SearchSuggestion>[];
    
    // Service suggestions
    if (queryLower.contains('swi') || queryLower.contains('switch')) {
      suggestions.addAll([
        const SearchSuggestion(text: 'Smart switches installation', type: SearchResultType.service),
        const SearchSuggestion(text: 'MCB and switch repair', type: SearchResultType.service),
      ]);
    }
    
    // Product suggestions
    if (queryLower.contains('swi') || queryLower.contains('switch')) {
      suggestions.addAll([
        const SearchSuggestion(text: 'Smart switches', type: SearchResultType.product),
        const SearchSuggestion(text: 'MCB and Switch', type: SearchResultType.product),
        const SearchSuggestion(text: 'AC Switch box', type: SearchResultType.product),
      ]);
    }
    
    return suggestions;
  }
  
  /// Perform search with query
  /// 
  /// [query] - The search query
  /// [category] - Optional category filter
  /// Returns list of search results
  Future<List<SearchResult>> search(String query, {String? category}) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    
    if (query.isEmpty) {
      return [];
    }
    
    // Mock search results
    final queryLower = query.toLowerCase();
    final results = <SearchResult>[];
    
    if (queryLower.contains('switch')) {
      // Service results
      if (category == null || category == 'all' || category == 'services') {
        results.addAll([
          SearchResult(
            id: 'service_1',
            type: SearchResultType.service,
            title: '1 Switch',
            category: 'Electrical Services',
            imageUrl: 'assets/search/service_1_switch.png',
            rating: 5.0,
            bookings: 248,
          ),
          SearchResult(
            id: 'service_2',
            type: SearchResultType.service,
            title: '2 Switches',
            category: 'Electrical Services',
            imageUrl: 'assets/search/service_2_switches.png',
            rating: 5.0,
            bookings: 248,
          ),
          SearchResult(
            id: 'service_3',
            type: SearchResultType.service,
            title: 'More than 2 Switches',
            category: 'Electrical Services',
            imageUrl: 'assets/search/service_more_switches.png',
            rating: 5.0,
            bookings: 248,
          ),
          SearchResult(
            id: 'service_4',
            type: SearchResultType.service,
            title: 'Power Switch',
            category: 'Electrical Services',
            imageUrl: 'assets/search/service_power_switch.png',
            rating: 5.0,
            bookings: 248,
          ),
        ]);
      }
      
      // Product results
      if (category == null || category == 'all' || category == 'products') {
        results.addAll([
          SearchResult(
            id: 'product_1',
            type: SearchResultType.product,
            title: 'Legrand - Single Pole Switch 10 AX, 250 V~, White',
            category: 'Electrical & Electronics',
            imageUrl: 'assets/search/product_single_pole_switch.png',
            price: 2.40,
            rating: 5.0,
          ),
          SearchResult(
            id: 'product_2',
            type: SearchResultType.product,
            title: 'Legrand - double Pole Switch 10 AX, 250 V~, White',
            category: 'Electrical & Electronics',
            imageUrl: 'assets/search/product_double_pole_switch.png',
            price: 12.04,
            rating: 5.0,
          ),
          SearchResult(
            id: 'product_3',
            type: SearchResultType.product,
            title: 'Legrand Mylinc 16A Single Pole 1 Module 1 Way Switch',
            category: 'Electrical & Electronics',
            imageUrl: 'assets/search/product_mylinc_switch.png',
            price: 4.00,
            rating: 4.8,
          ),
        ]);
      }
    }
    
    return results;
  }
  
  /// Get trending searches
  Future<List<String>> getTrendingSearches() async {
    // TODO: Implement actual API call
    return const [
      '1 BHK Cleaning',
      'AC Installation',
      'Gas Cylinder booking',
      'football turf booking',
      'Office cleaning',
      'tap repair',
      'bathroom cleaning',
      'Car wash',
      'van rental',
      'driving class',
    ];
  }
  
  /// Get recent searches (from local storage)
  Future<List<String>> getRecentSearches() async {
    // TODO: Implement local storage retrieval
    return [];
  }
  
  /// Save recent search (to local storage)
  Future<void> saveRecentSearch(String query) async {
    // TODO: Implement local storage save
  }
}

