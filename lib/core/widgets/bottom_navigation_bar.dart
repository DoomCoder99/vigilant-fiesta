import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../utils/asset_helper.dart';

/// Bottom Navigation Bar Widget
/// 
/// Matches Figma design exactly:
/// - Container: 280px width, 30px border radius, 24px bottom margin
/// - Background: #7132f4 (primary color)
/// - Active item: White background, 24px border radius, 20px horizontal padding, 12px vertical padding
/// - Icons: 20px size
/// - Text: 12px, SemiBold, #162028, 0.24px letter spacing
/// - Gap between items: 4px
class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: AppSpacing.xxl), // 24px from bottom
      child: Container(
        width: 280.0, // Fixed width as per Figma (280px)
        padding: const EdgeInsets.only(
          left: AppSpacing.md, // 8px
          right: AppSpacing.xl, // 20px
          top: AppSpacing.md, // 8px
          bottom: AppSpacing.md, // 8px
        ),
        decoration: BoxDecoration(
          color: AppColors.primary, // #7132f4
          borderRadius: BorderRadius.circular(30), // 30px border radius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context,
              icon: Icons.home,
              label: 'Home',
              index: 0,
              onTap: () {
                if (currentIndex != 0) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.amozitLandingConfirmed,
                    (route) => false,
                  );
                }
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.shopping_bag,
              label: 'Shop',
              index: 1,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.shopLanding);
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.checklist,
              label: 'Orders',
              index: 2,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.myOrders);
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.shopping_cart,
              label: 'Cart',
              index: 3,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        onTap();
        this.onTap(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppSpacing.xl : 0, // 20px when selected
          vertical: AppSpacing.sm + AppSpacing.sm, // 12px (4px + 8px)
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24), // 24px border radius
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Use asset icon if available, fallback to Material Icon
            AssetHelper.loadImageOrIcon(
              assetPath: _getIconAssetPath(icon),
              fallbackIcon: icon,
              size: 20, // 20px icon size
              color: isSelected ? AppColors.textPrimary : Colors.white,
            ),
            if (isSelected) ...[
              const SizedBox(width: AppSpacing.sm), // 4px gap
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600, // SemiBold
                  color: AppColors.textPrimary, // #162028
                  letterSpacing: 0.24, // 0.24px letter spacing
                  height: 1.33, // 16px line height / 12px font size
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Get asset path for navigation icon
  String _getIconAssetPath(IconData icon) {
    // Map Material Icons to asset paths
    if (icon == Icons.home) return AssetPaths.iconHome;
    if (icon == Icons.shopping_bag) return AssetPaths.iconShop;
    if (icon == Icons.checklist) return AssetPaths.iconOrders;
    if (icon == Icons.shopping_cart) return AssetPaths.iconCart;
    return ''; // Return empty string to trigger fallback
  }
}

