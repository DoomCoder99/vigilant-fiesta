import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Chat Typing Indicator Widget
/// 
/// Shows "Agent is typing..." indicator.
/// Following WDI Flutter Coding Standards.
class ChatTypingIndicator extends StatelessWidget {
  final String agentName;

  const ChatTypingIndicator({
    super.key,
    required this.agentName,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          top: AppSpacing.sm,
        ),
        child: Text(
          '$agentName is typing...',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

