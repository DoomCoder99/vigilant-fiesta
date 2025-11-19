/// Support Chat Session Model
/// 
/// Represents a support chat session linked to an order.
/// Following WDI Flutter Coding Standards.
class SupportChatSession {
  final String id;
  final String? orderId;
  final String? productName;
  final ChatSessionStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? agentName;
  final bool isAgentTyping;

  SupportChatSession({
    required this.id,
    this.orderId,
    this.productName,
    this.status = ChatSessionStatus.active,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.agentName,
    this.isAgentTyping = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  SupportChatSession copyWith({
    String? id,
    String? orderId,
    String? productName,
    ChatSessionStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? agentName,
    bool? isAgentTyping,
  }) {
    return SupportChatSession(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agentName: agentName ?? this.agentName,
      isAgentTyping: isAgentTyping ?? this.isAgentTyping,
    );
  }
}

/// Chat session status
enum ChatSessionStatus {
  connecting,
  active,
  ended,
  closed,
}

