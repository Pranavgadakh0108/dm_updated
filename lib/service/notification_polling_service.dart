// // ignore_for_file: avoid_print, deprecated_member_use

// import 'dart:async';
// import 'package:dmboss/service/background_notification_service.dart';
// import 'package:dmboss/service/get_notifications_model.dart';
// import 'package:dmboss/service/notification_send_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dmboss/model/notification_model.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:flutter/material.dart';

// class NotificationPollingService {
//   static const String checkNotificationsTask = "checkNotificationsTask";
//   static Timer? _pollingTimer;
//   static DateTime? _lastChecked;
//   static String? _lastNotificationId;

//   static Timer? _backgroundTimer;
//   static const Duration foregroundPollingInterval = Duration(minutes: 1);
//   static const Duration backgroundPollingInterval = Duration(minutes: 1);
//   static const Duration maxNotificationAge = Duration(minutes: 1);

//   static bool _isAppInForeground = false;

//   @pragma('vm:entry-point')
//   static void callbackDispatcher() {
//     Workmanager().executeTask((task, inputData) async {
//       print("Workmanager task started: $task");

//       try {
//         switch (task) {
//           case checkNotificationsTask:
//             await _executeBackgroundCheck();
//             return true;
//           default:
//             print("Unknown task: $task");
//             return false;
//         }
//       } catch (e, stackTrace) {
//         print("Error in Workmanager task: $e");
//         print("Stack trace: $stackTrace");
//         return false;
//       }
//     });
//   }

//   static void reducePollingFrequency() {
//     print("Reducing polling frequency for background");

//     // Stop foreground polling
//     _pollingTimer?.cancel();
//     _pollingTimer = null;

//     _backgroundTimer ??= Timer.periodic(backgroundPollingInterval, (timer) {
//       print("Background polling triggered");
//       checkForNewNotifications();
//     });
//   }

//   static void startPolling() {
//     print("Starting foreground polling");

//     // Stop background polling
//     _backgroundTimer?.cancel();
//     _backgroundTimer = null;

//     // Stop any existing foreground polling
//     _pollingTimer?.cancel();

//     // Immediate check
//     checkForNewNotifications();

//     // Start periodic foreground polling
//     _pollingTimer = Timer.periodic(foregroundPollingInterval, (timer) {
//       print("Foreground polling triggered");
//       checkForNewNotifications();
//     });
//   }

//   static void stopPolling() {
//     print("Stopping all polling");
//     _pollingTimer?.cancel();
//     _pollingTimer = null;
//     _backgroundTimer?.cancel();
//     _backgroundTimer = null;
//   }

//   static Future<void> initialize() async {
//     await _loadLastCheckedTime();
//     await _loadLastNotificationId();

//     await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//     await Future.delayed(Duration(seconds: 2));
//     await _registerBackgroundTask();

//     // Start with foreground polling by default
//     startPolling();

//     print("NotificationPollingService initialized");
//   }

//   static void setAppState(bool isInForeground) {
//     _isAppInForeground = isInForeground;
//     print("App state changed: ${isInForeground ? 'Foreground' : 'Background'}");

//     // Automatically adjust polling based on app state
//     if (isInForeground) {
//       startPolling();
//     } else {
//       reducePollingFrequency();
//     }
//   }

//   static Future<void> _registerBackgroundTask() async {
//     try {
//       await Workmanager().cancelByTag(checkNotificationsTask);

//       await Workmanager().registerPeriodicTask(
//         checkNotificationsTask,
//         checkNotificationsTask,
//         frequency: Duration(minutes: 15),
//         initialDelay: Duration(seconds: 10),
//         constraints: Constraints(
//           networkType: NetworkType.connected,
//           requiresBatteryNotLow: false,
//           requiresCharging: false,
//           requiresDeviceIdle: false,
//         ),
//         existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
//         backoffPolicy: BackoffPolicy.linear,
//         backoffPolicyDelay: Duration(seconds: 30),
//       );

//       print("Background task registered successfully");
//     } catch (e, stackTrace) {
//       print("Error registering background task: $e");
//       print("Stack trace: $stackTrace");
//       await _registerOneTimeTask();
//     }
//   }

//   static Future<void> _registerOneTimeTask() async {
//     try {
//       await Workmanager().registerOneOffTask(
//         "${checkNotificationsTask}_onetime",
//         checkNotificationsTask,
//         initialDelay: Duration(minutes: 15),
//         constraints: Constraints(networkType: NetworkType.connected),
//         existingWorkPolicy: ExistingWorkPolicy.replace,
//       );
//       print("One-time task registered as fallback");
//     } catch (e) {
//       print("Error registering one-time task: $e");
//     }
//   }

//   @pragma('vm:entry-point')
//   static Future<void> _executeBackgroundCheck() async {
//     try {
//       print("Executing WorkManager background check");

//       WidgetsFlutterBinding.ensureInitialized();
//       await BackgroundNotificationService.initializeForBackground();

//       final service = GetNotificationsService();
//       final NotificationModel? result = await service.getNotifications();

//       if (result != null && result.success && result.data.isNotEmpty) {
//         await _processNotifications(result.data, isBackground: true);
//       }
//     } catch (e) {
//       print('Error in background notification check: $e');
//     }
//   }

//   static Future<void> checkForNewNotifications() async {
//     try {
//       final bool notificationsEnabled = await _areNotificationsEnabled();
//       if (!notificationsEnabled) {
//         print("Notifications are disabled, skipping check");
//         return;
//       }

//       final service = GetNotificationsService();
//       final NotificationModel? result = await service.getNotifications();

//       if (result != null && result.success && result.data.isNotEmpty) {
//         await _processNotifications(
//           result.data,
//           isBackground: !_isAppInForeground,
//         );
//         _lastChecked = DateTime.now();
//         await _saveLastCheckedTime();
//       }
//     } catch (e) {
//       print('Error checking notifications: $e');
//     }
//   }

//   static Future<void> _processNotifications(
//     List<Datum> notifications, {
//     required bool isBackground,
//   }) async {
//     if (notifications.isEmpty) return;

//     notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     final Datum mostRecentNotification = notifications.first;

//     print("Processing notification: ${mostRecentNotification.id}");
//     print("Last known ID: $_lastNotificationId");
//     print(
//       "Current notification age: ${DateTime.now().difference(mostRecentNotification.createdAt).inMinutes} minutes",
//     );

//     if (_isNotificationTooOld(mostRecentNotification.createdAt)) {
//       print(
//         "${isBackground ? 'Background' : 'Foreground'}: Notification is too old",
//       );
//       _lastNotificationId = mostRecentNotification.id;
//       await _saveLastNotificationId();
//       return;
//     }

//     if (_lastNotificationId == mostRecentNotification.id) {
//       print(
//         "${isBackground ? 'Background' : 'Foreground'}: Already processed this notification",
//       );
//       return;
//     }

//     String? processingNotificationId;
//     if (processingNotificationId == mostRecentNotification.id) {
//       print("Already processing this notification, skipping duplicate");
//       return;
//     }

//     processingNotificationId = mostRecentNotification.id;

//     try {
//       if (isBackground) {
//         await BackgroundNotificationService.showBackgroundNotification(
//           title: mostRecentNotification.title,
//           body: mostRecentNotification.message,
//           data: {
//             'type': 'new_notification',
//             'id': mostRecentNotification.id,
//             'title': mostRecentNotification.title,
//             'message': mostRecentNotification.message,
//             'isResult': mostRecentNotification.isResult.toString(),
//             'screen': 'home',
//             'from_background': 'true',
//           },
//         );
//       } else {
//         await NotificationService.showCustomNotification(
//           title: mostRecentNotification.title,
//           body: mostRecentNotification.message,
//           data: {
//             'type': 'new_notification',
//             'id': mostRecentNotification.id,
//             'title': mostRecentNotification.title,
//             'message': mostRecentNotification.message,
//             'isResult': mostRecentNotification.isResult.toString(),
//             'screen': 'home',
//             'from_background': 'false',
//           },
//         );
//       }

//       // Update the last notification ID immediately
//       _lastNotificationId = mostRecentNotification.id;
//       await _saveLastNotificationId();

//       print(
//         "${isBackground ? 'Background' : 'Foreground'}: Sent notification: ${mostRecentNotification.title}",
//       );
//     } catch (e) {
//       print("Error showing notification: $e");
//     } finally {
//       processingNotificationId = null;
//     }
//   }

//   static bool _isNotificationTooOld(DateTime notificationTime) {
//     final DateTime now = DateTime.now();
//     final Duration age = now.difference(notificationTime);
//     return age > maxNotificationAge;
//   }

//   static Future<bool> _areNotificationsEnabled() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('notifications_enabled') ?? true;
//   }

//   static Future<void> _loadLastNotificationId() async {
//     final prefs = await SharedPreferences.getInstance();
//     _lastNotificationId = prefs.getString('last_notification_id');
//   }

//   static Future<void> _saveLastNotificationId() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (_lastNotificationId != null) {
//       await prefs.setString('last_notification_id', _lastNotificationId!);
//     }
//   }

//   static Future<void> _loadLastCheckedTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastCheckedMillis = prefs.getInt('last_checked_time');
//     if (lastCheckedMillis != null) {
//       _lastChecked = DateTime.fromMillisecondsSinceEpoch(lastCheckedMillis);
//     }
//   }

//   static Future<void> _saveLastCheckedTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(
//       'last_checked_time',
//       _lastChecked!.millisecondsSinceEpoch,
//     );
//   }

//   static Future<void> clearNotificationHistory() async {
//     _lastNotificationId = null;
//     _lastChecked = null;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('last_notification_id');
//     await prefs.remove('last_checked_time');
//   }

//   static Map<String, dynamic> getCurrentState() {
//     return {
//       'lastNotificationId': _lastNotificationId,
//       'lastChecked': _lastChecked?.toString(),
//       'pollingActive': _pollingTimer != null,
//       'backgroundPollingActive': _backgroundTimer != null,
//       'maxNotificationAge': '${maxNotificationAge.inMinutes} minutes',
//       'appInForeground': _isAppInForeground,
//     };
//   }
// }
