import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/service_order_status.dart';
import 'service_cancellation_confirmation_dialog.dart';
import '../../quick_trigger/controller/quick_trigger_controller.dart';
import '../../quick_trigger/models/quick_trigger_state.dart';

/// Service Order Detail Screen
/// 
/// Displays detailed service order information.
/// Handles multiple variants based on service order status:
/// - Upcoming: Shows "Scheduled on", "Call agent", "Cancel service" button
/// - Cancelled: Shows "Cancelled on", "Refund" status, disabled primary actions
/// - Completed: Shows "Completed on", "Rate this service" button
/// Design Source: Figma frames:
/// - "Order detail - service - upcoming" (node-id: 1-30580)
/// - "Order detail - service - cancelled" (node-id: 1-30691)
/// - "Order detail - service - completed" (node-id: 1-30800)
class ServiceOrderDetailScreen extends StatefulWidget {
  final String? orderId;
  final ServiceOrderStatus? orderStatus;

  const ServiceOrderDetailScreen({
    super.key,
    this.orderId,
    this.orderStatus,
  });

  @override
  State<ServiceOrderDetailScreen> createState() => _ServiceOrderDetailScreenState();
}

class _ServiceOrderDetailScreenState extends State<ServiceOrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Update Quick Trigger controller when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateQuickTriggerController();
    });
  }

  void _updateQuickTriggerController() {
    try {
      final quickTriggerController = Get.find<QuickTriggerController>();
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final displayOrderId = widget.orderId ?? args?['orderId'] ?? '';
      final status = widget.orderStatus ?? 
          (args?['orderStatus'] != null 
              ? ServiceOrderStatus.values.firstWhere(
                  (e) => e.toString() == args!['orderStatus'],
                  orElse: () => ServiceOrderStatus.upcoming,
                )
              : ServiceOrderStatus.upcoming);

      // Map ServiceOrderStatus to QuickTriggerState
      QuickTriggerState triggerState;
      if (status == ServiceOrderStatus.upcoming) {
        triggerState = QuickTriggerState.onTheDay;
      } else if (status == ServiceOrderStatus.completed) {
        triggerState = QuickTriggerState.onCompletion;
      } else {
        // Cancelled - hide Quick Trigger
        quickTriggerController.clearActiveServiceOrder();
        return;
      }

      // Update Quick Trigger with service order data
      quickTriggerController.setActiveServiceOrder(
        orderId: displayOrderId,
        serviceName: 'Switch / Socket Repair & Replacement',
        agentName: 'Mehdi Hasan',
        agentId: 'EXEC-001',
        agencyName: 'Service agency name',
        arrivalTime: '08:00 am',
        agentRating: 4.5,
        agentAvatarUrl: 'assets/quick_trigger/agent_avatar.png',
        state: triggerState,
      );
    } catch (e) {
      // Controller not initialized, ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get order ID and status from route arguments if not provided
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayOrderId = widget.orderId ?? args?['orderId'] ?? '';
    final status = widget.orderStatus ?? 
        (args?['orderStatus'] != null 
            ? ServiceOrderStatus.values.firstWhere(
                (e) => e.toString() == args!['orderStatus'],
                orElse: () => ServiceOrderStatus.upcoming,
              )
            : ServiceOrderStatus.upcoming);

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
            // Service title and items
            _buildServiceHeader(),
            const SizedBox(height: AppSpacing.lg),
            // Summary section
            _buildSummarySection(status),
            const SizedBox(height: AppSpacing.lg),
            // Payment section
            _buildPaymentSection(),
            const SizedBox(height: AppSpacing.lg),
            // Scheduled to section
            _buildScheduledToSection(),
            const SizedBox(height: AppSpacing.lg),
            // Assigned to section
            _buildAssignedToSection(status),
            // Cancelled status section (only for cancelled orders)
            if (status == ServiceOrderStatus.cancelled) ...[
              const SizedBox(height: AppSpacing.lg),
              _buildCancelledStatusSection(),
            ],
            const SizedBox(height: AppSpacing.lg),
            // Action buttons
            _buildActionButtons(context, status, displayOrderId),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Switch / socket repair & replacement',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            letterSpacing: 0.28,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildServiceItemRow('1 Switch', 'x1', 'OMR 24'),
        const SizedBox(height: AppSpacing.sm),
        _buildServiceItemRow('Power Switch', 'x1', 'OMR 52'),
      ],
    );
  }

  Widget _buildServiceItemRow(String name, String quantity, String price) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary.withOpacity(0.6),
              letterSpacing: 0.24,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            quantity,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary.withOpacity(0.6),
              letterSpacing: 0.24,
            ),
          ),
        ),
        SizedBox(
          width: 60,
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
    );
  }

  Widget _buildSummarySection(ServiceOrderStatus status) {
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
            status == ServiceOrderStatus.completed 
                ? 'Completed on' 
                : 'Scheduled on',
            '02 Oct 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.24,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2EB24F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Prepaid',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 9,
                    color: AppColors.backgroundWhite,
                    letterSpacing: 0.18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Item total', 'OMR 76'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Platform fee', 'OMR -'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Taxes', 'OMR -'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Total paid', 'OMR 76'),
          const Divider(height: 1, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Payment method', 'Master Card ** **62'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Transaction ID', 'HFSK78930NJ'),
        ],
      ),
    );
  }

  Widget _buildScheduledToSection() {
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
            'Scheduled to',
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

  Widget _buildAssignedToSection(ServiceOrderStatus status) {
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
            'Assigned to',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              // Agent avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6D1B0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/my_orders/service_actions/agent_avatar.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 30, color: AppColors.textPrimary);
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
                      'Mehdi Hasan',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'Executive ID\nService agency name',
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
              // Call button (only for upcoming orders)
              if (status == ServiceOrderStatus.upcoming)
                IconButton(
                  icon: Image.asset(
                    'assets/service_booking/icon_call.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.call, size: 16, color: AppColors.textPrimary);
                    },
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.serviceCall,
                      arguments: {
                        'orderId': widget.orderId,
                        'callType': 'outgoing',
                        'callState': 'ringing',
                        'agentName': 'Mehdi Hasan',
                      },
                    );
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.all(12),
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.textSecondary),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledStatusSection() {
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
          _buildDetailRow('Cancelled on', 'Today'),
          const SizedBox(height: AppSpacing.sm),
          _buildDetailRow('Refund', 'Processing'),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ServiceOrderStatus status, String orderId) {
    if (status == ServiceOrderStatus.completed) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Show invoice
              },
              icon: Image.asset(
                'assets/my_orders/icon_article.png',
                width: 12,
                height: 12,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.article, size: 12, color: AppColors.primary);
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
                Navigator.of(context).pushNamed(
                  AppRoutes.serviceReview,
                  arguments: {'orderId': orderId},
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
                'Rate this service',
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
    } else if (status == ServiceOrderStatus.upcoming) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Show invoice
              },
              icon: Image.asset(
                'assets/my_orders/icon_article.png',
                width: 12,
                height: 12,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.article, size: 12, color: AppColors.primary);
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
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const ServiceCancellationConfirmationDialog(),
                );
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
                'Cancel Order',
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
    // Cancelled status - no action buttons
    return const SizedBox.shrink();
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
          width: 100,
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

