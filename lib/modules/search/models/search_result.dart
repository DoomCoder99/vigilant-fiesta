/// Search Result Models
/// 
/// Models for search results (products and services)
library;

enum SearchResultType {
  product,
  service,
}

class SearchResult {
  final String id;
  final SearchResultType type;
  final String title;
  final String? category;
  final String? imageUrl;
  final double? price; // For products
  final double? rating; // For both
  final int? bookings; // For services
  final String? description;

  const SearchResult({
    required this.id,
    required this.type,
    required this.title,
    this.category,
    this.imageUrl,
    this.price,
    this.rating,
    this.bookings,
    this.description,
  });
}

class SearchSuggestion {
  final String text;
  final SearchResultType? type; // null for general suggestions

  const SearchSuggestion({
    required this.text,
    this.type,
  });
}

