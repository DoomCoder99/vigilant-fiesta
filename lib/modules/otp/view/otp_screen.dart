import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/otp_controller.dart';
import '../widgets/otp_input_field.dart';

/// OTP Verification Screen
/// 
/// Screen for verifying OTP sent to user's email/phone.
/// Supports normal, error, and correct states.
/// 
/// Design Sources:
/// - Normal: Figma frame "Register - OTP" (node-id: 1-1297)
/// - Error: Figma frame "OTP - Error" (node-id: 1-1419)
/// - Correct: Figma frame "OTP - Correct" (node-id: 1-1480)
class OtpScreen extends StatefulWidget {
  final String emailOrPhone;

  const OtpScreen({
    super.key,
    required this.emailOrPhone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = OtpController();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  OtpState _otpState = OtpState.normal;
  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer = 30;
    _canResend = false;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _resendTimer--;
          if (_resendTimer <= 0) {
            _canResend = true;
          }
        });
        return _resendTimer > 0;
      }
      return false;
    });
  }

  void _onOtpChanged() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      _verifyOtp(otp);
    } else {
      setState(() {
        _otpState = OtpState.normal;
      });
    }
  }

  Future<void> _verifyOtp(String otp) async {
    setState(() {
      _otpState = OtpState.verifying;
    });

    // TODO: Implement actual OTP verification API call
    final isValid = await _controller.verifyOtp(otp);

    if (mounted) {
      setState(() {
        _otpState = isValid ? OtpState.correct : OtpState.error;
      });

      if (isValid) {
        // Navigate to Create Password screen after a brief delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.createPassword,
              arguments: widget.emailOrPhone,
            );
          }
        });
      }
    }
  }

  void _resendOtp() {
    if (_canResend) {
      // TODO: Implement resend OTP API call
      _startResendTimer();
      // Clear OTP fields
      for (var controller in _otpControllers) {
        controller.clear();
      }
      setState(() {
        _otpState = OtpState.normal;
      });
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

    // Mask email for display
    final maskedEmail = _maskEmail(widget.emailOrPhone);

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
                    'Verify OTP',
                    style: AppTextStyles.headingMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Enter the 4 digit OTP sent on $maskedEmail',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxxxxl),

            // OTP Input Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  // OTP Input Fields Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < 4 ? AppSpacing.md : 0,
                        ),
                        child: OtpInputField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            _onOtpChanged();
                          },
                          onBackspace: () {
                            if (index > 0 && _otpControllers[index].text.isEmpty) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                          state: _otpState,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _otpControllers.every((c) => c.text.isNotEmpty) &&
                              _otpState != OtpState.verifying
                          ? () {
                              final otp = _otpControllers.map((c) => c.text).join();
                              _verifyOtp(otp);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _otpControllers
                                .every((c) => c.text.isNotEmpty)
                            ? AppColors.primary
                            : AppColors.buttonDisabled,
                        disabledBackgroundColor: AppColors.buttonDisabled,
                      ),
                      child: _otpState == OtpState.verifying
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
                          : const Text('Continue'),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Resend OTP / Error Message / Expired Message
                  if (_otpState == OtpState.error)
                    GestureDetector(
                      onTap: _resendOtp,
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            letterSpacing: 0.24,
                          ),
                          children: [
                            const TextSpan(text: 'Wrong OTP!'),
                          ],
                        ),
                      ),
                    )
                  else if (_otpState == OtpState.expired)
                    GestureDetector(
                      onTap: _resendOtp,
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            letterSpacing: 0.24,
                          ),
                          children: [
                            const TextSpan(text: 'Code expired. '),
                            TextSpan(
                              text: 'Resend OTP.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                letterSpacing: 0.24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (!_canResend)
                    Text(
                      'Resend OTP in $_resendTimer Seconds',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                        letterSpacing: 0.24,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _resendOtp,
                      child: Text(
                        'Resend OTP',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _maskEmail(String email) {
    if (email.contains('@')) {
      final parts = email.split('@');
      if (parts[0].length > 3) {
        return '${parts[0].substring(0, 3)}**@**${parts[1]}';
      }
      return '${parts[0].substring(0, 1)}**@**${parts[1]}';
    }
    // Phone number masking
    if (email.length > 6) {
      return '${email.substring(0, 3)}**${email.substring(email.length - 2)}';
    }
    return email;
  }
}

/// OTP State Enum
enum OtpState {
  normal,
  verifying,
  error,
  expired,
  correct,
}

