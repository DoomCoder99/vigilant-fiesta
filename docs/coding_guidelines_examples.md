# Coding Guidelines & Practical Examples

This document provides detailed examples and patterns for common coding scenarios in the Amoz Customer Flutter app.

---

## 📋 Table of Contents

1. [JSON-Driven Repeated UI](#json-driven-repeated-ui)
2. [Common Widget Patterns](#common-widget-patterns)
3. [Theme & Design System Usage](#theme--design-system-usage)
4. [State Management Patterns](#state-management-patterns)
5. [Error Handling Patterns](#error-handling-patterns)
6. [Performance Best Practices](#performance-best-practices)

---

## 1. JSON-Driven Repeated UI

### Overview

Using JSON data structures for repeated UI elements reduces code duplication, improves maintainability, and makes it easier to add/remove items.

### ✅ Benefits

- **DRY Principle**: Write UI logic once, data drives the instances
- **Easy Updates**: Add/remove items by modifying data only
- **Consistency**: Ensures all items follow the same pattern
- **Testability**: Easier to test with mock data

---

### 1.1 GridView with JSON Data

**Use Case:** Product grid, service categories, feature cards

```dart
class ServiceCategoryGrid extends StatelessWidget {
  // JSON data structure
  final List<Map<String, dynamic>> categories = [
    {
      'id': 1,
      'name': 'Plumbing',
      'icon': 'assets/images/plumbing_icon.png',
      'color': Color(0xff3498db),
      'route': '/service-booking/plumbing',
    },
    {
      'id': 2,
      'name': 'Electrical',
      'icon': 'assets/images/electrical_icon.png',
      'color': Color(0xfff39c12),
      'route': '/service-booking/electrical',
    },
    {
      'id': 3,
      'name': 'Carpentry',
      'icon': 'assets/images/carpentry_icon.png',
      'color': Color(0xff27ae60),
      'route': '/service-booking/carpentry',
    },
    {
      'id': 4,
      'name': 'Cleaning',
      'icon': 'assets/images/cleaning_icon.png',
      'color': Color(0xff9b59b6),
      'route': '/service-booking/cleaning',
    },
  ];

  const ServiceCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: kSpacingMd,
        mainAxisSpacing: kSpacingMd,
        childAspectRatio: 1.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(
          name: category['name'],
          icon: category['icon'],
          color: category['color'],
          onTap: () => Get.toNamed(category['route']),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(kRadiusMd),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 48, height: 48),
            VSpace(kSpacingSm),
            CommonText(
              name,
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 1.2 ListView with JSON Data

**Use Case:** Menu options, settings list, order history

```dart
class ProfileMenuList extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.person_outline,
      'title': 'Edit Profile',
      'subtitle': 'Update your personal information',
      'route': '/profile/edit',
      'showBadge': false,
    },
    {
      'icon': Icons.location_on_outlined,
      'title': 'Saved Addresses',
      'subtitle': 'Manage delivery addresses',
      'route': '/profile/addresses',
      'showBadge': false,
    },
    {
      'icon': Icons.credit_card_outlined,
      'title': 'Payment Methods',
      'subtitle': 'Manage cards and payment options',
      'route': '/profile/payments',
      'showBadge': false,
    },
    {
      'icon': Icons.notifications_outlined,
      'title': 'Notifications',
      'subtitle': 'Manage notification preferences',
      'route': '/profile/notifications',
      'showBadge': true,
      'badgeCount': 3,
    },
    {
      'icon': Icons.help_outline,
      'title': 'Help & Support',
      'subtitle': 'Get help with your orders',
      'route': '/support',
      'showBadge': false,
    },
    {
      'icon': Icons.info_outline,
      'title': 'About',
      'subtitle': 'Version 1.0.0',
      'route': '/about',
      'showBadge': false,
    },
  ];

  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: appMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(kRadiusSm),
            ),
            child: Icon(
              item['icon'],
              color: appMainColor,
              size: 22,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: CommonText(
                  item['title'],
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (item['showBadge'] == true) ...[
                HSpace(kSpacingSm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CommonText(
                    '${item['badgeCount']}',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          subtitle: CommonText(
            item['subtitle'],
            style: AppTextStyles.caption,
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: textSecondary,
          ),
          onTap: () => Get.toNamed(item['route']),
        );
      },
    );
  }
}
```

---

### 1.3 Carousel with JSON Data

**Use Case:** Banner ads, promotional offers, image galleries

```dart
class PromotionalCarousel extends StatefulWidget {
  const PromotionalCarousel({super.key});

  @override
  State<PromotionalCarousel> createState() => _PromotionalCarouselState();
}

class _PromotionalCarouselState extends State<PromotionalCarousel> {
  int _currentIndex = 0;
  
  final List<Map<String, dynamic>> banners = [
    {
      'id': 1,
      'image': 'assets/images/banner_1.png',
      'title': 'Get 50% Off',
      'subtitle': 'On your first service booking',
      'buttonText': 'Book Now',
      'route': '/service-booking',
      'backgroundColor': Color(0xff3498db),
    },
    {
      'id': 2,
      'image': 'assets/images/banner_2.png',
      'title': 'Rent a Car',
      'subtitle': 'Starting from \$25/day',
      'buttonText': 'Explore',
      'route': '/rent-vehicle',
      'backgroundColor': Color(0xffe74c3c),
    },
    {
      'id': 3,
      'image': 'assets/images/banner_3.png',
      'title': 'Premium Plans',
      'subtitle': 'Unlock exclusive benefits',
      'buttonText': 'Subscribe',
      'route': '/subscriptions',
      'backgroundColor': Color(0xff9b59b6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = banners[index];
              return _BannerCard(
                image: banner['image'],
                title: banner['title'],
                subtitle: banner['subtitle'],
                buttonText: banner['buttonText'],
                backgroundColor: banner['backgroundColor'],
                onTap: () => Get.toNamed(banner['route']),
              );
            },
          ),
        ),
        VSpace(kSpacingSm),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => Container(
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? appMainColor
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _BannerCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSpacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor,
            backgroundColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(kRadiusLg),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(kRadiusLg),
              ),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kSpacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  title,
                  style: AppTextStyles.heading1.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                VSpace(kSpacingXs),
                CommonText(
                  subtitle,
                  style: AppTextStyles.bodyText.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                VSpace(kSpacingMd),
                SizedBox(
                  width: 120,
                  child: CommonButton(
                    title: buttonText,
                    onTap: onTap,
                    backgroundColor: Colors.white,
                    textColor: backgroundColor,
                    height: 36,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### 1.4 Tab Content with JSON Data

**Use Case:** Category tabs, filter chips, segmented controls

```dart
class OrderHistoryTabs extends StatefulWidget {
  const OrderHistoryTabs({super.key});

  @override
  State<OrderHistoryTabs> createState() => _OrderHistoryTabsState();
}

class _OrderHistoryTabsState extends State<OrderHistoryTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> tabs = [
    {'label': 'All', 'count': 24, 'status': null},
    {'label': 'Pending', 'count': 5, 'status': 'pending'},
    {'label': 'Completed', 'count': 18, 'status': 'completed'},
    {'label': 'Cancelled', 'count': 1, 'status': 'cancelled'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: appMainColor,
            labelColor: appMainColor,
            unselectedLabelColor: textSecondary,
            tabs: tabs.map((tab) {
              return Tab(
                child: Row(
                  children: [
                    CommonText(
                      tab['label'],
                      style: AppTextStyles.bodyText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (tab['count'] > 0) ...[
                      HSpace(kSpacingXs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: appMainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CommonText(
                          '${tab['count']}',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((tab) {
              return OrderList(status: tab['status']);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
```

---

## 2. Common Widget Patterns

### 2.1 Loading States

```dart
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;
  
  const LoadingIndicator({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color ?? appMainColor,
          ),
          if (message != null) ...[
            VSpace(kSpacingMd),
            CommonText(
              message!,
              style: AppTextStyles.bodyText.copyWith(
                color: textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Usage in GetX Controller
class HomeController extends GetxController {
  var isLoading = false.obs;
  var data = [].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingIndicator(message: 'Loading data...');
      }
      
      return ListView.builder(
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          return DataCard(data: controller.data[index]);
        },
      );
    });
  }
}
```

---

### 2.2 Empty States

```dart
class EmptyStateWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;

  const EmptyStateWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 200,
              height: 200,
            ),
            VSpace(kSpacingLg),
            CommonText(
              title,
              style: AppTextStyles.heading1.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            VSpace(kSpacingSm),
            CommonText(
              subtitle,
              style: AppTextStyles.bodyText.copyWith(
                color: textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonTap != null) ...[
              VSpace(kSpacingLg),
              CommonButton(
                title: buttonText!,
                onTap: onButtonTap!,
                width: 200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Usage
EmptyStateWidget(
  image: 'assets/blank_states/cart_empty.png',
  title: 'Your cart is empty',
  subtitle: 'Add items to your cart to continue shopping',
  buttonText: 'Start Shopping',
  onButtonTap: () => Get.toNamed('/shop'),
)
```

---

### 2.3 Error States

```dart
class ErrorStateWidget extends StatelessWidget {
  final String? image;
  final String title;
  final String message;
  final String? retryButtonText;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    this.image,
    required this.title,
    required this.message,
    this.retryButtonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSpacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.asset(
                image!,
                width: 180,
                height: 180,
              )
            else
              Icon(
                Icons.error_outline,
                size: 80,
                color: errorColor,
              ),
            VSpace(kSpacingLg),
            CommonText(
              title,
              style: AppTextStyles.heading1.copyWith(
                fontSize: 20,
                color: errorColor,
              ),
              textAlign: TextAlign.center,
            ),
            VSpace(kSpacingSm),
            CommonText(
              message,
              style: AppTextStyles.bodyText.copyWith(
                color: textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (retryButtonText != null && onRetry != null) ...[
              VSpace(kSpacingLg),
              CommonButton(
                title: retryButtonText!,
                onTap: onRetry!,
                backgroundColor: errorColor,
                width: 150,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

### 2.4 Shimmer Loading Skeleton

```dart
class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerCard({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = kRadiusMd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// Usage: Product Card Skeleton
class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerCard(width: double.infinity, height: 150),
        VSpace(kSpacingSm),
        const ShimmerCard(width: 120, height: 16),
        VSpace(kSpacingXs),
        const ShimmerCard(width: 80, height: 14),
      ],
    );
  }
}
```

---

## 3. Theme & Design System Usage

### 3.1 Using Color Constants

```dart
// ❌ BAD: Hardcoded colors
Container(
  color: Color(0xff0fffff),  // Don't do this!
)

// ✅ GOOD: Use theme constants
Container(
  color: appMainColor,  // Defined in colors.dart
)

// ✅ GOOD: Use Theme.of(context)
Container(
  color: Theme.of(context).primaryColor,
)
```

---

### 3.2 Using Typography Constants

```dart
// ❌ BAD: Inline text styles
Text(
  'Hello World',
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
)

// ✅ GOOD: Use predefined text styles
CommonText(
  'Hello World',
  style: AppTextStyles.heading1,
)

// ✅ GOOD: Modify predefined styles
CommonText(
  'Hello World',
  style: AppTextStyles.bodyText.copyWith(
    fontWeight: FontWeight.bold,
    color: appMainColor,
  ),
)
```

---

### 3.3 Using Spacing Constants

```dart
// ❌ BAD: Magic numbers
Padding(
  padding: EdgeInsets.all(16),  // Don't hardcode!
  child: ...
)

// ✅ GOOD: Use spacing constants
Padding(
  padding: EdgeInsets.all(kSpacingMd),
  child: ...
)

// ✅ GOOD: Use spacing widgets
Column(
  children: [
    Text('First'),
    VSpace(kSpacingMd),  // Cleaner than SizedBox
    Text('Second'),
  ],
)
```

---

## 4. State Management Patterns (GetX)

### 4.1 Reactive Variables

```dart
class CartController extends GetxController {
  // Reactive variables
  var cartItems = <CartItem>[].obs;
  var totalAmount = 0.0.obs;
  var isLoading = false.obs;

  // Computed property
  int get itemCount => cartItems.length;
  bool get isEmpty => cartItems.isEmpty;

  // Methods
  void addItem(CartItem item) {
    cartItems.add(item);
    _calculateTotal();
  }

  void removeItem(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    _calculateTotal();
  }

  void _calculateTotal() {
    totalAmount.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}
```

---

### 4.2 Using Obx for Reactive UI

```dart
class CartScreen extends StatelessWidget {
  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Cart (${controller.itemCount})')),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }

        if (controller.isEmpty) {
          return EmptyStateWidget(
            image: 'assets/blank_states/cart_empty.png',
            title: 'Your cart is empty',
            subtitle: 'Add items to get started',
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemCard(
                    item: controller.cartItems[index],
                  );
                },
              ),
            ),
            _buildCheckoutSection(),
          ],
        );
      }),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(kSpacingMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                'Total',
                style: AppTextStyles.heading1,
              ),
              Obx(() => CommonText(
                '\$${controller.totalAmount.value.toStringAsFixed(2)}',
                style: AppTextStyles.heading1.copyWith(
                  color: appMainColor,
                ),
              )),
            ],
          ),
          VSpace(kSpacingMd),
          CommonButton(
            title: 'Proceed to Checkout',
            onTap: () => Get.toNamed('/checkout'),
          ),
        ],
      ),
    );
  }
}
```

---

## 5. Error Handling Patterns

### 5.1 Try-Catch with User Feedback

```dart
class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      final response = await ApiService.callApi(
        endpoint: 'products',
        type: ApiType.get,
      );

      if (response['success']) {
        products.value = (response['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        _showError(response['message'] ?? 'Failed to fetch products');
      }
    } on SocketException {
      _showError('No internet connection');
    } on TimeoutException {
      _showError('Request timed out. Please try again.');
    } catch (e) {
      _showError('An unexpected error occurred');
      debugPrint('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: errorColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(kSpacingMd),
    );
  }
}
```

---

### 5.2 Centralized Error Handler

```dart
// lib/core/utils/error_handler.dart
enum ErrorType {
  network,
  timeout,
  auth,
  server,
  unknown,
}

class ErrorHandler {
  static void handle(dynamic error, {String? customMessage}) {
    ErrorType type;
    String message;

    if (error is SocketException) {
      type = ErrorType.network;
      message = 'No internet connection';
    } else if (error is TimeoutException) {
      type = ErrorType.timeout;
      message = 'Request timed out';
    } else if (error is HttpException) {
      type = ErrorType.server;
      message = 'Server error occurred';
    } else {
      type = ErrorType.unknown;
      message = customMessage ?? 'An unexpected error occurred';
    }

    _showErrorDialog(type, message);
    _logError(type, error);
  }

  static void _showErrorDialog(ErrorType type, String message) {
    Get.snackbar(
      _getErrorTitle(type),
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: errorColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: Icon(_getErrorIcon(type), color: Colors.white),
    );
  }

  static String _getErrorTitle(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return 'Connection Error';
      case ErrorType.timeout:
        return 'Timeout Error';
      case ErrorType.auth:
        return 'Authentication Error';
      case ErrorType.server:
        return 'Server Error';
      default:
        return 'Error';
    }
  }

  static IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.timeout:
        return Icons.access_time;
      case ErrorType.auth:
        return Icons.lock;
      default:
        return Icons.error_outline;
    }
  }

  static void _logError(ErrorType type, dynamic error) {
    debugPrint('[$type] Error: $error');
    // Add logging service integration here (e.g., Firebase Crashlytics)
  }
}

// Usage
try {
  await fetchData();
} catch (e) {
  ErrorHandler.handle(e, customMessage: 'Failed to load data');
}
```

---

## 6. Performance Best Practices

### 6.1 Use const Constructors

```dart
// ❌ BAD: Non-const widgets rebuild unnecessarily
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Text('Hello'),
  );
}

// ✅ GOOD: Const widgets are cached
Widget build(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Hello'),
  );
}
```

---

### 6.2 Extract Widgets

```dart
// ❌ BAD: Large build method
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 100+ lines of nested widgets
          Container(
            child: Row(
              children: [
                // More nesting...
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ GOOD: Extract into smaller widgets
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ProductHeader(),
          const ProductDetails(),
          const ProductActions(),
        ],
      ),
    );
  }
}

class ProductHeader extends StatelessWidget {
  const ProductHeader({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Header implementation
  }
}
```

---

### 6.3 ListView Best Practices

```dart
// ❌ BAD: ListView without builder (loads all items)
ListView(
  children: products.map((product) => ProductCard(product)).toList(),
)

// ✅ GOOD: ListView.builder (lazy loading)
ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) => ProductCard(products[index]),
)

// ✅ GOOD: ListView.separated (with dividers)
ListView.separated(
  itemCount: products.length,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (context, index) => ProductCard(products[index]),
)
```

---

## Summary

This guide provides practical patterns for:

✅ **JSON-driven UI** - Reduce duplication in grids, lists, carousels  
✅ **Common widgets** - Loading, empty, error states  
✅ **Design system** - Colors, typography, spacing  
✅ **State management** - GetX reactive patterns  
✅ **Error handling** - Centralized error management  
✅ **Performance** - const, widget extraction, lazy loading  

**Remember:** Consistency is key. Follow these patterns across the entire codebase for maintainability and team collaboration.

---

**Last Updated:** November 2025

