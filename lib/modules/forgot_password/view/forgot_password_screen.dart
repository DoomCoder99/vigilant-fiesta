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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Listen to email/phone field changes
    _emailPhoneController.addListener(_onEmailPhoneChanged);
  }

  void _onEmailPhoneChanged() {
    setState(() {
      _errorMessage = null; // Clear error when user types
      // Re-validate to enable/disable button
    });
  }

  /// Check if button should be enabled
  bool get _isButtonEnabled {
    final input = _emailPhoneController.text.trim();
    return input.isNotEmpty && _isValidEmailOrPhone(input);
  }

  /// Validate email or phone number
  bool _isValidEmailOrPhone(String input) {
    if (input.isEmpty) return false;
    
    // Check if it's an email (contains @)
    if (input.contains('@')) {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      return emailRegex.hasMatch(input);
    }
    
    // Check if it's a phone number (digits only, 8-15 digits)
    final phoneRegex = RegExp(r'^[0-9]{8,15}$');
    return phoneRegex.hasMatch(input.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }

  Future<void> _handleGetOtp() async {
    final input = _emailPhoneController.text.trim();
    
    // Validate input
    if (!_isValidEmailOrPhone(input)) {
      setState(() {
        _errorMessage = 'Please enter a valid email or phone number';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
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
        arguments: input,
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

                  // Error Message
                  if (_errorMessage != null)
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

                  // Get OTP Button - Enabled when valid email/phone is entered
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_isButtonEnabled && !_isLoading)
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


