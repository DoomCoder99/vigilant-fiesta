import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Favorites Service
/// 
/// Manages user favorites using Hive local storage.
class FavoritesService extends ChangeNotifier {
  FavoritesService._();
  static final FavoritesService instance = FavoritesService._();
  
  static const String _boxName = 'favorites';
  Box<String>? _box;
  bool _initialized = false;

  /// Initialize Hive box
  Future<void> init() async {
    if (_initialized) return;
    
    // Hive doesn't need adapters for primitive types like String
    _box = await Hive.openBox<String>(_boxName);
    _initialized = true;
  }

  /// Check if product is favorited
  bool isFavorite(String productId) {
    if (!_initialized || _box == null) return false;
    return _box!.containsKey(productId);
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String productId) async {
    if (!_initialized || _box == null) {
      await init();
    }
    
    if (isFavorite(productId)) {
      await _box!.delete(productId);
    } else {
      await _box!.put(productId, productId);
    }
    notifyListeners();
  }

  /// Get all favorite product IDs
  List<String> get favorites {
    if (!_initialized || _box == null) return [];
    return _box!.values.toList();
  }
}

