import 'package:get/get.dart';
import '../../../data/models/vehicle_model.dart';

class RentVehicleController extends GetxController {
  // Observable lists
  final RxList<VehicleCategoryModel> categories = <VehicleCategoryModel>[].obs;
  final RxList<VehicleModel> vehicles = <VehicleModel>[].obs;
  final RxList<VehicleModel> filteredVehicles = <VehicleModel>[].obs;
  
  // Selected category
  final RxString selectedCategory = ''.obs;
  
  // Loading states
  final RxBool isLoading = false.obs;
  
  // Selected vehicle for detail view
  final Rxn<VehicleModel> selectedVehicle = Rxn<VehicleModel>();

  @override
  void onInit() {
    super.onInit();
    _initializeMockData();
  }

  void _initializeMockData() {
    // Initialize categories
    categories.value = [
      VehicleCategoryModel(
        id: 'sedans',
        name: 'Sedans',
        iconPath: 'assets/images/car_icon.png',
        vehicleCount: 248,
      ),
      VehicleCategoryModel(
        id: 'hatchbacks',
        name: 'Hatchbacks',
        iconPath: 'assets/images/car_icon.png',
        vehicleCount: 248,
      ),
      VehicleCategoryModel(
        id: '6seaters',
        name: '6 Seaters',
        iconPath: 'assets/images/car_icon.png',
        vehicleCount: 248,
      ),
      VehicleCategoryModel(
        id: 'premium',
        name: 'Premium Cars',
        iconPath: 'assets/images/car_icon.png',
        vehicleCount: 248,
      ),
      VehicleCategoryModel(
        id: 'vans',
        name: 'Vans',
        iconPath: 'assets/images/van_icon.png',
        vehicleCount: 0,
      ),
      VehicleCategoryModel(
        id: '4x4',
        name: '4x4',
        iconPath: 'assets/images/4x4_icon.png',
        vehicleCount: 0,
      ),
    ];

    // Initialize mock vehicles (Sedans)
    vehicles.value = [
      VehicleModel(
        id: '1',
        name: 'Toyota Camry',
        category: 'sedans',
        brand: 'Toyota',
        pricePerDay: 24.00,
        imagePath: 'assets/rent_vehicle/cars/car1_camry.png',
        rating: 5.0,
        totalBookings: 248,
        specs: VehicleSpecs(
          year: 2023,
          seats: 4,
          transmission: 'Manual',
          fuelType: 'Petrol',
          engineCapacity: '2000 Cc',
          features: ['AC', 'GPS', 'Bluetooth', 'USB'],
        ),
        rentalAgency: 'Rental Agency',
      ),
      VehicleModel(
        id: '2',
        name: 'Hyundai Sonata',
        category: 'sedans',
        brand: 'Hyundai',
        pricePerDay: 24.00,
        imagePath: 'assets/rent_vehicle/cars/car2_sonata.png',
        rating: 5.0,
        totalBookings: 248,
        specs: VehicleSpecs(
          year: 2023,
          seats: 4,
          transmission: 'Manual',
          fuelType: 'Petrol',
          engineCapacity: '2000 Cc',
          features: ['AC', 'GPS', 'Bluetooth'],
        ),
        rentalAgency: 'Rental Agency',
      ),
      VehicleModel(
        id: '3',
        name: 'Kia K3',
        category: 'sedans',
        brand: 'Kia',
        pricePerDay: 24.00,
        imagePath: 'assets/rent_vehicle/cars/car3_k3.png',
        rating: 5.0,
        totalBookings: 248,
        specs: VehicleSpecs(
          year: 2023,
          seats: 4,
          transmission: 'Manual',
          fuelType: 'Petrol',
          engineCapacity: '2000 Cc',
          features: ['AC', 'GPS'],
        ),
        rentalAgency: 'Rental Agency',
      ),
      VehicleModel(
        id: '4',
        name: 'Toyota Camry',
        category: 'sedans',
        brand: 'Toyota',
        pricePerDay: 24.00,
        imagePath: 'assets/rent_vehicle/cars/car4_camry2.png',
        rating: 5.0,
        totalBookings: 248,
        specs: VehicleSpecs(
          year: 2023,
          seats: 4,
          transmission: 'Manual',
          fuelType: 'Petrol',
          engineCapacity: '2000 Cc',
          features: ['AC', 'GPS', 'Bluetooth', 'USB', 'Sunroof'],
        ),
        rentalAgency: 'Rental Agency',
      ),
    ];

    filteredVehicles.value = vehicles;
  }

  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;
    
    if (categoryId.isEmpty) {
      filteredVehicles.value = vehicles;
    } else {
      filteredVehicles.value = vehicles
          .where((vehicle) => vehicle.category == categoryId)
          .toList();
    }
  }

  void selectVehicle(VehicleModel vehicle) {
    selectedVehicle.value = vehicle;
  }

  Future<void> fetchVehiclesByCategory(String categoryId) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    selectCategory(categoryId);
    isLoading.value = false;
  }

  VehicleCategoryModel? getCategoryById(String id) {
    try {
      return categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }
}

