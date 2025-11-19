import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/support_chat_controller.dart';

/// Support Chat Feedback Sheet
/// 
/// Bottom sheet for submitting feedback after chat ends.
/// Design Source: Figma frame "Support chat - Chat feedback" (node-id: 1:30338)
/// Following WDI Flutter Coding Standards.
class SupportChatFeedbackSheet extends StatefulWidget {
  final SupportChatController controller;

  const SupportChatFeedbackSheet({
    super.key,
    required this.controller,
  });

  @override
  State<SupportChatFeedbackSheet> createState() => _SupportChatFeedbackSheetState();
}

class _SupportChatFeedbackSheetState extends State<SupportChatFeedbackSheet> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How was your support experience with our customer care executive?',
            style: AppTextStyles.headingSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
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
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Icon(
                    starIndex <= _selectedRating
                        ? Icons.star
                        : Icons.star_border,
                    size: 32,
                    color: starIndex <= _selectedRating
                        ? Colors.amber
                        : AppColors.textSecondary,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Review text field
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
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Do you have anything more to share about this conversation?',
                          hintStyle: AppTextStyles.input.copyWith(
                            color: AppColors.inputPlaceholder,
                          ),
                          border: InputBorder.none,
                        ),
                        style: AppTextStyles.input,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/support_chat/icon_mic.png',
                        width: 16,
                        height: 16,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.mic, size: 16, color: AppColors.textPrimary);
                        },
                      ),
                      onPressed: () {
                        // TODO: Implement voice input
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Submit button
          SizedBox(
            width: 320,
            child: OutlinedButton(
              onPressed: _selectedRating > 0
                  ? () {
                      widget.controller.submitFeedback(
                        rating: _selectedRating,
                        comment: _commentController.text.trim().isEmpty
                            ? null
                            : _commentController.text.trim(),
                      );
                      Get.back();
                      Get.back(); // Close feedback sheet and chat screen
                      // Show success message
                      Get.snackbar(
                        'Feedback Submitted',
                        'Thank you for your feedback!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                'Submit Feedback',
                style: AppTextStyles.button.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

