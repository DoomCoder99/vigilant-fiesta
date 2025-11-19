# Cart and Payment Flow - Buttons, Navigation, and Assets

## Navigation Flow Summary

```
Product Detail / Category Listing
  └─> Add to Cart → Updates cart state
      └─> Cart Screen (/cart)
          └─> Continue → Payment Method Screen (/payment-method)
              └─> Pay Now → Payment Success Screen (/payment-success)
                  ├─> View this Order → My Orders (/my-orders)
                  └─> Continue Shopping → Shop Landing (/shop-landing)
```

## CTAs and Button Taps Wired

### Cart Screen (`cart_screen.dart`)

| Button/Tap | Location | Target Route/Action | Handler Status |
|------------|----------|-------------------|----------------|
| Back button | AppBar leading | Pops navigation stack | ✅ Wired |
| Address radio button (Al Farwaniyah) | Delivery section | Updates `_selectedAddress` state | ✅ Wired |
| Address radio button (Salala) | Delivery section | Updates `_selectedAddress` state | ✅ Wired |
| Add new address | Delivery section | TODO: Navigate to add address screen | ⚠️ TODO |
| Quantity minus (-) | Cart item | Decrements `_itemQuantity` (min 1) | ✅ Wired |
| Quantity plus (+) | Cart item | Increments `_itemQuantity` | ✅ Wired |
| Apply coupon code | Coupon section | TODO: Show coupon dialog | ⚠️ TODO |
| Continue button | Bottom bar | `/payment-method` | ✅ Wired |

### Payment Method Screen (`payment_method_screen.dart`)

| Button/Tap | Location | Target Route/Action | Handler Status |
|------------|----------|-------------------|----------------|
| Back button | AppBar leading | Pops navigation stack | ✅ Wired |
| Master Card radio | Cards section | Sets `_selectedPaymentMethod = 'mastercard'` | ✅ Wired |
| Add new card | Cards section | TODO: Navigate to add card screen | ⚠️ TODO |
| Amazon Pay radio | Wallets section | Sets `_selectedPaymentMethod = 'amazon_pay'` | ✅ Wired |
| Add your bank | Net Banking section | TODO: Navigate to add bank screen | ⚠️ TODO |
| Pay by cash radio | Pay After Service section | Sets `_selectedPaymentMethod = 'cash'` | ✅ Wired |
| Pay now button | Bottom of screen | `/payment-success` (enabled when method selected) | ✅ Wired |

**Note**: Master Card is selected by default (`_selectedPaymentMethod = 'mastercard'`), so Pay Now button is enabled on screen load.

### Payment Success Screen (`payment_success_screen.dart`)

| Button/Tap | Location | Target Route/Action | Handler Status |
|------------|----------|-------------------|----------------|
| View this Order button | Main action | `/my-orders` (replaces current route) | ✅ Wired |
| Continue Shopping button | Secondary action | `/shop-landing` (clears navigation stack) | ✅ Wired |

## Routes Defined

All routes are properly defined in `lib/core/routes/app_routes.dart`:

- ✅ `AppRoutes.cart = '/cart'`
- ✅ `AppRoutes.paymentMethod = '/payment-method'`
- ✅ `AppRoutes.paymentSuccess = '/payment-success'`
- ✅ `AppRoutes.myOrders = '/my-orders'`
- ✅ `AppRoutes.shopLanding = '/shop-landing'`

All routes are registered in `lib/main.dart` with proper page builders.

## Assets Added/Used

### Current Implementation (Placeholders)

**Icons Used (Material Icons)**:
- `Icons.arrow_back` - Back button
- `Icons.home` - Home address label
- `Icons.business_center` - Work address label
- `Icons.add` - Add new address/card/bank
- `Icons.remove` - Quantity decrement
- `Icons.add` - Quantity increment
- `Icons.shopping_cart` - Cart icon
- `Icons.chevron_right` - Continue button arrow
- `Icons.credit_card` - Card payment icon
- `Icons.account_balance_wallet` - Wallet icon
- `Icons.account_balance` - Bank icon
- `Icons.money` - Cash icon
- `Icons.chevron_right` - Payment method chevron
- `Icons.check` - Success checkmark
- `Icons.smart_toy` - Robot illustration placeholder
- `Radio` widget - Radio buttons (Material)

### Assets Needed (from Figma)

The following assets should be exported from Figma and added to `assets/images/`:

1. **Payment Method Icons** (24x24px):
   - Master Card icon (`imgImage33`)
   - Generic credit card icon (`imgImage34`)
   - Amazon Pay logo (`imgImage35`)
   - Bank building icon (`imgImage36`)
   - Cash/money icon (`imgImage37`)

2. **Success Illustration**:
   - Robot illustration (complex SVG/PNG) - Multiple group assets from Figma
   - Checkmark badge icon

3. **UI Icons** (16x16px, 20x20px):
   - Radio button checked icon (`imgRadioButtonChecked`)
   - Radio button unchecked icon (`imgRadioButtonUnchecked`)
   - Home icon (`imgHome`)
   - Business center icon (`imgBusinessCenter`)
   - Add icon (`imgAdd`)
   - Chevron forward icon (`imgChevronForward`)
   - Arrow left icon (`imgArrowLeft1`)

4. **Other Assets**:
   - Divider lines (`imgLine932`, `imgLine933`, `imgLine935`, `imgLine896`)

### Asset URLs from Figma

**Cart Screen**:
- `imgLine896` - Vertical divider in bottom bar
- `imgChevronForward` - Continue button arrow
- `imgRadioButtonChecked` - Selected address radio
- `imgRadioButtonUnchecked` - Unselected address radio
- `imgHome` - Home address label icon
- `imgBusinessCenter` - Work address label icon
- `imgAdd` - Add new address icon
- `imgLine933` - Address divider
- `imgLine935` - Section dividers

**Payment Method Screen**:
- `imgImage33` - Master Card icon
- `imgImage34` - Generic credit card icon
- `imgImage35` - Amazon Pay logo
- `imgImage36` - Bank building icon
- `imgImage37` - Cash/money icon
- `imgChevronForward` - Payment method chevron
- `imgLine932` - Section dividers

**Payment Success Screen**:
- Multiple group assets for robot illustration (complex SVG)
- Checkmark badge assets

### Next Steps for Assets

1. **Export from Figma**:
   - Use the Figma MCP asset URLs provided in design context files
   - Export all icons and illustrations
   - Save to `assets/images/` folder

2. **Update `pubspec.yaml`**:
   - Ensure `assets/images/` is declared (already exists)
   - Add any new subfolders if needed

3. **Update Code**:
   - Replace Material Icons with `Image.asset()` calls
   - Use proper asset paths
   - Ensure proper sizing and alignment

## Design Fidelity

### Spacing Matches (±2dp tolerance)
- ✅ Cart screen sections: 24dp spacing
- ✅ Payment method sections: 24dp spacing
- ✅ Success screen spacing: 48dp between major elements
- ✅ Button padding: 16dp vertical, 32dp horizontal
- ✅ Card padding: 12dp, 16dp

### Colors Match Design Tokens
- ✅ Primary purple: `AppColors.primary` (#7132F4)
- ✅ Text colors: `AppColors.textPrimary` with opacity variations
- ✅ Borders: `AppColors.textSecondary` (#D6DEE8)
- ✅ Background: `AppColors.backgroundWhite` (#FFFFFF)

### Typography Matches Design Tokens
- ✅ All text uses `AppTextStyles` variants
- ✅ Font sizes: 8px, 10px, 12px, 14px, 24px
- ✅ Font weights: w300 (Light), w500 (Medium), w600 (SemiBold), bold
- ✅ Line heights match Figma specifications

### Border Radius Matches
- ✅ Small radius: 4dp (badges, icons)
- ✅ Medium radius: 8dp (cards, containers)
- ✅ Large radius: 28dp (buttons)
- ✅ Fully rounded: 999dp (success screen buttons)
- ✅ Custom: 12dp (success card)

## Summary

✅ **All screens implemented** with proper state management  
✅ **All navigation handlers wired** correctly  
✅ **Routes defined and registered** in router  
✅ **Design tokens used consistently** throughout  
✅ **No linter errors**  
✅ **Code follows WDI Flutter Coding Standards**

**Remaining TODOs**:
- Export and add Figma assets
- Implement add address/card/bank screens
- Implement coupon code dialog
- Connect to actual payment processing API

