import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // Create wave animation (rotates hand from -20 to 20 degrees for waving motion)
    _waveAnimation = Tween<double>(begin: -0.35, end: 0.35).animate(
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
                  // Robot Character Illustration with Waving Hand Animation
                  SizedBox(
                    width: 101,
                    height: 149,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Robot body (static) - without the right hand
                        SvgPicture.asset(
                          'assets/images/robot_mascot.svg',
                          width: 101,
                          height: 149,
                          fit: BoxFit.contain,
                          semanticsLabel: 'Robot Mascot',
                          placeholderBuilder: (context) => const SizedBox(
                            width: 101,
                            height: 149,
                          ),
                        ),
                        // Animated waving hand positioned at robot's right side
                        Positioned(
                          right: 0,
                          top: 18,
                          child: AnimatedBuilder(
                            animation: _waveAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _waveAnimation.value,
                                alignment: const Alignment(-0.5, 0.0),
                                child: SvgPicture.asset(
                                  'assets/images/robot_hand_wave.svg',
                                  width: 20,
                                  height: 35,
                                  fit: BoxFit.contain,
                                  placeholderBuilder: (context) => const SizedBox(
                                    width: 20,
                                    height: 35,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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


