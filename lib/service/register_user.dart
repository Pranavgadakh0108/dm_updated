import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/register_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Dio> getDioInstance() async {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<RegisterUserModel?> registerUser({
    required String mobile,
    required String name,

    required String password,
    required String confirmPassword,
  }) async {
    try {
      final dio = await getDioInstance();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final fcmToken = sharedPreferences.getString('fcm_token');

      final response = await dio.post(
        '/auth/register',
        data: {
          'mobile': mobile,
          'name': name,
          'fcm_token': fcmToken,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        }
        return RegisterUserModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {}
      return null;
    }
  }
}
