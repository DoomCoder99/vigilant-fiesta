import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/order_status.dart';
import 'product_cancellation_confirmation_screen.dart';

/// Order Detail Screen
/// 
/// Displays detailed order information.
/// Handles multiple variants based on order status and context:
/// - Active: Shows "Delivery expected by", "Total to pay", "Cancel Order" button
/// - Delivered: Shows "Delivered on", "Total paid", "Return Order" button
/// - Return flow: Shows issue selection (variant 68:4013)
/// - Return status: Shows return timeline (variant 68:4093)
/// Design Source: Figma frames:
/// - "Order detail - product - active" (node-id: 68-3821)
/// - "Order detail - product - active (variant)" (node-id: 68-4013)
/// - "Order detail - product - active (other variant)" (node-id: 68-4093)
class OrderDetailScreen extends StatefulWidget {
  final String? orderId;
  final OrderStatus? orderStatus;
  final bool showReturnFlow;
  final bool showReturnStatus;

  const OrderDetailScreen({
    super.key,
    this.orderId,
    this.orderStatus,
    this.showReturnFlow = false,
    this.showReturnStatus = false,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? _selectedReturnReason;

  @override
  Widget build(BuildContext context) {
    // Get order ID and status from route arguments if not provided
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayOrderId = widget.orderId ?? args?['orderId'] ?? '';
    final status = widget.orderStatus ?? 
        (args?['orderStatus'] != null 
            ? OrderStatus.values.firstWhere(
                (e) => e.toString() == args!['orderStatus'],
                orElse: () => OrderStatus.active,
              )
            : OrderStatus.active);
    
    final showReturnFlow = widget.showReturnFlow || (args?['showReturnFlow'] ?? false);
    final showReturnStatus = widget.showReturnStatus || (args?['showReturnStatus'] ?? false);

    final isDelivered = status == OrderStatus.delivered;
    final isCancelled = status == OrderStatus.cancelled;

    // Return status variant
    if (showReturnStatus) {
      return _buildReturnStatusScreen(context, displayOrderId);
    }

    // Return flow variant
    if (showReturnFlow) {
      return _buildReturnFlowScreen(context, displayOrderId);
    }

    // Standard order detail
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
          'order details',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/icon_share.png',
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.share, color: AppColors.textPrimary, size: 16);
              },
            ),
            onPressed: () {
              // TODO: Share order
            },
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product item
            _buildProductItem(),
            const SizedBox(height: AppSpacing.lg),
            // Summary section
            _buildSummarySection(isDelivered, isCancelled),
            const SizedBox(height: AppSpacing.lg),
            // Payment section
            _buildPaymentSection(isDelivered),
            const SizedBox(height: AppSpacing.lg),
            // Delivery address section
            _buildDeliveryAddressSection(isDelivered),
            const SizedBox(height: AppSpacing.lg),
            // Order Cancelled section (if cancelled)
            if (isCancelled) ...[
              _buildOrderCancelledSection(),
              const SizedBox(height: AppSpacing.lg),
            ],
            // Action buttons
            _buildActionButtons(context, isDelivered, isCancelled, displayOrderId),
            const SizedBox(height: AppSpacing.lg),
            // Track order button (only for active orders)
            if (!isDelivered && !isCancelled)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.tracking,
                      arguments: {'orderId': displayOrderId},
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
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
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnFlowScreen(BuildContext context, String orderId) {
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
          'Return order',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product item
            _buildProductItem(),
            const SizedBox(height: AppSpacing.lg),
            // Issue selection
            Text(
              'What\'s the issue with this item?',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.24,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildReturnReasonOptions(),
            const SizedBox(height: AppSpacing.lg),
            // Return policy
            _buildReturnPolicySection(),
            const SizedBox(height: AppSpacing.lg),
            // Return eligibility
            _buildReturnEligibilitySection(),
            const SizedBox(height: 100), // Space for button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: const BoxDecoration(
          color: AppColors.backgroundWhite,
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _selectedReturnReason != null
              ? () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.cancellationConfirmation,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxxl,
              vertical: AppSpacing.lg,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTextStyles.button.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Image.asset(
                'assets/service_booking/icon_chevron_forward.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.chevron_right, size: 20, color: AppColors.backgroundWhite);
                },
                color: AppColors.backgroundWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReturnStatusScreen(BuildContext context, String orderId) {
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
          'Return order',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product item
            _buildProductItem(),
            const SizedBox(height: AppSpacing.lg),
            // Return status
            Text(
              'Return status',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.24,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildReturnStatusTimeline(),
            const SizedBox(height: AppSpacing.lg),
            // Return policy
            _buildReturnPolicySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem() {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.inputBorder,
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
          ),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            child: Image.asset(
              'assets/my_orders/product_bose_headphones.png',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/product_image_9.png',
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, size: 30, color: AppColors.textPrimary);
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bose QuietComfort® 45 Headphones',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  letterSpacing: 0.28,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Text(
                    'x1',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withOpacity(0.6),
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Text(
                    'OMR 12.04',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withOpacity(0.6),
                      letterSpacing: 0.24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(bool isDelivered, bool isCancelled) {
    return Container(
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
            'Summary',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Ordered on', '24 Sep 2025'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Order number', '857-4748-37848'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isDelivered ? 'Delivered to' : 'Delivering to',
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
                    'Home',
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
          _buildDetailRow(
            isDelivered ? 'Delivered on' : 'Delivery expected by',
            isDelivered ? '02 Oct 2025' : '02 Oct 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(bool isDelivered) {
    return Container(
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
            'Payment',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Item total', 'OMR 12.04'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Platform fee', 'OMR 4'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Taxes', 'OMR 3.96'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow(
            isDelivered ? 'Total paid' : 'Total to pay',
            'OMR 20',
          ),
          const Divider(height: 1, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Payment method', 'Master Card ** **62'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Transaction ID', 'HFSK78930NJ'),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddressSection(bool isDelivered) {
    return Container(
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
            isDelivered ? 'Delivered to' : 'Delivering to',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'House / Apartment number',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'Street name, Locality, Town, Postcode.',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary.withOpacity(0.6),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Location',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDelivered, bool isCancelled, String orderId) {
    // If cancelled, only show Buy Again button
    if (isCancelled) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            // TODO: Buy again - navigate to product detail or add to cart
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            'buy again',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 0.24,
            ),
          ),
        ),
      );
    }

    // For active/delivered orders, show all buttons
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.invoice,
                arguments: {'orderId': orderId},
              );
            },
            icon: Image.asset(
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
            label: Text(
              'Invoice',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.24,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: Buy again - navigate to product detail or add to cart
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'buy again',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.24,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.supportInitial,
                arguments: {
                  'orderId': orderId,
                  'productName': 'Bose QuietComfort® 45 Headphones', // TODO: Get from order data
                },
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Support',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.24,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              if (isDelivered) {
                // Navigate to return flow
                Navigator.of(context).pushNamed(
                  AppRoutes.orderDetail,
                  arguments: {
                    'orderId': orderId,
                    'showReturnFlow': true,
                  },
                );
              } else {
                // Show product cancellation confirmation
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ProductCancellationConfirmationScreen(orderId: orderId),
                );
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              side: const BorderSide(color: Color(0xFFF14336)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              isDelivered ? 'Return Order' : 'Cancel Order',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF14336),
                letterSpacing: 0.24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCancelledSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.errorLight),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order cancelled',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Cancelled on', '31 Sep 2025'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Refund', 'Processing'),
        ],
      ),
    );
  }

  Widget _buildReturnReasonOptions() {
    final reasons = [
      'Defective or doesn\'t work',
      'Physical damage',
      'Missing parts',
      'Wrong item',
      'No longer needed',
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.textSecondary),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Column(
        children: [
          for (int i = 0; i < reasons.length; i++) ...[
            InkWell(
              onTap: () {
                setState(() {
                  _selectedReturnReason = reasons[i];
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    _selectedReturnReason == reasons[i]
                        ? 'assets/service_booking/icon_radio_checked.png'
                        : 'assets/service_booking/icon_radio_unchecked.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        _selectedReturnReason == reasons[i]
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 16,
                        color: _selectedReturnReason == reasons[i]
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      );
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      reasons[i],
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        letterSpacing: 0.24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (i < reasons.length - 1)
              const Divider(height: 1, color: AppColors.textSecondary),
          ],
        ],
      ),
    );
  }

  Widget _buildReturnPolicySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Return policy',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus.',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary.withOpacity(0.6),
            letterSpacing: 0.24,
          ),
        ),
      ],
    );
  }

  Widget _buildReturnEligibilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Return Eligibility',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Till 02 Nov 2025',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary.withOpacity(0.6),
            letterSpacing: 0.24,
          ),
        ),
      ],
    );
  }

  Widget _buildReturnStatusTimeline() {
    return Column(
      children: [
        const Divider(height: 1, color: AppColors.textSecondary),
        _buildReturnStatusItem(
          'Return request placed on',
          'Today',
          isCompleted: true,
        ),
        const Divider(height: 1, color: AppColors.textSecondary),
        _buildReturnStatusItem(
          'Pickup scheduled',
          '20 Oct 2025',
          isCompleted: false,
        ),
        const Divider(height: 1, color: AppColors.textSecondary),
        _buildReturnStatusItem(
          'Refund initiated',
          'Awaiting',
          isCompleted: false,
        ),
        const Divider(height: 1, color: AppColors.textSecondary),
      ],
    );
  }

  Widget _buildReturnStatusItem(String label, String value, {required bool isCompleted}) {
    final statusColor = isCompleted ? AppColors.textPrimary : const Color(0xFFFA643B);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            isCompleted
                ? 'assets/my_orders/icon_check_circle.png'
                : 'assets/service_booking/icon_radio_unchecked.png',
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: statusColor,
                size: 20,
              );
            },
            color: statusColor,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: statusColor,
                letterSpacing: 0.24,
              ),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: statusColor,
              letterSpacing: 0.24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
        SizedBox(
          width: 64,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: AppColors.textPrimary.withOpacity(0.6),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}
