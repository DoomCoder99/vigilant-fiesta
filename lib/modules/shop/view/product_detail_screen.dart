import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../services/cart_service.dart';

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

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartService _cartService = CartService.instance;
  int _currentImageIndex = 0;

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
            icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: () {},
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
                  // Product details
                  _buildProductDetails(),
                  const SizedBox(height: AppSpacing.xxl),
                  // Reviews section
                  _buildReviewsSection(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            _buildReviewFilter('Best rated'),
            const SizedBox(width: AppSpacing.md),
            _buildReviewFilter('Most recent'),
            const SizedBox(width: AppSpacing.md),
            _buildReviewFilter('My location'),
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

  Widget _buildReviewFilter(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall,
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
        child: ElevatedButton(
          onPressed: () {
            if (isInCart) {
              _cartService.removeFromCart(productId);
            } else {
              _cartService.addToCart(productId);
            }
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
                isInCart ? 'Remove from Cart' : 'Add to Cart',
                style: AppTextStyles.button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

