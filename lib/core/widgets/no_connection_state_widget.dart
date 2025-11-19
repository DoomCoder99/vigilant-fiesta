import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'amozit_error_state_widget.dart';

/// NoConnectionStateWidget
/// 
/// Widget displayed when there's no internet connection.
/// Design Source: Figma frame "No connection" (node-id: 1-12185)
class NoConnectionStateWidget extends StatelessWidget {
  /// Retry callback
  final VoidCallback? onRetry;

  const NoConnectionStateWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AmozitErrorStateWidget(
      title: 'Unable to connect.\nPlease check your internet connection.',
      assetPath: 'assets/blank_states/no_connection.png',
      retryLabel: 'Retry',
      onRetry: onRetry,
      customIllustration: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/blank_states/no_connection.png',
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
                  Icons.wifi_off,
                  size: 80,
                  color: AppColors.error,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

