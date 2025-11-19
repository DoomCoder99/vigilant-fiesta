import 'package:flutter/foundation.dart';

/// Simple cart service for managing cart state
/// 
/// This is a basic implementation. Can be replaced with GetX controller or Bloc
/// following WDI patterns when needed.
class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  final Set<String> _cartItems = {};

  /// Get all cart item IDs
  Set<String> get cartItems => Set.unmodifiable(_cartItems);

  /// Get cart item count
  int get itemCount => _cartItems.length;

  /// Check if product is in cart
  bool isInCart(String productId) {
    return _cartItems.contains(productId);
  }

  /// Add product to cart
  void addToCart(String productId) {
    if (!_cartItems.contains(productId)) {
      _cartItems.add(productId);
      notifyListeners();
    }
  }

  /// Remove product from cart
  void removeFromCart(String productId) {
    if (_cartItems.contains(productId)) {
      _cartItems.remove(productId);
      notifyListeners();
    }
  }

  /// Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

