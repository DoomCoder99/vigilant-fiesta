import 'package:get/get.dart';
import '../models/chat_message.dart';
import '../models/support_chat_session.dart';
import '../models/suggested_action.dart';
import '../repository/support_repository.dart';

/// Support Chat Controller
/// 
/// Manages support chat state and business logic.
/// Following WDI Flutter Coding Standards - GetX pattern.
class SupportChatController extends GetxController {
  final SupportRepository _repository = SupportRepository();

  // Session state
  final Rxn<SupportChatSession> session = Rxn<SupportChatSession>();
  final RxBool isLoadingSession = false.obs;
  final RxString sessionError = ''.obs;

  // Messages state
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoadingMessages = false.obs;

  // UI state
  final RxBool isAgentTyping = false.obs;
  final RxBool showSuggestedActions = true.obs;
  final RxString inputText = ''.obs;

  // Order context
  String? orderId;
  String? productName;

  @override
  void onInit() {
    super.onInit();
    // Get order context from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    orderId = args?['orderId'] as String?;
    productName = args?['productName'] as String?;
    
    if (orderId != null) {
      startChat();
    }
  }

  /// Start a new chat session
  Future<void> startChat() async {
    if (orderId == null) return;

    isLoadingSession.value = true;
    sessionError.value = '';

    try {
      final newSession = await _repository.startChat(
        orderId: orderId!,
        productName: productName,
      );
      session.value = newSession;
      
      // Simulate agent joining after a delay
      _simulateAgentJoin();
    } catch (e) {
      sessionError.value = 'Failed to start chat. Please try again.';
    } finally {
      isLoadingSession.value = false;
    }
  }

  /// Send a message
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || session.value == null) return;

    final message = ChatMessage.user(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      sessionId: session.value!.id,
      text: text.trim(),
    );

    // Add message optimistically
    messages.add(message);
    inputText.value = '';
    showSuggestedActions.value = false;

    // Scroll to bottom will be handled by the view

    try {
      // Send to backend
      await _repository.sendMessage(
        sessionId: session.value!.id,
        text: text.trim(),
      );

      // Update message status
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = ChatMessage.user(
          id: message.id,
          sessionId: message.sessionId,
          text: message.text,
          timestamp: message.timestamp,
          status: MessageStatus.delivered,
        );
      }

      // Simulate agent response after delay
      _simulateAgentResponse();
    } catch (e) {
      // Handle error - could show retry option
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = ChatMessage.user(
          id: message.id,
          sessionId: message.sessionId,
          text: message.text,
          timestamp: message.timestamp,
          status: MessageStatus.sending,
        );
      }
    }
  }

  /// Send a suggested action
  void sendSuggestedAction(SuggestedAction action) {
    sendMessage(action.payload);
  }

  /// Simulate agent joining the chat
  void _simulateAgentJoin() {
    Future.delayed(const Duration(seconds: 2), () {
      if (session.value == null) return;

      final joinMessage = ChatMessage.system(
        id: 'sys_${DateTime.now().millisecondsSinceEpoch}',
        sessionId: session.value!.id,
        text: 'Agent John Doe joined this chat.',
      );
      messages.add(joinMessage);

      // Update session with agent name
      session.value = session.value!.copyWith(
        agentName: 'John Doe',
        status: ChatSessionStatus.active,
      );
    });
  }

  /// Simulate agent typing indicator
  void _simulateAgentResponse() {
    isAgentTyping.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isAgentTyping.value = false;

      if (session.value == null) return;

      // Add a mock agent response
      final agentMessage = ChatMessage.executive(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        sessionId: session.value!.id,
        text: 'Good morning, Sir. Just wanted to confirm your mobile handset model. Could you share the brand and model of your handset, please?',
        agentName: session.value!.agentName ?? 'Support',
      );
      messages.add(agentMessage);
    });
  }

  /// End the chat session
  Future<void> endChat() async {
    if (session.value == null) return;

    try {
      await _repository.endChat(session.value!.id);
      session.value = session.value!.copyWith(
        status: ChatSessionStatus.ended,
      );

      // Add system message
      final closeMessage = ChatMessage.system(
        id: 'sys_${DateTime.now().millisecondsSinceEpoch}',
        sessionId: session.value!.id,
        text: 'Agent ${session.value!.agentName ?? 'Support'} closed this chat.',
      );
      messages.add(closeMessage);
    } catch (e) {
      // Handle error
    }
  }

  /// Submit feedback
  Future<void> submitFeedback({
    required int rating,
    String? comment,
  }) async {
    if (session.value == null) return;

    try {
      await _repository.submitFeedback(
        sessionId: session.value!.id,
        rating: rating,
        comment: comment,
      );
    } catch (e) {
      // Handle error
    }
  }

  /// Update input text
  void updateInputText(String text) {
    inputText.value = text;
  }

  /// Check if send button should be enabled
  bool get canSend => inputText.value.trim().isNotEmpty;

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}

