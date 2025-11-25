import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

/// Social Login Button Widget
/// 
/// Reusable button for social login options (Google, Apple, etc.)
/// Supports both icon assets and IconData for flexibility
class SocialLoginButton extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    this.icon,
    this.iconAsset,
    required this.onTap,
  }) : assert(icon != null || iconAsset != null, 'Either icon or iconAsset must be provided');

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
        child: Center(
          child: iconAsset != null
              ? Image.asset(
                  iconAsset!,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to a default icon if image fails to load
                    return Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.textPrimary,
                    );
                  },
                )
              : Icon(
                  icon,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
        ),
      ),
    );
  }
}

