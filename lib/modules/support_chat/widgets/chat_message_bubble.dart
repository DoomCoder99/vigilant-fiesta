import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../models/chat_message.dart';

/// Chat Message Bubble Widget
/// 
/// Displays a single chat message bubble (user or executive).
/// Following WDI Flutter Coding Standards.
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showTimestamp;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showTimestamp = true,
  });

  @override
  Widget build(BuildContext context) {
    final isFromUser = message.from == MessageSender.user;
    final isSystem = message.from == MessageSender.system;

    if (isSystem) {
      return _buildSystemMessage();
    }

    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: EdgeInsets.only(
          left: isFromUser ? 80 : 0,
          right: isFromUser ? 0 : 80,
          bottom: AppSpacing.md,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isFromUser
              ? const Color(0xFFE7DCFF) // User bubble color
              : const Color(0xFFF6F6F6), // Executive bubble color
          border: Border.all(
            color: isFromUser
                ? const Color(0xFFC9AFFF) // User border
                : const Color(0xFFDEDEDE), // Executive border
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: message.from == MessageSender.executive ? 11 : 12,
                color: AppColors.textPrimary,
              ),
            ),
            if (showTimestamp) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.formattedTime,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 9,
                      color: AppColors.textPrimary.withValues(alpha: 0.3),
                      letterSpacing: 0.18,
                    ),
                  ),
                  if (isFromUser) ...[
                    const SizedBox(width: AppSpacing.xs),
                    _buildStatusIcon(),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        border: Border.all(
          color: const Color(0xFFD5D5D5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        message.text,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 11,
          fontStyle: FontStyle.italic,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    // Status icon (check mark for delivered/read)
    return Image.asset(
      'assets/support_chat/icon_check_done_all.png',
      width: 12,
      height: 12,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(width: 12, height: 12);
      },
    );
  }
}

