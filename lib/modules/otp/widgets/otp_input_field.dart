import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../view/otp_screen.dart';

/// OTP Input Field Widget
/// 
/// Single digit input field for OTP entry.
/// Supports different visual states: normal, error, correct.
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final OtpState state;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    double borderWidth;

    switch (state) {
      case OtpState.error:
      case OtpState.expired:
        borderColor = AppColors.errorLight;
        borderWidth = 2.0;
        break;
      case OtpState.correct:
        borderColor = AppColors.success;
        borderWidth = 2.0;
        break;
      default:
        borderColor = controller.text.isEmpty
            ? AppColors.inputBorder
            : AppColors.inputBorderFilled;
        borderWidth = 1.0;
    }

    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyles.otpDigit,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            borderSide: BorderSide(
              color: (state == OtpState.error || state == OtpState.expired)
                  ? AppColors.errorLight
                  : AppColors.primary,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            onChanged(value);
          }
        },
        onTap: () {
          // Select all text when tapped
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
      ),
    );
  }
}

