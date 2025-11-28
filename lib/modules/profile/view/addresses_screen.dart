import 'package:amoz_customer/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Addresses Screen
///
/// Lists user's saved addresses.
/// Design Source: Figma frame "Addresses" (node-id: 1-25533)
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      {
        'type': 'Home',
        'address':
            '12/2, Al Rawahy Building,\nAl Nahda Street, Building 123\nAl Khuwair, Muscat, OMN 112',
        'isDefault': true,
      },
      {
        'type': 'Work',
        'address':
            '12/2, Al Rawahy Building,\nAl Nahda Street, Building 123\nAl Khuwair, Muscat, OMN 112',
        'isDefault': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
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
        title: const Text(
          'Addresses',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Color(0xffD6DEE8)),
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return _AddressCard(
                    type: address['type'] as String,
                    address: address['address'] as String,
                    isDefault: address['isDefault'] as bool,
                    onEdit: () {
                      // TODO: Navigate to edit address screen
                    },
                  );
                },
              ),
              Divider(height: 1, color: Color(0xffD6DEE8)),
              SizedBox(height: AppSpacing.xl,),
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // remove internal padding
                  minimumSize: Size(0, 0), // remove minimum tap target
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // remove extra height
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.addLocation);
                },
                icon: Image.asset(
                  'assets/profile/add_icon.png',
                  width: 12,
                  height: 12,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.add,
                      size: 12,
                      color: AppColors.primary,
                    );
                  },
                ),
                label: const Text(
                  'Add new address',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.figtree,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String type;
  final String address;
  final bool isDefault;
  final VoidCallback onEdit;

  const _AddressCard({
    required this.type,
    required this.address,
    required this.isDefault,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Type Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: const Color(0xFFD6DEE8)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        type == 'Home'
                            ? 'assets/profile/home_icon.png'
                            : 'assets/profile/work_icon.png',
                        width: 12,
                        height: 12,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            type == 'Home' ? Icons.home : Icons.business,
                            size: 12,
                            color: AppColors.textPrimary,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        type,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  address,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 3),
              Icon(Icons.edit, size: 16, color: AppColors.textPrimary),
            ],
          ),
        ],
      ),
    );
  }
}
