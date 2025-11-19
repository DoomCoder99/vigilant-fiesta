# Shop Module Route Table

## Navigation Flow Overview

```
Amozit Landing Confirmed
  └─> Shop Landing (via bottom nav "Shop")
      ├─> Category Listing (via category tap / "View All")
      │   └─> Product Detail (via product tap)
      │       └─> Cart (via "Add to Cart")
      ├─> Cart (via bottom nav / cart icon)
      │   └─> Payment Method (via "Continue")
      │       └─> Payment Success (via payment selection)
      │           ├─> My Orders (via "View this Order")
      │           └─> Shop Landing (via "Continue Shopping")
      └─> My Orders (via bottom nav "Orders")
          └─> Order Detail (via order tap)
              ├─> Tracking (via "Track order")
              └─> Cancellation Confirmation (via "Cancel Order")
```

## Route Table

| Logical Screen | Figma Frame(s) | Route Name | Widget Name | Description |
|---------------|----------------|------------|-------------|-------------|
| Shop Landing | 1-2906 | `/shop-landing` | `ShopLandingScreen` | Main shop screen with categories and featured products |
| Category Listing | 1-3185, 1-3413 | `/category-listing` | `CategoryListingScreen` | Products in a specific category with filters |
| Product Detail | 1-3660, 1-5186, 1-5408, 1-5625, 1-6074 | `/product-detail` | `ProductDetailScreen` | Product details, reviews, add to cart |
| Cart | 1-4160 | `/cart` | `CartScreen` | Shopping cart with items and checkout |
| Payment Method | 1-4276 | `/payment-method` | `PaymentMethodScreen` | Payment method selection |
| Payment Success | 1-4376 | `/payment-success` | `PaymentSuccessScreen` | Payment confirmation screen |
| My Orders | 1-4583 | `/my-orders` | `MyOrdersScreen` | List of user orders (Active/Services/Products/Cancel) |
| Order Detail | 1-4695, 1-4793, 1-4887, 1-4967, 1-5034, 1-5101 | `/order-detail` | `OrderDetailScreen` | Detailed order information |
| Tracking | 1-4657 | `/tracking` | `TrackingScreen` | Order tracking timeline (modal/dialog) |
| Cancellation Confirmation | 1-5175 | `/cancellation-confirmation` | `CancellationConfirmationDialog` | Cancel/return order confirmation dialog |
| Menu - All Categories | 1-4101 | `/menu-all-categories` | `MenuAllCategoriesScreen` | Full category menu (modal/drawer) |
| Menu - All Sub Categories | 1-4142 | `/menu-all-sub-categories` | `MenuAllSubCategoriesScreen` | Sub-categories for a category (modal/drawer) |

## Key Navigation Actions

| Source Screen | Action | Target Route | Handler Location |
|--------------|--------|--------------|------------------|
| Amozit Landing Confirmed | Tap "Shop" (bottom nav) | `/shop-landing` | Bottom navigation handler |
| Shop Landing | Tap category icon | `/category-listing` | Category card `onTap` |
| Shop Landing | Tap "View All" (categories) | `/menu-all-categories` | "View All" button `onTap` |
| Shop Landing | Tap product card | `/product-detail` | Product card `onTap` |
| Category Listing | Tap product card | `/product-detail` | Product card `onTap` |
| Category Listing | Tap "Menu" icon | `/menu-all-categories` | Menu icon `onTap` |
| Product Detail | Tap "Add to Cart" | `/cart` | "Add to Cart" button `onTap` |
| Cart | Tap "Continue" | `/payment-method` | "Continue" button `onTap` |
| Payment Method | Select payment method | `/payment-success` | Payment option `onTap` |
| Payment Success | Tap "View this Order" | `/order-detail` | "View this Order" button `onTap` |
| Payment Success | Tap "Continue Shopping" | `/shop-landing` | "Continue Shopping" button `onTap` |
| My Orders | Tap order item | `/order-detail` | Order card `onTap` |
| My Orders | Tap "Track order" | `/tracking` | "Track order" button `onTap` |
| Order Detail | Tap "Track order" | `/tracking` | "Track order" button `onTap` |
| Order Detail | Tap "Cancel Order" | `/cancellation-confirmation` | "Cancel Order" button `onTap` |
| Menu All Categories | Tap category | `/category-listing` | Category item `onTap` |
| Menu All Categories | Tap category with sub-categories | `/menu-all-sub-categories` | Category item `onTap` |
| Menu All Sub Categories | Tap sub-category | `/category-listing` | Sub-category item `onTap` |

## Route Parameters

- `/category-listing`: Requires `categoryId` or `categoryName` parameter
- `/product-detail`: Requires `productId` parameter
- `/order-detail`: Requires `orderId` parameter
- `/tracking`: Requires `orderId` parameter (can be shown as modal/dialog)
- `/menu-all-sub-categories`: Requires `categoryId` or `categoryName` parameter

