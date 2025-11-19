/// Tracking Step Model
/// 
/// Represents a single step in the order tracking timeline.
class TrackingStep {
  final String label;
  final String value;
  final bool isCompleted;
  final DateTime? timestamp;

  const TrackingStep({
    required this.label,
    required this.value,
    required this.isCompleted,
    this.timestamp,
  });
}

