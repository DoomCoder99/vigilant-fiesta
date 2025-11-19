/// Notification Model
/// 
/// Represents a single notification item.
/// Design Source: Figma frames "Notifications" (node-id: 1-11457, 1-11702, 1-11347)
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final String? actionText;
  final String? actionRoute;
  final Map<String, dynamic>? actionArguments;
  final String iconPath;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.actionText,
    this.actionRoute,
    this.actionArguments,
    required this.iconPath,
    required this.type,
    this.isRead = false,
    required this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? timestamp,
    String? actionText,
    String? actionRoute,
    Map<String, dynamic>? actionArguments,
    String? iconPath,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      actionText: actionText ?? this.actionText,
      actionRoute: actionRoute ?? this.actionRoute,
      actionArguments: actionArguments ?? this.actionArguments,
      iconPath: iconPath ?? this.iconPath,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
      actionText: json['actionText'] as String?,
      actionRoute: json['actionRoute'] as String?,
      actionArguments: json['actionArguments'] as Map<String, dynamic>?,
      iconPath: json['iconPath'] as String,
      type: NotificationType.fromString(json['type'] as String),
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp,
      'actionText': actionText,
      'actionRoute': actionRoute,
      'actionArguments': actionArguments,
      'iconPath': iconPath,
      'type': type.toString(),
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

/// Notification Type Enum
enum NotificationType {
  order,
  rental,
  service,
  profile,
  promotion,
  wishlist,
  system;

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (type) => type.toString() == value,
      orElse: () => NotificationType.system,
    );
  }

  @override
  String toString() {
    return name;
  }
}

