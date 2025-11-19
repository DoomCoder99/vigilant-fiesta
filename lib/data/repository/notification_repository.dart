import '../models/notification_model.dart';
import '../models/notification_settings_model.dart';

/// Notification Repository
/// 
/// Handles notification data operations.
/// Following WDI Flutter Coding Standards - API layer pattern.
class NotificationRepository {
  // TODO: Replace with actual API service integration
  // static const String baseUrl = "https://api.example.com/";

  /// Fetch all notifications
  /// 
  /// Returns a list of notifications sorted by creation date (newest first).
  /// TODO: Replace mock data with actual API call using ApiService.callApi
  Future<List<NotificationModel>> fetchNotifications() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data matching Figma design (State C - node-id: 1-11347)
    return [
      NotificationModel(
        id: '1',
        title: 'Rent a vehicle',
        message:
            'Your pickup for Toyota Camry is scheduled for tomorrow, 20 Sep 2025',
        timestamp: 'Today, 10:20am',
        actionText: null,
        actionRoute: null,
        iconPath: 'assets/notifications/rent_vehicle.png',
        type: NotificationType.rental,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'Arriving today!',
        message:
            'Dervin UV Protection Square Flat Lens Sunglasses is out for delivery.',
        timestamp: 'Today, 08:10am',
        actionText: 'Track Order',
        actionRoute: '/tracking',
        actionArguments: {'orderId': '456'},
        iconPath: 'assets/notifications/delivery.png',
        type: NotificationType.order,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      NotificationModel(
        id: '3',
        title: 'Profile incomplete.',
        message: 'Your profile is missing information like Address.',
        timestamp: '28 Sep, 04:30pm',
        actionText: 'Complete now',
        actionRoute: '/profile-edit',
        iconPath: 'assets/notifications/profile.png',
        type: NotificationType.profile,
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    // TODO: Replace with actual API call:
    // final response = await ApiService.callApi(
    //   endpoint: 'notifications',
    //   type: ApiType.get,
    // );
    // return (response['data'] as List)
    //     .map((json) => NotificationModel.fromJson(json))
    //     .toList();
  }

  /// Mark a notification as read
  /// 
  /// TODO: Replace with actual API call
  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // TODO: Replace with actual API call:
    // await ApiService.callApi(
    //   endpoint: 'notifications/$notificationId/read',
    //   type: ApiType.put,
    // );
  }

  /// Mark all notifications as read
  /// 
  /// TODO: Replace with actual API call
  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // TODO: Replace with actual API call:
    // await ApiService.callApi(
    //   endpoint: 'notifications/read-all',
    //   type: ApiType.put,
    // );
  }

  /// Fetch notification settings
  /// 
  /// TODO: Replace with SharedPreferences or secure storage for persistence
  Future<NotificationSettings> fetchSettings() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // TODO: Load from SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // final settingsJson = prefs.getString('notification_settings');
    // if (settingsJson != null) {
    //   return NotificationSettings.fromJson(jsonDecode(settingsJson));
    // }
    return NotificationSettings.defaultSettings;
  }

  /// Update notification settings
  /// 
  /// TODO: Replace with SharedPreferences or secure storage for persistence
  /// TODO: Sync with backend API
  Future<void> updateSettings(NotificationSettings settings) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: Save to SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString(
    //   'notification_settings',
    //   jsonEncode(settings.toJson()),
    // );
    // TODO: Sync with backend:
    // await ApiService.callApi(
    //   endpoint: 'notification-settings',
    //   type: ApiType.put,
    //   body: settings.toJson(),
    // );
  }
}

