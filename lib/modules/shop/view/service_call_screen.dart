import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Service Call Screen
/// 
/// Displays service agent call UI with different states:
/// - Outgoing call - waiting to pickup (ringing)
/// - Outgoing call - on call
/// - Incoming call - ringing
/// - Incoming call - on call
/// Design Source: Figma frames:
/// - "Outgoing call, waiting to pickup" (node-id: 1-30911)
/// - "Outgoing call, on call" (node-id: 1-31002)
/// - "Incoming call, ringing" (node-id: 1-30951)
/// - "Incoming call, on call" (node-id: 1-31043)
class ServiceCallScreen extends StatefulWidget {
  final String? orderId;
  final String? callType; // 'outgoing' or 'incoming'
  final String? callState; // 'ringing' or 'onCall'
  final String? agentName;

  const ServiceCallScreen({
    super.key,
    this.orderId,
    this.callType,
    this.callState,
    this.agentName,
  });

  @override
  State<ServiceCallScreen> createState() => _ServiceCallScreenState();
}

class _ServiceCallScreenState extends State<ServiceCallScreen> {
  Timer? _callTimer;
  int _callDurationSeconds = 0;
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  bool get _isOnCall => widget.callState == 'onCall';

  @override
  void initState() {
    super.initState();
    if (_isOnCall) {
      _startCallTimer();
    }
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _callDurationSeconds++;
      });
    });
  }

  String _formatCallDuration() {
    final minutes = _callDurationSeconds ~/ 60;
    final seconds = _callDurationSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _handleAccept() {
    setState(() {
      // Transition to on-call state
    });
    _startCallTimer();
    // TODO: Accept call via telephony service
  }

  void _handleReject() {
    Navigator.of(context).pop();
    // TODO: Reject call via telephony service
  }

  void _handleEndCall() {
    _callTimer?.cancel();
    Navigator.of(context).pop();
    // TODO: End call via telephony service
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    // TODO: Toggle mute via telephony service
  }

  void _toggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
    // TODO: Toggle speaker via telephony service
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final displayCallType = widget.callType ?? args?['callType'] ?? 'outgoing';
    final displayCallState = widget.callState ?? args?['callState'] ?? 'ringing';
    final displayAgentName = widget.agentName ?? args?['agentName'] ?? 'Mehdi Hasan';

    final isOutgoing = displayCallType == 'outgoing';
    final isRinging = displayCallState == 'ringing';
    final isOnCall = displayCallState == 'onCall';

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar area (spacer)
            const SizedBox(height: 32),
            // Agent avatar and name
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Agent avatar
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background circle
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6D1B0),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/my_orders/service_actions/agent_avatar.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: AppColors.textPrimary,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Agent name
                    Text(
                      displayAgentName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 28,
                        letterSpacing: 0.56,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Call status or timer
                    if (isRinging)
                      Text(
                        isOutgoing ? 'Ringing..' : 'Calling..',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.2,
                        ),
                      )
                    else
                      Text(
                        _formatCallDuration(),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.2,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Call controls
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxxxl),
              child: _buildCallControls(isOutgoing, isRinging, isOnCall),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControls(bool isOutgoing, bool isRinging, bool isOnCall) {
    if (isRinging && !isOutgoing) {
      // Incoming call - Accept/Reject buttons
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Accept button
          GestureDetector(
            onTap: _handleAccept,
            child: Container(
              width: 114,
              height: 114,
              decoration: BoxDecoration(
                color: const Color(0xFF28B446),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/my_orders/service_actions/icon_call.png',
                  width: 24,
                  height: 24,
                  color: AppColors.backgroundWhite,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.call,
                      size: 24,
                      color: AppColors.backgroundWhite,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Reject button
          GestureDetector(
            onTap: _handleReject,
            child: Container(
              width: 114,
              height: 114,
              decoration: BoxDecoration(
                color: const Color(0xFFE64040),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/my_orders/service_actions/icon_call_end.png',
                  width: 24,
                  height: 24,
                  color: AppColors.backgroundWhite,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.call_end,
                      size: 24,
                      color: AppColors.backgroundWhite,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    } else if (isRinging && isOutgoing) {
      // Outgoing call - waiting to pickup
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Speaker button
          _buildControlButton(
            icon: 'assets/my_orders/service_actions/icon_volume_up.png',
            onTap: _toggleSpeaker,
            isActive: _isSpeakerOn,
          ),
          const SizedBox(width: AppSpacing.lg),
          // End call button
          _buildControlButton(
            icon: 'assets/my_orders/service_actions/icon_call_end.png',
            onTap: _handleEndCall,
            isActive: true,
            backgroundColor: const Color(0xFFE64040),
          ),
        ],
      );
    } else {
      // On call - Mute, Speaker, End call
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mute button
          _buildControlButton(
            icon: _isMuted
                ? 'assets/my_orders/service_actions/icon_mic_off.png'
                : 'assets/my_orders/service_actions/icon_mic.png',
            onTap: _toggleMute,
            isActive: _isMuted,
          ),
          const SizedBox(width: AppSpacing.lg),
          // Speaker button
          _buildControlButton(
            icon: 'assets/my_orders/service_actions/icon_volume_up.png',
            onTap: _toggleSpeaker,
            isActive: _isSpeakerOn,
          ),
          const SizedBox(width: AppSpacing.lg),
          // End call button
          _buildControlButton(
            icon: 'assets/my_orders/service_actions/icon_call_end.png',
            onTap: _handleEndCall,
            isActive: true,
            backgroundColor: const Color(0xFFE64040),
          ),
        ],
      );
    }
  }

  Widget _buildControlButton({
    required String icon,
    required VoidCallback onTap,
    bool isActive = false,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: backgroundColor ?? (isActive ? AppColors.primary : Colors.transparent),
          border: backgroundColor == null
              ? Border.all(color: AppColors.textSecondary)
              : null,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: 24,
            height: 24,
            color: backgroundColor != null
                ? AppColors.backgroundWhite
                : (isActive ? AppColors.primary : AppColors.textPrimary),
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.settings,
                size: 24,
                color: backgroundColor != null
                    ? AppColors.backgroundWhite
                    : (isActive ? AppColors.primary : AppColors.textPrimary),
              );
            },
          ),
        ),
      ),
    );
  }
}

