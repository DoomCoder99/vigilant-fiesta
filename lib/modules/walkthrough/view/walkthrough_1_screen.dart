import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/location_permission_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Walkthrough 1 Screen
/// 
/// First screen in the onboarding walkthrough flow.
/// Introduces users to the app's core functionality: finding, booking, and relaxing.
/// Uses a carousel for the illustration image.
/// 
/// Design Source: Figma frame "Walkthrough 1" (node-id: 1-1018)
/// Carousel Image: Figma frame "Frame 1171275300" (node-id: 1-1036)
class Walkthrough1Screen extends StatefulWidget {
  const Walkthrough1Screen({super.key});

  @override
  State<Walkthrough1Screen> createState() => _Walkthrough1ScreenState();
}

class _Walkthrough1ScreenState extends State<Walkthrough1Screen> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  // List of walkthrough images (3-4 images for carousel)
  // TODO: Replace with actual walkthrough images when available
  final List<String> _walkthroughImages = [
    'assets/images/walkthrough_illustration.png',
    'assets/images/walkthrough_illustration.png', // Placeholder for image 2
    'assets/images/walkthrough_illustration.png', // Placeholder for image 3
    'assets/images/walkthrough_illustration.png', // Placeholder for image 4
  ];

  @override
  Widget build(BuildContext context) {
    // Set status bar style to dark (dark icons on light background)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                const SizedBox(height: AppSpacing.xxxxxl),

                // Logo
                SizedBox(
                  width: 112,
                  height: 24,
                  child: Image.asset(
                    'assets/images/amozit_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxxxl),

                // Heading and Description
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxxxxl,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Find, book and relax!',
                        style: AppTextStyles.headingLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Search for the relevant services available in your location, book the experts and sit back, relax.',
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Carousel Illustration (260x228)
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: _walkthroughImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return SizedBox(
                      width: 260,
                      height: 228,
                      child: Image.asset(
                        _walkthroughImages[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 228,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),

                const Spacer(),

                // Pagination Dots
                _PaginationDots(
                  currentIndex: _currentIndex,
                  totalDots: _walkthroughImages.length,
                ),

                const SizedBox(height: AppSpacing.xxxxxl),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      // Sign In Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _handleButtonPress(context, isSignIn: true);
                          },
                          child: const Text('Sign In'),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.lg),

                      // Explore Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _handleButtonPress(context, isSignIn: false);
                          },
                          child: const Text('Explore'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxxxl),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Handle button press - request location permission for first-time users
  /// 
  /// For first-time users who haven't granted location permission,
  /// this will show the system permission dialog.
  /// After permission handling, navigates to the appropriate screen.
  Future<void> _handleButtonPress(BuildContext context, {required bool isSignIn}) async {
    final permissionService = LocationPermissionService.instance;
    
    // Check if permission is already granted
    final isGranted = await permissionService.isPermissionGranted();
    
    // If permission is not granted, request it (for first-time users)
    if (!isGranted) {
      // Request location permission - this will show the system-generated dialog
      await permissionService.requestPermission();
    }
    
    // Navigate to the appropriate screen
    if (mounted) {
      if (isSignIn) {
        Navigator.of(context).pushNamed(AppRoutes.signIn);
      } else {
        // Navigate to Registration screen after location permission handling
        Navigator.of(context).pushReplacementNamed(AppRoutes.register);
      }
    }
  }
}


/// Pagination Dots Widget
/// 
/// Shows progress indicator for walkthrough screens.
/// Active dot is filled with primary color, inactive dots are outlined.
class _PaginationDots extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const _PaginationDots({
    required this.currentIndex,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDots,
        (index) {
          final isActive = index == currentIndex;
          return Container(
            margin: EdgeInsets.only(
              right: index < totalDots - 1 ? AppSpacing.sm : 0,
            ),
            width: isActive ? 20 : 4,
            height: isActive ? 8 : 4,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.textSecondary,
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
          );
        },
      ),
    );
  }
}

