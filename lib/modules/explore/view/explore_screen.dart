import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Explore Screen
/// 
/// Main application screen displayed after successful sign-in.
/// This is a placeholder screen - to be implemented with full design.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Explore',
          style: AppTextStyles.headingMedium,
        ),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Explore Screen',
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }
}

