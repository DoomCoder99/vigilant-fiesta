import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../view/search_results_screen.dart';

/// Search Screen
/// 
/// Main search screen with active keyboard and trending searches.
/// Design Source: Figma frame "Search" (node-id: 1-27201)
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _autoSuggestions = [];
  bool _showSuggestions = false;

  // Mock trending searches
  final List<String> _trendingSearches = [
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

  // Mock auto-suggestions (in real app, this would come from API)
  final Map<String, List<String>> _suggestionMap = {
    'swi': ['Switch', 'Smart switches installation', 'MCB and switch repair'],
    'cle': ['Cleaning', '1 BHK Cleaning', 'Office cleaning', 'bathroom cleaning'],
    'car': ['Car wash', 'Car interior & exterior cleaning', 'Rent Mercedes G Wagon'],
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Focus search field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        _showSuggestions = false;
        _autoSuggestions = [];
      });
      return;
    }

    // Generate auto-suggestions based on query
    final suggestions = <String>[];
    for (final entry in _suggestionMap.entries) {
      if (query.startsWith(entry.key)) {
        suggestions.addAll(entry.value);
      }
    }

    // Also check trending searches
    for (final trend in _trendingSearches) {
      if (trend.toLowerCase().contains(query) && !suggestions.contains(trend)) {
        suggestions.add(trend);
      }
    }

    setState(() {
      _autoSuggestions = suggestions;
      _showSuggestions = suggestions.isNotEmpty;
    });
  }

  void _handleSearch(String query) {
    if (query.trim().isEmpty) return;

    // Close keyboard
    _searchFocusNode.unfocus();

    // Navigate to search results
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(searchQuery: query),
      ),
    );
  }

  void _selectTrendingSearch(String search) {
    _searchController.text = search;
    _handleSearch(search);
  }

  void _selectSuggestion(String suggestion) {
    _searchController.text = suggestion;
    _handleSearch(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.all(AppSpacing.lg),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: AssetHelper.loadImageOrIcon(
                      assetPath: assets.AssetPaths.iconArrowLeft,
                      fallbackIcon: Icons.arrow_back,
                      size: 16,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      autofocus: true,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search for services & products',
                        hintStyle: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          color: AppColors.textPrimary.withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: _handleSearch,
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.cancel, size: 16, color: AppColors.textPrimary),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _showSuggestions = false;
                          _autoSuggestions = [];
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: _showSuggestions && _autoSuggestions.isNotEmpty
                  ? _buildAutoSuggestions()
                  : _buildTrendingSearches(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoSuggestions() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        Text(
          'Suggestions',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        ..._autoSuggestions.map((suggestion) => _buildSuggestionItem(suggestion)),
      ],
    );
  }

  Widget _buildSuggestionItem(String suggestion) {
    return InkWell(
      onTap: () => _selectSuggestion(suggestion),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          suggestion,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSearches() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        Text(
          'Trending searches',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _trendingSearches.map((search) {
            return InkWell(
              onTap: () => _selectTrendingSearch(search),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  search,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
