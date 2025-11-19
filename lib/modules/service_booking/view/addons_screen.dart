import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/utils/asset_helper.dart' as assets;

/// Addons Screen
///
/// Displays add-on products that can be added to the service booking.
/// Shown as a modal bottom sheet with selectable products.
/// Design Source: Figma frames "Addons" (node-id: 1-9876)
/// and "Addons - added" (node-id: 1-10008)
class AddonsScreen extends StatefulWidget {
  const AddonsScreen({super.key});

  @override
  State<AddonsScreen> createState() => _AddonsScreenState();
}

class _AddonsScreenState extends State<AddonsScreen> {
  final Map<int, int> _addonQuantities = {};

  void _addAddon(int index) {
    setState(() {
      _addonQuantities[index] = (_addonQuantities[index] ?? 0) + 1;
    });
  }

  void _removeAddon(int index) {
    setState(() {
      if ((_addonQuantities[index] ?? 0) > 0) {
        _addonQuantities[index] = _addonQuantities[index]! - 1;
        if (_addonQuantities[index] == 0) {
          _addonQuantities.remove(index);
        }
      }
    });
  }

  void _incrementAddon(int index) {
    setState(() {
      _addonQuantities[index] = (_addonQuantities[index] ?? 0) + 1;
    });
  }

  int _getTotalQuantity() {
    return _addonQuantities.values.fold(0, (sum, qty) => sum + qty);
  }

  double _getTotalPrice() {
    double total = 0;
    _addonQuantities.forEach((index, qty) {
      total += _getAddonPrice(index) * qty;
    });
    return total;
  }

  double _getAddonPrice(int index) {
    switch (index) {
      case 0:
        return 2.40; // Legrand - Single Pole Switch
      case 1:
        return 12.04; // Legrand - Double Pole Switch
      case 2:
        return 4.00; // Legrand Mylinc 16A
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final addons = [
      {
        'name': 'Legrand - Single Pole Switch 10 AX, 250 V~, White',
        'rating': 5,
        'price': 2.40,
        'image': assets.AssetPaths.addonLegrandSinglePole,
      },
      {
        'name': 'Legrand - Double Pole Switch 10 AX, 250 V~, White',
        'rating': 5,
        'price': 12.04,
        'image': assets.AssetPaths.addonLegrandDoublePole,
      },
      {
        'name': 'Legrand Mylinc 16A Single Pole 1 Module 1 Way Switch',
        'rating': 4.8,
        'price': 4.00,
        'image': assets.AssetPaths.addonLegrandMylinc,
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.xl),
          topRight: Radius.circular(AppBorderRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(0, AppSpacing.xxl, 0, AppSpacing.xxxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add - Ons',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // For first-time users, navigate to Add Location
                    // TODO: Check if user has saved addresses, if yes go to SlotSelection
                    Navigator.of(context).pushNamed(AppRoutes.addLocation);
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: addons.length,
              itemBuilder: (context, index) {
                final addon = addons[index];
                final quantity = _addonQuantities[index] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.lg),
                  child: _buildAddonCard(addon, index, quantity),
                );
              },
            ),
          ),
          if (_getTotalQuantity() > 0) _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildAddonCard(Map<String, dynamic> addon, int index, int quantity) {
    return SizedBox(
      width: 102,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 102,
            height: 102,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Icon(Icons.power, size: 40, color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                '${addon['rating']}',
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
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            addon['name'] as String,
            style: AppTextStyles.caption.copyWith(
              fontSize: 10,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(
                '${addon['price']}',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                'OMR',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 8,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (quantity == 0)
            ElevatedButton(
              onPressed: () => _addAddon(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                side: BorderSide(color: AppColors.primary),
                minimumSize: const Size(102, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Add To Cart',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Container(
              width: 102,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _removeAddon(index),
                    child: Text(
                      '-',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
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
                    onTap: () => _incrementAddon(index),
                    child: Text(
                      '+',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
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

  Widget _buildBottomBar() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.lg),
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
                Icon(Icons.shopping_bag_outlined, size: 16, color: AppColors.primary),
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
              Navigator.of(context).pop();
              // For first-time users, navigate to Add Location
              // TODO: Check if user has saved addresses, if yes go to SlotSelection
              Navigator.of(context).pushNamed(AppRoutes.addLocation);
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

