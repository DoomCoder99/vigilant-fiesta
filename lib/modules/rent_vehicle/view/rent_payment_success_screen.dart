import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_cart_controller.dart';
import '../../explore/view/explore_screen.dart';

class RentPaymentSuccessScreen extends StatelessWidget {
  const RentPaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<RentCartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    
                    // Success card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7132F4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Title
                          Obx(() {
                            final vehicle = cartController.selectedVehicle.value;
                            return Text(
                              '${vehicle?.name ?? 'Vehicle'} booked!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Figtree',
                              ),
                            );
                          }),
                          const SizedBox(height: 24),

                          // Robot illustration placeholder
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Robot body (simplified)
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    size: 80,
                                    color: Color(0xFF7132F4),
                                  ),
                                ),
                                // Success checkmark badge
                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Confirmation message
                    Obx(() {
                      final vehicle = cartController.selectedVehicle.value;
                      final startDate = cartController.startDate.value;
                      
                      if (vehicle == null || startDate == null) {
                        return const SizedBox.shrink();
                      }

                      final dateStr = _formatDate(startDate);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Your request for Rent A Vehicle\n${vehicle.name} for $dateStr\nhas been confirmed.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF162028),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Figtree',
                            height: 1.5,
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add to calendar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to calendar'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7132F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text(
                        'Add to your Calendar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        cartController.clearCart();
                        Get.offAll(() => const ExploreScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF7132F4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text(
                        'Explore Amozit',
                        style: TextStyle(
                          color: Color(0xFF7132F4),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}

