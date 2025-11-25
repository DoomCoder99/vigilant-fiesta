import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../core/widgets/quick_access_first_time_overlay.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../../service_booking/view/home_maintenance_categories_screen.dart';
import '../../quick_trigger/view/quick_trigger_host.dart';
import '../widgets/location_bottom_sheet.dart';
import 'menu_all_categories_screen.dart';

/// Amozit Landing Confirmed Screen
/// 
/// Main landing screen after user confirmation with bottom navigation.
/// Design Source: Figma frame "Amozit Landing Confirmed" (node-id: 1-2517)
class AmozitLandingConfirmedScreen extends StatefulWidget {
  const AmozitLandingConfirmedScreen({super.key});

  @override
  State<AmozitLandingConfirmedScreen> createState() => _AmozitLandingConfirmedScreenState();
}

class _AmozitLandingConfirmedScreenState extends State<AmozitLandingConfirmedScreen> {
  int _currentIndex = 0; // 0 = Home, 1 = Shop, 2 = Orders, 3 = Cart
  int _currentBannerIndex = 0; // Current banner carousel index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: QuickAccessFirstTimeOverlay(
        child: QuickTriggerHost(
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Status bar area (handled by system)
          const SizedBox(height: AppSpacing.xxxxl),
          // Banner section (includes Location & Profile overlay and Search bar)
          _buildBanner(),
          const SizedBox(height: AppSpacing.xxl),
          // Quick Services section
          _buildQuickServices(),
          const SizedBox(height: AppSpacing.xxl),
          // Shop by category section
          _buildShopByCategory(),
          const SizedBox(height: AppSpacing.xxl),
          // Promotional banner
          _buildPromotionalBanner(),
          const SizedBox(height: AppSpacing.xxl),
          // Top rated services section
          _buildTopRatedServices(),
          const SizedBox(height: AppSpacing.xxl),
          // Refresh banner
          _buildRefreshBanner(),
          const SizedBox(height: AppSpacing.xxl),
          // Bestsellers section
          _buildBestsellers(),
          const SizedBox(height: AppSpacing.xxl),
          // Bose promotional banner
          _buildBoseBanner(),
          const SizedBox(height: AppSpacing.xxl),
          // Top rated women's salons section
          _buildTopRatedSalons(),
          const SizedBox(height: AppSpacing.xxl),
          // Refer & Earn section
          _buildReferAndEarn(),
          const SizedBox(height: AppSpacing.xxxxxl), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildBanner() {
    // Banner data with images and text
    final banners = [
      {
        'image': assets.AssetPaths.bannerCarCare,
        'title': 'premium car care',
        'subtitle': 'near you, 24x7, Pick up & drop',
        'buttonText': 'Book Now',
      },
      {
        'image': assets.AssetPaths.bannerMusicSpeaker,
        'title': 'Your new music companion!',
        'subtitle': 'Check the Bluetooth speaker range from Maestro.',
        'buttonText': 'Explore',
      },
      {
        'image': assets.AssetPaths.bannerSibert,
        'title': 'Get 20% off on your first consultation',
        'subtitle': 'Verified professionals, book at your preferred time slot.',
        'buttonText': 'Book Now',
      },
      {
        'image': assets.AssetPaths.bannerRefresh,
        'title': 'Super Clean Home Interior Cleaning Services',
        'subtitle': 'REFRSH - Professional cleaning services',
        'buttonText': 'Book Now',
      },
    ];

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          // Carousel background images
          CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIndex) {
              final banner = banners[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.0),
                    ],
                    stops: const [0.09, 0.37],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background image
                    Positioned.fill(
                      child: AssetHelper.loadImageOrPlaceholder(
                        assetPath: banner['image'] as String,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.0),
                            ],
                            stops: const [0.09, 0.37],
                          ),
                        ),
                      ),
                    ),
                    // Content overlay
                    Positioned(
                      right: AppSpacing.lg,
                      top: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            banner['title'] as String,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFD5B591),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            banner['subtitle'] as String,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // TODO: Navigate based on button text
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(
                                    minWidth: 120,
                                    minHeight: 32,
                                  ),
                                  child: Text(
                                    banner['buttonText'] as String,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
              height: 400,
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
          // Location & Profile - positioned at top
          _buildLocationAndProfile(),
          // Search bar - positioned below location & profile
          _buildSearchBarInBanner(),
          // Pagination dots
          Positioned(
            bottom: AppSpacing.lg,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                final isActive = index == _currentBannerIndex;
                return Container(
                  width: isActive ? 20 : 4,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
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
      ),
    );
  }

  Widget _buildLocationAndProfile() {
    return Positioned(
      top: 44, // Position from top of banner
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location section - clickable
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const LocationBottomSheet(),
              );
            },
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Koramangala',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                      ],
                    ),
                    Text(
                      'Bengaluru, Karnataka',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Profile avatar - clickable, positioned at right
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.profileAndMore);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFE6D1B0),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile/profile_avatar.png',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6D1B0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.textPrimary,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBarInBanner() {
    return Positioned(
      top: 100, // Position from top of banner (below Location & Profile)
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.search);
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                'Search',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Services',
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
                  'See all',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              final services = [
                'Home maintenance',
                'cleaning & pest control',
                'sports & fitness',
                'rent a vehicle',
                'driving instructor',
                "women's salon & spa",
                'gas cylinder booking',
                'painting services',
              ];
              final icons = [
                Icons.home_repair_service,
                Icons.cleaning_services,
                Icons.fitness_center,
                Icons.directions_car,
                Icons.drive_eta,
                Icons.face,
                Icons.local_gas_station,
                Icons.format_paint,
              ];
              return _buildServiceCard(services[index], icons[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String name, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Navigate to Home Maintenance Categories if "Home maintenance" is tapped
        if (name.toLowerCase().contains('home maintenance')) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => const HomeMaintenanceCategoriesScreen(),
          );
        } else {
          // TODO: Handle other service categories
        }
      },
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildShopByCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
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
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryCard('Personal care', Icons.person),
              _buildCategoryCard('Home appliances', Icons.home),
              _buildCategoryCard('Cloths & Apparels', Icons.checkroom),
              _buildCategoryCard('Mobiles & computers', Icons.phone_android),
              _buildCategoryCard('Sports & games', Icons.sports_soccer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.categoryListing,
          arguments: {'categoryName': name},
        );
      },
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
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

  Widget _buildPromotionalBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 140,
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
              child: AssetHelper.loadImageOrPlaceholder(
                assetPath: assets.AssetPaths.promoRectangle26, // SIBERT banner image
                width: 146,
                height: 140,
                fit: BoxFit.cover,
              ),
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

  Widget _buildTopRatedServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'top rated services',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16,
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
                  'See all',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 268,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  width: 92,
                  margin: const EdgeInsets.only(right: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: AppColors.inputBorder,
                          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        ),
                        child: const Icon(Icons.image, size: 40),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Service Name',
                        style: AppTextStyles.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          Positioned(
            left: AppSpacing.xxl,
            top: AppSpacing.xxl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REFRSH',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Super Clean Home\nInterior Cleaning Services',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
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

  Widget _buildBestsellers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bestsellers',
                style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.shopLanding);
                },
                child: Text(
                  'Shop now',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
              childAspectRatio: 0.75,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildProductCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index) {
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
              child: Stack(
                children: [
                  AssetHelper.loadImageOrPlaceholder(
                    assetPath: _getProductImagePath(index),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Row(
                      children: [
                        AssetHelper.loadImageOrIcon(
                          assetPath: assets.AssetPaths.star1,
                          fallbackIcon: Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        Text(
                          '5',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ],
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

  Widget _buildBoseBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 198,
      decoration: BoxDecoration(
        color: const Color(0xFFD5B591),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          Positioned(
            left: AppSpacing.lg,
            top: AppSpacing.xxl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlimited music, limited stock.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
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
                    'BOSE',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -AppSpacing.xxl,
            top: 0,
            child: Container(
              width: 221,
              height: 188,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: const Icon(Icons.headphones, size: 100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRatedSalons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top rated women's salons",
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
                  'View all',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 304,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  width: 92,
                  margin: const EdgeInsets.only(right: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: AppColors.inputBorder,
                          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        ),
                        child: const Icon(Icons.image, size: 40),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Salon Name',
                        style: AppTextStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12),
                          Text(
                            'Location',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferAndEarn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                    'www.amozit.com/referral/483BBJ78xh64 #0233444',
                    style: AppTextStyles.bodySmall,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.content_copy, size: 16),
                  onPressed: () {
                    const referralText = 'www.amozit.com/referral/483BBJ78xh64 #0233444';
                    Clipboard.setData(const ClipboardData(text: referralText));
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
              const referralCode = '#0233444';
              const referralUrl = 'www.amozit.com/referral/483BBJ78xh64';
              await Share.share(
                'Check out AMOZIT! Use my referral code $referralCode: $referralUrl',
                subject: 'AMOZIT Referral',
              );
            },
            icon: AssetHelper.loadImageOrIcon(
              assetPath: assets.AssetPaths.iconShare,
              fallbackIcon: Icons.share,
              size: 12,
            ),
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

  Widget _buildBottomNavigationBar() {
    return AppBottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
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

