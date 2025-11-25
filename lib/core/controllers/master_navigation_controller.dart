import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Master Navigation Controller
/// 
/// Manages index-based navigation for bottom navigation screens.
/// This allows switching between Home, Shop, Orders, and Cart screens
/// while maintaining navigation state.
class MasterNavigationController extends ChangeNotifier {
  int _currentIndex = 0; // 0 = Home, 1 = Shop, 2 = Orders, 3 = Cart
  
  int get currentIndex => _currentIndex;
  
  /// Navigate to a specific tab by index
  void navigateToIndex(BuildContext context, int index) {
    if (_currentIndex == index) return; // Already on this tab
    
    _currentIndex = index;
    notifyListeners();
    
    // Navigate to the appropriate route
    switch (index) {
      case 0: // Home
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.amozitLandingConfirmed,
          (route) => false,
        );
        break;
      case 1: // Shop
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.shopLanding,
          (route) => false,
        );
        break;
      case 2: // Orders
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.myOrders,
          (route) => false,
        );
        break;
      case 3: // Cart
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.cart,
          (route) => false,
        );
        break;
    }
  }
  
  /// Set current index without navigation (for initial state)
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

