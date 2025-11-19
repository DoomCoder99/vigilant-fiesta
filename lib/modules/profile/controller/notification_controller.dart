import 'package:get/get.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../data/models/notification_settings_model.dart';
import '../../../../data/repository/notification_repository.dart';

/// Notification Controller
/// 
/// Manages notification list state and settings.
/// Following WDI Flutter Coding Standards - GetX pattern.
/// 
/// Features:
/// - Error handling with user-friendly messages
/// - Retry logic for failed operations
/// - Optimistic updates for better UX
class NotificationController extends GetxController {
  final NotificationRepository _repository = NotificationRepository();

  // Notification list state
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isRetrying = false.obs;

  // Notification settings state
  final Rx<NotificationSettings> settings =
      NotificationSettings.defaultSettings.obs;
  final RxBool isSavingSettings = false.obs;
  final RxString settingsErrorMessage = ''.obs;

  // Filter state (for future tabs/filters)
  final Rx<NotificationType?> selectedFilter = Rx<NotificationType?>(null);

  // Retry configuration
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    fetchSettings();
  }

  /// Fetch notifications from repository with retry logic
  /// 
  /// Retries up to [_maxRetries] times on failure.
  Future<void> fetchNotifications({bool isRetry = false}) async {
    if (isRetry) {
      isRetrying(true);
    } else {
      isLoading(true);
    }
    
    errorMessage('');
    
    int attempt = 0;
    Exception? lastError;
    
    while (attempt < _maxRetries) {
      try {
        final fetchedNotifications = await _repository.fetchNotifications();
        notifications.assignAll(fetchedNotifications);
        errorMessage(''); // Clear any previous errors
        return; // Success, exit retry loop
      } catch (e) {
        lastError = e is Exception ? e : Exception(e.toString());
        attempt++;
        
        if (attempt < _maxRetries) {
          // Wait before retrying
          await Future.delayed(_retryDelay);
        }
      }
    }
    
    // All retries failed
    final errorMsg = _getErrorMessage(lastError);
    errorMessage(errorMsg);
    
    // Show error toast
    Get.snackbar(
      'Error',
      errorMsg,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  /// Retry fetching notifications
  Future<void> retryFetchNotifications() async {
    await fetchNotifications(isRetry: true);
    isRetrying(false);
  }

  /// Mark a notification as read with error handling
  Future<void> markAsRead(String notificationId) async {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;

    // Optimistic update
    final originalNotification = notifications[index];
    notifications[index] = originalNotification.copyWith(isRead: true);

    try {
      await _repository.markAsRead(notificationId);
    } catch (e) {
      // Revert optimistic update on error
      notifications[index] = originalNotification;
      
      // Show error toast
      Get.snackbar(
        'Error',
        'Failed to mark notification as read. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      
      // Log error (TODO: Replace with proper logging service)
      print('Error marking notification as read: $e');
    }
  }

  /// Mark all notifications as read with error handling
  Future<void> markAllAsRead() async {
    if (notifications.isEmpty) return;

    // Optimistic update
    final originalNotifications = notifications.toList();
    notifications.assignAll(
      notifications.map((n) => n.copyWith(isRead: true)).toList(),
    );

    try {
      await _repository.markAllAsRead();
      
      // Show success toast
      Get.snackbar(
        'Success',
        'All notifications marked as read',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      // Revert optimistic update on error
      notifications.assignAll(originalNotifications);
      
      // Show error toast
      Get.snackbar(
        'Error',
        'Failed to mark all notifications as read. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      
      // Log error (TODO: Replace with proper logging service)
      print('Error marking all notifications as read: $e');
    }
  }

  /// Fetch notification settings with error handling
  Future<void> fetchSettings() async {
    try {
      final fetchedSettings = await _repository.fetchSettings();
      settings.value = fetchedSettings;
      settingsErrorMessage('');
    } catch (e) {
      // Use defaults on error, don't show error to user (settings are not critical)
      settings.value = NotificationSettings.defaultSettings;
      settingsErrorMessage('');
      
      // Log error silently (TODO: Replace with proper logging service)
      print('Error fetching notification settings: $e');
    }
  }

  /// Update notification settings with retry logic and error handling
  Future<void> updateSettings(NotificationSettings newSettings) async {
    // Optimistic update
    final originalSettings = settings.value;
    settings.value = newSettings;
    settingsErrorMessage('');
    
    isSavingSettings(true);
    
    int attempt = 0;
    Exception? lastError;
    
    while (attempt < _maxRetries) {
      try {
        await _repository.updateSettings(newSettings);
        // Success - settings already updated optimistically
        return;
      } catch (e) {
        lastError = e is Exception ? e : Exception(e.toString());
        attempt++;
        
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      }
    }
    
    // All retries failed - revert optimistic update
    settings.value = originalSettings;
    final errorMsg = _getErrorMessage(lastError);
    settingsErrorMessage(errorMsg);
    
    // Show error toast
    Get.snackbar(
      'Error',
      'Failed to save notification settings. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    
    // Re-throw to allow UI to handle if needed
    throw lastError ?? Exception('Failed to update settings');
  }

  /// Retry updating settings
  Future<void> retryUpdateSettings() async {
    await updateSettings(settings.value);
  }

  /// Get user-friendly error message from exception
  String _getErrorMessage(Exception? error) {
    if (error == null) {
      return 'An unexpected error occurred. Please try again.';
    }
    
    final errorString = error.toString().toLowerCase();
    
    // Network-related errors
    if (errorString.contains('network') || 
        errorString.contains('connection') ||
        errorString.contains('timeout') ||
        errorString.contains('socket')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    
    // Server errors
    if (errorString.contains('500') || errorString.contains('server')) {
      return 'Server error. Please try again later.';
    }
    
    // Authentication errors
    if (errorString.contains('401') || errorString.contains('unauthorized')) {
      return 'Authentication failed. Please sign in again.';
    }
    
    // Permission errors
    if (errorString.contains('403') || errorString.contains('forbidden')) {
      return 'You don\'t have permission to perform this action.';
    }
    
    // Not found errors
    if (errorString.contains('404') || errorString.contains('not found')) {
      return 'Resource not found.';
    }
    
    // Generic error
    return 'Failed to load notifications. Please try again.';
  }

  /// Filter notifications by type
  List<NotificationModel> get filteredNotifications {
    if (selectedFilter.value == null) {
      return notifications.toList();
    }
    return notifications
        .where((n) => n.type == selectedFilter.value)
        .toList();
  }

  /// Check if there are unread notifications
  bool get hasUnreadNotifications {
    return notifications.any((n) => !n.isRead);
  }

  /// Get unread count
  int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }

  /// Check if there's an active error
  bool get hasError => errorMessage.value.isNotEmpty || settingsErrorMessage.value.isNotEmpty;

  /// Clear all errors
  void clearErrors() {
    errorMessage('');
    settingsErrorMessage('');
  }
}

