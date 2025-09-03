import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/register_user_model.dart';

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

  // Register user method with password
  Future<RegisterUserModel?> registerUser({
    required String mobile,
    required String name,
    // required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final dio = await getDioInstance();
      print('Sending request to: $baseUrl/auth/register');
      print(
        'Registration data: mobile=$mobile, name=$name, password=$password',
      );

      final response = await dio.post(
        '/auth/register',
        data: {
          'mobile': mobile,
          'name': name,
          // 'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          print('Response data is null!');
          return null;
        }
        return RegisterUserModel.fromJson(response.data);
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception caught during registration: $e');
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response: ${e.response?.data}');
        print('Error type: ${e.type}');
      }
      return null;
    }
  }

  // Alternative method that returns just the success status
  // Future<bool?> registerUserSimple({
  //   required String mobile,
  //   required String name,
  //   required String email,
  //   required String password, // Added password parameter
  // }) async {
  //   try {
  //     final dio = await getDioInstance();

  //     final response = await dio.post(
  //       '/auth/register',
  //       data: {
  //         'mobile': mobile,
  //         'name': name,
  //         'email': email,
  //         'password': password, // Added password field
  //       },
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final registerUserModel = RegisterUserModel.fromJson(response.data);
  //       return registerUserModel.success;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Exception caught during registration: $e');
  //     return false;
  //   }
  // }
}
