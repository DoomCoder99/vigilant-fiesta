import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../repository/order_repository.dart';

/// Cancel Order Screen
/// 
/// Screen for selecting cancellation reason and confirming order cancellation.
/// Design Source: Figma frame "Cancel order" (node-id: 1-7445)
class CancelOrderScreen extends StatefulWidget {
  final String? orderId;

  const CancelOrderScreen({
    super.key,
    this.orderId,
  });

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  String? _selectedReason;
  final TextEditingController _commentsController = TextEditingController();
  final OrderRepository _orderRepository = OrderRepository.instance;
  bool _isCancelling = false;

  final List<String> _cancellationReasons = [
    'I changed mind',
    'Found better price',
    'Other',
  ];

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayOrderId = widget.orderId ?? args?['orderId'] ?? '';

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
          'Cancel order',
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
            // Cancellation reasons
            _buildCancellationReasons(),
            const SizedBox(height: AppSpacing.lg),
            // Comments (Optional)
            _buildCommentsSection(),
            const SizedBox(height: AppSpacing.lg),
            // Refund section
            _buildRefundSection(),
            const SizedBox(height: AppSpacing.lg),
            // Helpline section
            _buildHelplineSection(),
            const SizedBox(height: AppSpacing.lg),
            // Cancel Order button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _selectedReason != null && !_isCancelling
                    ? () {
                        _handleCancelOrder(context, displayOrderId);
                      }
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: _selectedReason != null && !_isCancelling
                        ? const Color(0xFFF14336)
                        : AppColors.textSecondary,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: _isCancelling
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF14336)),
                        ),
                      )
                    : Text(
                        'Cancel Order',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _selectedReason != null && !_isCancelling
                              ? const Color(0xFFF14336)
                              : AppColors.textPrimary.withOpacity(0.5),
                          letterSpacing: 0.24,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
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

  Widget _buildCancellationReasons() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: _cancellationReasons.map((reason) {
        final isSelected = _selectedReason == reason;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedReason = reason;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.backgroundWhite,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.6)
                    : Colors.black.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              reason,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments (Optional)',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            border: Border.all(color: AppColors.inputBorder),
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentsController,
                  maxLines: 3,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Is there anything you want us to know?',
                    hintStyle: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.inputPlaceholder,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Image.asset(
                'assets/orders/cancel_order/icon_mic.png',
                width: 16,
                height: 16,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.mic, size: 16, color: AppColors.textPrimary);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRefundSection() {
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
            'Refund',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your amount of OMR 20.00 will be transferred within 7 business days. Any convenience fee / visitation fee maybe deducted. Read our cancellation policy for details.',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              color: AppColors.textPrimary.withOpacity(0.6),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () {
              // TODO: Navigate to cancellation policy
            },
            child: Text(
              'Cancellation policy',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelplineSection() {
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
            'Helpline',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildHelplineRow('Email Support', 'helpdesk@amozit.ae', isLink: true),
          const SizedBox(height: AppSpacing.sm),
          _buildHelplineRow('Toll - free number', '1800 - 080 - 011'),
          const Divider(height: 1, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          _buildHelplineRow('Payment method', 'Master Card ** **62'),
          const SizedBox(height: AppSpacing.sm),
          _buildHelplineRow('Transaction ID', 'HFSK78930NJ'),
        ],
      ),
    );
  }

  Widget _buildHelplineRow(String label, String value, {bool isLink = false}) {
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
        if (isLink)
          InkWell(
            onTap: () {
              // TODO: Open email client
            },
            child: Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                letterSpacing: 0.2,
              ),
            ),
          )
        else
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

  Future<void> _handleCancelOrder(BuildContext context, String orderId) async {
    if (_selectedReason == null) return;

    setState(() {
      _isCancelling = true;
    });

    try {
      // Call order repository to cancel order
      final success = await _orderRepository.cancelOrder(
        orderId: orderId,
        reason: _selectedReason!,
        comments: _commentsController.text.isNotEmpty
            ? _commentsController.text
            : null,
      );

      if (!mounted) return;

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order cancelled successfully'),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate back to Order Detail with cancelled status
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.orderDetail,
          arguments: {
            'orderId': orderId,
            'orderStatus': 'OrderStatus.cancelled',
          },
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to cancel order. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() {
          _isCancelling = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error cancelling order: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
      setState(() {
        _isCancelling = false;
      });
    }
  }
}

