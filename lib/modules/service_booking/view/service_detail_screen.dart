import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/utils/asset_helper.dart' as assets;

/// Service Detail Screen
///
/// Displays detailed information about a service (e.g., Switch & Sockets)
/// with options to add items to cart and view process details.
/// Supports "item added" state with quantity adjustment.
/// Design Source: Figma frames "Switch & sockets detail" (node-id: 1-8903)
/// and "Switch & sockets detail - item added" (node-id: 1-9156)
class ServiceDetailScreen extends StatefulWidget {
  final String serviceName;
  final String serviceCategory;

  const ServiceDetailScreen({
    super.key,
    required this.serviceName,
    required this.serviceCategory,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  // Track which service items have been added and their quantities
  final Map<int, int> _itemQuantities = {};

  void _addItem(int index) {
    setState(() {
      _itemQuantities[index] = (_itemQuantities[index] ?? 0) + 1;
    });
  }

  void _removeItem(int index) {
    setState(() {
      if ((_itemQuantities[index] ?? 0) > 0) {
        _itemQuantities[index] = _itemQuantities[index]! - 1;
        if (_itemQuantities[index] == 0) {
          _itemQuantities.remove(index);
        }
      }
    });
  }

  void _incrementItem(int index) {
    setState(() {
      _itemQuantities[index] = (_itemQuantities[index] ?? 0) + 1;
    });
  }

  int _getTotalQuantity() {
    return _itemQuantities.values.fold(0, (sum, qty) => sum + qty);
  }

  double _getTotalPrice() {
    double total = 0;
    _itemQuantities.forEach((index, qty) {
      total += _getServicePrice(index) * qty;
    });
    return total;
  }

  double _getServicePrice(int index) {
    // Prices based on Figma data
    switch (index) {
      case 0:
        return 24.0; // 1 Switch
      case 1:
        return 32.0; // 2 Switches
      case 2:
        return 48.0; // More than 2 Switches
      case 3:
        return 52.0; // Power Switch
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'name': '1 Switch',
        'rating': 5,
        'bookings': 248,
        'price': 'OMR 24',
        'image': assets.AssetPaths.serviceItem1, // Placeholder
      },
      {
        'name': '2 Switches',
        'rating': 5,
        'bookings': 248,
        'price': 'OMR 32',
        'image': assets.AssetPaths.serviceItem2, // Placeholder
      },
      {
        'name': 'More Than 2 Switches',
        'rating': 5,
        'bookings': 248,
        'price': 'OMR 48',
        'image': assets.AssetPaths.serviceItem3, // Placeholder
      },
      {
        'name': 'Power Switch',
        'rating': 5,
        'bookings': 248,
        'price': 'OMR 52',
        'image': assets.AssetPaths.serviceItem4, // Placeholder
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),
            _buildServiceHeader(),
            const SizedBox(height: AppSpacing.xxl),
            _buildServiceList(services),
            const Divider(height: 1, color: AppColors.inputBorder),
            const SizedBox(height: AppSpacing.xxl),
            _buildOurProcess(),
            const Divider(height: 1, color: AppColors.inputBorder),
            const SizedBox(height: AppSpacing.xxl),
            _buildRatings(),
            const SizedBox(height: AppSpacing.xxl),
            _buildReviews(),
            const SizedBox(height: AppSpacing.xxxxxl),
          ],
        ),
      ),
      bottomNavigationBar: _getTotalQuantity() > 0 ? _buildBottomBar() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundWhite,
      elevation: 0,
      leading: IconButton(
        icon: AssetHelper.loadImageOrIcon(
          assetPath: assets.AssetPaths.iconBackArrow,
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
    );
  }

  Widget _buildServiceHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Switch / Socket Repair & Replacement',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                      assetPath: assets.AssetPaths.star1,
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
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
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
      ),
    );
  }

  Widget _buildServiceList(List<Map<String, dynamic>> services) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: services.asMap().entries.map((entry) {
          final index = entry.key;
          final service = entry.value;
          final quantity = _itemQuantities[index] ?? 0;

          return Column(
            children: [
              _buildServiceItem(service, index, quantity),
              if (index < services.length - 1)
                const Divider(height: 1, color: AppColors.inputBorder),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service, int index, int quantity) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFDAE6ED),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Icon(Icons.electrical_services, size: 32, color: Colors.grey[600]),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
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
                      assetPath: assets.AssetPaths.star1,
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
                Text(
                  service['price'] as String,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          if (quantity == 0)
            ElevatedButton(
              onPressed: () => _addItem(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                minimumSize: const Size(47, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Add',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => _removeItem(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '-',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => _incrementItem(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '+',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
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

  Widget _buildOurProcess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Process',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildProcessStep('1', 'Inspection', 'We inspect the switchboard, then send a repair quote for your approval.'),
          const Divider(height: 1, color: AppColors.inputBorder),
          _buildProcessStep('2', 'Quote Approval', 'You can approve the quote to proceed, or pay a visitation fee in case of decline.'),
          const Divider(height: 1, color: AppColors.inputBorder),
          _buildProcessStep('3', 'Replacement Or Spares', 'If needed, replacement or spares will be sourced from local / nearby shops.'),
          const Divider(height: 1, color: AppColors.inputBorder),
          _buildProcessStep('4', 'Quality Check', 'Our technicians will check the quality of job by standard procedures.'),
        ],
      ),
    );
  }

  Widget _buildProcessStep(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4.5',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return AssetHelper.loadImageOrIcon(
                        assetPath: assets.AssetPaths.star1,
                        fallbackIcon: Icons.star,
                        size: 12,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Overall Rating',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildRatingBar(5, 182, 0.76),
          _buildRatingBar(4, 60, 0.46),
          _buildRatingBar(3, 3, 0.05),
          _buildRatingBar(2, 0, 0.04),
          _buildRatingBar(1, 0, 0.03),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int count, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(
            '$stars',
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 2),
          AssetHelper.loadImageOrIcon(
            assetPath: assets.AssetPaths.star1,
            fallbackIcon: Icons.star,
            size: 8,
            color: Colors.amber,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 20,
            child: Text(
              count < 10 ? '0$count' : '$count',
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    final reviews = [
      {'name': 'Wade Warren', 'rating': 5, 'date': 'Sep 12', 'service': 'More than 2 Switches'},
      {'name': 'Ronald Richards', 'rating': 5, 'date': 'Sep 12', 'service': 'More than 2 Switches'},
      {'name': 'Jane Cooper', 'rating': 5, 'date': 'Sep 12', 'service': 'More than 2 Switches'},
      {'name': 'Albert Flores', 'rating': 5, 'date': 'Sep 12', 'service': 'More than 2 Switches'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Reviews',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              _buildFilterChip('Most Recent', true),
              const SizedBox(width: AppSpacing.md),
              _buildFilterChip('My Location', false),
              const SizedBox(width: AppSpacing.md),
              _buildFilterChip('Best Rated', false),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Column(
            children: reviews.asMap().entries.map((entry) {
              final index = entry.key;
              final review = entry.value;
              return Column(
                children: [
                  _buildReviewItem(review),
                  if (index < reviews.length - 1)
                    const Divider(height: 1, color: AppColors.inputBorder),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.inputBorder,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 12,
          color: selected ? AppColors.backgroundWhite : AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review['name'] as String,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Row(
                children: List.generate(review['rating'] as int, (index) {
                  return AssetHelper.loadImageOrIcon(
                    assetPath: assets.AssetPaths.star1,
                    fallbackIcon: Icons.star,
                    size: 8,
                    color: Colors.amber,
                  );
                }),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 1,
                height: 12,
                color: AppColors.inputBorder,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                review['date'] as String,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 1,
                height: 12,
                color: AppColors.inputBorder,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                review['service'] as String,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus. Nulla facilisi. Nunc et euismod libero, vel venenatis libero.',
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              border: Border.all(color: AppColors.inputBorder),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(26),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${_getTotalQuantity()}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 1,
                  height: 16,
                  color: AppColors.inputBorder,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'OMR ${_getTotalPrice().toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Navigate to add-ons screen
              Navigator.of(context).pushNamed(AppRoutes.serviceAddons);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.backgroundWhite,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Continue',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundWhite,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.chevron_right, size: 20, color: AppColors.backgroundWhite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

