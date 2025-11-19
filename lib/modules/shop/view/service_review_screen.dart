import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../quick_trigger/controller/quick_trigger_controller.dart';

/// Service Review Screen
/// 
/// Allows users to rate and review a completed service.
/// Supports two states:
/// - Blank: No stars selected, empty text
/// - Star & Review Box: Stars selected, review text input visible
/// Design Source: Figma frames:
/// - "Review - blank" (node-id: 1-31096)
/// - "Review - star & review box" (node-id: 1-31109)
class ServiceReviewScreen extends StatefulWidget {
  final String? orderId;

  const ServiceReviewScreen({
    super.key,
    this.orderId,
  });

  @override
  State<ServiceReviewScreen> createState() => _ServiceReviewScreenState();
}

class _ServiceReviewScreenState extends State<ServiceReviewScreen> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xxxxl,
              AppSpacing.lg,
              AppSpacing.xxxxl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Rating icon
                Image.asset(
                  'assets/my_orders/service_actions/rating_icon.png',
                  width: 128,
                  height: 128,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.star, size: 128, color: AppColors.primary);
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),
                // Title
                Text(
                  'Hello, there!\nHow would you rate this service?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                // Star rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRating = starIndex;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg / 2),
                        child: Image.asset(
                          starIndex <= _selectedRating
                              ? 'assets/my_orders/service_actions/star_filled.png'
                              : 'assets/my_orders/service_actions/star_empty.png',
                          width: 32,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              starIndex <= _selectedRating ? Icons.star : Icons.star_border,
                              size: 32,
                              color: starIndex <= _selectedRating 
                                  ? AppColors.primary 
                                  : AppColors.textSecondary,
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.xxxxl),
                // Review text input (shown when rating is selected)
                if (_selectedRating > 0) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Review (Optional)',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                        ),
                        child: TextField(
                          controller: _reviewController,
                          maxLines: 4,
                          style: AppTextStyles.input.copyWith(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Do you have anything more to share about this service?',
                            hintStyle: AppTextStyles.input.copyWith(
                              fontSize: 12,
                              color: AppColors.inputPlaceholder,
                            ),
                            contentPadding: const EdgeInsets.all(AppSpacing.lg),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              child: Image.asset(
                                'assets/my_orders/service_actions/icon_mic.png',
                                width: 16,
                                height: 16,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.mic, size: 16, color: AppColors.textPrimary);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxxxl),
                ],
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _selectedRating > 0
                        ? () {
                            // TODO: Submit review to backend
                            // Transition Quick Trigger to thanks state
                            try {
                              final quickTriggerController = Get.find<QuickTriggerController>();
                              quickTriggerController.transitionToThanks();
                            } catch (e) {
                              // Controller not initialized, ignore
                            }
                            // Navigate back
                            Navigator.of(context).pop();
                            // Optionally show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Review submitted successfully'),
                              ),
                            );
                          }
                        : null,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxxxl,
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Submit Feedback',
                      style: AppTextStyles.buttonSecondary.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

