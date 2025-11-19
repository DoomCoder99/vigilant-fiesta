import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';

/// Password Strength Indicator Widget
/// 
/// Shows visual dots representing password length/strength.
/// Displays up to 8 dots based on password length.
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final length = password.length;
    final dotCount = length > 8 ? 8 : length;

    return Row(
      children: List.generate(
        dotCount,
        (index) => Container(
          margin: EdgeInsets.only(
            right: index < dotCount - 1 ? AppSpacing.sm : 0,
          ),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.passwordDot,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

