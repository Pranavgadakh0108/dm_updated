import 'dart:async';
import 'package:dmboss/service/get_notifications_model.dart';
import 'package:dmboss/service/notification_send_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmboss/model/notification_model.dart';
import 'package:workmanager/workmanager.dart';

class NotificationPollingService {
  static const String checkNotificationsTask = "checkNotificationsTask";
  static Timer? _pollingTimer;
  static List<String> _knownNotificationIds = [];
  static DateTime? _lastChecked;

  // Background callback handler - Moved outside the class as a top-level function
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      print("Workmanager task executed: $task");

      switch (task) {
        case checkNotificationsTask:
          await checkForNewNotifications();
          return true;
        default:
          return false;
      }
    });
  }

  static Future<void> initialize() async {
    await _loadKnownNotifications();
    await _loadLastCheckedTime();

    // Initialize Workmanager with the callback dispatcher
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

    // Register the background task
    await _registerBackgroundTask();

    // Start foreground polling
    startPolling();
  }

  static Future<void> _registerBackgroundTask() async {
    try {
      // Cancel any existing task first to avoid duplicates
      await Workmanager().cancelByTag(checkNotificationsTask);

      // Register periodic background task
      await Workmanager().registerPeriodicTask(
        checkNotificationsTask,
        checkNotificationsTask,
        frequency: Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        initialDelay: Duration(seconds: 10),
      );

      print("Background notification task registered successfully");
    } catch (e) {
      print("Error registering background notification task: $e");
    }
  }

  static void startPolling() {
    stopPolling();

    // Initial check
    checkForNewNotifications();

    // Set up periodic polling for foreground
    _pollingTimer = Timer.periodic(Duration(minutes: 2), (timer) {
      checkForNewNotifications();
    });
  }

  static void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    Workmanager().cancelByTag(checkNotificationsTask);
  }

  static Future<void> checkForNewNotifications() async {
    try {
      // Check if notifications are enabled (optional)
      final bool notificationsEnabled = await _areNotificationsEnabled();
      if (!notificationsEnabled) {
        print("Notifications are disabled, skipping check");
        return;
      }

      final service = GetNotificationsService();
      final NotificationModel? result = await service.getNotifications();

      if (result != null && result.success) {
        await _processNewNotifications(result.data);
        _lastChecked = DateTime.now();
        await _saveLastCheckedTime();
      }
    } catch (e) {
      print('Error checking notifications: $e');
    }
  }

  static Future<bool> _areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  static Future<void> _processNewNotifications(
    List<Datum> notifications,
  ) async {
    // Sort by creation date (newest first)
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final newNotifications = notifications.where((notification) {
      return !_knownNotificationIds.contains(notification.id);
    }).toList();

    if (newNotifications.isNotEmpty) {
      // Send notifications for new entries (newest first)
      for (final notification in newNotifications.reversed) {
        await NotificationService.showCustomNotification(
          title: notification.title,
          body: notification.message,
          data: {
            'type': 'new_notification',
            'id': notification.id,
            'title': notification.title,
            'message': notification.message,
            'screen': 'home',
          },
        );

        _knownNotificationIds.add(notification.id);
      }

      await _saveKnownNotifications();
    }
  }

  static Future<void> _loadKnownNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('known_notification_ids') ?? [];
    _knownNotificationIds = ids;
  }

  static Future<void> _saveKnownNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('known_notification_ids', _knownNotificationIds);
  }

  static Future<void> _loadLastCheckedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCheckedMillis = prefs.getInt('last_checked_time');
    if (lastCheckedMillis != null) {
      _lastChecked = DateTime.fromMillisecondsSinceEpoch(lastCheckedMillis);
    }
  }

  static Future<void> _saveLastCheckedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'last_checked_time',
      _lastChecked!.millisecondsSinceEpoch,
    );
  }

  // Clear all stored notifications (for testing)
  static Future<void> clearNotificationHistory() async {
    _knownNotificationIds.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('known_notification_ids');
    await prefs.remove('last_checked_time');
  }
}
