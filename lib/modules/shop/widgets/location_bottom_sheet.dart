import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/services/location_permission_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/asset_helper.dart';
import '../../../../core/utils/asset_helper.dart' as assets;
import '../widgets/add_address_bottom_sheet.dart';

/// Location Bottom Sheet Widget
/// 
/// Displays saved addresses in a bottom sheet format.
/// If user has no addresses, automatically gets current location and shows add address screen.
/// Design Source: Figma frame "Addresses" (node-id: 1-25533)
class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    // TODO: Replace with actual address fetching from service/repository
    // For now, checking if user has addresses
    final addresses = <Map<String, dynamic>>[];
    
    // If no addresses, get current location and show add address screen
    if (addresses.isEmpty) {
      final permissionService = LocationPermissionService.instance;
      final isGranted = await permissionService.isPermissionGranted();
      
      if (isGranted) {
        // Get current location
        try {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          
          // Close this bottom sheet and show add address bottom sheet with current location
          if (mounted) {
            Navigator.of(context).pop();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddAddressBottomSheet(),
            );
            return;
          }
        } catch (e) {
          // Error getting location, show empty state
          if (mounted) {
            setState(() {
              _addresses = addresses;
              _isLoading = false;
            });
          }
          return;
        }
      } else {
        // Request permission first
        final granted = await permissionService.requestPermission();
        if (granted && mounted) {
          try {
            final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            
            // Close this bottom sheet and show add address bottom sheet
            Navigator.of(context).pop();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddAddressBottomSheet(),
            );
            return;
          } catch (e) {
            // Error getting location, show empty state
            if (mounted) {
              setState(() {
                _addresses = addresses;
                _isLoading = false;
              });
            }
            return;
          }
        } else {
          // Permission denied, show empty state
          if (mounted) {
            setState(() {
              _addresses = addresses;
              _isLoading = false;
            });
          }
          return;
        }
      }
    }
    
    setState(() {
      _addresses = addresses;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'Addresses',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Addresses list or empty state
          Flexible(
            child: _addresses.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_off,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'No addresses saved',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Add your first address to get started',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : _addresses.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        itemCount: _addresses.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final address = _addresses[index];
                          return _AddressCard(
                            type: address['type'] as String,
                            address: address['address'] as String,
                            isDefault: address['isDefault'] as bool,
                            onEdit: () {
                              // TODO: Navigate to edit address screen
                            },
                            onSelect: () {
                              // TODO: Update selected location and close bottom sheet
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
          ),
          const SizedBox(height: 12),
          // Add new address button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Close addresses bottom sheet
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddAddressBottomSheet(),
                );
              },
              icon: AssetHelper.loadImageOrIcon(
                assetPath: assets.AssetPaths.iconAdd,
                fallbackIcon: Icons.add,
                size: 12,
                color: AppColors.primary,
              ),
              label: Text(
                'Add new address',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.lg),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String type;
  final String address;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onSelect;

  const _AddressCard({
    required this.type,
    required this.address,
    required this.isDefault,
    required this.onEdit,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address type chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AssetHelper.loadImageOrIcon(
                    assetPath: type == 'Home' 
                        ? assets.AssetPaths.iconHomeServiceBooking
                        : assets.AssetPaths.iconBusinessCenter,
                    fallbackIcon: type == 'Home' ? Icons.home : Icons.work,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    type,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Address text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Edit icon
            IconButton(
              icon: const Icon(Icons.edit, size: 16, color: AppColors.textPrimary),
              onPressed: onEdit,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

