import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/update_profile_model.dart';

class UpdateProfileService {
  Future<Dio> getDioInstance() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

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

  Future<UpdateProfileModel?> updateProfile({
    String? name,
    String? newPassword,
    String? confirmPassword,
  }) async {
    try {
      if (newPassword != null && newPassword.isNotEmpty) {
        if (confirmPassword == null || confirmPassword.isEmpty) {
          throw Exception('Please confirm your password');
        }
        if (newPassword != confirmPassword) {
          throw Exception('Passwords do not match');
        }
        if (newPassword.length < 4 || newPassword.length > 4) {
          throw Exception('Password must be 4 digits');
        }
      }

      final dio = await getDioInstance();

      final data = {};
      if (name != null && name.isNotEmpty) data['name'] = name;
      if (newPassword != null && newPassword.isNotEmpty) {
        data['password'] = newPassword;
        data['password_confirmation'] = confirmPassword;
      }

      final response = await dio.put('/users/me', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateProfileModel.fromJson(response.data);
      } else {
        throw Exception('Update failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfileSimple({
    String? name,
    String? newPassword,
    String? confirmPassword,
  }) async {
    try {
      final result = await updateProfile(
        name: name,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return result?.success ?? false;
    } catch (e) {
      return false;
    }
  }
}
