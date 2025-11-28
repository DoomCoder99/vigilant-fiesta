import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/social_login_button.dart';

/// Registration Screen
/// 
/// Screen for new user registration with email/phone input and social login options.
/// 
/// Design Source: Figma frame "Register" (node-id: 1-1228)
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailPhoneController = TextEditingController();

  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar style to dark
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
        child: Column(
          children: [
            // Header with Back Button and Sign In
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 16),
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: const BorderSide(
                          color: Color(0xFFEBEBEB),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),

                  // Sign In Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.signIn);
                    },
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxxxxl),

            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxxxl),
              child: Column(
                children: [
                  Text(
                    'Sign up to Amozit',
                    style: AppTextStyles.headingMedium.copyWith(
                      fontSize: 24.0,
                      height: 1.0, // 24px / 24px
                      fontWeight: FontWeight.w600, // SemiBold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Register with your email or phone number',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10.0,
                      height: 1.2, // 12px / 10px
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxxxxl),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  // Email/Phone Input
                  TextField(
                    controller: _emailPhoneController,
                    style: AppTextStyles.input,
                    decoration: InputDecoration(
                      hintText: 'Email or Phone number',
                      hintStyle: AppTextStyles.input.copyWith(
                        color: AppColors.inputPlaceholder,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorder,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorder,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(AppSpacing.lg),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Get OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailPhoneController.text.isNotEmpty) {
                          // TODO: Call API to send OTP
                          // For now, navigate to OTP screen
                          Navigator.of(context).pushNamed(
                            AppRoutes.registerOtp,
                            arguments: _emailPhoneController.text,
                          );
                        }
                      },
                      child: const Text('Get OTP'),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Or Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.textTertiary,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Text(
                          'Or',
                          style: AppTextStyles.dividerText,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.textTertiary,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Social Login Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        iconAsset: "assets/login/facebook.png",
                        // icon: Icons.search, // Google icon placeholder
                        onTap: () {
                          // TODO: Implement Google sign in
                        },
                      ),
                      const SizedBox(width: AppSpacing.md),
                      SocialLoginButton(
                        iconAsset: "assets/login/google.png",
                        // icon: Icons.apple, // Apple icon placeholder
                        onTap: () {
                          // TODO: Implement Apple sign in
                        },
                      ),
                    ],
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


