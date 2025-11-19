/// Suggested Action Model
/// 
/// Represents a quick reply suggestion in the support chat.
/// Following WDI Flutter Coding Standards.
class SuggestedAction {
  final String id;
  final String label;
  final String payload; // The text to send when tapped

  const SuggestedAction({
    required this.id,
    required this.label,
    required this.payload,
  });

  /// Default suggested actions for support chat
  static List<SuggestedAction> get defaultActions => [
        const SuggestedAction(
          id: 'mark_resolved',
          label: 'Mark as resolved',
          payload: 'Mark as resolved',
        ),
        const SuggestedAction(
          id: 'escalate',
          label: 'Escalate',
          payload: 'Escalate',
        ),
        const SuggestedAction(
          id: 'report',
          label: 'Report',
          payload: 'Report',
        ),
      ];
}

