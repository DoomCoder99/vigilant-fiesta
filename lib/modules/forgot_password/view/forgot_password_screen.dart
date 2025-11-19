import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../registration/widgets/social_login_button.dart';

/// Forgot Password Screen
/// 
/// Initial screen for password recovery flow.
/// User enters email/phone to receive OTP.
/// 
/// Design Source:
/// - Figma frame "Forgot password" (node-id: 1-2070)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailPhoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }

  Future<void> _handleGetOtp() async {
    if (_emailPhoneController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement actual OTP request API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Navigate to OTP screen with email/phone
      Navigator.of(context).pushNamed(
        AppRoutes.forgotPasswordOtp,
        arguments: _emailPhoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Header with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
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
                    'Forgot Password?',
                    style: AppTextStyles.headingMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Enter your registered email or phone number.',
                    style: AppTextStyles.caption,
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
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Icon(
                          Icons.mic,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Get OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_emailPhoneController.text.isNotEmpty &&
                              !_isLoading)
                          ? _handleGetOtp
                          : null,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.backgroundWhite,
                                ),
                              ),
                            )
                          : const Text('Get OTP'),
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
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            letterSpacing: 0.24,
                          ),
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
                        icon: Icons.search, // Google icon placeholder
                        onTap: () {
                          // TODO: Implement Google sign in
                        },
                      ),
                      const SizedBox(width: AppSpacing.md),
                      SocialLoginButton(
                        icon: Icons.apple, // Apple icon placeholder
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


