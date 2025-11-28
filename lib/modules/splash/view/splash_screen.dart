import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Splash Screen
/// 
/// Initial onboarding screen displayed when the app launches.
/// Shows the app logo/character with animated waving motion and Flutter loader.
/// Automatically navigates to Walkthrough 1 after a brief delay (typically 2-3 seconds).
/// 
/// Design Source: Figma frame "Splash" (node-id: 1-844)
/// Loader: Figma frame "Frame 1171275401" (node-id: 1-1015)
/// Mascot Animation: Figma frame "Layer_1" (node-id: 1-863)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize wave animation controller
    _waveController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    // Create wave animation (rotates arm from -15 to 15 degrees)
    _waveAnimation = Tween<double>(begin: -0.15, end: 0.15).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeInOut,
      ),
    );

    // Navigate to Walkthrough 1 after 2.5 seconds
    // TODO: Replace with actual onboarding logic (check if user has seen walkthrough)
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.walkthrough1);
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
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
            // Main Content - Centered Robot Character with Animation
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Robot Character Illustration with Waving Animation
                  SizedBox(
                    width: 101,
                    height: 149,
                    child: Image.asset(
                      'assets/images/robot_character.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Flutter CircularProgressIndicator (24x24)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.backgroundWhite,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // "Launching.." Text
                  Text(
                    'Launching..',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.backgroundWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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


