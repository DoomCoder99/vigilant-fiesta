import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/sign_in_controller.dart';
import '../../registration/widgets/social_login_button.dart';

/// Sign In Screen
/// 
/// Screen for user authentication with email/phone and password.
/// Supports normal, error, and success states.
/// 
/// Design Sources:
/// - Normal: Figma frame "Sign in" (node-id: 1-1825)
/// - Wrong Entry: Figma frame "Sign in - wrong entry" (node-id: 1-1902)
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = SignInController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_emailPhoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // TODO: Implement actual sign-in API call
    final result = await _controller.signIn(
      _emailPhoneController.text,
      _passwordController.text,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (result.success) {
        // Navigate to Amozit Landing Confirmed after successful sign-in
        Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
      } else {
        setState(() {
          _errorMessage = result.errorMessage ?? 'Wrong password!';
        });
      }
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

    final hasError = _errorMessage != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button and Register Link
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

                  // Register Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.register);
                    },
                    child: Text(
                      'Register',
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
                    'Sign in to Amozit',
                    style: AppTextStyles.headingMedium.copyWith(
                      fontSize: 24.0,
                      height: 1.0, // 24px / 24px
                      fontWeight: FontWeight.w600, // SemiBold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Login with your email or phone number to access all services in your area.',
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

                  // Password Input
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: AppTextStyles.input,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: AppTextStyles.input.copyWith(
                        color: AppColors.inputPlaceholder,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: BorderSide(
                          color: hasError
                              ? AppColors.errorLight
                              : AppColors.inputBorder,
                          width: hasError ? 2 : 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: BorderSide(
                          color: hasError
                              ? AppColors.errorLight
                              : AppColors.inputBorder,
                          width: hasError ? 2 : 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        borderSide: BorderSide(
                          color: hasError
                              ? AppColors.errorLight
                              : AppColors.primary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(AppSpacing.lg),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  // Error Message
                  if (hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _errorMessage!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.errorLight,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          (_emailPhoneController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  !_isLoading)
                              ? _handleSignIn
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
                          : const Text('Sign In'),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Forgot Password Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                    },
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.link,
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


