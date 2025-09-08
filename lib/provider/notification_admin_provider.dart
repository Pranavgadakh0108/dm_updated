import 'package:dmboss/model/notification_model_from_admin.dart';
import 'package:dmboss/service/notification_admin_service.dart';
import 'package:flutter/material.dart';

class GetNotificationsAdminProvider extends ChangeNotifier {
  NotificationModelFromAdmin? _notificationModel;
  String? _errorMessage;
  bool _isLoading = false;

  NotificationModelFromAdmin? get notificationModel => _notificationModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getNotificationsFromAdmin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetAdminNotificationsService();
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
