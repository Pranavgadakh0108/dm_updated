// ignore_for_file: library_prefixes

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

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('fcm_token', _fcmToken ?? "");
    _firebaseMessaging.onTokenRefresh.listen((t) => _fcmToken = t);
  }

  static void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotificationFromMessage(message);
    });
  }

  static void _setupBackgroundTapHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

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
