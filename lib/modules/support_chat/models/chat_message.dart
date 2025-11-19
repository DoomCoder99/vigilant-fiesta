/// Chat Message Model
/// 
/// Represents a single message in a support chat conversation.
/// Following WDI Flutter Coding Standards.
class ChatMessage {
  final String id;
  final String sessionId;
  final MessageSender from;
  final String text;
  final DateTime timestamp;
  final bool isRead;
  final MessageStatus status;
  final Map<String, dynamic>? meta;

  ChatMessage({
    required this.id,
    required this.sessionId,
    required this.from,
    required this.text,
    required this.timestamp,
    this.isRead = false,
    this.status = MessageStatus.sent,
    this.meta,
  });

  /// Create a user message
  factory ChatMessage.user({
    required String id,
    required String sessionId,
    required String text,
    DateTime? timestamp,
    MessageStatus status = MessageStatus.sent,
  }) {
    return ChatMessage(
      id: id,
      sessionId: sessionId,
      from: MessageSender.user,
      text: text,
      timestamp: timestamp ?? DateTime.now(),
      status: status,
    );
  }

  /// Create an executive/agent message
  factory ChatMessage.executive({
    required String id,
    required String sessionId,
    required String text,
    DateTime? timestamp,
    String? agentName,
  }) {
    return ChatMessage(
      id: id,
      sessionId: sessionId,
      from: MessageSender.executive,
      text: text,
      timestamp: timestamp ?? DateTime.now(),
      meta: agentName != null ? {'agentName': agentName} : null,
    );
  }

  /// Create a system message (e.g., "Agent joined", "Chat closed")
  factory ChatMessage.system({
    required String id,
    required String sessionId,
    required String text,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id,
      sessionId: sessionId,
      from: MessageSender.system,
      text: text,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  /// Format timestamp for display (e.g., "10:03")
  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Get agent name if available
  String? get agentName => meta?['agentName'] as String?;
}

/// Message sender type
enum MessageSender {
  user,
  executive,
  system,
}

/// Message delivery status
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
}

