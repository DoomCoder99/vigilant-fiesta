import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rental_duration_controller.dart';
import '../widgets/day_wise_rental_selector.dart';
import '../widgets/hourly_rental_selector.dart';
import '../widgets/addons_drawer.dart';

class RentalDurationScreen extends StatelessWidget {
  const RentalDurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RentalDurationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF162028)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Rent Vehicle',
          style: TextStyle(
            color: Color(0xFF162028),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Figtree',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/rent_vehicle/icons/close_small.png',
              width: 20,
              height: 20,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: Obx(() => Row(
              children: [
                Expanded(
                  child: _TabButton(
                    title: 'Day-Wise Rental',
                    isSelected: controller.rentalType.value == RentalType.dayWise,
                    onTap: () => controller.switchRentalType(RentalType.dayWise),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TabButton(
                    title: 'Hourly Rental',
                    isSelected: controller.rentalType.value == RentalType.hourly,
                    onTap: () => controller.switchRentalType(RentalType.hourly),
                  ),
                ),
              ],
            )),
          ),

          // Content area
          Expanded(
            child: Obx(() {
              if (controller.rentalType.value == RentalType.dayWise) {
                return const DayWiseRentalSelector();
              } else {
                return const HourlyRentalSelector();
              }
            }),
          ),

          // Apply button
          Padding(
            padding: const EdgeInsets.all(25),
            child: Obx(() => SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.canApply ? () {
                  controller.apply();
                  // Show add-ons drawer (it will navigate to cart on Continue)
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddOnsDrawer(),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.canApply 
                      ? const Color(0xFF7132F4) 
                      : const Color(0xFFEBEBEB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  disabledBackgroundColor: const Color(0xFFEBEBEB),
                  disabledForegroundColor: Colors.white,
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Figtree',
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEBEFF5) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF7132F4) : const Color(0xFFEBEBEB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? const Color(0xFF7132F4) : const Color(0xFF162028),
              fontFamily: 'Figtree',
            ),
          ),
        ),
      ),
    );
  }
}

