import 'package:get/get.dart';
import '../models/quick_trigger_state.dart';

/// Quick Trigger Controller
/// 
/// Manages the state and behavior of the Quick Trigger floating button
/// and Service Information overlay.
/// 
/// State Management:
/// - Tracks current service order context (id, time, agent info)
/// - Manages Quick Trigger overlay state (onTheDay, minimized, onCompletion, thanks)
/// - Controls visibility of floating button based on service order status
class QuickTriggerController extends GetxController {
  // Current Quick Trigger state
  final Rx<QuickTriggerState> currentState = QuickTriggerState.onTheDay.obs;
  
  // Current active service order context
  final Rxn<String> currentOrderId = Rxn<String>();
  final Rxn<String> serviceName = Rxn<String>();
  final Rxn<String> agentName = Rxn<String>();
  final Rxn<String> agentId = Rxn<String>();
  final Rxn<String> agencyName = Rxn<String>();
  final Rxn<String> arrivalTime = Rxn<String>();
  final Rxn<double> agentRating = Rxn<double>();
  final Rxn<String> agentAvatarUrl = Rxn<String>();
  
  // Whether the floating button should be visible
  final RxBool isVisible = false.obs;
  
  // Whether the overlay is currently expanded (not minimized)
  final RxBool isExpanded = true.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: Initialize from service order data when available
    // For now, using mock data for testing
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock data - replace with actual service order data
    currentOrderId.value = 'ORD-12345';
    serviceName.value = 'Switch / Socket Repair & Replacement';
    agentName.value = 'Mehdi Hasan';
    agentId.value = 'EXEC-001';
    agencyName.value = 'Service agency name';
    arrivalTime.value = '08:00 am';
    agentRating.value = 4.5;
    agentAvatarUrl.value = 'assets/quick_trigger/agent_avatar.png';
    
    // Set initial state based on service status
    // TODO: Determine state from actual service order status
    currentState.value = QuickTriggerState.onTheDay;
    isVisible.value = true;
    isExpanded.value = true;
  }

  /// Set the active service order and update Quick Trigger state
  void setActiveServiceOrder({
    required String orderId,
    String? serviceName,
    String? agentName,
    String? agentId,
    String? agencyName,
    String? arrivalTime,
    double? agentRating,
    String? agentAvatarUrl,
    required QuickTriggerState state,
  }) {
    currentOrderId.value = orderId;
    this.serviceName.value = serviceName;
    this.agentName.value = agentName;
    this.agentId.value = agentId;
    this.agencyName.value = agencyName;
    this.arrivalTime.value = arrivalTime;
    this.agentRating.value = agentRating;
    this.agentAvatarUrl.value = agentAvatarUrl;
    
    currentState.value = state;
    isVisible.value = true;
    isExpanded.value = state != QuickTriggerState.minimized;
  }

  /// Clear the active service order and hide Quick Trigger
  void clearActiveServiceOrder() {
    currentOrderId.value = null;
    serviceName.value = null;
    agentName.value = null;
    agentId.value = null;
    agencyName.value = null;
    arrivalTime.value = null;
    agentRating.value = null;
    agentAvatarUrl.value = null;
    
    isVisible.value = false;
    isExpanded.value = false;
  }

  /// Expand the overlay (from minimized state)
  void expandOverlay() {
    if (currentState.value == QuickTriggerState.minimized) {
      // Restore to previous state (onTheDay or onCompletion)
      // For now, defaulting to onTheDay - TODO: track previous state
      currentState.value = QuickTriggerState.onTheDay;
      isExpanded.value = true;
    }
  }

  /// Minimize the overlay
  void minimizeOverlay() {
    currentState.value = QuickTriggerState.minimized;
    isExpanded.value = false;
  }

  /// Transition to completion state
  void transitionToCompletion() {
    currentState.value = QuickTriggerState.onCompletion;
    isExpanded.value = true;
  }

  /// Transition to thanks state (after review submission)
  void transitionToThanks() {
    currentState.value = QuickTriggerState.thanks;
    isExpanded.value = true;
    
    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (currentState.value == QuickTriggerState.thanks) {
        clearActiveServiceOrder();
      }
    });
  }

  /// Toggle overlay expansion (expand if minimized, minimize if expanded)
  void toggleOverlay() {
    if (currentState.value == QuickTriggerState.minimized) {
      expandOverlay();
    } else {
      minimizeOverlay();
    }
  }
}

