import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// AmozitErrorStateWidget
/// 
/// Reusable error state widget for displaying error states across the app.
/// Used for: Generic Error, No Connection, Payment Failed.
/// 
/// Design Source: Module 14 - Blank Screens & System States
class AmozitErrorStateWidget extends StatelessWidget {
  /// Error title
  final String title;
  
  /// Error description/subtitle
  final String? description;
  
  /// Retry button label (default: "Retry")
  final String? retryLabel;
  
  /// Retry callback
  final VoidCallback? onRetry;
  
  /// Optional back/go back callback
  final VoidCallback? onBack;
  
  /// Asset path for illustration image (160x160px)
  final String? assetPath;
  
  /// Custom illustration widget
  final Widget? customIllustration;
  
  /// Optional additional widget to display below illustration
  final Widget? illustrationOverlay;
  
  /// Additional help text (e.g., contact info)
  final String? helpText;

  const AmozitErrorStateWidget({
    super.key,
    required this.title,
    this.description,
    this.retryLabel,
    this.onRetry,
    this.onBack,
    this.assetPath,
    this.customIllustration,
    this.illustrationOverlay,
    this.helpText,
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
            
            // Help text (if provided)
            if (helpText != null) ...[
              const SizedBox(height: AppSpacing.xl),
              _buildHelpText(),
            ],
            
            // Buttons
            if (onRetry != null || onBack != null) ...[
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
      return Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline,
          size: 80,
          color: AppColors.error,
        ),
      );
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
                  Icons.error_outline,
                  size: 80,
                  color: AppColors.error,
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

  Widget _buildHelpText() {
    return Text(
      helpText!,
      textAlign: TextAlign.center,
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary.withOpacity(0.4),
      ),
    );
  }

  Widget _buildButtons() {
    if (onRetry != null && onBack != null) {
      // Two buttons side by side
      return Row(
        children: [
          Expanded(
            child: _buildRetryButton(),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _buildBackButton(),
          ),
        ],
      );
    } else if (onRetry != null) {
      // Single retry button
      return _buildRetryButton();
    } else if (onBack != null) {
      // Single back button
      return _buildBackButton();
    }
    return const SizedBox.shrink();
  }

  Widget _buildRetryButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onRetry,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
        ),
        child: Text(
          retryLabel ?? 'Retry',
          style: AppTextStyles.button,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onBack,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          ),
        ),
        child: Text(
          'Go Back',
          style: AppTextStyles.buttonSecondary,
        ),
      ),
    );
  }
}

