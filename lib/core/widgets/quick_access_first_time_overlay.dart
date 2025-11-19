import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../routes/app_routes.dart';

/// QuickAccessFirstTimeOverlay
/// 
/// Overlay displayed to first-time users introducing the Quick Access feature.
/// Design Source: Figma frame "Quick access - first time user - optional" (node-id: 1-12073)
class QuickAccessFirstTimeOverlay extends StatefulWidget {
  final Widget child;

  const QuickAccessFirstTimeOverlay({
    super.key,
    required this.child,
  });

  @override
  State<QuickAccessFirstTimeOverlay> createState() => _QuickAccessFirstTimeOverlayState();
}

class _QuickAccessFirstTimeOverlayState extends State<QuickAccessFirstTimeOverlay> {
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _checkShouldShowOverlay();
  }

  Future<void> _checkShouldShowOverlay() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOverlay = prefs.getBool('quick_access_first_time_seen') ?? false;
      
      if (!hasSeenOverlay && mounted) {
        setState(() {
          _showOverlay = true;
        });
      }
    } catch (e) {
      // If SharedPreferences fails, show overlay anyway (first time)
      if (mounted) {
        setState(() {
          _showOverlay = true;
        });
      }
    }
  }

  Future<void> _dismissOverlay({bool skipToHome = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('quick_access_first_time_seen', true);
    } catch (e) {
      // If SharedPreferences fails, continue anyway
    }
    
    if (mounted) {
      setState(() {
        _showOverlay = false;
      });
    }

    if (skipToHome && mounted) {
      // Navigate to home/shop landing if needed
      // This is optional - overlay can just dismiss
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showOverlay) _buildOverlay(),
      ],
    );
  }

  Widget _buildOverlay() {
    return Material(
      color: Colors.black.withOpacity(0.5), // Dimmed background
      child: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Skip button
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _dismissOverlay(skipToHome: true),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Skip to Home',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Illustration and welcome text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/blank_states/quick_access_welcome.png',
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
                              Icons.rocket_launch_outlined,
                              size: 80,
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        'Welcome!\nWhat are you looking for?',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.28,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.xxl),
                
                // Service categories grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: _buildServiceCategories(),
                ),
                
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCategories() {
    final categories = [
      _ServiceCategory(
        name: 'Home maintenance',
        iconPath: 'assets/blank_states/icons/home_maintenance.png',
        onTap: () {
          _dismissOverlay();
          // TODO: Navigate to home maintenance services
        },
      ),
      _ServiceCategory(
        name: 'cleaning & pest control',
        iconPath: 'assets/blank_states/icons/cleaning_pest.png',
        onTap: () {
          _dismissOverlay();
          // TODO: Navigate to cleaning services
        },
      ),
      _ServiceCategory(
        name: 'sports & fitness',
        iconPath: 'assets/blank_states/icons/sports_fitness.png',
        onTap: () {
          _dismissOverlay();
          // TODO: Navigate to sports services
        },
      ),
      _ServiceCategory(
        name: 'rent a vehicle',
        iconPath: 'assets/blank_states/icons/rent_vehicle.png',
        onTap: () {
          _dismissOverlay();
          Navigator.of(context).pushNamed(AppRoutes.rentVehicleHome);
        },
      ),
      _ServiceCategory(
        name: 'driving instructor',
        iconPath: 'assets/blank_states/icons/driving_instructor.png',
        onTap: () {
          _dismissOverlay();
          // TODO: Navigate to driving instructor services
        },
      ),
      _ServiceCategory(
        name: 'gas cylinder booking',
        iconPath: 'assets/blank_states/icons/gas_cylinder.png',
        onTap: () {
          _dismissOverlay();
          // TODO: Navigate to gas cylinder booking
        },
      ),
      _ServiceCategory(
        name: 'Online Shopping',
        iconPath: 'assets/blank_states/icons/online_shopping.png',
        onTap: () {
          _dismissOverlay();
          Navigator.of(context).pushNamed(AppRoutes.shopLanding);
        },
      ),
    ];

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: categories.map((category) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 50 - AppSpacing.md) / 2,
          child: _ServiceCategoryButton(category: category),
        );
      }).toList(),
    );
  }
}

class _ServiceCategory {
  final String name;
  final String iconPath;
  final VoidCallback onTap;

  _ServiceCategory({
    required this.name,
    required this.iconPath,
    required this.onTap,
  });
}

class _ServiceCategoryButton extends StatelessWidget {
  final _ServiceCategory category;

  const _ServiceCategoryButton({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: category.onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: AppColors.textSecondary),
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        child: Row(
          children: [
            Image.asset(
              category.iconPath,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.category,
                    size: 16,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                category.name,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

