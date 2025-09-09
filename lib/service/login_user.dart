// import 'package:dio/dio.dart';
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/login_user_model.dart'; // Import your login model

// class AuthService {
//   Future<Dio> getDioInstance() async {
//     return Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );
//   }

//   // Login user method
//   Future<LoginUserModel?> loginUser({
//     required String mobile,
//     required String password,
//   }) async {
//     try {
//       final dio = await getDioInstance();

//       final response = await dio.post(
//         '/auth/login',
//         data: {'mobile': mobile, 'password': password},
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data == null) {
//           return null;
//         }
//         return LoginUserModel.fromJson(response.data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       if (e is DioException) {
//         print('DioException: ${e.message}');
//         print('Response: ${e.response?.data}');
//         print('Error type: ${e.type}');
//       }
//       return null;
//     }
//   }

//   // Alternative method that returns just the success status
//   Future<bool?> loginUserSimple({
//     required String mobile,
//     required String password,
//   }) async {
//     try {
//       final dio = await getDioInstance();

//       final response = await dio.post(
//         '/auth/login',
//         data: {'mobile': mobile, 'password': password},
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final loginUserModel = LoginUserModel.fromJson(response.data);
//         return loginUserModel.success;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Exception caught during login: $e');
//       return false;
//     }
//   }

//   // Optional: Method to store token after successful login
//   Future<void> storeLoginData(LoginUserModel loginData) async {
//     // Store token in secure storage or preferences
//     // Example: await storage.write(key: 'token', value: loginData.token);
//     // Store user data if needed
//     print('Login successful. Token: ${loginData.token}');
//   }
// }

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/login_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _isLoggedInKey = 'is_logged_in';

  Future<Dio> getDioInstance() async {
    // Get token from storage
    final token = await getStoredToken();

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  // Login user method
  Future<LoginUserModel?> loginUser({
    required String mobile,
    required String password,
  }) async {
    try {
      final dio = await getDioInstance();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final fcmToken = sharedPreferences.getString('fcm_token');

      final response = await dio.post(
        '/auth/login',
        data: {'mobile': mobile, 'password': password, 'fcm_token': fcmToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        }

        final loginUserModel = LoginUserModel.fromJson(response.data);

        // Store token after successful login
        await storeToken(loginUserModel.token, loginUserModel.user.id);

        return loginUserModel;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response: ${e.response?.data}');
        print('Error type: ${e.type}');
      }
      return null;
    }
  }

  // Store token method
  Future<void> storeToken(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString("user_id", userId);
  }

  // Get stored token
  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Store login data (updated method)
  Future<void> storeLoginData(LoginUserModel loginData) async {
    final prefs = await SharedPreferences.getInstance();

    // Store token
    await prefs.setString(_tokenKey, loginData.token);
    await prefs.setBool(_isLoggedInKey, true);

    // Store user data if needed (optional)
    // You can store other user information here
    print('Login successful. Token stored: ${loginData.token}');
  }

  // Clear all auth data (logout)
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Simple login method
  Future<bool?> loginUserSimple({
    required String mobile,
    required String password,
  }) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.post(
        '/auth/login',
        data: {'mobile': mobile, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginUserModel = LoginUserModel.fromJson(response.data);

        // Store token
        await storeToken(loginUserModel.token, loginUserModel.user.id);

        return loginUserModel.success;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception caught during login: $e');
      return false;
    }
  }
}
