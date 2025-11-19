import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Base Layout for Location Access Screen
/// 
/// Provides the common layout structure shared between Android and iOS variants:
/// - Status bar
/// - Logo
/// - Heading and description
/// - Illustration
/// - Pagination dots
/// - Bottom action buttons
class LocationAccessBase extends StatelessWidget {
  final Widget child;

  const LocationAccessBase({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Content (same as Walkthrough 1)
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

                // Illustration
                SizedBox(
                  width: 260,
                  height: 228,
                  child: Image.asset(
                    'assets/images/walkthrough_illustration.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),

                // Pagination Dots
                const _PaginationDots(currentIndex: 0, totalDots: 3),

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
                            Navigator.of(context).pushNamed(AppRoutes.signIn);
                          },
                          child: const Text('Sign In'),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.lg),

                      // Explore Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigate to Location Access screen to request permission
                            Navigator.of(context).pushReplacementNamed(AppRoutes.locationAccess);
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

            // Platform-specific Modal Overlay
            child,
          ],
        ),
      ),
    );
  }
}


/// Pagination Dots Widget (reused from Walkthrough)
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

