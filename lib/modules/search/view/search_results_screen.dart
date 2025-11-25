import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import 'search_not_found_screen.dart';

/// Search Results Screen
/// 
/// Displays search results category-wise (Services and Products).
/// Design Source: Figma frame "Search - on enter" (node-id: 1-27294)
class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String _selectedTab = 'All'; // All, Services, Products
  List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  bool _hasResults = false;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  void _performSearch() {
    // Mock search results - in real app, this would call an API
    final query = widget.searchQuery.toLowerCase();
    
    // Mock services matching the query
    _services = [
      {
        'title': '1 Switch',
        'category': 'Electrical Services',
        'rating': 5.0,
        'bookings': 248,
        'image': assets.AssetPaths.serviceItem1,
      },
      {
        'title': '2 Switches',
        'category': 'Electrical Services',
        'rating': 5.0,
        'bookings': 248,
        'image': assets.AssetPaths.serviceItem2,
      },
      {
        'title': 'More than 2 Switches',
        'category': 'Electrical Services',
        'rating': 5.0,
        'bookings': 248,
        'image': assets.AssetPaths.serviceItem3,
      },
      {
        'title': 'Power Switch',
        'category': 'Electrical Services',
        'rating': 5.0,
        'bookings': 248,
        'image': assets.AssetPaths.serviceItem4,
      },
    ].where((service) => 
      service['title'].toString().toLowerCase().contains(query) ||
      service['category'].toString().toLowerCase().contains(query)
    ).toList();

    // Mock products matching the query
    _products = [
      {
        'title': 'Legrand - Single Pole Switch 10 AX, 250 V~, White',
        'category': 'Electrical & Electronics',
        'price': 2.40,
        'rating': 5.0,
        'image': assets.AssetPaths.addonLegrandSinglePole,
      },
      {
        'title': 'Legrand - double Pole Switch 10 AX, 250 V~, White',
        'category': 'Electrical & Electronics',
        'price': 12.04,
        'rating': 5.0,
        'image': assets.AssetPaths.addonLegrandDoublePole,
      },
      {
        'title': 'Legrand Mylinc 16A Single Pole 1 Module 1 Way Switch',
        'category': 'Electrical & Electronics',
        'price': 4.00,
        'rating': 4.8,
        'image': assets.AssetPaths.addonLegrandMylinc,
      },
    ].where((product) => 
      product['title'].toString().toLowerCase().contains(query) ||
      product['category'].toString().toLowerCase().contains(query)
    ).toList();

    setState(() {
      _hasResults = _services.isNotEmpty || _products.isNotEmpty;
      _isLoading = false;
    });

    // If no results, navigate to not found screen
    if (!_hasResults) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SearchNotFoundScreen(searchQuery: widget.searchQuery),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasResults) {
      return const SizedBox.shrink(); // Will navigate to not found screen
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: AssetHelper.loadImageOrIcon(
            assetPath: assets.AssetPaths.iconArrowLeft,
            fallbackIcon: Icons.arrow_back,
            size: 16,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.searchQuery,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel, size: 16, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.inputBorder)),
            ),
            child: Row(
              children: [
                _buildTab('All', _selectedTab == 'All'),
                _buildTab('Services', _selectedTab == 'Services'),
                _buildTab('Products', _selectedTab == 'Products'),
              ],
            ),
          ),
          // Results
          Expanded(
            child: _selectedTab == 'All'
                ? _buildAllResults()
                : _selectedTab == 'Services'
                    ? _buildServicesResults()
                    : _buildProductsResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
              color: isActive ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllResults() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_services.isNotEmpty) ...[
            Text(
              'Services',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            ..._services.map((service) => _buildServiceCard(service)),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
          ],
          if (_products.isNotEmpty) ...[
            Text(
              'Products',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            ..._products.map((product) => _buildProductCard(product)),
          ],
        ],
      ),
    );
  }

  Widget _buildServicesResults() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          'Services',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        ..._services.map((service) => _buildServiceCard(service)),
      ],
    );
  }

  Widget _buildProductsResults() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          'Products',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        ..._products.map((product) => _buildProductCard(product)),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.serviceDetail,
          arguments: {'serviceId': service['title']},
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Service image
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFDAE6ED),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AssetHelper.loadImageOrPlaceholder(
                  assetPath: service['image'] as String,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Service details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${service['rating']}',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      AssetHelper.loadImageOrIcon(
                        assetPath: assets.AssetPaths.star1,
                        fallbackIcon: Icons.star,
                        size: 8,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${service['bookings']} bookings)',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 8,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service['category'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 8,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Add button
            ElevatedButton(
              onPressed: () {
                // TODO: Add to cart or navigate to service detail
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: const Size(60, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Add',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productDetail,
          arguments: {'productId': product['title']},
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            // Product image
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AssetHelper.loadImageOrPlaceholder(
                  assetPath: product['image'] as String,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['category'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 8,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['title'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${product['price']}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'OMR',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Rating badge
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${product['rating']}',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  AssetHelper.loadImageOrIcon(
                    assetPath: assets.AssetPaths.star1,
                    fallbackIcon: Icons.star,
                    size: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

