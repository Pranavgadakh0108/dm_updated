import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/dmboss',
      [
        NotificationChannel(
          channelKey: 'new_entries_channel',
          channelName: 'New Notifications',
          channelDescription: 'Notifications for new entries',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          criticalAlerts: true,
          // Enable background execution
          enableVibration: true,
          enableLights: true,
        ),
      ],
      channelGroups: [],
      debug: false,
    );

    // Request permissions for background notifications
    await AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: [
        NotificationPermission.Alert,
        NotificationPermission.Sound,
        NotificationPermission.Badge,
        NotificationPermission.Vibration,
        NotificationPermission.Light,
        NotificationPermission.CriticalAlert,
      ],
    );

    // Set up notification click listener
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onNotificationClicked,
      onNotificationCreatedMethod: _onNotificationCreated,
      onNotificationDisplayedMethod: _onNotificationDisplayed,
      onDismissActionReceivedMethod: _onNotificationDismissed,
    );
  }

  static Future<void> showCustomNotification({
    required String title,
    required String body,
    required Map<String, String?>? data,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        channelKey: 'new_entries_channel',
        title: title,
        body: body,
        payload: data,
        notificationLayout: NotificationLayout.Default,
        autoDismissible: false,
        criticalAlert: true,
      ),
    );
  }

  // Handle notification click
  static Future<void> _onNotificationClicked(
    ReceivedAction receivedAction,
  ) async {
    final data = receivedAction.payload ?? {};
    _handleNotificationNavigation(data);
  }

  // Optional: Handle notification creation
  static Future<void> _onNotificationCreated(
    ReceivedNotification receivedNotification,
  ) async {
    // You can handle notification creation here if needed
  }

  // Optional: Handle notification display
  static Future<void> _onNotificationDisplayed(
    ReceivedNotification receivedNotification,
  ) async {
    // You can handle notification display here if needed
  }

  // Optional: Handle notification dismiss
  static Future<void> _onNotificationDismissed(
    ReceivedAction receivedAction,
  ) async {
    // You can handle notification dismiss here if needed
  }

  static void _handleNotificationNavigation(Map<String, dynamic> data) {
    // Your navigation logic here
    print('Notification clicked with data: $data');
  }

  // Additional useful methods
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<bool> areNotificationsEnabled() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  static Future<void> requestPermissions() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Get current notification settings
  static Future<List<NotificationPermission>>
  getNotificationPermission() async {
    return await AwesomeNotifications().checkPermissionList();
  }
}
