import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

/// Cart Service with Hive storage
/// 
/// Manages cart state and persists to local device storage using Hive.
class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  static const String _boxName = 'cart';
  Box<String>? _box;
  bool _initialized = false;
  final Map<String, int> _cartItems = {}; // productId -> quantity

  /// Initialize Hive box and load cart data
  Future<void> init() async {
    if (_initialized) return;
    
    try {
      _box = await Hive.openBox<String>(_boxName);
      
      // Load cart items from Hive
      for (var key in _box!.keys) {
        final value = _box!.get(key);
        if (value != null) {
          try {
            final quantity = int.parse(value);
            _cartItems[key.toString()] = quantity;
          } catch (e) {
            // Handle parsing error
          }
        }
      }
      
      _initialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing cart: $e');
    }
  }

  /// Get all cart item IDs
  Set<String> get cartItems => Set.unmodifiable(_cartItems.keys);

  /// Get cart item count (total items)
  int get itemCount {
    return _cartItems.values.fold(0, (sum, quantity) => sum + quantity);
  }

  /// Check if product is in cart
  bool isInCart(String productId) {
    return _cartItems.containsKey(productId) && _cartItems[productId]! > 0;
  }

  /// Get quantity of a product in cart
  int getQuantity(String productId) {
    return _cartItems[productId] ?? 0;
  }

  /// Add product to cart (increments quantity)
  Future<void> addToCart(String productId) async {
    if (!_initialized) {
      await init();
    }
    
    _cartItems[productId] = (_cartItems[productId] ?? 0) + 1;
    
    // Save to Hive
    if (_box != null) {
      await _box!.put(productId, _cartItems[productId].toString());
    }
    
    notifyListeners();
  }

  /// Remove product from cart (decrements quantity, removes if reaches 0)
  Future<void> removeFromCart(String productId) async {
    if (!_initialized) {
      await init();
    }
    
    if (_cartItems.containsKey(productId)) {
      final quantity = _cartItems[productId]!;
      if (quantity > 1) {
        _cartItems[productId] = quantity - 1;
        // Update in Hive
        if (_box != null) {
          await _box!.put(productId, _cartItems[productId].toString());
        }
      } else {
        _cartItems.remove(productId);
        // Remove from Hive
        if (_box != null) {
          await _box!.delete(productId);
        }
      }
      notifyListeners();
    }
  }

  /// Set specific quantity for a product
  Future<void> setQuantity(String productId, int quantity) async {
    if (!_initialized) {
      await init();
    }
    
    if (quantity <= 0) {
      _cartItems.remove(productId);
      if (_box != null) {
        await _box!.delete(productId);
      }
    } else {
      _cartItems[productId] = quantity;
      if (_box != null) {
        await _box!.put(productId, quantity.toString());
      }
    }
    notifyListeners();
  }

  /// Clear cart
  Future<void> clearCart() async {
    _cartItems.clear();
    if (_box != null) {
      await _box!.clear();
    }
    notifyListeners();
  }
}

