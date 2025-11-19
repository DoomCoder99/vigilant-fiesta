import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/support_chat_controller.dart';
import '../models/suggested_action.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_typing_indicator.dart';
import '../widgets/suggested_actions_row.dart';

/// Support Chat Screen
/// 
/// Main chat interface for support conversations.
/// Handles multiple states: blank, user-only, typing, multi-turn conversations.
/// Design Source: Figma frames:
/// - "Support chat - blank" (node-id: 1:29698, 1:30248)
/// - "Support chat - chat from user" (node-id: 1:29744)
/// - "Support chat - chat from user & chat activity" (node-id: 1:29796)
/// - "Support chat - chat from user & executive - 1..4" (node-id: 1:29850, 1:29909, 1:29975, 1:30047)
/// - "Support chat - Suggested actions" (node-id: 1:30125)
/// Following WDI Flutter Coding Standards.
class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportChatController());

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(controller),
      body: Column(
        children: [
          // Header with product info
          _buildHeader(controller),
          const Divider(height: 1, color: AppColors.textSecondary),

          // Chat messages area
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return _buildBlankState(controller);
              }
              return _buildChatList(controller);
            }),
          ),

          // Suggested actions (shown when applicable)
          Obx(() {
            if (controller.showSuggestedActions.value &&
                controller.messages.isNotEmpty) {
              return SuggestedActionsRow(
                actions: SuggestedAction.defaultActions,
                onActionTap: (action) {
                  controller.sendSuggestedAction(action);
                },
              );
            }
            return const SizedBox.shrink();
          }),

          // Input field
          _buildInputField(controller),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(SupportChatController controller) {
    return AppBar(
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
        onPressed: () => Get.back(),
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
        'Support',
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      actions: [
        Obx(() {
          if (controller.session.value == null) {
            return const SizedBox.shrink();
          }
          return IconButton(
            icon: Image.asset(
              'assets/support_chat/icon_more_vert.png',
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 20);
              },
            ),
            onPressed: () => _showOverflowMenu(controller),
          );
        }),
      ],
    );
  }

  Widget _buildHeader(SupportChatController controller) {
    return Obx(() {
      final productName = controller.productName ?? 'Product';
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
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
                    return const Icon(Icons.image, size: 30, color: AppColors.textPrimary);
                  },
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support for',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withValues(alpha: 0.6),
                      letterSpacing: 0.24,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    productName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBlankState(SupportChatController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Type in your concern here. Our executive will soon join the chat and help to resolve your concern.',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.textPrimary,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(SupportChatController controller) {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        reverse: false,
        itemCount: controller.messages.length +
            (controller.isAgentTyping.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.messages.length &&
              controller.isAgentTyping.value) {
            return ChatTypingIndicator(
              agentName: controller.session.value?.agentName ?? 'Support',
            );
          }

          final message = controller.messages[index];
          return ChatMessageBubble(message: message);
        },
      );
    });
  }

  Widget _buildInputField(SupportChatController controller) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border(
          top: BorderSide(color: AppColors.inputBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Image.asset(
              'assets/support_chat/icon_add.png',
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.add, color: AppColors.textPrimary, size: 16);
              },
            ),
            onPressed: () {
              // TODO: Show attachment options
            },
          ),
          Expanded(
            child: TextField(
              onChanged: (text) => controller.updateInputText(text),
              decoration: InputDecoration(
                hintText: 'Type a message..',
                hintStyle: AppTextStyles.input.copyWith(
                  color: AppColors.inputPlaceholder,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.input,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (text) {
                if (text.trim().isNotEmpty) {
                  controller.sendMessage(text);
                }
              },
            ),
          ),
          Obx(() {
            return TextButton(
              onPressed: controller.canSend
                  ? () {
                      controller.sendMessage(controller.inputText.value);
                    }
                  : null,
              child: Text(
                'Send',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                      color: controller.canSend
                          ? AppColors.primary
                          : AppColors.textSecondary,
                  letterSpacing: 0.24,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showOverflowMenu(SupportChatController controller) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => _OverflowMenuSheet(controller: controller),
    );
  }
}

/// Overflow Menu Sheet
/// 
/// Bottom sheet showing chat options (Mark as resolved, Escalate, Report, Download).
/// Design Source: Figma frame "overflow menu" (node-id: 1:30219)
class _OverflowMenuSheet extends StatelessWidget {
  final SupportChatController controller;

  const _OverflowMenuSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuOption(
            icon: Icons.check_circle,
            label: 'Mark as resolved',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement mark as resolved
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildMenuOption(
            icon: Icons.trending_up,
            label: 'Escalate',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement escalate
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildMenuOption(
            icon: Icons.flag,
            label: 'report',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement report
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildMenuOption(
            icon: Icons.download,
            label: 'download',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement download chat
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.md),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 14,
              letterSpacing: 0.28,
            ),
          ),
        ],
      ),
    );
  }
}

