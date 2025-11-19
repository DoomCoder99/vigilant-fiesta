# Shop Module - Navigation Handlers Summary

## Key Buttons/CTAs and Their Navigation Handlers

### 1. Shop Landing Screen (`shop_landing_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Category card tap | `_buildCategoryCard()` | `/category-listing` | ✅ Wired - `onTap` navigates with `categoryName` |
| "View All" button | `_buildShopByCategory()` | `/menu-all-categories` | ✅ Wired - `TextButton.onPressed` |
| Product card tap | `_buildProductCard()` | `/product-detail` | ✅ Wired - `GestureDetector.onTap` with `productId` |
| "Book Now" button | `_buildBanner()` | N/A | ⚠️ TODO - Should navigate to services booking |

### 2. Category Listing Screen (`category_listing_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Product card tap | `_buildProductCard()` | `/product-detail` | ✅ Wired - `GestureDetector.onTap` with `productId` |
| "add to cart" button | `_buildProductCard()` | `/cart` | ✅ Wired - `ElevatedButton.onPressed` |
| Menu icon (apps) | AppBar actions | `/menu-all-categories` | ✅ Wired - `IconButton.onPressed` |
| Search icon | AppBar actions | N/A | ⚠️ TODO - Implement search |
| Filter icon (tune) | AppBar actions | N/A | ⚠️ TODO - Implement filters |

### 3. Product Detail Screen (`product_detail_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| "Add to Cart" button | `_buildBottomBar()` | `/cart` | ✅ Wired - `ElevatedButton.onPressed` |
| Favorite icon | AppBar actions | N/A | ⚠️ TODO - Implement favorites |
| Share icon | AppBar actions | N/A | ⚠️ TODO - Implement sharing |

### 4. Cart Screen (`cart_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| "Continue" button | `_buildBottomBar()` | `/payment-method` | ✅ Wired - `ElevatedButton.onPressed` |
| "Apply coupon code" | `_buildCouponSection()` | N/A | ⚠️ TODO - Implement coupon input |
| "Add new address" | `_buildDeliverySection()` | N/A | ⚠️ TODO - Navigate to address form |
| Quantity +/- buttons | `_buildCartItem()` | N/A | ⚠️ TODO - Update cart quantity |

### 5. Payment Method Screen (`payment_method_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Payment option tap | `_buildPaymentOption()` | `/payment-success` | ✅ Wired - `InkWell.onTap` |
| "Add new card" | `_buildPaymentOption()` | N/A | ⚠️ TODO - Navigate to add card screen |
| "Add your bank" | `_buildPaymentOption()` | N/A | ⚠️ TODO - Navigate to add bank screen |

### 6. Payment Success Screen (`payment_success_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| "View this Order" button | `build()` | `/order-detail` | ✅ Wired - `OutlinedButton.onPressed` with `orderId` |
| "Continue Shopping" button | `build()` | `/shop-landing` | ✅ Wired - `ElevatedButton.onPressed` with `pushNamedAndRemoveUntil` |

### 7. My Orders Screen (`my_orders_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Order card tap | `_buildOrderCard()` | `/order-detail` | ⚠️ TODO - Should navigate to order detail |
| "Track order" button | `_buildOrderCard()` | `/tracking` | ✅ Wired - `ElevatedButton.onPressed` with `orderId` |
| "Invoice" button | `_buildOrderCard()` | N/A | ⚠️ TODO - Show/download invoice |
| Filter tabs | `_buildFilterTabs()` | N/A | ⚠️ TODO - Filter orders by status |

### 8. Order Detail Screen (`order_detail_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| "Track order" button | `build()` | `/tracking` | ✅ Wired - `ElevatedButton.onPressed` with `orderId` |
| "Cancel Order" button | `_buildActionButtons()` | `/cancellation-confirmation` | ✅ Wired - `OutlinedButton.onPressed` |
| "Invoice" button | `_buildActionButtons()` | N/A | ⚠️ TODO - Show/download invoice |
| "buy again" button | `_buildActionButtons()` | N/A | ⚠️ TODO - Add to cart and navigate |

### 9. Tracking Screen (`tracking_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Close button (X) | Header | Back navigation | ✅ Wired - `IconButton.onPressed` with `Navigator.pop()` |

### 10. Cancellation Confirmation Dialog (`cancellation_confirmation_dialog.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| "No, Go Back" button | `build()` | Back navigation | ✅ Wired - `OutlinedButton.onPressed` with `Navigator.pop()` |
| "Yes, Return product" button | `build()` | Back + Snackbar | ✅ Wired - `ElevatedButton.onPressed` with cancellation logic |

### 11. Menu All Categories Screen (`menu_all_categories_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Category item tap | `_buildCategoryItem()` | `/category-listing` | ✅ Wired - `GestureDetector.onTap` with `categoryName` |
| Close button (X) | Header | Back navigation | ✅ Wired - `IconButton.onPressed` with `Navigator.pop()` |

### 12. Menu All Sub Categories Screen (`menu_all_sub_categories_screen.dart`)

| Button/CTA | Source Location | Target Route | Handler Status |
|------------|----------------|--------------|----------------|
| Sub-category item tap | `_buildSubCategoryItem()` | `/category-listing` | ✅ Wired - `InkWell.onTap` with `categoryName` |
| Close button (X) | Header | Back navigation | ✅ Wired - `IconButton.onPressed` with `Navigator.pop()` |

## Navigation Patterns Used

### Pattern 1: Simple Navigation
```dart
Navigator.of(context).pushNamed(AppRoutes.targetRoute);
```

### Pattern 2: Navigation with Arguments
```dart
Navigator.of(context).pushNamed(
  AppRoutes.targetRoute,
  arguments: {'key': 'value'},
);
```

### Pattern 3: Replace Current Route
```dart
Navigator.of(context).pushReplacementNamed(AppRoutes.targetRoute);
```

### Pattern 4: Replace All Routes (Clear Stack)
```dart
Navigator.of(context).pushNamedAndRemoveUntil(
  AppRoutes.targetRoute,
  (route) => false,
);
```

### Pattern 5: Pop Dialog/Modal
```dart
Navigator.of(context).pop();
```

## Summary Statistics

- **Total Screens Implemented**: 12
- **Navigation Handlers Wired**: 20+
- **Routes Defined**: 12
- **TODO Items**: ~15 (mostly for features like search, filters, favorites, etc.)

## Notes

1. All primary navigation flows are wired and functional
2. Secondary features (search, filters, favorites) are marked as TODO
3. Route arguments are properly handled via `ModalRoute.of(context)?.settings.arguments`
4. Dialog screens use `Navigator.pop()` for dismissal
5. Payment success uses `pushNamedAndRemoveUntil` to clear navigation stack before going to shop landing

