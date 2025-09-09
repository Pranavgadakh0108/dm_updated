// import 'package:dmboss/model/notification_model.dart';
// import 'package:dmboss/service/firebase_notification_service.dart';
// import 'package:dmboss/service/get_notifications_model.dart';
// import 'package:flutter/material.dart';

// class GetNotificationsProvider extends ChangeNotifier {
//   NotificationModel? _notificationModel;
//   String? _errorMessage;
//   bool _isLoading = false;

//   NotificationModel? get notificationModel => _notificationModel;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;

//   Future<void> getNotificationsProvider(BuildContext context) async {
//     _isLoading = true;
//     notifyListeners();

//     final service = GetNotificationsService();
//     final result = await service.getNotifications();

//     if (result != null) {
//       _notificationModel = result;
//       _errorMessage = null;

//       // NEW: Send notifications using the Firebase service
//       await FirebaseNotificationService.sendNotificationFromModel(result);
//     } else {
//       _errorMessage = 'Failed to fetch Notifications Service.';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:dmboss/model/notification_model.dart' as apiModel;
import 'package:dmboss/service/firebase_notification_service.dart';
import 'package:dmboss/service/get_notifications_model.dart';
import 'package:flutter/material.dart';

class GetNotificationsProvider extends ChangeNotifier {
  apiModel.NotificationModel? _notificationModel;
  String? _errorMessage;
  bool _isLoading = false;

  apiModel.NotificationModel? get notificationModel => _notificationModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getNotificationsProvider(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetNotificationsService();
    final result = await service.getNotifications();

    if (result != null) {
      _notificationModel = result;
      _errorMessage = null;

      // ✅ explicitly call using apiModel.NotificationModel
      await FirebaseNotificationService.sendNotificationFromModel(result);
    } else {
      _errorMessage = 'Failed to fetch Notifications.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
