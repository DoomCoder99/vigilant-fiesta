import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/routes/app_routes.dart';

/// Add Location Screen for first-time service booking
/// 
/// Allows users to select their service location on a map.
/// User can:
/// - Move the map pin to change location
/// - Search for a location
/// - Use current location
/// - Proceed to Add Address screen
class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  // Selected location (stubbed for now - will be replaced with actual map integration)
  final String _selectedLocation = 'Al Farwaniyah';
  final String _selectedAddress = 'Block 4, Al Farwaniyah, Oman';

  void _useCurrentLocation() {
    // TODO: Implement actual location permission request and retrieval
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Using current location...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToAddAddress() {
    Navigator.of(context).pushNamed(
      AppRoutes.addAddress,
      arguments: {
        'location': _selectedLocation,
        'address': _selectedAddress,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            // Map view (stubbed with image)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 600,
              child: AssetHelper.loadImageOrPlaceholder(
                assetPath: "assets/map/map.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 65,
                color: AppColors.backgroundWhite,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    // Top bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 36,
                            height: 36,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.inputBorder),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: AssetHelper.loadImageOrIcon(
                              assetPath: AssetPaths.iconArrowLeft,
                              fallbackIcon: Icons.arrow_back,
                              size: 16,
                            ),
                          ),
                        ),

                        // Title
                        Text(
                          'Set Location',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        // Empty space for balance (tune icon is hidden in Figma)
                        const SizedBox(width: 36),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search bar
            Positioned(
              top: 80,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    AssetHelper.loadImageOrIcon(
                      assetPath: AssetPaths.iconSearchLocation,
                      fallbackIcon: Icons.search,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search a building, street or area',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center pin indicator
            Positioned(
              left: 0,
              right: 0,
              top: 295,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Service location tooltip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Service location',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.backgroundWhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Move the pin to change location',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 10,
                            color: AppColors.backgroundWhite.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow down
                  CustomPaint(
                    size: const Size(24, 12),
                    painter: _ArrowPainter(),
                  ),
                  // Pin
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Color(0xff8B9D71).withOpacity(0.5),
                           borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Color(0xff8B9D71),
                           borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Use current location button
            Positioned(
              left: 0,
              right: 0,
              top: 592,
              child: Center(
                child: GestureDetector(
                  onTap: _useCurrentLocation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EBFE),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AssetHelper.loadImageOrIcon(
                          assetPath: AssetPaths.iconMyLocation,
                          fallbackIcon: Icons.my_location,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Use current location',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom sheet - Selected Location
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.lg,
                  bottom: 32,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Selected Location',
                            style: AppTextStyles.headingSmall.copyWith(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: AssetHelper.loadImageOrIcon(
                              assetPath: AssetPaths.iconCloseSmall,
                              fallbackIcon: Icons.close,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Selected location display
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundWhite,
                              border: Border.all(color: AppColors.inputBorder),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: AssetHelper.loadImageOrIcon(
                              assetPath: AssetPaths.iconLocationPin,
                              fallbackIcon: Icons.location_on,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedLocation,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  _selectedAddress,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textPrimary.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Add Address button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _navigateToAddAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.backgroundWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                          ),
                          child: Text(
                            'Add Address',
                            style: AppTextStyles.button.copyWith(
                              fontSize: 14,
                              color: AppColors.backgroundWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the arrow down indicator
class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
