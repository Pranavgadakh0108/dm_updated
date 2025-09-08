import 'dart:async';
import 'package:dmboss/service/get_notifications_model.dart';
import 'package:dmboss/service/notification_send_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmboss/model/notification_model.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';

class NotificationPollingService {
  static const String checkNotificationsTask = "checkNotificationsTask";
  static Timer? _pollingTimer;
  static DateTime? _lastChecked;
  static String? _lastNotificationId;

  // Maximum age for notifications to be considered "recent" (5 minutes)
  static const Duration maxNotificationAge = Duration(minutes: 2);

  // Track app state
  static bool _isAppInForeground = false;

  // Background callback handler - MUST be a top-level function
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      print("Workmanager background task executed: $task");

      switch (task) {
        case checkNotificationsTask:
          await _executeBackgroundCheck();
          return true;
        default:
          return false;
      }
    });
  }

  // Separate method for background execution
  @pragma('vm:entry-point')
  static Future<void> _executeBackgroundCheck() async {
    try {
      print("Executing background notification check");

      // Initialize dependencies for background
      WidgetsFlutterBinding.ensureInitialized();

      final service = GetNotificationsService();
      final NotificationModel? result = await service.getNotifications();

      if (result != null && result.success && result.data.isNotEmpty) {
        await _processBackgroundNotifications(result.data);
      }
    } catch (e) {
      print('Error in background notification check: $e');
    }
  }

  static Future<void> initialize() async {
    await _loadLastCheckedTime();
    await _loadLastNotificationId();

    // Initialize Workmanager with the callback dispatcher
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

    // Register the background task with more aggressive settings
    await _registerBackgroundTask();

    // Start foreground polling
    startPolling();
  }

  // Method to update app state
  static void setAppState(bool isInForeground) {
    _isAppInForeground = isInForeground;
    print("App state changed: ${isInForeground ? 'Foreground' : 'Background'}");
  }

  static Future<void> _registerBackgroundTask() async {
    try {
      // Cancel any existing task first to avoid duplicates
      await Workmanager().cancelByTag(checkNotificationsTask);

      // Register periodic background task with more frequent checks
      await Workmanager().registerPeriodicTask(
        checkNotificationsTask,
        checkNotificationsTask,
        frequency: Duration(minutes: 3),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
        ),
        initialDelay: Duration(seconds: 30),
        existingWorkPolicy:
            ExistingPeriodicWorkPolicy.replace, // Replace old tasks
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

    // Set up periodic polling for foreground (less frequent in foreground)
    _pollingTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      checkForNewNotifications();
    });
  }

  static void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  static Future<void> checkForNewNotifications() async {
    try {
      // Check if notifications are enabled
      final bool notificationsEnabled = await _areNotificationsEnabled();
      if (!notificationsEnabled) {
        print("Notifications are disabled, skipping check");
        return;
      }

      final service = GetNotificationsService();
      final NotificationModel? result = await service.getNotifications();

      if (result != null && result.success && result.data.isNotEmpty) {
        await _processRecentNotifications(result.data);
        _lastChecked = DateTime.now();
        await _saveLastCheckedTime();
      }
    } catch (e) {
      print('Error checking notifications: $e');
    }
  }

  // Separate processing for background to handle app state differences
  static Future<void> _processBackgroundNotifications(
    List<Datum> notifications,
  ) async {
    // Sort by creation date (newest first)
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Get the most recent notification
    final Datum mostRecentNotification = notifications.first;

    // Check if the notification is too old to send
    if (_isNotificationTooOld(mostRecentNotification.createdAt)) {
      print(
        "Background: Notification is too old: ${mostRecentNotification.title}",
      );
      // Still update the last known ID to avoid checking this again
      _lastNotificationId = mostRecentNotification.id;
      await _saveLastNotificationId();
      return;
    }

    // If we have a last known notification ID, check if it's different
    if (_lastNotificationId != null &&
        _lastNotificationId == mostRecentNotification.id) {
      print("Background: No new notifications since last check");
      return;
    }

    // If this is the first time checking or we have a new notification
    if (_lastNotificationId == null ||
        _lastNotificationId != mostRecentNotification.id) {
      // Send notification - this will work even when app is terminated
      await NotificationService.showCustomNotification(
        title: mostRecentNotification.title,
        body: mostRecentNotification.message,
        data: {
          'type': 'new_notification',
          'id': mostRecentNotification.id,
          'title': mostRecentNotification.title,
          'message': mostRecentNotification.message,
          'isResult': mostRecentNotification.isResult.toString(),
          'screen': 'home',
          'from_background': 'true',
        },
      );

      // Update last known notification ID
      _lastNotificationId = mostRecentNotification.id;
      await _saveLastNotificationId();

      print("Background: Sent notification: ${mostRecentNotification.title}");
    }
  }

  static Future<void> _processRecentNotifications(
    List<Datum> notifications,
  ) async {
    // Similar processing but for foreground
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final Datum mostRecentNotification = notifications.first;

    if (_isNotificationTooOld(mostRecentNotification.createdAt)) {
      print(
        "Foreground: Notification is too old: ${mostRecentNotification.title}",
      );
      _lastNotificationId = mostRecentNotification.id;
      await _saveLastNotificationId();
      return;
    }

    if (_lastNotificationId != null &&
        _lastNotificationId == mostRecentNotification.id) {
      print("Foreground: No new notifications since last check");
      return;
    }

    if (_lastNotificationId == null ||
        _lastNotificationId != mostRecentNotification.id) {
      await NotificationService.showCustomNotification(
        title: mostRecentNotification.title,
        body: mostRecentNotification.message,
        data: {
          'type': 'new_notification',
          'id': mostRecentNotification.id,
          'title': mostRecentNotification.title,
          'message': mostRecentNotification.message,
          'isResult': mostRecentNotification.isResult.toString(),
          'screen': 'home',
          'from_background': 'false',
        },
      );

      _lastNotificationId = mostRecentNotification.id;
      await _saveLastNotificationId();

      print("Foreground: Sent notification: ${mostRecentNotification.title}");
    }
  }

  static bool _isNotificationTooOld(DateTime notificationTime) {
    final DateTime now = DateTime.now();
    final Duration age = now.difference(notificationTime);
    return age > maxNotificationAge;
  }

  static Future<bool> _areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  static Future<void> _loadLastNotificationId() async {
    final prefs = await SharedPreferences.getInstance();
    _lastNotificationId = prefs.getString('last_notification_id');
  }

  static Future<void> _saveLastNotificationId() async {
    final prefs = await SharedPreferences.getInstance();
    if (_lastNotificationId != null) {
      await prefs.setString('last_notification_id', _lastNotificationId!);
    }
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

  static Future<void> clearNotificationHistory() async {
    _lastNotificationId = null;
    _lastChecked = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_notification_id');
    await prefs.remove('last_checked_time');
  }

  static Map<String, dynamic> getCurrentState() {
    return {
      'lastNotificationId': _lastNotificationId,
      'lastChecked': _lastChecked?.toString(),
      'pollingActive': _pollingTimer != null,
      'maxNotificationAge': '${maxNotificationAge.inMinutes} minutes',
      'appInForeground': _isAppInForeground,
    };
  }
}
