import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/utils/asset_helper.dart' as assets;

/// Slot Selection Screen
///
/// Allows user to select booking slot (immediate or scheduled).
/// Displays service items in a drawer/modal and slot selection options.
/// Design Source: Figma frames "Slot selection" (node-id: 1-9576)
/// and "Select slot drawer - book slot" (node-id: 1-10152)
class SlotSelectionScreen extends StatefulWidget {
  const SlotSelectionScreen({super.key});

  @override
  State<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen> {
  String _selectedSlot = 'immediate'; // 'immediate' or 'scheduled'
  bool _showSlotDrawer = false;

  @override
  void initState() {
    super.initState();
    // Show slot drawer after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showSlotDrawer = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Main content (address form - placeholder)
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 24, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Al Farwaniyah',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Block 4, Al Farwaniyah, Oman',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Detailed Address',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Placeholder text fields
                  _buildTextField('City'),
                  const SizedBox(height: AppSpacing.md),
                  _buildTextField('Street'),
                  const SizedBox(height: AppSpacing.md),
                  _buildTextField('Landmark'),
                  const SizedBox(height: AppSpacing.md),
                  _buildTextField('House # / Apartment name / Floor'),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Save this address as',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      _buildAddressTypeChip('Home', Icons.home, true),
                      const SizedBox(width: AppSpacing.md),
                      _buildAddressTypeChip('Work', Icons.business_center, false),
                      const SizedBox(width: AppSpacing.md),
                      _buildAddressTypeChip('Friends', Icons.group, false),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Slot selection drawer
          if (_showSlotDrawer) _buildSlotDrawer(),
        ],
      ),
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
        'Set Address',
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTextField(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontSize: 16,
                color: const Color(0xFF9E9E9E),
              ),
            ),
          ),
          Icon(Icons.mic, size: 16, color: AppColors.textPrimary),
        ],
      ),
    );
  }

  Widget _buildAddressTypeChip(String label, IconData icon, bool selected) {
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: selected ? AppColors.backgroundWhite : AppColors.textPrimary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: selected ? AppColors.backgroundWhite : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotDrawer() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xxl, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select A Slot',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: AssetHelper.loadImageOrIcon(
                    assetPath: assets.AssetPaths.iconCloseSmall,
                    fallbackIcon: Icons.close,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                      _showSlotDrawer = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            _buildSlotOption(
              icon: Icons.bolt,
              title: 'Immediate',
              description: 'Service will be scheduled at the earliest',
              value: 'immediate',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildSlotOption(
              icon: Icons.calendar_today,
              title: 'Schedule For Later',
              description: 'Select your preferred date & time',
              value: 'scheduled',
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
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
                            '1',
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
                        'OMR 24',
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
                    // Navigate to cart (reuse existing cart route from Module 2)
                    Navigator.of(context).pushNamed(AppRoutes.cart);
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
          ],
        ),
      ),
    );
  }

  Widget _buildSlotOption({
    required IconData icon,
    required String title,
    required String description,
    required String value,
  }) {
    final isSelected = _selectedSlot == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSlot = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              size: 16,
              color: isSelected ? AppColors.primary : AppColors.inputBorder,
            ),
          ],
        ),
      ),
    );
  }
}

