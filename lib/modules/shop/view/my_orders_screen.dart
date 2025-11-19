import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/order_status.dart';
import 'product_cancellation_confirmation_screen.dart';

/// My Orders Screen
/// 
/// Displays list of user orders with tabs (Active, Services, Products, Cancel/Return).
/// Design Source: Figma frames:
/// - "My Orders - active" (node-id: 1-6293)
/// - "My Orders - services" (node-id: 1-6435)
/// - "My Orders - products" (node-id: 1-6559)
/// - "My Orders - cancel / return" (node-id: 1-6655)
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String _selectedTab = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icon_back_arrow.png',
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 16);
            },
          ),
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: AppColors.textSecondary),
            ),
          ),
        ),
        title: Text(
          'my orders',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter tabs
          _buildFilterTabs(),
          // Orders list
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildFilterTab('Active'),
          _buildFilterTab('Services'),
          _buildFilterTab('Products'),
          _buildFilterTab('Cancel / Return'),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    final isActive = _selectedTab == label;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = label;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.5),
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 'Active':
        return _buildActiveTab();
      case 'Services':
        return _buildServicesTab();
      case 'Products':
        return _buildProductsTab();
      case 'Cancel / Return':
        return _buildCancelReturnTab();
      default:
        return _buildActiveTab();
    }
  }

  Widget _buildActiveTab() {
    // TODO: Replace with actual order data check
    // For now, always show orders. When backend is integrated, check:
    // final hasOrders = orders.isNotEmpty;
    // if (!hasOrders) {
    //   return AmozitEmptyStateWidget(...);
    // }
    
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Deliver to section
        Text(
          'Deliver to',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildProductOrderCard(
          productName: 'Bose QuietComfort® 45 Headphones',
          quantity: 'x1',
          price: 'OMR 12.04',
          orderedOn: '24 Sep 2025',
          deliveringTo: 'Home',
          deliveryExpectedBy: '02 Oct 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: {'orderId': 'order_123'},
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _buildProductOrderCard(
          productName: 'Samsung galaxy m36 5G (velvet black) 8GB ram',
          quantity: 'x1',
          price: 'OMR 12.04',
          orderedOn: '18 Sep 2025',
          deliveringTo: 'Home',
          deliveryExpectedBy: '20 Sep 2025',
          orderStatus: OrderStatus.active,
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: {
                'orderId': 'order_124',
                'orderStatus': 'OrderStatus.active',
              },
            );
          },
          onCancel: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const ProductCancellationConfirmationScreen(orderId: 'order_124'),
            );
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        // Service booked for section
        Text(
          'Service booked for',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildServiceOrderCard(
          serviceName: 'Switch / socket repair & replacement',
          items: [
            {'name': '1 Switch', 'quantity': 'x1', 'price': 'OMR 24'},
            {'name': 'Power Switch', 'quantity': 'x1', 'price': 'OMR 52'},
          ],
          orderedOn: '24 Sep 2025',
          scheduledTo: 'Home',
          scheduledOn: '02 Oct 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.serviceOrderDetail,
              arguments: {
                'orderId': 'service_123',
                'orderStatus': 'ServiceOrderStatus.upcoming',
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Active section
        Text(
          'active',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildServiceOrderCard(
          serviceName: 'Switch / socket repair & replacement',
          items: [
            {'name': '1 Switch', 'quantity': 'x1', 'price': 'OMR 24'},
            {'name': 'Power Switch', 'quantity': 'x1', 'price': 'OMR 52'},
          ],
          orderedOn: '24 Sep 2025',
          scheduledTo: 'Home',
          scheduledOn: '02 Oct 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.serviceOrderDetail,
              arguments: {
                'orderId': 'service_123',
                'orderStatus': 'ServiceOrderStatus.upcoming',
              },
            );
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        // Past section
        Text(
          'Past',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildServiceOrderCard(
          serviceName: 'AC Installation',
          items: [
            {'name': 'Split AC installation', 'quantity': 'x1', 'price': 'OMR 40'},
          ],
          orderedOn: '24 Sep 2025',
          scheduledTo: 'Home',
          completedOn: '02 Oct 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.serviceOrderDetail,
              arguments: {
                'orderId': 'service_124',
                'orderStatus': 'ServiceOrderStatus.completed',
              },
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _buildServiceOrderCard(
          serviceName: 'AC Installation',
          items: [
            {'name': 'Split AC installation', 'quantity': 'x1', 'price': 'OMR 40'},
          ],
          orderedOn: '12 Sep 2025',
          scheduledTo: 'Work',
          completedOn: '18 Sep 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.serviceOrderDetail,
              arguments: {
                'orderId': 'service_125',
                'orderStatus': 'ServiceOrderStatus.completed',
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductsTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Active section
        Text(
          'Active',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildProductOrderCard(
          productName: 'Bose QuietComfort® 45 Headphones',
          quantity: 'x1',
          price: 'OMR 12.04',
          orderedOn: '24 Sep 2025',
          deliveringTo: 'Home',
          deliveryExpectedBy: '02 Oct 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: {'orderId': 'order_123'},
            );
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        // Past section
        Text(
          'Past',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildProductOrderCard(
          productName: 'Samsung galaxy m36 5G (velvet black) 8GB ram',
          quantity: 'x1',
          price: 'OMR 12.04',
          orderedOn: '18 Sep 2025',
          deliveringTo: 'Home',
          deliveredOn: '20 Sep 2025',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: {'orderId': 'order_124'},
            );
          },
        ),
      ],
    );
  }

  Widget _buildCancelReturnTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _buildCancelledOrderCard(
          productName: 'Bose QuietComfort® 45 Headphones',
          quantity: 'x1',
          price: 'OMR 12.04',
          orderedOn: '24 Sep 2025',
          cancelledOn: '31 Sep 2025',
          refundStatus: 'Processing',
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: {'orderId': 'order_123'},
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductOrderCard({
    required String productName,
    required String quantity,
    required String price,
    required String orderedOn,
    required String deliveringTo,
    String? deliveryExpectedBy,
    String? deliveredOn,
    OrderStatus orderStatus = OrderStatus.active,
    required VoidCallback onTap,
    VoidCallback? onCancel,
  }) {
    final isCancelled = orderStatus == OrderStatus.cancelled;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: AppColors.textSecondary),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    productName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.24,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  quantity,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: AppColors.textPrimary.withOpacity(0.6),
                    letterSpacing: 0.24,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                SizedBox(
                  width: 64,
                  child: Text(
                    price,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withOpacity(0.6),
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 1, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            _buildOrderDetailRow('Ordered on', orderedOn),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivering to',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textPrimary.withOpacity(0.6),
                    letterSpacing: 0.2,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/service_booking/icon_home.png',
                      width: 12,
                      height: 12,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.home, size: 12, color: AppColors.textPrimary);
                      },
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      deliveringTo,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (isCancelled) ...[
              _buildOrderDetailRow('Cancelled on', '31 Sep 2025'),
              const SizedBox(height: AppSpacing.sm),
              _buildOrderDetailRow('Refund', 'Processing'),
            ] else ...[
              if (deliveryExpectedBy != null)
                _buildOrderDetailRow('Delivery expected by', deliveryExpectedBy),
              if (deliveredOn != null)
                _buildOrderDetailRow('Delivered on', deliveredOn),
            ],
            const Divider(height: 1, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            // Action buttons
            if (isCancelled)
              // Cancelled orders: no action buttons
              const SizedBox.shrink()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.invoice,
                        arguments: {'orderId': 'order_123'},
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/orders/track_invoice/icon_article.png',
                          width: 12,
                          height: 12,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/my_orders/icon_article.png',
                              width: 12,
                              height: 12,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.article, size: 12, color: AppColors.primary);
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Invoice',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (onCancel != null)
                        OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFF14336)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF14336),
                              letterSpacing: 0.24,
                            ),
                          ),
                        ),
                      if (onCancel != null) const SizedBox(width: AppSpacing.sm),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.tracking,
                            arguments: {'orderId': 'order_123'},
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Track order',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceOrderCard({
    required String serviceName,
    required List<Map<String, String>> items,
    required String orderedOn,
    required String scheduledTo,
    String? scheduledOn,
    String? completedOn,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: AppColors.textSecondary),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceName,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.24,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['name']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary.withOpacity(0.6),
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Text(
                        item['quantity']!,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          color: AppColors.textPrimary.withOpacity(0.6),
                          letterSpacing: 0.24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      SizedBox(
                        width: 64,
                        child: Text(
                          item['price']!,
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary.withOpacity(0.6),
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            const Divider(height: 1, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            _buildOrderDetailRow('Ordered on', orderedOn),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service scheduled to',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textPrimary.withOpacity(0.6),
                    letterSpacing: 0.2,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/service_booking/icon_home.png',
                      width: 12,
                      height: 12,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.home, size: 12, color: AppColors.textPrimary);
                      },
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      scheduledTo,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (scheduledOn != null)
              _buildOrderDetailRow('Scheduled on', scheduledOn),
            if (completedOn != null)
              _buildOrderDetailRow('Completed on', completedOn),
            const Divider(height: 1, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.invoice,
                      arguments: {'orderId': 'service_123'},
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/orders/track_invoice/icon_article.png',
                        width: 12,
                        height: 12,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/my_orders/icon_article.png',
                            width: 12,
                            height: 12,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.article, size: 12, color: AppColors.primary);
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Invoice',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.tracking,
                      arguments: {'orderId': 'service_123'},
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Track Service',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelledOrderCard({
    required String productName,
    required String quantity,
    required String price,
    required String orderedOn,
    required String cancelledOn,
    required String refundStatus,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: AppColors.errorLight),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    productName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.24,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Text(
                  quantity,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: AppColors.textPrimary.withOpacity(0.6),
                    letterSpacing: 0.24,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                SizedBox(
                  width: 64,
                  child: Text(
                    price,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withOpacity(0.6),
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 1, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.sm),
            _buildOrderDetailRow('Ordered on', orderedOn),
            const SizedBox(height: AppSpacing.sm),
            _buildOrderDetailRow('Cancelled on', cancelledOn),
            const SizedBox(height: AppSpacing.sm),
            _buildOrderDetailRow('Refund', refundStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: AppColors.textPrimary.withOpacity(0.6),
            letterSpacing: 0.2,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: AppColors.textPrimary.withOpacity(0.6),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
