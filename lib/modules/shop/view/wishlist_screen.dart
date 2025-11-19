import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/amozit_empty_state_widget.dart';

/// Wishlist Screen
/// 
/// Displays user's wishlist items.
/// Design Source: Figma frame "My Wishlist - no items" (node-id: 1-12240)
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // TODO: Replace with actual wishlist data from service/controller
  final List<String> _wishlistItems = [];

  @override
  Widget build(BuildContext context) {
    final isEmpty = _wishlistItems.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icon_back_arrow.png',
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 16);
            },
          ),
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: Color(0xFFEBEBEB)),
            ),
          ),
        ),
        title: Text(
          'My Wishlist',
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isEmpty
          ? AmozitEmptyStateWidget(
              title: 'Oops. seems like it\'s empty here!',
              assetPath: 'assets/blank_states/wishlist_empty.png',
              illustrationOverlay: Image.asset(
                'assets/blank_states/wishlist_empty_ellipse.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
              primaryCtaLabel: 'Explore our Products',
              onPrimaryCtaTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.shopLanding);
              },
              secondaryCtaLabel: 'Home',
              onSecondaryCtaTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              buttonsStacked: true,
            )
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // TODO: Implement wishlist items list
                Text(
                  'Wishlist items will be displayed here',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
    );
  }
}

