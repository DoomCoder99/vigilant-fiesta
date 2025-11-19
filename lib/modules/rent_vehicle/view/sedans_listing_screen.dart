import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_vehicle_controller.dart';
import '../../../data/models/vehicle_model.dart';
import 'vehicle_detail_screen.dart';

class SedansListingScreen extends StatelessWidget {
  const SedansListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RentVehicleController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Color(0xFF162028)),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Cars',
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
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEBEBEB)),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.tune, size: 16, color: Color(0xFF162028)),
            ),
            onPressed: () {
              // TODO: Open filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date selector
            _buildDateSelector(),
            const SizedBox(height: 24),

            // Category header
            _buildCategoryHeader(controller),
            const SizedBox(height: 16),

            // Vehicle list
            Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredVehicles.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final vehicle = controller.filteredVehicles[index];
                return _buildVehicleCard(vehicle, controller);
              },
            )),
            const SizedBox(height: 32),

            // Our Process section
            _buildOurProcessSection(),
            const SizedBox(height: 32),

            // Ratings section
            _buildRatingsSection(),
            const SizedBox(height: 32),

            // Reviews
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () {
        // TODO: Open date selector
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEBEBEB)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 20, color: Color(0xFF7132F4)),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '20 Sep 2025 - 26 Sep 2025',
                  style: TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Figtree',
                  ),
                ),
                Text(
                  '7 Days',
                  style: TextStyle(
                    color: Color(0x99162028),
                    fontSize: 10,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Change',
              style: TextStyle(
                color: Color(0xFF7132F4),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(RentVehicleController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sedans',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
            Row(
              children: [
                const Text(
                  '5',
                  style: TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 8,
                    fontFamily: 'Figtree',
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.star, size: 8, color: Color(0xFFFFB800)),
                const SizedBox(width: 4),
                Text(
                  '(248 Bookings)',
                  style: TextStyle(
                    color: const Color(0xFF162028).withOpacity(0.6),
                    fontSize: 8,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFEBEFF5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.verified,
                size: 16,
                color: Color(0xFF7132F4),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'Amozit\nVerified',
              style: TextStyle(
                color: Color(0xFF7132F4),
                fontSize: 8,
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleCard(VehicleModel vehicle, RentVehicleController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectVehicle(vehicle);
        Get.to(() => const VehicleDetailScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEBEBEB)),
        ),
        child: Column(
          children: [
            // Car image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                vehicle.imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: const Color(0xFFF8F8F8),
                    child: const Icon(Icons.directions_car, size: 60, color: Color(0xFFD6DEE8)),
                  );
                },
              ),
            ),

            // Vehicle details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.name,
                              style: const TextStyle(
                                color: Color(0xFF162028),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Figtree',
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  '5',
                                  style: TextStyle(
                                    color: Color(0xFF162028),
                                    fontSize: 8,
                                    fontFamily: 'Figtree',
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Icon(Icons.star, size: 8, color: Color(0xFFFFB800)),
                                const SizedBox(width: 4),
                                Text(
                                  '(${vehicle.totalBookings} Bookings)',
                                  style: TextStyle(
                                    color: const Color(0xFF162028).withOpacity(0.6),
                                    fontSize: 8,
                                    fontFamily: 'Figtree',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              vehicle.rentalAgency ?? 'Rental Agency',
                              style: const TextStyle(
                                color: Color(0x99162028),
                                fontSize: 10,
                                fontFamily: 'Figtree',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'From OMR ${vehicle.pricePerDay.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF162028),
                                fontSize: 10,
                                fontFamily: 'Figtree',
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.selectVehicle(vehicle);
                          Get.to(() => const VehicleDetailScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7132F4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Rent Vehicle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOurProcessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Process',
          style: TextStyle(
            color: Color(0xFF162028),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 16),
        _buildProcessStep('1', 'Inspection', 'We will visit your front door, Then rent a repair garage for your approval.'),
        const SizedBox(height: 12),
        _buildProcessStep('2', 'Quote Approval', 'You can review the price provided to you in relation that fine in case of electric.'),
        const SizedBox(height: 12),
        _buildProcessStep('3', 'Replacement Or Spares', 'If problem, replacement or spares will be sourced right local / nearby shops.'),
        const SizedBox(height: 12),
        _buildProcessStep('4', 'Quality Check', 'We will check the quality of car by standard procedures.'),
      ],
    );
  }

  Widget _buildProcessStep(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFEBEFF5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFF7132F4),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF162028),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Figtree',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: const Color(0xFF162028).withOpacity(0.6),
                  fontSize: 10,
                  fontFamily: 'Figtree',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '4.5',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                    Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                    Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                    Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                    Icon(Icons.star_half, size: 12, color: Color(0xFFFFB800)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Overall Rating',
                  style: TextStyle(
                    color: Color(0x99162028),
                    fontSize: 10,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildRatingBar(5, 182),
        _buildRatingBar(4, 60),
        _buildRatingBar(3, 01),
        _buildRatingBar(2, 00),
        _buildRatingBar(1, 00),
      ],
    );
  }

  Widget _buildRatingBar(int stars, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(
              color: Color(0xFF162028),
              fontSize: 10,
              fontFamily: 'Figtree',
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 10, color: Color(0xFFFFB800)),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: count > 0 ? count / 200 : 0,
              backgroundColor: const Color(0xFFEBEBEB),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB800)),
              minHeight: 4,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(
              color: Color(0xFF162028),
              fontSize: 10,
              fontFamily: 'Figtree',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Reviews',
          style: TextStyle(
            color: Color(0xFF162028),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildFilterChip('Most Recent', true),
            const SizedBox(width: 8),
            _buildFilterChip('My Location', false),
            const SizedBox(width: 8),
            _buildFilterChip('Best Rated', false),
          ],
        ),
        const SizedBox(height: 16),
        _buildReviewCard('Wade Warren', 4, 'More than 2 Satellites'),
        const SizedBox(height: 12),
        _buildReviewCard('Ronald Richards', 5, 'More than 2 Satellites'),
        const SizedBox(height: 12),
        _buildReviewCard('Jane Cooper', 4, 'More than 2 Satellites'),
        const SizedBox(height: 12),
        _buildReviewCard('Albert Flores', 3, 'More than 2 Satellites'),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF7132F4) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF7132F4) : const Color(0xFFEBEBEB),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF162028),
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'Figtree',
        ),
      ),
    );
  }

  Widget _buildReviewCard(String name, int rating, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFD6DEE8),
                child: Icon(Icons.person, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF162028),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Figtree',
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            size: 10,
                            color: const Color(0xFFFFB800),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: const Color(0xFF162028).withOpacity(0.6),
                            fontSize: 8,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse et ultricies lectus. Nulla facilisis. Maur ac euismod Hume, vel accumsan libero.',
            style: TextStyle(
              color: const Color(0xFF162028).withOpacity(0.8),
              fontSize: 10,
              fontFamily: 'Figtree',
            ),
          ),
        ],
      ),
    );
  }
}

