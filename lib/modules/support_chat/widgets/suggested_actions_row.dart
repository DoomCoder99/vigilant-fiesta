import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/suggested_action.dart';

/// Suggested Actions Row Widget
/// 
/// Displays quick action chips for common support actions.
/// Following WDI Flutter Coding Standards.
class SuggestedActionsRow extends StatelessWidget {
  final List<SuggestedAction> actions;
  final Function(SuggestedAction) onActionTap;

  const SuggestedActionsRow({
    super.key,
    required this.actions,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return _SuggestedActionChip(
            action: action,
            onTap: () => onActionTap(action),
          );
        }).toList(),
      ),
    );
  }
}

class _SuggestedActionChip extends StatelessWidget {
  final SuggestedAction action;
  final VoidCallback onTap;

  const _SuggestedActionChip({
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              action.label,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Icon placeholder - will be replaced with actual icons from assets
            Icon(
              _getIconForAction(action.id),
              size: 12,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForAction(String actionId) {
    switch (actionId) {
      case 'mark_resolved':
        return Icons.check_circle;
      case 'escalate':
        return Icons.trending_up;
      case 'report':
        return Icons.flag;
      default:
        return Icons.help_outline;
    }
  }
}

