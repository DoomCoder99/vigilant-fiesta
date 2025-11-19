/// Quick Trigger State Enum
/// 
/// Represents the different states of the Quick Trigger overlay:
/// - onTheDay: Service is scheduled for today and is active/upcoming
/// - minimized: Overlay has been manually minimized by user
/// - onCompletion: Service has been completed but user hasn't acknowledged/dismissed
/// - thanks: Final acknowledgment state after review/feedback submission
enum QuickTriggerState {
  onTheDay,
  minimized,
  onCompletion,
  thanks,
}

