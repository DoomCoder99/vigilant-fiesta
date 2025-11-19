import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

/// Social Login Button Widget
/// 
/// Reusable button for social login options (Google, Apple, etc.)
class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 100,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.inputBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

