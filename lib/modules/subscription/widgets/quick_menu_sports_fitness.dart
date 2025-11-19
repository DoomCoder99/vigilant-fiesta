import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_category_controller.dart';

/// Quick Menu Sports & Fitness Widget
/// 
/// Displays quick access chips for sport categories.
/// Design Source: Figma frames "Quick menu – Sports & fitness" (node-id: 1-15524, 1-15600)
class QuickMenuSportsFitness extends StatelessWidget {
  const QuickMenuSportsFitness({super.key});

  final List<Map<String, dynamic>> _sportCategories = const [
    {'id': 'tennis', 'name': 'Tennis courts', 'icon': 'assets/subscriptions/sports/tennis_icon.png'},
    {'id': 'football', 'name': 'Football courts', 'icon': 'assets/subscriptions/sports/football_icon.png'},
    {'id': 'cricket', 'name': 'cricket courts', 'icon': 'assets/subscriptions/sports/cricket_icon.png'},
    {'id': 'badminton', 'name': 'badminton courts', 'icon': 'assets/subscriptions/sports/badminton_icon.png'},
    {'id': 'golf', 'name': 'golf courses', 'icon': 'assets/subscriptions/sports/golf_icon.png'},
    {'id': 'basketball', 'name': 'basketball courts', 'icon': 'assets/subscriptions/sports/basketball_icon.png'},
    {'id': 'volleyball', 'name': 'volleyball courts', 'icon': 'assets/subscriptions/sports/volleyball_icon.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionCategoryController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _sportCategories.take(4).map((sport) {
            return _buildSportChip(sport, controller);
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Second row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _sportCategories.skip(4).take(3).map((sport) {
            return _buildSportChip(sport, controller);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSportChip(
    Map<String, dynamic> sport,
    SubscriptionCategoryController controller,
  ) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectQuickMenu(sport['id'] as String),
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(sport['icon'] as String),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
                child: Image.asset(
                  sport['icon'] as String,
                  width: 32,
                  height: 32,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.sports, size: 20, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: 64,
                child: Text(
                  sport['name'] as String,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));
  }
}

