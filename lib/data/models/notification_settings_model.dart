/// Notification Settings Model
/// 
/// Represents user notification preferences.
/// Design Source: Figma frame "Notification settings" (node-id: 1-11405)
class NotificationSettings {
  final bool pushNotificationsEnabled;
  final bool wishlistUpdatesEnabled;
  final bool serviceNotificationsEnabled;
  final bool emailNotificationsEnabled;

  const NotificationSettings({
    this.pushNotificationsEnabled = true,
    this.wishlistUpdatesEnabled = false,
    this.serviceNotificationsEnabled = true,
    this.emailNotificationsEnabled = false,
  });

  NotificationSettings copyWith({
    bool? pushNotificationsEnabled,
    bool? wishlistUpdatesEnabled,
    bool? serviceNotificationsEnabled,
    bool? emailNotificationsEnabled,
  }) {
    return NotificationSettings(
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      wishlistUpdatesEnabled:
          wishlistUpdatesEnabled ?? this.wishlistUpdatesEnabled,
      serviceNotificationsEnabled:
          serviceNotificationsEnabled ?? this.serviceNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
    );
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] as bool? ?? true,
      wishlistUpdatesEnabled: json['wishlistUpdatesEnabled'] as bool? ?? false,
      serviceNotificationsEnabled:
          json['serviceNotificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['emailNotificationsEnabled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'wishlistUpdatesEnabled': wishlistUpdatesEnabled,
      'serviceNotificationsEnabled': serviceNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
    };
  }

  /// Default settings matching Figma design
  static const NotificationSettings defaultSettings = NotificationSettings(
    pushNotificationsEnabled: true,
    wishlistUpdatesEnabled: false,
    serviceNotificationsEnabled: true,
    emailNotificationsEnabled: false,
  );
}

