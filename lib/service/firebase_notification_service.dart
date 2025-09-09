// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'package:awesome_notifications/awesome_notifications.dart'
//     hide NotificationModel;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:dmboss/model/notification_model.dart';

// class FirebaseNotificationService {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final AwesomeNotifications _awesomeNotifications =
//       AwesomeNotifications();

//   static String? _fcmToken;
//   static String? get fcmToken => _fcmToken;

//   // Track last notification ID to prevent duplicates
//   static int _lastNotificationId = 0;
//   static String? _lastNotificationHash;

//   static Future<void> initialize() async {
//     await Firebase.initializeApp();

//     // Request permissions
//     await _requestPermissions();

//     // Initialize Awesome Notifications
//     await _initializeAwesomeNotifications();

//     // Get FCM token
//     await _getFcmToken();

//     // Setup foreground message handler
//     _setupForegroundHandler();

//     // Setup background message handler
//     _setupBackgroundHandler();
//   }

//   static Future<void> _requestPermissions() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       announcement: false,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   static Future<void> _initializeAwesomeNotifications() async {
//     await _awesomeNotifications.initialize(
//       null, // Use default app icon
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Notifications',
//           channelDescription: 'Notification channel for basic notifications',
//           defaultColor: Colors.blue,
//           ledColor: Colors.white,
//           importance: NotificationImportance.High,
//           channelShowBadge: true,
//           playSound: true,
//         ),
//       ],
//     );
//   }

//   static Future<void> _getFcmToken() async {
//     _fcmToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $_fcmToken');

//     // Listen for token refresh
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       _fcmToken = newToken;
//       print('FCM Token refreshed: $newToken');
//     });
//   }

//   static void _setupForegroundHandler() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received foreground message: ${message.notification?.title}');
//       _showNotificationFromMessage(message);
//     });
//   }

//   static void _setupBackgroundHandler() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message opened from background: ${message.notification?.title}');
//       _handleNotificationTap(message);
//     });
//   }

//   static Future<void> _showNotificationFromMessage(
//     RemoteMessage message,
//   ) async {
//     final notification = message.notification;
//     final data = message.data;

//     if (notification != null) {
//       await _showNotification(
//         title: notification.title ?? 'New Notification',
//         body: notification.body ?? '',
//         data: data,
//       );
//     }
//   }

//   static Future<void> _showNotification({
//     required String title,
//     required String body,
//     Map<String, dynamic>? data,
//   }) async {
//     // Generate a unique hash for this notification to prevent duplicates
//     final notificationHash =
//         '$title$body${DateTime.now().millisecondsSinceEpoch}';

//     // Check if this is a duplicate of the last notification
//     if (_lastNotificationHash == notificationHash) {
//       print('Duplicate notification detected, skipping');
//       return;
//     }

//     _lastNotificationId++;
//     _lastNotificationHash = notificationHash;

//     await _awesomeNotifications.createNotification(
//       content: NotificationContent(
//         id: _lastNotificationId,
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//         payload: data as Map<String, String?>,
//         notificationLayout: NotificationLayout.Default,
//       ),
//     );
//   }

//   static void _handleNotificationTap(RemoteMessage message) {
//     // Handle notification tap - you can navigate to specific screens here
//     print('Notification tapped with data: ${message.data}');
//   }

//   // Send notification from API model (only the most recent one)
//   static Future<void> sendNotificationFromModel(NotificationModel model) async {
//     if (model.data.isEmpty) return;

//     // Get only the most recent notification
//     final recentNotification = model.data.last;

//     // Create a unique hash for this notification
//     final notificationHash =
//         '${recentNotification.id}${recentNotification.updatedAt.millisecondsSinceEpoch}';

//     // Check if this notification was already shown
//     if (_lastNotificationHash == notificationHash) {
//       print('Notification already shown, skipping');
//       return;
//     }

//     await _showNotification(
//       title: recentNotification.title,
//       body: recentNotification.message,
//       data: {
//         'id': recentNotification.id,
//         'isResult': recentNotification.isResult.toString(),
//         'createdAt': recentNotification.createdAt.toIso8601String(),
//         'resultData': recentNotification.resultData?.toJson().toString() ?? '',
//       },
//     );

//     _lastNotificationHash = notificationHash;
//   }

//   // Clear notification history
//   static void clearNotificationHistory() {
//     _lastNotificationHash = null;
//     _lastNotificationId = 0;
//   }
// }

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dmboss/model/notification_model.dart' as apiModel;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  static String? _fcmToken;
  static String? get fcmToken => _fcmToken;

  static int _lastNotificationId = 0;
  static String? _lastNotificationHash;

  static Future<void> initialize() async {
    await _requestPermissions();
    await _initializeAwesomeNotifications();
    await _getFcmToken();
    _setupForegroundHandler();
    _setupBackgroundTapHandler();
  }

  static Future<void> _requestPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _initializeAwesomeNotifications() async {
    await _awesomeNotifications.initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
      ),
    ]);
  }

  static Future<void> _getFcmToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $_fcmToken");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('fcm_token', _fcmToken ?? "");
    _firebaseMessaging.onTokenRefresh.listen((t) => _fcmToken = t);
  }

  // ✅ Foreground messages
  static void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotificationFromMessage(message);
    });
  }

  // ✅ Background tap handler
  static void _setupBackgroundTapHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification clicked: ${message.data}");
      // Navigate to a screen if needed
    });
  }

  // ✅ Show notification (can be called from foreground/background/kill)
  static Future<void> showNotificationFromMessage(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    final title = notification?.title ?? "New Notification";
    final body = notification?.body ?? "";

    final notificationHash =
        "$title$body${DateTime.now().millisecondsSinceEpoch}";
    if (_lastNotificationHash == notificationHash) return;

    _lastNotificationId++;
    _lastNotificationHash = notificationHash;

    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: _lastNotificationId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: data.map((k, v) => MapEntry(k, v.toString())),
      ),
    );
  }

  static Future<void> sendNotificationFromModel(
    apiModel.NotificationModel model,
  ) async {
    if (model.data.isEmpty) return;

    final recent = model.data.last;

    final notificationHash =
        '${recent.id}_${recent.updatedAt.millisecondsSinceEpoch}';
    if (_lastNotificationHash == notificationHash) {
      print('Duplicate notification (model) — skipping.');
      return;
    }

    _lastNotificationId++;
    _lastNotificationHash = notificationHash;

    final payload = <String, String>{
      'id': recent.id,
      'title': recent.title,
      'message': recent.message,
      'isResult': recent.isResult.toString(),
      'createdAt': recent.createdAt.toIso8601String(),
      'updatedAt': recent.updatedAt.toIso8601String(),
      'createdBy': recent.createdBy ?? '',
      'resultData': recent.resultData != null
          ? jsonEncode(recent.resultData!.toJson())
          : '',
    };

    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: _lastNotificationId,
        channelKey: 'basic_channel',
        title: recent.title,
        body: recent.message,
        payload: payload,
      ),
    );
  }
}
