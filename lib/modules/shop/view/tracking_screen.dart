import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/tracking_step.dart';
import '../repository/tracking_repository.dart';

/// Tracking Screen
/// 
/// Displays order tracking timeline as a full screen.
/// Design Source: Figma frame "Tracking" (node-id: 1-6714)
class TrackingScreen extends StatefulWidget {
  final String? orderId;

  const TrackingScreen({
    super.key,
    this.orderId,
  });

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final TrackingRepository _trackingRepository = TrackingRepository.instance;
  List<TrackingStep> _trackingSteps = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrackingData();
  }

  Future<void> _loadTrackingData() async {
    final orderId = widget.orderId ?? '';
    if (orderId.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final steps = await _trackingRepository.getTrackingTimeline(orderId);
      setState(() {
        _trackingSteps = steps;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          'Track order',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_trackingSteps.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Text(
                          'No tracking information available',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._buildTrackingTimeline(),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildTrackingTimeline() {
    final widgets = <Widget>[];
    
    for (int i = 0; i < _trackingSteps.length; i++) {
      final step = _trackingSteps[i];
      widgets.add(_buildTrackingItem(step));
      
      if (i < _trackingSteps.length - 1) {
        widgets.add(const Divider(height: 1, color: AppColors.textSecondary));
      }
    }
    
    return widgets;
  }

  Widget _buildTrackingItem(TrackingStep step) {
    final statusColor = step.isCompleted ? AppColors.success : const Color(0xFFFA643B);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            step.isCompleted
                ? 'assets/orders/track_invoice/icon_check_circle.png'
                : 'assets/orders/track_invoice/icon_radio_unchecked.png',
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to existing assets if new ones don't exist
              return Image.asset(
                step.isCompleted
                    ? 'assets/my_orders/icon_check_circle.png'
                    : 'assets/service_booking/icon_radio_unchecked.png',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    step.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: statusColor,
                    size: 20,
                  );
                },
                color: statusColor,
              );
            },
            color: statusColor,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              step.label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: step.isCompleted ? AppColors.textPrimary : statusColor,
                letterSpacing: 0.24,
              ),
            ),
          ),
          Text(
            step.value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: step.isCompleted ? AppColors.textPrimary : statusColor,
              letterSpacing: 0.24,
            ),
          ),
        ],
      ),
    );
  }
}
