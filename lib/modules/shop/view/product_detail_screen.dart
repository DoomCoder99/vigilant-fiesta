import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../services/cart_service.dart';
import '../services/favorites_service.dart';

/// Product Detail Screen
/// 
/// Displays detailed product information, reviews, and add to cart functionality.
/// Design Source: Figma frames "Product detail" (node-id: 1-3660, 1-5186, 1-5408, 1-5625, 1-6074)
/// Supports multiple product variants through configuration
class ProductDetailScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailScreen({
    super.key,
    this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  final CartService _cartService = CartService.instance;
  final FavoritesService _favoritesService = FavoritesService.instance;
  int _currentImageIndex = 0;
  late TabController _tabController;
  String _selectedReviewFilter = 'Best rated';

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
    _favoritesService.addListener(_onFavoritesChanged);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    _favoritesService.removeListener(_onFavoritesChanged);
    _tabController.dispose();
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
    // Get product ID from route arguments if not provided
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayProductId = widget.productId ?? args?['productId'] ?? '';
    final isInCart = _cartService.isInCart(displayProductId);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Electronic Devices',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _favoritesService.isFavorite(displayProductId)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: _favoritesService.isFavorite(displayProductId)
                  ? Colors.red
                  : AppColors.textPrimary,
            ),
            onPressed: () {
              _favoritesService.toggleFavorite(displayProductId);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: () {
              Share.share(
                'Check out this product: Bose QuietComfort® 45 Headphones\nPrice: OMR 12.04\nFrom AMOZIT',
                subject: 'Product from AMOZIT',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image carousel
            _buildImageCarousel(context),
            // Product info
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Electronic devices',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Bose QuietComfort® 45 Headphones',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '5',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '(248 Reviews)',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Text(
                        'OMR 12.04',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'OMR',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Tabs for Product Details and Reviews
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'Product Details'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  SizedBox(
                    height: 600,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Product Details Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProductDetails(),
                            ],
                          ),
                        ),
                        // Reviews Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: _buildReviewsSection(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, displayProductId, isInCart),
    );
  }

  Widget _buildImageCarousel(BuildContext context) {
    final images = List.generate(5, (index) => 'image_$index'); // Placeholder
    
    return Stack(
      children: [
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.inputBorder,
          ),
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5],
                  ),
                ),
                child: Center(
                  child: AssetHelper.loadImageOrPlaceholder(
                    assetPath: assets.AssetPaths.productImage9, // Use first product image as placeholder
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        // Image pagination dots
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              final isActive = index == _currentImageIndex;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: isActive ? 20 : 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brand', style: AppTextStyles.caption),
                  Text('Bose', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Warranty', style: AppTextStyles.caption),
                  Text('1 year', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Color', style: AppTextStyles.caption),
                  Text('Deep Plum', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Noise control', style: AppTextStyles.caption),
                  Text('ANC', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Bose QuietComfort Ultra Bluetooth Headphones, Wireless Headphones with Spatial Audio...',
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'About this item',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'SPATIAL AUDIO HEADPHONES: Bose QuietComfort Ultra Headphones with spatial audio give you an immersive experience...',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    // Star rating distribution data (5 to 1 stars)
    final ratingDistribution = {
      5: 182,
      4: 60,
      3: 3,
      2: 0,
      1: 0,
    };
    final totalReviews = ratingDistribution.values.fold(0, (sum, count) => sum + count);
    final overallRating = 4.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall rating and star distribution
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overallRating.toString(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                // Star display
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < overallRating.floor()
                          ? Icons.star
                          : (index < overallRating ? Icons.star_half : Icons.star_border),
                      size: 12,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Overall rating',
                  style: AppTextStyles.caption.copyWith(fontSize: 8),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Star rating progress bars (5 to 1)
                  ...ratingDistribution.entries.map((entry) {
                    final starCount = entry.key;
                    final reviewCount = entry.value;
                    final percentage = totalReviews > 0 ? reviewCount / totalReviews : 0.0;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                '$starCount',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.star, size: 8, color: Colors.amber),
                            ],
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD6DEE8),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: percentage,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.textPrimary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          SizedBox(
                            width: 20,
                            child: Text(
                              reviewCount.toString().padLeft(2, '0'),
                              textAlign: TextAlign.right,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'All reviews',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Review filters
        Row(
          children: [
            _buildReviewFilter('Best rated', _selectedReviewFilter == 'Best rated'),
            const SizedBox(width: AppSpacing.md),
            _buildReviewFilter('Most recent', _selectedReviewFilter == 'Most recent'),
            const SizedBox(width: AppSpacing.md),
            _buildReviewFilter('My location', _selectedReviewFilter == 'My location'),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // Review items
        _buildReviewItem('Wade Warren', 'Sep 12', 5),
        const Divider(),
        _buildReviewItem('Ronald Richards', 'Sep 12', 5),
        const Divider(),
        _buildReviewItem('Jane Cooper', 'Sep 12', 5),
      ],
    );
  }

  Widget _buildReviewFilter(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReviewFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withOpacity(0.6)
                : AppColors.inputBorder,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(String name, String date, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTextStyles.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              ...List.generate(rating, (index) => const Icon(Icons.star, size: 12, color: Colors.amber)),
              const SizedBox(width: AppSpacing.sm),
              Text(date, style: AppTextStyles.caption),
              const SizedBox(width: AppSpacing.sm),
              Text('More than 2 Switches', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, String productId, bool isInCart) {
    final quantity = _cartService.getQuantity(productId);
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: isInCart && quantity > 0
            ? _buildCounterButton(productId)
            : ElevatedButton(
                onPressed: () {
                  _cartService.addToCart(productId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.backgroundWhite,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Add to Cart',
                      style: AppTextStyles.button,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

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
}

