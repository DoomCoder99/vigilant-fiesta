/// Subscription Slot Selection Model
/// 
/// Represents selected time slots for a subscription.
/// Following WDI Flutter Coding Standards.
class SubscriptionSlotSelectionModel {
  final List<int> daysOfWeek; // 0 = Sunday, 1 = Monday, ..., 6 = Saturday
  final String timeRange; // e.g., "08:00 - 09:00 AM"
  final DateTime startDate;
  final DateTime? endDate; // Optional end date for subscription
  final bool isRecurring;

  SubscriptionSlotSelectionModel({
    required this.daysOfWeek,
    required this.timeRange,
    required this.startDate,
    this.endDate,
    this.isRecurring = true,
  });

  factory SubscriptionSlotSelectionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionSlotSelectionModel(
      daysOfWeek: (json['days_of_week'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      timeRange: json['time_range'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      isRecurring: json['is_recurring'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days_of_week': daysOfWeek,
      'time_range': timeRange,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_recurring': isRecurring,
    };
  }

  String get daysOfWeekDisplay {
    const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final selectedDays = daysOfWeek.map((d) => dayNames[d]).join(', ');
    return selectedDays;
  }
}

