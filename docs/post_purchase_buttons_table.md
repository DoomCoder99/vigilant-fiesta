# Post-Purchase Experience - Buttons and CTAs Table

## Complete Button/CTA Reference

| Button/CTA | Source Screen | Target Route/Action | Handler Status | Notes |
|------------|---------------|-------------------|----------------|-------|
| **Back button** | My Orders | Pops navigation stack | ✅ Wired | AppBar leading icon |
| **Active filter tab** | My Orders | Updates `_selectedFilter` state | ✅ Wired | Default selected, purple underline |
| **Services filter tab** | My Orders | Updates `_selectedFilter` state | ✅ Wired | Tappable tab |
| **Products filter tab** | My Orders | Updates `_selectedFilter` state | ✅ Wired | Tappable tab |
| **Cancel / Return filter tab** | My Orders | Updates `_selectedFilter` state | ✅ Wired | Tappable tab |
| **Order card (entire card)** | My Orders | `/order-detail` with `orderId: 'order_123'` | ✅ Wired | `InkWell` wrapper on card |
| **Invoice button** | My Orders | TODO: Show invoice dialog/PDF | ⚠️ TODO | Icon + text button |
| **Track order button** | My Orders | Shows Tracking bottom sheet modal | ✅ Wired | Opens via `showModalBottomSheet` |
| **Back button** | Order Detail | Pops navigation stack | ✅ Wired | AppBar leading icon |
| **Share button** | Order Detail | TODO: Share order details | ⚠️ TODO | AppBar action icon |
| **Track order button** | Order Detail | Shows Tracking bottom sheet modal | ✅ Wired | Only visible for active orders |
| **Invoice button** | Order Detail | TODO: Show invoice dialog/PDF | ⚠️ TODO | Outlined button with icon |
| **Buy again button** | Order Detail | TODO: Navigate to product/add to cart | ⚠️ TODO | Outlined button |
| **Cancel Order button** | Order Detail | Shows Cancellation Confirmation bottom sheet | ✅ Wired | Only for active orders, red button |
| **Return Order button** | Order Detail | Shows Cancellation Confirmation bottom sheet | ✅ Wired | Only for delivered orders, red button |
| **Close button** | Tracking | Pops bottom sheet modal | ✅ Wired | Top-right icon button |
| **No, Go Back button** | Cancellation Confirmation | Pops bottom sheet modal | ✅ Wired | Purple filled button |
| **Yes, Return product button** | Cancellation Confirmation | Processes return → Navigates to `/my-orders` | ✅ Wired | Red outlined button, shows snackbar |

## Navigation Flow Summary

```
My Orders (/my-orders)
  │
  ├─> Order Card Tap → Order Detail (/order-detail)
  │   │
  │   ├─> Track Order → Tracking (bottom sheet)
  │   │   └─> Close → Back to Order Detail
  │   │
  │   ├─> Cancel Order → Cancellation Confirmation (bottom sheet)
  │   │   ├─> No, Go Back → Back to Order Detail
  │   │   └─> Yes, Return → My Orders (/my-orders)
  │   │
  │   └─> Return Order → Cancellation Confirmation (bottom sheet)
  │       ├─> No, Go Back → Back to Order Detail
  │       └─> Yes, Return → My Orders (/my-orders)
  │
  └─> Track Order → Tracking (bottom sheet)
      └─> Close → Back to My Orders
```

## Order Status Variants

### Active Order (OrderStatus.active)
- **Summary Section**: "Delivering to", "Delivery expected by"
- **Payment Section**: "Total to pay"
- **Action Buttons**: "Cancel Order" (red)
- **Track Order Button**: Visible

### Delivered Order (OrderStatus.delivered)
- **Summary Section**: "Delivered to", "Delivered on"
- **Payment Section**: "Total paid"
- **Action Buttons**: "Return Order" (red)
- **Track Order Button**: Hidden

## Assets Imported/Used

### Icons (Material Icons - Placeholders)
- `Icons.arrow_back` - Back navigation
- `Icons.share` - Share order
- `Icons.home` - Home address label
- `Icons.article` - Invoice icon
- `Icons.check_circle` - Completed tracking step
- `Icons.radio_button_unchecked` - Pending tracking step
- `Icons.close` - Close button
- `Icons.image` - Product image placeholder

### Assets Needed (from Figma)
1. **Product Images**: Product thumbnails (52x52px)
2. **Icons**: 
   - Invoice icon (`imgArticle`)
   - Share icon (`imgShare`)
   - Home icon (`imgHome`)
   - Check circle icon (`imgCheckCircle`)
   - Radio button unchecked icon (`imgRadioButtonUnchecked`)
   - Close small icon (`imgCloseSmall`)
3. **Dividers**: 
   - `imgLine933` - Order card divider
   - `imgLine934` - Payment section divider
   - `imgLine938` - Tracking timeline divider

## Implementation Notes

### Bottom Sheet Modals
- **Tracking Screen**: Shown as bottom sheet with rounded top corners (24dp radius)
- **Cancellation Confirmation**: Shown as bottom sheet with rounded top corners (24dp radius)
- Both use `showModalBottomSheet` with `backgroundColor: Colors.transparent`
- Both are dismissible via close button or back gesture

### Order Status Handling
- Single `OrderDetailScreen` widget handles all variants
- Uses `OrderStatus` enum for type-safe status management
- Conditional rendering based on `isDelivered` flag
- Extensible for future status types (cancelled, returning, etc.)

### Route Arguments
- Order Detail accepts `orderId` and `orderStatus` via route arguments
- Tracking accepts `orderId` via route arguments
- All arguments properly extracted with null-safety checks

## Summary

✅ **All primary navigation handlers wired**  
✅ **Bottom sheet modals properly implemented**  
✅ **Order status variants handled in single screen**  
✅ **Routes defined and registered**  
✅ **Design tokens used consistently**  
✅ **No linter errors**  
✅ **Code follows WDI Flutter Coding Standards**

**Remaining TODOs**:
- Export and add Figma assets
- Implement invoice display/download
- Implement share order functionality
- Implement buy again navigation
- Connect to actual order API
- Implement order cancellation/return API calls

