import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_category_controller.dart';
import '../data/models/subscription_venue_model.dart';
import '../widgets/quick_menu_sports_fitness.dart';
import '../widgets/subscription_banner.dart';
import '../widgets/turf_promotional_banner.dart';
import '../widgets/venue_card.dart';

/// Sports & Fitness Category Screen
/// 
/// Displays Sports & Fitness category with venues and quick menu.
/// Design Source: Figma frame "Sports & fitness" (node-id: 1-15889)
class SportsFitnessCategoryScreen extends StatelessWidget {
  const SportsFitnessCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionCategoryController());

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: AppColors.textPrimary),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Sports & Fitness',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEBEBEB)),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.tune, size: 16, color: AppColors.textPrimary),
            ),
            onPressed: () {
              // TODO: Show filter/sort options
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingVenues.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              
              // Subscription banner
              const SubscriptionBanner(),
              
              const SizedBox(height: AppSpacing.md),
              
              // Promotional banner for turfs
              const TurfPromotionalBanner(),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Sport Turfs section header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sport Turfs',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '5',
                            style: AppTextStyles.caption.copyWith(fontSize: 8),
                          ),
                          const Icon(Icons.star, size: 8, color: Color(0xFFFFB800)),
                          Text(
                            ' (248 bookings)',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 8,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/subscriptions/sports/shield_verified.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.verified,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Amozit Verified',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Quick menu
              const QuickMenuSportsFitness(),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Venue listings by sport type
              ..._buildVenueSections(controller),
            ],
          ),
        );
      }),
    );
  }

  List<Widget> _buildVenueSections(SubscriptionCategoryController controller) {
    final venuesBySport = controller.venuesBySport;
    final sections = <Widget>[];

    // Tennis Courts section
    if (venuesBySport.containsKey('tennis')) {
      sections.add(_buildSportSection(
        'Tennis Courts',
        venuesBySport['tennis']!,
        controller,
      ));
    }

    // Football Courts section
    if (venuesBySport.containsKey('football')) {
      sections.add(_buildSportSection(
        'Football Courts',
        venuesBySport['football']!,
        controller,
      ));
    }

    // Other sections can be added similarly
    for (final entry in venuesBySport.entries) {
      if (entry.key != 'tennis' && entry.key != 'football') {
        sections.add(_buildSportSection(
          '${entry.key[0].toUpperCase()}${entry.key.substring(1)} Courts',
          entry.value,
          controller,
        ));
      }
    }

    return sections;
  }

  Widget _buildSportSection(
    String title,
    List<SubscriptionVenueModel> venues,
    SubscriptionCategoryController controller,
  ) {
    final sectionId = title.toLowerCase().replaceAll(' ', '_');
    final isExpanded = controller.isSectionExpanded(sectionId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleSection(sectionId),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: AppSpacing.md),
          ...venues.map((venue) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: VenueCard(
                  venue: venue,
                  onViewDetails: () {
                    Get.toNamed(
                      AppRoutes.subscriptionVenueDetail,
                      arguments: {'venueId': venue.id},
                    );
                  },
                  onBookSlot: () {
                    Get.toNamed(
                      AppRoutes.subscriptionVenueDetail,
                      arguments: {'venueId': venue.id},
                    );
                  },
                ),
              )),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

