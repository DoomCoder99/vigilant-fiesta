import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../repository/invoice_repository.dart';

/// Invoice Screen
/// 
/// Displays invoice for an order.
/// Design Source: Figma frame "Order detail - product - active" (node-id: 1-6993)
class InvoiceScreen extends StatefulWidget {
  final String? orderId;

  const InvoiceScreen({
    super.key,
    this.orderId,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final InvoiceRepository _invoiceRepository = InvoiceRepository.instance;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    // Get order ID from route arguments if not provided
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
          'Invoice',
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
              _handleShareInvoice(context, displayOrderId);
            },
            tooltip: 'Share invoice',
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
            // Invoice content area
            _buildInvoiceContentArea(),
            const SizedBox(height: AppSpacing.lg),
            // Action buttons
            _buildActionButtons(context, displayOrderId),
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
              'assets/orders/track_invoice/product_bose_headphones_invoice.png',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
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

  Widget _buildInvoiceContentArea() {
    return Container(
      height: 580,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.textSecondary),
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
      ),
      child: Center(
        child: Text(
          'Invoice',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, String orderId) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isDownloading
                ? null
                : () {
                    _handleDownloadInvoice(context, orderId);
                  },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: _isDownloading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Download',
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
            onPressed: _isSharing
                ? null
                : () {
                    _handleShareInvoice(context, orderId);
                  },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: _isSharing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Share',
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
    );
  }

  Future<void> _handleDownloadInvoice(BuildContext context, String orderId) async {
    if (orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order ID is required'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      final filePath = await _invoiceRepository.downloadInvoice(orderId);
      
      setState(() {
        _isDownloading = false;
      });

      if (filePath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invoice downloaded to: $filePath'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice download not yet implemented. Please check back later.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading invoice: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _handleShareInvoice(BuildContext context, String orderId) async {
    if (orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order ID is required'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSharing = true;
    });

    try {
      final success = await _invoiceRepository.shareInvoice(orderId);
      
      setState(() {
        _isSharing = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice shared successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invoice sharing not yet implemented. Please check back later.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSharing = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing invoice: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

