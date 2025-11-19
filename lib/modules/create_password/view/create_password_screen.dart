import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/password_validation.dart';
import '../widgets/password_requirement_item.dart';
import '../widgets/password_strength_indicator.dart';

/// Create Password Screen
/// 
/// Screen for creating a new password with real-time validation.
/// Supports multiple states: initial, validation in progress, validation complete, show password.
/// 
/// Design Sources:
/// - Initial: Figma frame "Create password" (node-id: 1-1541)
/// - Validation: Figma frame "Create password - validation" (node-id: 1-1609)
/// - Validation Complete: Figma frame "Create password - validation complete" (node-id: 1-1683)
/// - Show Password: Figma frame "Create password - show password" (node-id: 1-1758)
class CreatePasswordScreen extends StatefulWidget {
  final String emailOrPhone;

  const CreatePasswordScreen({
    super.key,
    required this.emailOrPhone,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  final _validation = PasswordValidation();

  PasswordValidationResult _validationResult = PasswordValidationResult.empty();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    setState(() {
      _validationResult = _validation.validate(_passwordController.text);
    });
  }

  Future<void> _handleCreatePassword() async {
    if (!_validationResult.isValid) {
      return;
    }

    // TODO: Implement actual password creation API call
    // For now, mark user as authenticated and navigate to Shop Landing
    if (mounted) {
      // Mark user as authenticated after successful registration
      final authService = AuthService.instance;
      authService.markAsAuthenticated(widget.emailOrPhone);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      
      // Navigate to Amozit Landing Confirmed after successful registration completion
      Navigator.of(context).pushReplacementNamed(AppRoutes.amozitLandingConfirmed);
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
                    'Create a Password',
                    style: AppTextStyles.headingMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'To further login into Amozit.',
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
                  // Password Input Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: AppTextStyles.input,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
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

                  // Password Strength Indicator (shown when password is being typed)
                  if (_passwordController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.sm,
                        left: AppSpacing.lg,
                      ),
                      child: PasswordStrengthIndicator(
                        password: _passwordController.text,
                      ),
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Update & Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _validationResult.isValid
                          ? _handleCreatePassword
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _validationResult.isValid
                            ? AppColors.primary
                            : AppColors.buttonDisabled,
                        disabledBackgroundColor: AppColors.buttonDisabled,
                      ),
                      child: const Text('Update & Sign in'),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Password Requirements
                  Column(
                    children: [
                      PasswordRequirementItem(
                        text: 'Minimum 8 characters',
                        isValid: _validationResult.hasMinLength,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      PasswordRequirementItem(
                        text: 'Contains a number or a symbol',
                        isValid: _validationResult.hasNumberOrSymbol,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      PasswordRequirementItem(
                        text: 'Use at least one uppercase letter',
                        isValid: _validationResult.hasUppercase,
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


