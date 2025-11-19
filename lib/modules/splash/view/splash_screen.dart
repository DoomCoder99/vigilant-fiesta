import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Splash Screen
/// 
/// Initial onboarding screen displayed when the app launches.
/// Shows the app logo/character and automatically navigates to Walkthrough 1
/// after a brief delay (typically 2-3 seconds).
/// 
/// Design Source: Figma frame "Splash" (node-id: 1-844)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Walkthrough 1 after 2.5 seconds
    // TODO: Replace with actual onboarding logic (check if user has seen walkthrough)
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.walkthrough1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar style to light (white icons on dark background)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content - Centered Robot Character
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Robot Character Illustration
                  SizedBox(
                    width: 101,
                    height: 149,
                    child: Image.asset(
                      'assets/images/robot_character.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxxxl),

                  // Loading Indicator
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      'assets/images/loading_indicator.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // "Launching.." Text
                  Text(
                    'Launching..',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.backgroundWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


