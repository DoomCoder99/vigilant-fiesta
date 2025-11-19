import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_vehicle_controller.dart';
import 'sedans_listing_screen.dart';

class RentVehicleHomeScreen extends StatelessWidget {
  const RentVehicleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RentVehicleController());

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
          'Rent A Vehicle',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Padding(
              padding: const EdgeInsets.all(25),
              child: _buildHeroBanner(),
            ),

            // Rent A Vehicle Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _buildRentVehicleHeader(),
            ),
            const SizedBox(height: 16),

            // Date Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _buildDateSelector(),
            ),
            const SizedBox(height: 24),

            // Vehicle Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: _buildVehicleCategories(controller),
            ),
            const SizedBox(height: 32),

            // Cars Section
            _buildCarsSection(controller),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/rent_vehicle/banners/hero_banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Book Vehicles As',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Figtree',
                  ),
                ),
                const Text(
                  'Low As OMR 240',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Figtree',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A good companion for your leisure\ntrips and utilities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Figtree',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Get.find<RentVehicleController>().selectCategory('sedans');
                    Get.to(() => const SedansListingScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7132F4),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Figtree',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRentVehicleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rent A Vehicle',
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
                  '(248 bookings)',
                  style: TextStyle(
                    color: const Color(0xFF162028).withOpacity(0.6),
                    fontSize: 8,
                    fontFamily: 'Figtree',
                    decoration: TextDecoration.underline,
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

  Widget _buildVehicleCategories(RentVehicleController controller) {
    return Column(
      children: [
        Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            if (index >= controller.categories.length) {
              return const SizedBox();
            }
            final category = controller.categories[index];
            return _buildCategoryCard(category, controller);
          },
        )),
      ],
    );
  }

  Widget _buildCategoryCard(category, RentVehicleController controller) {
    return GestureDetector(
      onTap: () {
        controller.selectCategory(category.id);
        Get.to(() => const SedansListingScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEBEBEB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category.id),
              size: 32,
              color: const Color(0xFF162028),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF162028),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'sedans':
      case 'hatchbacks':
      case '6seaters':
      case 'premium':
        return Icons.directions_car;
      case 'vans':
        return Icons.airport_shuttle;
      case '4x4':
        return Icons.terrain;
      default:
        return Icons.directions_car;
    }
  }

  Widget _buildCarsSection(RentVehicleController controller) {
    return Container(
      color: const Color(0xFFF8F8F8),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Obx(() => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categories.take(4).length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return _buildCarsCategoryRow(category, controller);
            },
          )),
        ],
      ),
    );
  }

  Widget _buildCarsCategoryRow(category, RentVehicleController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEBEBEB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
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
                    '(${category.vehicleCount} Bookings)',
                    style: TextStyle(
                      color: const Color(0xFF162028).withOpacity(0.6),
                      fontSize: 8,
                      fontFamily: 'Figtree',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Toyota',
                    style: TextStyle(
                      color: Color(0xFF162028),
                      fontSize: 10,
                      fontFamily: 'Figtree',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 12,
                    color: const Color(0xFFEBEBEB),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Nissan',
                    style: TextStyle(
                      color: Color(0xFF162028),
                      fontSize: 10,
                      fontFamily: 'Figtree',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 12,
                    color: const Color(0xFFEBEBEB),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'GM',
                    style: TextStyle(
                      color: Color(0xFF162028),
                      fontSize: 10,
                      fontFamily: 'Figtree',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 12,
                    color: const Color(0xFFEBEBEB),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Mercedes',
                    style: TextStyle(
                      color: Color(0xFF162028),
                      fontSize: 10,
                      fontFamily: 'Figtree',
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              controller.selectCategory(category.id);
              Get.to(() => const SedansListingScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7132F4),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'View Models',
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
    );
  }
}

