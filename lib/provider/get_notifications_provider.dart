import 'package:dmboss/model/notification_model.dart';
import 'package:dmboss/service/get_notifications_model.dart';
import 'package:flutter/material.dart';

class GetNotificationsProvider extends ChangeNotifier {
  NotificationModel? _notificationModel;
  String? _errorMessage;
  bool _isLoading = false;

  NotificationModel? get notificationModel => _notificationModel;
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
    } else {
      _errorMessage = 'Failed to fetch Notifiactions Service.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
