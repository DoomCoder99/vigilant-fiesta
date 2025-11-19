import 'package:flutter/material.dart';
import 'amozit_error_state_widget.dart';

/// GenericErrorStateWidget
/// 
/// Generic error state widget for unexpected failures.
/// Design Source: Figma frame "Generic error - Something went wrong!" (node-id: 1-11944)
class GenericErrorStateWidget extends StatelessWidget {
  /// Error title (default: "Something went wrong!")
  final String? errorTitle;
  
  /// Error description
  final String? errorDescription;
  
  /// Retry callback
  final VoidCallback? onRetry;
  
  /// Go back callback
  final VoidCallback? onBack;

  const GenericErrorStateWidget({
    super.key,
    this.errorTitle,
    this.errorDescription,
    this.onRetry,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AmozitErrorStateWidget(
      title: errorTitle ?? 'Something went wrong!',
      description: errorDescription ?? 'And we\'re not sure what happened.\nWait a few seconds, or restart the application.',
      assetPath: 'assets/blank_states/generic_error.png',
      retryLabel: 'Retry',
      onRetry: onRetry,
      onBack: onBack,
    );
  }
}

