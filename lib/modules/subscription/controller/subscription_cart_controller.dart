import 'package:get/get.dart';
import '../data/models/subscription_cart_item_model.dart';
import '../data/repository/subscription_repository.dart';

/// Subscription Cart Controller
/// 
/// Manages subscription items in cart.
/// Following WDI Flutter Coding Standards (GetX).
class SubscriptionCartController extends GetxController {
  final SubscriptionRepository _repository = SubscriptionRepository();

  // Cart items
  final RxList<SubscriptionCartItemModel> cartItems =
      <SubscriptionCartItemModel>[].obs;

  // Payment summary
  final RxDouble platformFee = 0.0.obs;
  final RxDouble taxes = 0.0.obs;

  // Pay monthly toggle (for subscription mode)
  final RxBool payMonthly = false.obs;

  /// Add subscription item to cart
  void addToCart(SubscriptionCartItemModel item) {
    // For subscriptions, typically only one item per cart
    // Remove existing subscription items if any
    cartItems.clear();
    cartItems.add(item);
    payMonthly.value = item.payMonthly;
  }

  /// Remove item from cart
  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }

  /// Update pay monthly toggle
  void updatePayMonthly(bool value) {
    payMonthly.value = value;
    if (cartItems.isNotEmpty) {
      final item = cartItems.first;
      cartItems[0] = item.copyWith(payMonthly: value);
    }
  }

  /// Calculate item total
  double get itemTotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  /// Calculate total to pay
  double get totalToPay {
    return itemTotal + platformFee.value + taxes.value;
  }

  /// Get cart item count
  int get itemCount {
    return cartItems.length;
  }

  /// Check if cart is empty
  bool get isEmpty {
    return cartItems.isEmpty;
  }

  /// Clear cart
  void clearCart() {
    cartItems.clear();
    payMonthly.value = false;
  }

  /// Create subscription from cart
  Future<Map<String, dynamic>> createSubscription({
    required String paymentMethodId,
  }) async {
    if (cartItems.isEmpty) {
      throw Exception('Cart is empty');
    }

    final item = cartItems.first;
    
    return await _repository.createSubscription(
      planId: item.plan.id,
      venueId: item.venue.id,
      slotSelection: item.slotSelection?.toJson() ?? {},
      paymentMethodId: paymentMethodId,
    );
  }
}

