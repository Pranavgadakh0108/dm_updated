// // services/custom_notification_service.dart
// import 'package:dmboss/service/firebase_notification_service.dart';
// import 'package:flutter/material.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:dmboss/model/notification_model.dart';

// class CustomNotificationService {
//   static final CustomNotificationService _instance =
//       CustomNotificationService._internal();
//   factory CustomNotificationService() => _instance;
//   CustomNotificationService._internal();

//   static const String _channelKey = 'custom_notifications_channel';
//   static const String _channelName = 'Custom Notifications';
//   static const String _channelDescription =
//       'Notifications for app updates and results';

//   // Initialize the notification service
//   static Future<void> initialize() async {
//     await _setupNotificationChannels();
//     _setupNotificationListeners();
//     print('Custom Notification Service Initialized');
//   }

//   // Setup notification channels
//   static Future<void> _setupNotificationChannels() async {
//     await AwesomeNotifications().initialize(
//       null, // Use default app icon
//       [
//         NotificationChannel(
//           channelKey: _channelKey,
//           channelName: _channelName,
//           channelDescription: _channelDescription,
//           defaultColor: Colors.blue,
//           ledColor: Colors.blue,
//           importance: NotificationImportance.High,
//           channelShowBadge: true,
//           playSound: true,
//           criticalAlerts: true,
//           enableVibration: true,
//           enableLights: true,
//           soundSource:
//               'resource://raw/notification_sound', // Add your sound file
//         ),
//       ],
//       debug: true,
//     );
//   }

//   // Setup notification listeners
//   static void _setupNotificationListeners() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: _onNotificationClicked,
//       onNotificationCreatedMethod: _onNotificationCreated,
//       onNotificationDisplayedMethod: _onNotificationDisplayed,
//       onDismissActionReceivedMethod: _onNotificationDismissed,
//     );
//   }

//   // Send notification from Datum model (checks if it's the most recent)
//   static Future<bool> sendNotificationFromModel(Datum notificationData) async {
//     try {
//       // Check if this is a new notification
//       final isNew = await NotificationStorageService.isNewNotification(
//         notificationData.id,
//         notificationData.createdAt,
//       );

//       if (!isNew) {
//         print('Notification ${notificationData.id} is not new - skipping');
//         return false;
//       }

//       // Create notification payload
//       final Map<String, String> payload = {
//         'notificationId': notificationData.id,
//         'title': notificationData.title,
//         'message': notificationData.message,
//         'isResult': notificationData.isResult.toString(),
//         'createdAt': notificationData.createdAt.toIso8601String(),
//         'type': 'app_notification',
//       };

//       // Add result data if available
//       if (notificationData.isResult && notificationData.resultData != null) {
//         final resultData = notificationData.resultData!;
//         payload.addAll({
//           'resultId': resultData.id,
//           'marketId': resultData.market?.id ?? '',
//           'marketGame': resultData.market?.game ?? '',
//           'marketBazar': resultData.market?.bazar ?? '',
//           'date': resultData.date,
//           'open': resultData.open,
//           'openPanna': resultData.openPanna,
//           'close': resultData.close,
//           'closePanna': resultData.closePanna,
//           'isResultNotification': 'true',
//         });
//       }

//       // Create and show the notification
//       await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: _generateNotificationId(),
//           channelKey: _channelKey,
//           title: notificationData.title,
//           body: notificationData.message,
//           payload: payload,
//           notificationLayout: NotificationLayout.Default,
//           autoDismissible: false,
//           criticalAlert: true,
//           category: notificationData.isResult
//               ? NotificationCategory.Social
//               : NotificationCategory.Reminder,
//         ),
//       );

//       // Save this as the last notification
//       await NotificationStorageService.saveLastNotification(
//         notificationData.id,
//         notificationData.createdAt,
//       );

//       print('Notification sent: ${notificationData.title}');
//       return true;
//     } catch (e) {
//       print('Error sending notification: $e');
//       return false;
//     }
//   }

//   // Send only the most recent notification from a list
//   static Future<bool> sendMostRecentNotification(
//     List<Datum> notifications,
//   ) async {
//     if (notifications.isEmpty) return false;

//     // Sort notifications by creation date (newest first)
//     notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

//     // Get the most recent notification
//     final mostRecent = notifications.first;

//     return await sendNotificationFromModel(mostRecent);
//   }

//   // Send multiple notifications with rate limiting
//   static Future<int> sendNotifications(List<Datum> notifications) async {
//     int sentCount = 0;

//     for (final notification in notifications) {
//       final wasSent = await sendNotificationFromModel(notification);
//       if (wasSent) sentCount++;

//       // Add small delay to avoid overwhelming the system
//       await Future.delayed(const Duration(milliseconds: 50));
//     }

//     return sentCount;
//   }

//   // Handle notification click
//   static Future<void> _onNotificationClicked(
//     ReceivedAction receivedAction,
//   ) async {
//     final payload = receivedAction.payload ?? {};
//     print('Notification clicked with payload: $payload');

//     // Handle navigation based on notification type
//     _handleNotificationNavigation(payload);
//   }

//   static void _handleNotificationNavigation(Map<String, String?> payload) {
//     final notificationId = payload['notificationId'];
//     final isResult = payload['isResult'] == 'true';

//     if (isResult) {
//       // Navigate to results screen
//       print('Navigating to results screen for notification: $notificationId');
//     } else {
//       // Navigate to notifications screen
//       print('Navigating to notifications screen');
//     }
//   }

//   static Future<void> _onNotificationCreated(
//     ReceivedNotification receivedNotification,
//   ) async {
//     print('Notification created: ${receivedNotification.title}');
//   }

//   static Future<void> _onNotificationDisplayed(
//     ReceivedNotification receivedNotification,
//   ) async {
//     print('Notification displayed: ${receivedNotification.title}');
//   }

//   static Future<void> _onNotificationDismissed(
//     ReceivedAction receivedAction,
//   ) async {
//     print('Notification dismissed: ${receivedAction.title}');
//   }

//   // Generate unique notification ID
//   static int _generateNotificationId() {
//     return DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   }

//   // Clear all notifications
//   static Future<void> clearAllNotifications() async {
//     await AwesomeNotifications().cancelAll();
//     print('All notifications cleared');
//   }

//   // Check if notifications are enabled
//   static Future<bool> areNotificationsEnabled() async {
//     return await AwesomeNotifications().isNotificationAllowed();
//   }

//   // Request notification permissions
//   static Future<bool> requestNotificationPermissions() async {
//     return await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

//   // Get notification channels
//   static List<NotificationChannel> getNotificationChannels() {
//     return [
//       NotificationChannel(
//         channelKey: _channelKey,
//         channelName: _channelName,
//         channelDescription: _channelDescription,
//         defaultColor: Colors.blue,
//         ledColor: Colors.blue,
//         importance: NotificationImportance.High,
//         channelShowBadge: true,
//         playSound: true,
//         criticalAlerts: true,
//         enableVibration: true,
//         enableLights: true,
//       ),
//     ];
//   }
// }
