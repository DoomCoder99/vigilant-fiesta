import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import 'menu_all_categories_screen.dart';

/// Shop Landing Screen
/// 
/// Main shop screen displaying categories and featured products.
/// Design Source: Figma frame "Shop landing" (node-id: 1-2906)
class ShopLandingScreen extends StatefulWidget {
  const ShopLandingScreen({super.key});

  @override
  State<ShopLandingScreen> createState() => _ShopLandingScreenState();
}

class _ShopLandingScreenState extends State<ShopLandingScreen> {
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildShopLanding(context);
  }

  Widget _buildShopLanding(BuildContext context) {
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
          'Shop',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.search);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            // Banner section
            _buildBanner(context),
            const SizedBox(height: AppSpacing.xxl),
            // Shop by category section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildShopByCategory(context),
            ),
            const SizedBox(height: AppSpacing.xxl),
            // Featured/Best sellers tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildProductTabs(context),
            ),
            const SizedBox(height: AppSpacing.xxl),
            // Product grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildProductGrid(context),
            ),
            const SizedBox(height: AppSpacing.xxl),
            // Promotional banner
            _buildPromotionalBanner(),
            const SizedBox(height: AppSpacing.xxl),
            // Refer & Earn section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildReferAndEarn(),
            ),
            const SizedBox(height: AppSpacing.xxxxxl), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBanner(BuildContext context) {
    // Banner data with 3-4 images and separate text
    final banners = [
      {
        'title': 'Services starting from OMR 9.99',
        'subtitle': 'Verified professionals, book at your preferred time slot.',
        'buttonText': 'Book Now',
        'bgColor': const Color(0xFF7132F4), // Primary purple
      },
      {
        'title': 'Your new music companion!',
        'subtitle': 'Check the Bluetooth speaker range from Maestro.',
        'buttonText': 'Explore',
        'bgColor': const Color(0xFF1E88E5), // Blue for music banner
      },
      {
        'title': 'Premium car care',
        'subtitle': 'near you, 24x7, Pick up & drop',
        'buttonText': 'Book Now',
        'bgColor': const Color(0xFF7132F4),
      },
      {
        'title': 'Get 20% off on your first consultation',
        'subtitle': 'Book now and save big on your first service',
        'buttonText': 'Shop Now',
        'bgColor': const Color(0xFFD5B591),
      },
    ];

    return SizedBox(
      height: 180,
      child: CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          final banner = banners[index];
          return _buildBannerItem(
            banner['title'] as String,
            banner['subtitle'] as String,
            banner['buttonText'] as String,
            banner['bgColor'] as Color,
          );
        },
        options: CarouselOptions(
          height: 180,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          onPageChanged: (index, reason) {
            setState(() {
              _currentBannerIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildBannerItem(String title, String subtitle, String buttonText, Color bgColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // Background decoration circles
          Positioned(
            right: AppSpacing.xxl,
            top: AppSpacing.xxl,
            child: Container(
              width: 61,
              height: 61,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            child: Container(
              width: 57,
              height: 57,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
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
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    if (buttonText == 'Explore') {
                      // Navigate to shop categories or products
                    } else {
                      // TODO: Navigate to services booking
                    }
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
                    buttonText,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Pagination dots - will be handled by CarouselSlider
        ],
      ),
    );
  }

  Widget _buildShopByCategory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shop by category',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => MenuAllCategoriesScreen(),
                );
              },
              child: Text(
                'View All',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryCard(
              context,
              'Personal care',
              Icons.person,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Personal care'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'Electronic devices',
              Icons.devices,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Electronic devices'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'Home appliances',
              Icons.home,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Home appliances'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'Cloths & Apparels',
              Icons.checkroom,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Cloths & Apparels'},
                );
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryCard(
              context,
              'Sports & games',
              Icons.sports_soccer,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Sports & games'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'Beauty & grooming',
              Icons.face,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Beauty & grooming'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'cleaning products',
              Icons.cleaning_services,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'cleaning products'},
                );
              },
            ),
            _buildCategoryCard(
              context,
              'Bath & hygiene',
              Icons.bathroom,
              () {
                Navigator.of(context).pushNamed(
                  AppRoutes.categoryListing,
                  arguments: {'categoryName': 'Bath & hygiene'},
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String name,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: AssetHelper.loadImageOrIcon(
              assetPath: _getCategoryIconPath(name),
              fallbackIcon: icon,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: 64,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTabs(BuildContext context) {
    return Row(
      children: [
        _buildTab('Featured', true),
        const SizedBox(width: AppSpacing.lg),
        _buildTab('Best sellers', false),
        const SizedBox(width: AppSpacing.lg),
        _buildTab('top deals', false),
        const SizedBox(width: AppSpacing.lg),
        _buildTab('new arrivals', false),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          width: 79,
          height: 2,
          color: isActive ? AppColors.primary : Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.lg,
        mainAxisSpacing: AppSpacing.lg,
        childAspectRatio: 0.75,
      ),
      itemCount: 6, // Placeholder count
      itemBuilder: (context, index) {
        return _buildProductCard(context, index);
      },
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productDetail,
          arguments: {'productId': 'product_$index'},
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
              child: AssetHelper.loadImageOrPlaceholder(
                assetPath: _getProductImagePath(index),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Product Name',
            style: AppTextStyles.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'OMR 12.04',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 164,
      decoration: BoxDecoration(
        color: const Color(0xFFD5B591),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          Positioned(
            left: AppSpacing.lg,
            top: AppSpacing.lg,
            child: Container(
              width: 146,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: const Icon(Icons.image, size: 60),
            ),
          ),
          Positioned(
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Get 20% off on your\nfirst consultation',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                  ),
                  child: Text(
                    'SIBERT',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
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
  }

  Widget _buildReferAndEarn() {
    const referralCode = '#0233444';
    const referralUrl = 'www.amozit.com/referral/483BBJ78xh64';
    const fullReferralText = '$referralUrl $referralCode';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxxxl),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Refer & Earn big!',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Invite your friends and earn rewards. The more you share, the more you gain.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.inputBorder),
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fullReferralText,
                    style: AppTextStyles.bodySmall,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.content_copy, size: 16),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: fullReferralText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Referral code copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () async {
              await Share.share(
                'Check out AMOZIT! Use my referral code $referralCode: $referralUrl',
                subject: 'AMOZIT Referral',
              );
            },
            icon: const Icon(Icons.share, size: 12),
            label: Text(
              'share with friends',
              style: AppTextStyles.bodySmall,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return AppBottomNavigationBar(
      currentIndex: 1, // Shop is selected
      onTap: (index) {
        // Navigation handled by AppBottomNavigationBar
        // Master navigation will handle route switching
      },
    );
  }

  /// Get asset path for category icon
  String _getCategoryIconPath(String categoryName) {
    final name = categoryName.toLowerCase();
    if (name.contains('personal care')) return assets.AssetPaths.categoryPersonalCare;
    if (name.contains('electronic')) return assets.AssetPaths.categoryElectronicDevices;
    if (name.contains('home appliance')) return assets.AssetPaths.categoryHomeAppliances;
    if (name.contains('cloth') || name.contains('apparel')) return assets.AssetPaths.categoryClothing;
    if (name.contains('mobile') || name.contains('computer')) return assets.AssetPaths.categoryMobilesComputers;
    if (name.contains('sport') || name.contains('game')) return assets.AssetPaths.categorySportsGames;
    if (name.contains('beauty') || name.contains('grooming')) return assets.AssetPaths.categoryBeautyGrooming;
    if (name.contains('cleaning')) return assets.AssetPaths.categoryCleaningProducts;
    if (name.contains('bath') || name.contains('hygiene')) return assets.AssetPaths.categoryBathHygiene;
    return ''; // Return empty string to trigger fallback
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
      return productImages[index];
    }
    return assets.AssetPaths.productPlaceholder; // Fallback to placeholder
  }
}

