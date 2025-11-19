import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// AmozitEmptyStateWidget
/// 
/// Reusable empty state widget for displaying empty/blank states across the app.
/// Used for: Cart, Orders, Wishlist, Notifications, Search Not Found, Filter Applied Blank.
/// 
/// Design Source: Module 14 - Blank Screens & System States
class AmozitEmptyStateWidget extends StatelessWidget {
  /// Title text displayed prominently
  final String title;
  
  /// Optional description/subtitle text
  final String? description;
  
  /// Primary CTA button label
  final String? primaryCtaLabel;
  
  /// Primary CTA callback
  final VoidCallback? onPrimaryCtaTap;
  
  /// Secondary CTA button label
  final String? secondaryCtaLabel;
  
  /// Secondary CTA callback
  final VoidCallback? onSecondaryCtaTap;
  
  /// Asset path for illustration image (160x160px)
  final String? assetPath;
  
  /// Optional additional widget to display below illustration (e.g., ellipse overlay)
  final Widget? illustrationOverlay;
  
  /// Custom illustration widget (if assetPath is not provided)
  final Widget? customIllustration;
  
  /// Whether to show buttons in a column (stacked) or row (side by side)
  final bool buttonsStacked;

  const AmozitEmptyStateWidget({
    super.key,
    required this.title,
    this.description,
    this.primaryCtaLabel,
    this.onPrimaryCtaTap,
    this.secondaryCtaLabel,
    this.onSecondaryCtaTap,
    this.assetPath,
    this.illustrationOverlay,
    this.customIllustration,
    this.buttonsStacked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            _buildIllustration(),
            
            const SizedBox(height: AppSpacing.xxl),
            
            // Title and Description
            _buildTextContent(),
            
            // Buttons
            if (primaryCtaLabel != null || secondaryCtaLabel != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              _buildButtons(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    if (customIllustration != null) {
      return customIllustration!;
    }

    if (assetPath == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            assetPath!,
            width: 160,
            height: 160,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inbox_outlined,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
              );
            },
          ),
          if (illustrationOverlay != null)
            Positioned(
              top: 2,
              child: illustrationOverlay!,
            ),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.28,
            color: AppColors.textPrimary,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppColors.textPrimary.withOpacity(0.4),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildButtons() {
    if (buttonsStacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (primaryCtaLabel != null)
            _buildPrimaryButton(),
          if (secondaryCtaLabel != null) ...[
            const SizedBox(height: AppSpacing.md),
            _buildSecondaryButton(),
          ],
        ],
      );
    } else {
      return Row(
        children: [
          if (primaryCtaLabel != null)
            Expanded(
              child: _buildPrimaryButton(),
            ),
          if (primaryCtaLabel != null && secondaryCtaLabel != null)
            const SizedBox(width: AppSpacing.md),
          if (secondaryCtaLabel != null)
            Expanded(
              child: _buildSecondaryButton(),
            ),
        ],
      );
    }
  }

  Widget _buildPrimaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPrimaryCtaTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
        ),
        child: Text(
          primaryCtaLabel!,
          style: AppTextStyles.button,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onSecondaryCtaTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
        ),
        child: Text(
          secondaryCtaLabel!,
          style: AppTextStyles.buttonSecondary,
        ),
      ),
    );
  }
}

