import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/asset_helper.dart';
import '../../../core/routes/app_routes.dart';
import 'package:get/get.dart';

/// Add Address Screen for first-time service booking
/// 
/// Allows users to enter detailed address information for service delivery.
/// User can:
/// - Enter city, street, landmark, and house/apartment details
/// - Select address type (Home, Work, Friends, Others)
/// - Save the address as default
/// - Continue to slot selection
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  String _selectedAddressType = 'Home';
  String? _selectedLocation;
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();
    // Get location passed from AddLocationScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _selectedLocation = args['location'] as String?;
          _selectedAddress = args['address'] as String?;
        });
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  void _continueToSelectSlot() {
    // Validate that at least city and street are filled
    if (_cityController.text.isEmpty || _streetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter city and street details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Save address to data layer
    // For now, navigate to slot selection
    Navigator.of(context).pushNamed(
      AppRoutes.slotSelection,
      arguments: {
        'location': _selectedLocation,
        'address': _selectedAddress,
        'city': _cityController.text,
        'street': _streetController.text,
        'landmark': _landmarkController.text,
        'house': _houseController.text,
        'addressType': _selectedAddressType,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leadingWidth: 45,
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD6DEE8)),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Set address',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                // Container(
                //   height: 100,
                //   color: AppColors.backgroundWhite,
                //   padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                //   child: Column(
                //     children: [
                //       const SizedBox(height: AppSpacing.md),
                //       // Top bar
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           // Back button
                //           GestureDetector(
                //             onTap: () => Navigator.of(context).pop(),
                //             child: Container(
                //               width: 36,
                //               height: 36,
                //               padding: const EdgeInsets.all(10),
                //               decoration: BoxDecoration(
                //                 border: Border.all(color: AppColors.inputBorder),
                //                 borderRadius: BorderRadius.circular(28),
                //               ),
                //               child: AssetHelper.loadImageOrIcon(
                //                 assetPath: AssetPaths.iconArrowLeft,
                //                 fallbackIcon: Icons.arrow_back,
                //                 size: 16,
                //               ),
                //             ),
                //           ),
                //
                //           // Title
                //           Text(
                //             'Set Address',
                //             style: AppTextStyles.bodyMedium.copyWith(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w500,
                //               color: AppColors.textPrimary,
                //             ),
                //           ),
                //
                //           // Empty space for balance
                //           const SizedBox(width: 36),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // Location display
                SizedBox(height: AppSpacing.md,),
                if (_selectedLocation != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Row(
                      children: [
                        AssetHelper.loadImageOrIcon(
                          assetPath: AssetPaths.iconLocationOn,
                          fallbackIcon: Icons.location_on,
                          size: 24,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedLocation!,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              if (_selectedAddress != null)
                                Text(
                                  _selectedAddress!,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: AppSpacing.xl),

                // Detailed Address label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(
                    'Detailed Address',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Address input fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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

                const SizedBox(height: AppSpacing.xl),

                // Save this address as label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(
                    'Save This Address As',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Address type chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    children: [
                      _buildAddressTypeChip(
                        label: 'Home',
                        icon: AssetPaths.iconHomeServiceBooking,
                        fallbackIcon: Icons.home,
                      ),
                      const SizedBox(width: 8),
                      _buildAddressTypeChip(
                        label: 'Work',
                        icon: AssetPaths.iconBusinessCenter,
                        fallbackIcon: Icons.work,
                      ),
                      const SizedBox(width: 8),
                      _buildAddressTypeChip(
                        label: 'Friends',
                        icon: AssetPaths.iconGroups,
                        fallbackIcon: Icons.group,
                      ),
                      const SizedBox(width: 8),
                      _buildAddressTypeChip(
                        label: 'Others',
                        icon: AssetPaths.iconAddLocationAlt,
                        fallbackIcon: Icons.location_on,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // Continue button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _continueToSelectSlot,
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
                        'Continue To Select Slot',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 14,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
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
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.backgroundWhite,
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.6)
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
