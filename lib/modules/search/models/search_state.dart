/// Search UI State
/// 
/// Enum representing different states of the search UI
library;

enum SearchUiState {
  idle, // Initial empty state with trending searches
  typing, // User is typing, show suggestions
  results, // Search results displayed
  categoryTab, // Category tab selected
  notFound, // No results found
}

