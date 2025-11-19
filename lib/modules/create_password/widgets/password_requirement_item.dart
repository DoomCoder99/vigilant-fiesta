import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Password Requirement Item Widget
/// 
/// Displays a single password requirement with a checkmark or circle icon.
/// Shows green checkmark when requirement is met, empty circle when not met.
class PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const PasswordRequirementItem({
    super.key,
    required this.text,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isValid
              ? AppColors.validationSuccess
              : AppColors.textTertiary,
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: isValid
                ? AppColors.validationSuccess
                : AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

