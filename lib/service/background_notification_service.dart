// background_notification_service.dart
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class BackgroundNotificationService {
  static Future<void> initializeForBackground() async {
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
          enableVibration: true,
          enableLights: true,
        ),
      ],
      channelGroups: [],
      debug: false,
    );
  }

  static Future<void> showBackgroundNotification({
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
}
