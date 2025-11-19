import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Select Slot Drawer Explore Widget
/// 
/// Bottom sheet for selecting slot exploration mode.
/// Design Source: Figma frame "Select slot drawer – explore" (node-id: 1-16608)
class SelectSlotDrawerExplore extends StatelessWidget {
  final Function(String mode)? onModeSelected; // 'explore' or 'specific'

  const SelectSlotDrawerExplore({
    super.key,
    this.onModeSelected,
  });

  static void show(
    BuildContext context, {
    Function(String mode)? onModeSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectSlotDrawerExplore(onModeSelected: onModeSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xxl,
        AppSpacing.lg,
        AppSpacing.xxxxl,
      ),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select a slot',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Image.asset(
                  'assets/subscriptions/icons/close_small.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // Option 1: Let Me Explore
          _buildOption(
            context,
            title: 'Let me explore',
            subtitle: 'I\'ll choose the available slots',
            icon: Icons.bolt,
            iconBackgroundColor: AppColors.primary,
            isSelected: true,
            onTap: () {
              Navigator.of(context).pop();
              onModeSelected?.call('explore');
            },
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Option 2: Book A Specific Slot
          _buildOption(
            context,
            title: 'Book A Specific Slot',
            subtitle: 'I have a preferred date & time',
            icon: Icons.calendar_today,
            iconBackgroundColor: AppColors.backgroundWhite,
            isSelected: false,
            onTap: () {
              Navigator.of(context).pop();
              onModeSelected?.call('specific');
            },
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onModeSelected?.call('explore');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'Continue To Explore',
                style: AppTextStyles.button.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBackgroundColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(
            color: const Color(0xFFD6DEE8),
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(28),
                border: iconBackgroundColor == AppColors.backgroundWhite
                    ? Border.all(color: const Color(0xFFD6DEE8))
                    : null,
              ),
              child: Icon(
                icon,
                size: 16,
                color: iconBackgroundColor == AppColors.primary
                    ? AppColors.backgroundWhite
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : const Color(0xFFD6DEE8),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

