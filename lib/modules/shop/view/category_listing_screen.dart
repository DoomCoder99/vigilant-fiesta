import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../../../../core/widgets/amozit_empty_state_widget.dart';
import '../services/cart_service.dart';
import 'menu_all_categories_screen.dart';

/// Category Listing Screen
/// 
/// Displays products in a specific category with filters.
/// Design Source: Figma frame "Category listing" (node-id: 1-3185)
/// Also handles "product added to cart" state (node-id: 1-3413)
class CategoryListingScreen extends StatefulWidget {
  final String? categoryName;

  const CategoryListingScreen({
    super.key,
    this.categoryName,
  });

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  String? _selectedFilter = 'Latest';
  final CartService _cartService = CartService.instance;
  
  // TODO: Replace with actual product data
  final List<String> _products = List.generate(10, (i) => 'product_$i');
  
  // Check if filters are active (not "Latest")
  bool get _hasActiveFilters => _selectedFilter != 'Latest';
  
  // Check if filtered results are empty
  bool get _hasNoFilteredResults {
    if (!_hasActiveFilters) return false;
    // TODO: Replace with actual filtered product count
    return false; // Placeholder - replace with actual filter logic
  }

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Get category name from route arguments if not provided
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayCategoryName = widget.categoryName ?? args?['categoryName'] ?? 'Category';

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: AssetHelper.loadImageOrIcon(
            assetPath: assets.AssetPaths.iconBackArrow,
            fallbackIcon: Icons.arrow_back,
            size: 16,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: Color(0xFFEBEBEB)),
            ),
          ),
        ),
        title: Text(
          displayCategoryName,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w500, // Medium weight as per Figma
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: AssetHelper.loadImageOrIcon(
              assetPath: assets.AssetPaths.iconApps,
              fallbackIcon: Icons.apps,
              size: 16,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const MenuAllCategoriesScreen(),
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(36, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: Color(0xFFEBEBEB)),
              ),
            ),
          ),
          IconButton(
            icon: AssetHelper.loadImageOrIcon(
              assetPath: assets.AssetPaths.iconSearch,
              fallbackIcon: Icons.search,
              size: 16,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.search);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(36, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: Color(0xFFEBEBEB)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textPrimary, size: 16),
            onPressed: () {
              // TODO: Implement filters
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(36, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: Color(0xFFEBEBEB)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          _buildFilterTabs(),
          // Product grid or empty state
          Expanded(
            child: _hasNoFilteredResults && _hasActiveFilters
                ? AmozitEmptyStateWidget(
                    title: 'Oops. seems like it\'s empty here!',
                    assetPath: 'assets/blank_states/filter_empty.png',
                    illustrationOverlay: Image.asset(
                      'assets/blank_states/filter_empty_ellipse.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                    primaryCtaLabel: 'Adjust the Filters',
                    onPrimaryCtaTap: () {
                      // TODO: Open filter dialog/sheet
                      setState(() {
                        _selectedFilter = 'Latest'; // Reset to default
                      });
                    },
                    secondaryCtaLabel: 'Clear Filters',
                    onSecondaryCtaTap: () {
                      setState(() {
                        _selectedFilter = 'Latest'; // Clear filters
                      });
                    },
                    buttonsStacked: true,
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.lg,
                      mainAxisSpacing: AppSpacing.lg,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final productId = _products[index];
                      return _buildProductCard(context, productId, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Latest', 'Tablets', 'mobiles', 'laptops', 'headphones'];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 24,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: filters.map((filter) {
                final isActive = _selectedFilter == filter;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          filter,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10,
                            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                            color: isActive 
                                ? AppColors.textPrimary 
                                : AppColors.textPrimary.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: const Icon(
              Icons.view_cozy,
              size: 12,
              color: AppColors.backgroundWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String productId, int index) {
    final isInCart = _cartService.isInCart(productId);
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productDetail,
          arguments: {'productId': productId},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.inputBorder,
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Stack(
                children: [
                  AssetHelper.loadImageOrPlaceholder(
                    assetPath: _getProductImagePath(index),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Rating badge
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '5',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                          AssetHelper.loadImageOrIcon(
                            assetPath: assets.AssetPaths.star1,
                            fallbackIcon: Icons.star,
                            size: 8,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Discount badge
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1EBFE),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.6),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '10% off',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Electronic devices',
            style: AppTextStyles.caption.copyWith(
              fontSize: 8,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Bose QuietComfort® 45 Headphones',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(
                '12.04',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                'OMR',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    if (isInCart) {
                      _cartService.removeFromCart(productId);
                    } else {
                      _cartService.addToCart(productId);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isInCart 
                          ? AppColors.primary.withOpacity(0.3)
                          : AppColors.primary,
                    ),
                    backgroundColor: isInCart 
                        ? AppColors.primary.withOpacity(0.1)
                        : Colors.transparent,
                    foregroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 28),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    isInCart ? 'Added' : 'add to cart',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 12,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Get asset path for product image based on index
  String _getProductImagePath(int index) {
    // Map product indices to downloaded product images
    final productImages = [
      assets.AssetPaths.productImage9,
      assets.AssetPaths.productImage10,
      assets.AssetPaths.productImage11,
      assets.AssetPaths.productImage12,
      assets.AssetPaths.productImage13,
      assets.AssetPaths.productImage14,
      assets.AssetPaths.productImage15,
      assets.AssetPaths.productImage16,
    ];
    if (index < productImages.length) {
      return productImages[index % productImages.length];
    }
    return assets.AssetPaths.productPlaceholder; // Fallback to placeholder
  }
}


