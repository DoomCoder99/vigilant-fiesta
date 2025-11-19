import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/routes/app_routes.dart';
import 'quick_menu_electrical_screen.dart';

/// Electrical Services Screen
/// 
/// Displays electrical services with expandable/collapsible sections.
/// Design Source: Figma frames "Home services - electrical services" (node-id: 1-8479, 1-8716)
class ElectricalServicesScreen extends StatefulWidget {
  const ElectricalServicesScreen({super.key});

  @override
  State<ElectricalServicesScreen> createState() => _ElectricalServicesScreenState();
}

class _ElectricalServicesScreenState extends State<ElectricalServicesScreen> {
  // Track expanded/collapsed state for each service category
  final Map<String, bool> _expandedSections = {
    'Switch & Sockets': true,
    'doorbell & security': false,
    'wiring': false,
    'light & fan': false,
    'MCB / Fuse': false,
    'Appliance installation': false,
    'Other consultation': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner section
            _buildBanner(),
            const SizedBox(height: AppSpacing.lg),
            // Category header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildCategoryHeader(),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Service categories grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildServiceCategoriesGrid(),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Expandable service sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _buildServiceSections(),
            ),
            const SizedBox(height: AppSpacing.xxxxxl), // Space for floating button
          ],
        ),
      ),
      floatingActionButton: _buildMenuButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundWhite,
      elevation: 0,
      leading: IconButton(
        icon: AssetHelper.loadImageOrIcon(
          assetPath: AssetPaths.iconBackArrow,
          fallbackIcon: Icons.arrow_back,
          size: 16,
          color: AppColors.textPrimary,
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
        'Electrical Services',
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.tune,
            size: 16,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            // TODO: Implement filter
          },
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
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Stack(
        children: [
          Positioned(
            left: AppSpacing.lg,
            top: AppSpacing.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Services starting from OMR 9.99',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Verified professionals, book at your preferred time slot.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: AppColors.textPrimary.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to booking flow
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: AppColors.backgroundWhite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Electrical',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(
                  '5',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 2),
                AssetHelper.loadImageOrIcon(
                  assetPath: AssetPaths.star1,
                  fallbackIcon: Icons.star,
                  size: 8,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '(248 bookings)',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 8,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 16, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                'Amozit Verified',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCategoriesGrid() {
    final categories = [
      {'name': 'Switch & Sockets', 'icon': Icons.power},
      {'name': 'doorbell & security', 'icon': Icons.doorbell},
      {'name': 'wiring', 'icon': Icons.cable},
      {'name': 'light & fan', 'icon': Icons.lightbulb},
      {'name': 'MCB / Fuse', 'icon': Icons.electrical_services},
      {'name': 'Appliance installation', 'icon': Icons.build},
      {'name': 'Other consultation', 'icon': Icons.chat_bubble_outline},
      {'name': 'light & fan', 'icon': Icons.lightbulb}, // Duplicate in design
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCategoryItem(categories[0]),
            _buildServiceCategoryItem(categories[1]),
            _buildServiceCategoryItem(categories[2]),
            _buildServiceCategoryItem(categories[3]),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCategoryItem(categories[4]),
            _buildServiceCategoryItem(categories[5]),
            _buildServiceCategoryItem(categories[6]),
            _buildServiceCategoryItem(categories[7]),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCategoryItem(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        // Toggle expanded state
        setState(() {
          _expandedSections[category['name']] = !(_expandedSections[category['name']] ?? false);
        });
      },
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                category['icon'] as IconData,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              category['name'] as String,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                height: 1.2,
                letterSpacing: 0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSections() {
    return Column(
      children: [
        _buildExpandableSection('Switch & Sockets', [
          {
            'title': 'Switch / socket repair & replacement',
            'rating': 5,
            'bookings': 248,
            'price': 'OMR 24',
            'availability': 'Earliest availability at 10:20 AM',
          },
          {
            'title': 'Switchboard Repair / Replacement',
            'rating': 5,
            'bookings': 248,
            'price': 'OMR 24',
            'availability': 'Earliest availability at 10:20 AM',
          },
          {
            'title': 'new Switchboard installation',
            'rating': 5,
            'bookings': 248,
            'price': 'OMR 24',
            'availability': 'Earliest availability at 10:20 AM',
          },
        ]),
        _buildExpandableSection('doorbell & security', [
          {
            'title': 'Regular Doorbell replacement',
            'rating': 5,
            'bookings': 248,
            'price': 'OMR 24',
            'availability': 'Earliest availability at 10:20 AM',
          },
          {
            'title': 'Regular Doorbell Installation',
            'rating': 5,
            'bookings': 248,
            'price': 'OMR 24',
            'availability': 'Earliest availability at 10:20 AM',
          },
        ]),
        _buildExpandableSection('wiring', []),
        _buildExpandableSection('light & fan', []),
        _buildExpandableSection('MCB / Fuse', []),
        _buildExpandableSection('Appliance installation', []),
        _buildExpandableSection('Other consultation', []),
      ],
    );
  }

  Widget _buildExpandableSection(String sectionName, List<Map<String, dynamic>> services) {
    final isExpanded = _expandedSections[sectionName] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedSections[sectionName] = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Transform.rotate(
                  angle: isExpanded ? 0 : 3.14159, // 180 degrees
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded && services.isNotEmpty) ...[
          ...services.map((service) => _buildServiceItem(service)),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['title'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      '${service['rating']}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    AssetHelper.loadImageOrIcon(
                      assetPath: AssetPaths.star1,
                      fallbackIcon: Icons.star,
                      size: 8,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${service['bookings']} bookings)',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text(
                      'Starts from ${service['price']}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.textPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      service['availability'] as String,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.serviceDetail,
                      arguments: {
                        'serviceName': service['title'],
                        'serviceCategory': 'Electrical',
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'View details',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.serviceDetail,
                arguments: {
                  'serviceName': service['title'],
                  'serviceCategory': 'Electrical',
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundWhite,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Add',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xxxxxl),
      child: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const QuickMenuElectricalScreen(),
          );
        },
        icon: Icon(
          Icons.list,
          size: 12,
          color: AppColors.backgroundWhite,
        ),
        label: Text(
          'Menu',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.backgroundWhite,
            letterSpacing: 0.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textPrimary,
          foregroundColor: AppColors.backgroundWhite,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 6,
        ),
      ),
    );
  }
}

