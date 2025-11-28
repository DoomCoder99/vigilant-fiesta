import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

/// Amozit Landing Confirmed Screen
///
/// Main landing screen after user confirmation with bottom navigation.
/// Design Source: Figma frame "Amozit Landing Confirmed" (node-id: 1-2517)

class AmozitLandingConfirmedScreen extends StatefulWidget {
  const AmozitLandingConfirmedScreen({super.key});

  @override
  State<AmozitLandingConfirmedScreen> createState() =>
      _AmozitLandingConfirmedScreenState();
}

class _AmozitLandingConfirmedScreenState
    extends State<AmozitLandingConfirmedScreen> {
  int _currentIndex = 0;
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: QuickAccessFirstTimeOverlay(
        child: QuickTriggerHost(child: _buildBody()),
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

          // const SizedBox(height: AppSpacing.xxl),
          // Quick Services section
          _buildQuickServices(),
          const SizedBox(height: AppSpacing.xl),
          // Shop by category section
          _buildShopByCategory(),
          const SizedBox(height: AppSpacing.xxl),
          // Promotional banner
          _buildPromotionalBanner(),
          const SizedBox(height: AppSpacing.xl),
          // Top rated services section
          _buildTopRatedServices(),
          // const SizedBox(height: AppSpacing.xl),
          // Refresh banner
          _buildRefreshBanner(),
          const SizedBox(height: AppSpacing.xxl),
          // Bestsellers section
          _buildBestsellers(),
          const SizedBox(height: AppSpacing.xxl),
          // Bose promotional banner
          _buildBoseBanner(),
          // const SizedBox(height: AppSpacing.xxl),
          // Top rated women's salons section
          _buildTopRatedSalons(),
          const SizedBox(height: AppSpacing.xxl),
          // Refer & Earn section
          _buildReferAndEarn(),
          const SizedBox(height: AppSpacing.xxxxxl), // Space for bottom nav
          const SizedBox(height: AppSpacing.xxxxxl), // Space for bottom nav
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
                        assetPath: "assets/home/banner.png",
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
          // Search bar - positioned below location
          _buildSearchBarOverlay(),
          // Pagination dots
          Positioned(
            bottom: AppSpacing.xxxl,
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
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Container(
              height: 15,
              color: Colors.transparent, // Outer black container
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndProfile() {
    return Positioned(
      top: 44,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.addLocation);

              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   backgroundColor: Colors.transparent,
              //   builder: (context) => const LocationBottomSheet(),
              // );
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
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 16,
                        ),
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

  Widget _buildSearchBarOverlay() {
    return Positioned(
      top: 100, // Position from top of banner (below location & profile)
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.search);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(AppBorderRadius.xl),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white, size: 16),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Search',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 12,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            child: Row(
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
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.black, decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 25,

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
              color: Colors.white,
              border: Border.all(color: Color(0xffD6DEE8)),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
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
                  Navigator.of(context).pushNamed(AppRoutes.menuAllCategories);
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
      height: 150,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                         Radius.circular(10),
                        ),
                        child: AssetHelper.loadImageOrPlaceholder(
                          assetPath: "assets/home/banner3.png",
                          width: MediaQuery.of(context).size.width-40,
                          height: 140,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 400,
              viewportFraction: 0.88,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index == _currentBannerIndex;
                return Container(
                  width: isActive ? 20 : 4,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.6),
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
                onPressed: () {},
                child: Text(
                  'See all',
                  style: AppTextStyles.bodySmall.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 150,
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
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.sm,
                          ),
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
          SizedBox(
            height: 150,
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
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.sm,
                          ),
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
               Radius.circular(20),
            ),
            child: Image.asset(
              "assets/home/refresh.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover
            ),
          ),
          Positioned(
            right: AppSpacing.xxl,
            top: AppSpacing.xxl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'REFRSH',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Super Clean Home\nInterior Cleaning Services',
                  textAlign: TextAlign.end,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,

                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Book Now',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
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
          // const SizedBox(height: AppSpacing.lg),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: GridView.builder(
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
                        Text('5', style: AppTextStyles.caption),
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
    return SizedBox(
      height: 198,
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, realIndex) {
              return Container(
                decoration: BoxDecoration(),
                child: Positioned.fill(
                  child: AssetHelper.loadImageOrPlaceholder(
                    assetPath: "assets/home/Banner section.png",
                    width: double.infinity,
                    height: double.infinity,

                    fit: BoxFit.cover,
                  ),
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
          Positioned(
            bottom: AppSpacing.xl,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index == _currentBannerIndex;
                return Container(
                  width: isActive ? 20 : 4,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.6),
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
                onPressed: () {},
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
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: GridView.builder(
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
          ),
        ],
      ),
    );
  }

  Widget _buildReferAndEarn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  "Refer & Earn Big!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                /// Subtitle
                Text(
                  "Invite your friends and earn rewards.\n"
                      "The more you share, the more you gain.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 20),

                /// Referral link box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "www.amozit.com/referral/483BBJ78xh64",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Icon(Icons.copy, size: 22, color: Colors.grey.shade600),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Share button
                SizedBox(
                  width: 200,
                  height: 52,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff7132F4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.share, color: Colors.white),
                         SizedBox(width: AppSpacing.xl,),
                         Text(
                          "Share With Friends",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Top-right gift
            Positioned(
              top: 20,
              right: 10,
              child: Image.asset(
                "assets/home/image-removebg-preview (4) 2.png",
                scale: 4,
              ),
            ),

            /// Bottom-right gift
            Positioned(
              bottom: -100,
              right: -10,
              child: Image.asset(
                "assets/home/image-removebg-preview (4) 1.png",
               scale: 4,
              ),
            ),
          ],
        ),
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
