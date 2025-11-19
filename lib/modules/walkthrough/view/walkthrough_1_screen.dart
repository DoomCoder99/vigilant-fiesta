import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Walkthrough 1 Screen
/// 
/// First screen in the onboarding walkthrough flow.
/// Introduces users to the app's core functionality: finding, booking, and relaxing.
/// 
/// Design Source: Figma frame "Walkthrough 1" (node-id: 1-1018)
class Walkthrough1Screen extends StatelessWidget {
  const Walkthrough1Screen({super.key});

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
          ],
        ),
      ),
    );
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

