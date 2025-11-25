import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/services/location_permission_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;

/// Add Address Bottom Sheet Widget
/// 
/// Allows users to enter detailed address information.
/// Design Source: Figma frame "Add address" (node-id: 1-26043)
class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({super.key});

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  String _selectedAddressType = 'Home';
  String? _currentLocation;
  String? _currentAddress;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final permissionService = LocationPermissionService.instance;
    final isGranted = await permissionService.isPermissionGranted();
    
    if (!isGranted) {
      final granted = await permissionService.requestPermission();
      if (!granted) {
        return;
      }
    }

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      // TODO: Use geocoding to convert coordinates to address
      // For now, using placeholder
      setState(() {
        _currentLocation = 'Al Farwaniyah';
        _currentAddress = 'Block 4, Al Farwaniyah, Oman';
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_cityController.text.isEmpty || _streetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter city and street details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Save address to backend
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Address saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: AssetHelper.loadImageOrIcon(
                      assetPath: assets.AssetPaths.iconArrowLeft,
                      fallbackIcon: Icons.arrow_back,
                      size: 16,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: const BorderSide(color: AppColors.inputBorder),
                      ),
                    ),
                  ),
                  Text(
                    'Set address',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance space
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Current location display
            if (_currentLocation != null || _isLoadingLocation)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: AssetHelper.loadImageOrIcon(
                        assetPath: assets.AssetPaths.iconLocationOn,
                        fallbackIcon: Icons.location_on,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_isLoadingLocation)
                            Text(
                              'Getting location...',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            )
                          else if (_currentLocation != null)
                            Text(
                              _currentLocation!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          if (_currentAddress != null && !_isLoadingLocation)
                            Text(
                              _currentAddress!,
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
              ),
            const SizedBox(height: 20),
            // Detailed Address label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'Detailed address',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Address input fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _cityController,
                    hintText: 'City',
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _streetController,
                    hintText: 'Street',
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _landmarkController,
                    hintText: 'Landmark',
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _houseController,
                    hintText: 'House # / Apartment name / Floor',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Save this address as label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'Save this address as',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Address type chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  _buildAddressTypeChip(
                    label: 'Home',
                    icon: assets.AssetPaths.iconHomeServiceBooking,
                    fallbackIcon: Icons.home,
                  ),
                  const SizedBox(width: 8),
                  _buildAddressTypeChip(
                    label: 'Work',
                    icon: assets.AssetPaths.iconBusinessCenter,
                    fallbackIcon: Icons.work,
                  ),
                  const SizedBox(width: 8),
                  _buildAddressTypeChip(
                    label: 'Friends',
                    icon: assets.AssetPaths.iconGroups,
                    fallbackIcon: Icons.group,
                  ),
                  const SizedBox(width: 8),
                  _buildAddressTypeChip(
                    label: 'Others',
                    icon: assets.AssetPaths.iconAddLocationAlt,
                    fallbackIcon: Icons.location_on,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Save Address button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                  ),
                  child: Text(
                    'Save Address',
                    style: AppTextStyles.button.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          AssetHelper.loadImageOrIcon(
            assetPath: assets.AssetPaths.iconMic,
            fallbackIcon: Icons.mic,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTypeChip({
    required String label,
    required String icon,
    required IconData fallbackIcon,
  }) {
    final isSelected = _selectedAddressType == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddressType = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.backgroundWhite,
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withOpacity(0.6)
                : AppColors.inputBorder,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetHelper.loadImageOrIcon(
              assetPath: icon,
              fallbackIcon: fallbackIcon,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

