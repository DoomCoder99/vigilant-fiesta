import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../../../../core/widgets/amozit_empty_state_widget.dart';
import '../services/cart_service.dart';
import '../services/favorites_service.dart';
import 'menu_all_categories_screen.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';

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
  final FavoritesService _favoritesService = FavoritesService.instance;
  int _currentBottomNavIndex = 1; // Shop tab is index 1
  
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
    _favoritesService.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    _favoritesService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  void _onFavoritesChanged() {
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
                builder: (context) => MenuAllCategoriesScreen(),
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
          // Banner carousel section (always shown when clicking on any main category)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: _buildBannerCarousel(),
          ),
          // Product added to cart carousel section (if any products in cart)
          if (_cartService.itemCount > 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text(
                      'Products Added to Cart',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildProductAddedToCartCarousel(),
                ],
              ),
            ),
          ],
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
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          // Navigate based on index
          switch (index) {
            case 0:
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.amozitLandingConfirmed,
                (route) => false,
              );
              break;
            case 1:
              // Already on shop page
              break;
            case 2:
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.myOrders,
                (route) => false,
              );
              break;
            case 3:
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.cart,
                (route) => false,
              );
              break;
          }
        },
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
                child: isInCart
                    ? _buildCounterButton(productId)
                    : OutlinedButton(
                        onPressed: () {
                          _cartService.addToCart(productId);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 28),
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'add to cart',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: () {
                  _favoritesService.toggleFavorite(productId);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    _favoritesService.isFavorite(productId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 12,
                    color: _favoritesService.isFavorite(productId)
                        ? Colors.red
                        : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build counter button for products in cart
  Widget _buildCounterButton(String productId) {
    final quantity = _cartService.getQuantity(productId);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (quantity <= 1) {
                _cartService.removeFromCart(productId);
              } else {
                _cartService.removeFromCart(productId);
              }
            },
            child: Text(
              '-',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 24,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              _cartService.addToCart(productId);
            },
            child: Text(
              '+',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build banner carousel section (shown when clicking on any main category)
  Widget _buildBannerCarousel() {
    // Banner carousel data with 3-4 images and separate text
    final bannerItems = [
      {
        'image': assets.AssetPaths.bannerMusicSpeaker,
        'title': 'Your new music companion!',
        'subtitle': 'Check the Bluetooth speaker range from Maestro.',
        'buttonText': 'Explore',
      },
      {
        'image': assets.AssetPaths.bannerCarCare,
        'title': 'Premium car care',
        'subtitle': 'near you, 24x7, Pick up & drop',
        'buttonText': 'Book Now',
      },
      {
        'image': assets.AssetPaths.bannerMusicSpeaker,
        'title': 'Services starting from OMR 9.99',
        'subtitle': 'Verified professionals, book at your preferred time slot.',
        'buttonText': 'Book Now',
      },
      {
        'image': assets.AssetPaths.bannerCarCare,
        'title': 'Get 20% off on your first consultation',
        'subtitle': 'Book now and save big on your first service',
        'buttonText': 'Shop Now',
      },
    ];

    return SizedBox(
      height: 180,
      child: CarouselSlider.builder(
        itemCount: bannerItems.length,
        itemBuilder: (context, index, realIndex) {
          final item = bannerItems[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Stack(
              children: [
                // Background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetHelper.loadImageOrPlaceholder(
                    assetPath: item['image'] as String,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // Content
                Positioned(
                  left: AppSpacing.lg,
                  top: AppSpacing.xxl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        item['subtitle'] as String,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate based on button text
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                        ),
                        child: Text(
                          item['buttonText'] as String,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 180,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  /// Build carousel for product added to cart section
  Widget _buildProductAddedToCartCarousel() {
    // Carousel data with 3-4 images and separate text
    final carouselItems = [
      {
        'image': assets.AssetPaths.productImage9,
        'text': 'Recently Added',
      },
      {
        'image': assets.AssetPaths.productImage10,
        'text': 'Popular Now',
      },
      {
        'image': assets.AssetPaths.productImage11,
        'text': 'Best Deals',
      },
      {
        'image': assets.AssetPaths.productImage12,
        'text': 'Top Rated',
      },
    ];

    return CarouselSlider.builder(
      itemCount: carouselItems.length,
      itemBuilder: (context, index, realIndex) {
        final item = carouselItems[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputBorder,
                    borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                  ),
                  child: AssetHelper.loadImageOrPlaceholder(
                    assetPath: item['image'] as String,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                item['text'] as String,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 120,
        viewportFraction: 0.3,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
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


