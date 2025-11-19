import 'package:get/get.dart';
import '../../../data/models/addon_model.dart';
import '../../../data/models/vehicle_model.dart';

class RentCartController extends GetxController {
  // Selected vehicle
  final Rxn<VehicleModel> selectedVehicle = Rxn<VehicleModel>();
  
  // Rental details
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();
  final Rxn<String> pickupLocation = Rxn<String>();
  
  // Add-ons
  final RxList<AddonModel> addons = <AddonModel>[].obs;
  
  // Cart items (add-ons)
  final RxList<AddonModel> cartItems = <AddonModel>[].obs;
  
  // Payment summary
  final RxDouble platformFee = 6.0.obs;
  final RxDouble taxes = 8.0.obs;

  // Getters
  double get vehicleTotal {
    if (selectedVehicle.value == null || startDate.value == null || endDate.value == null) {
      return 0.0;
    }
    final days = endDate.value!.difference(startDate.value!).inDays + 1;
    return selectedVehicle.value!.pricePerDay * days;
  }

  double get addonsTotal {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get itemTotal {
    return vehicleTotal + addonsTotal;
  }

  double get totalToPay {
    return itemTotal + platformFee.value + taxes.value;
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Initialize add-ons
  void initializeAddons() {
    addons.value = [
      AddonModel(
        id: '1',
        name: 'Dervin UV Protection Square Flat Lens Matte Frame Sunglasses',
        price: 18.20,
        imagePath: 'assets/rent_vehicle/addons/sunglasses.png',
        rating: 5.0,
      ),
      AddonModel(
        id: '2',
        name: 'Isofix Child Car Seat ECE certified',
        price: 12.04,
        imagePath: 'assets/rent_vehicle/addons/car_seat.png',
        rating: 5.0,
      ),
      AddonModel(
        id: '3',
        name: 'Dejavu Car freshner 10ml',
        price: 4.00,
        imagePath: 'assets/rent_vehicle/addons/air_freshener.png',
        rating: 4.8,
      ),
    ];
  }

  // Add to cart
  void addToCart(AddonModel addon) {
    final existingIndex = cartItems.indexWhere((item) => item.id == addon.id);
    
    if (existingIndex >= 0) {
      final existing = cartItems[existingIndex];
      cartItems[existingIndex] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      cartItems.add(addon.copyWith(quantity: 1));
    }
  }

  // Update quantity
  void updateQuantity(String addonId, int quantity) {
    if (quantity <= 0) {
      cartItems.removeWhere((item) => item.id == addonId);
      return;
    }
    
    final index = cartItems.indexWhere((item) => item.id == addonId);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
    }
  }

  // Remove from cart
  void removeFromCart(String addonId) {
    cartItems.removeWhere((item) => item.id == addonId);
  }

  // Set rental details
  void setRentalDetails({
    VehicleModel? vehicle,
    DateTime? start,
    DateTime? end,
    String? location,
  }) {
    selectedVehicle.value = vehicle;
    startDate.value = start;
    endDate.value = end;
    pickupLocation.value = location;
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
    selectedVehicle.value = null;
    startDate.value = null;
    endDate.value = null;
    pickupLocation.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    initializeAddons();
  }
}

