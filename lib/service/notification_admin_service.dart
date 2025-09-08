import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/notification_model_from_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAdminNotificationsService {
  Future<Dio> _getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<NotificationModelFromAdmin?> getNotifications() async {
    try {
      final dio = await _getDioInstance();

      final result = await dio.get(
        "/users/notifications/notifications-only/all",
      );

      if (result.statusCode == 200) {
        return NotificationModelFromAdmin.fromJson(result.data);
      } else {
        "Failed to Fetch Notifications";
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['msg'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      "Error: $errorMessage";

      return null;
    }
    return null;
  }
}
