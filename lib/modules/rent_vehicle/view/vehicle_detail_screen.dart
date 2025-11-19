import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_vehicle_controller.dart';
import '../controller/rent_cart_controller.dart';
import '../../../data/models/vehicle_model.dart';
import 'select_duration_pickup_screen.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RentVehicleController>();
    Get.put(RentCartController()); // Initialize cart controller
    
    return Obx(() {
      final vehicle = controller.selectedVehicle.value;
      
      if (vehicle == null) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Vehicle Details'),
          ),
          body: const Center(
            child: Text('No vehicle selected'),
          ),
        );
      }

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
          title: Text(
            vehicle.name,
            style: const TextStyle(
              color: Color(0xFF162028),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Figtree',
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share, size: 20, color: Color(0xFF162028)),
              onPressed: () {
                // TODO: Share functionality
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date selector
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: _buildDateSelector(),
                    ),

                    // Vehicle image carousel
                    _buildVehicleImageCarousel(vehicle),
                    const SizedBox(height: 24),

                    // Vehicle info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _buildVehicleInfo(vehicle),
                    ),
                    const SizedBox(height: 24),

                    // Car Details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _buildCarDetails(vehicle),
                    ),
                    const SizedBox(height: 24),

                    // Ratings
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _buildRatingsSection(),
                    ),
                    const SizedBox(height: 24),

                    // Reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _buildReviewsSection(),
                    ),
                    const SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),

            // Bottom continue button
            _buildBottomButton(vehicle),
          ],
        ),
      );
    });
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

  Widget _buildVehicleImageCarousel(VehicleModel vehicle) {
    return SizedBox(
      height: 200,
      child: PageView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                vehicle.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF8F8F8),
                    child: const Icon(Icons.directions_car, size: 80, color: Color(0xFFD6DEE8)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfo(VehicleModel vehicle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vehicle.name,
          style: const TextStyle(
            color: Color(0xFF162028),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Text(
              '5',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 10,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.star, size: 10, color: Color(0xFFFFB800)),
            const SizedBox(width: 4),
            Text(
              '(${vehicle.totalBookings} Bookings)',
              style: TextStyle(
                color: const Color(0xFF162028).withOpacity(0.6),
                fontSize: 10,
                fontFamily: 'Figtree',
              ),
            ),
            const Spacer(),
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
        ),
        const SizedBox(height: 8),
        Text(
          vehicle.rentalAgency ?? 'Rental Agency',
          style: const TextStyle(
            color: Color(0x99162028),
            fontSize: 12,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              vehicle.pricePerDay.toStringAsFixed(2),
              style: const TextStyle(
                color: Color(0xFF162028),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
              ),
            ),
            const Text(
              ' OMR / Day',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarDetails(VehicleModel vehicle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Car Details',
          style: TextStyle(
            color: Color(0xFF162028),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildDetailRow('Year', vehicle.specs.year.toString()),
              const Divider(height: 24),
              _buildDetailRow('Seating', '${vehicle.specs.seats}'),
              const Divider(height: 24),
              _buildDetailRow('Transmission', vehicle.specs.transmission),
              const Divider(height: 24),
              _buildDetailRow('Fuel Type', vehicle.specs.fuelType),
              const Divider(height: 24),
              _buildDetailRow('Engine', vehicle.specs.engineCapacity),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu volutpat elit. Quisque ultrices euismod lacus. In sagittis viverra nisi, quis velit consectetur imperdiet suscipit tincidunt. Sed ac pharetra diam. Ut vestibulum turpis urna eu cursus quis. Maecenas facilisis scelerisque neque ut hendrerit. Nam in pharetra odio.',
          style: TextStyle(
            color: Color(0x99162028),
            fontSize: 10,
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Set in pharetra diam. Ut vestibulum turpis urna eu cursus quis. Maecenas facilisis scelerisque neque ut hendrerit. Nam in pharetra odio. Mauris velit neque, laoreet nec lacinia aliquet, porttitor eget metus. Vestibulum ante ipsum primis in faucibus orci lorem ipsum dolor sit amet.',
          style: TextStyle(
            color: Color(0x99162028),
            fontSize: 10,
            fontFamily: 'Figtree',
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF162028).withOpacity(0.6),
            fontSize: 12,
            fontFamily: 'Figtree',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF162028),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Figtree',
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

  Widget _buildBottomButton(VehicleModel vehicle) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEBEBEB), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEFF5),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag_outlined, size: 20, color: Color(0xFF7132F4)),
                const SizedBox(width: 8),
                Text(
                  'OMR ${(vehicle.pricePerDay * 7).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const SelectDurationPickupScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7132F4),
                padding: const EdgeInsets.symmetric(vertical: 16),
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
        ],
      ),
    );
  }
}

