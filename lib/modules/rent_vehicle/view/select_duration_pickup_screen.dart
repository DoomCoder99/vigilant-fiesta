import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_cart_controller.dart';
import 'rental_duration_screen.dart';

class SelectDurationPickupScreen extends StatefulWidget {
  const SelectDurationPickupScreen({super.key});

  @override
  State<SelectDurationPickupScreen> createState() => _SelectDurationPickupScreenState();
}

class _SelectDurationPickupScreenState extends State<SelectDurationPickupScreen> {
  String selectedLocation = 'Salala';
  
  final List<String> locations = [
    'Salala',
    'Muscat',
    'Sur',
    'Seeb',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent dismissal when tapping inside
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pickup From',
                          style: TextStyle(
                            color: Color(0xFF162028),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Figtree',
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            size: 24,
                            color: Color(0xFF162028),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  // Location list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        const Text(
                          'Pickup From',
                          style: TextStyle(
                            color: Color(0xFF162028),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Figtree',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFEBEBEB)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: locations.length,
                            separatorBuilder: (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final location = locations[index];
                              final isSelected = selectedLocation == location;
                              
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedLocation = location;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected 
                                                ? const Color(0xFF7132F4) 
                                                : const Color(0xFFEBEBEB),
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFF7132F4),
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        location,
                                        style: TextStyle(
                                          color: const Color(0xFF162028),
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                          fontFamily: 'Figtree',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Continue button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save pickup location
                          final cartController = Get.find<RentCartController>();
                          cartController.pickupLocation.value = selectedLocation;
                          
                          // Navigate to duration selection
                          Navigator.pop(context);
                          Get.to(() => const RentalDurationScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7132F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Figtree',
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

