import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/user_profile_model.dart';
import 'package:dmboss/service/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService {
  final AuthService _authService = AuthService();

  Future<Dio> _getAuthenticatedDio() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('auth_token');

    print(token);

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

  Future<UserModel?> getUserProfile() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final dio = await _getAuthenticatedDio();

      final response = await dio.get(
        '/users/me',
        options: Options(validateStatus: (status) => status! < 500),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          return null;
        }

        final userProfileModel = UserModel.fromJson(response.data);

        if (userProfileModel.success) {
          return userProfileModel;
        } else {
          return null;
        }
      } else if (response.statusCode == 401) {
        await _authService.clearAuthData();
        return null;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          await _authService.clearAuthData();
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> updateUserProfile({
    String? name,
    String? email,
    String? paytm,
  }) async {
    try {
      final dio = await _getAuthenticatedDio();

      final Map<String, dynamic> updateData = {};
      if (name != null) updateData['name'] = name;
      if (email != null) updateData['email'] = email;
      if (paytm != null) updateData['paytm'] = paytm;

      final response = await dio.put(
        '/users/me',
        data: updateData,
        options: Options(validateStatus: (status) => status! < 500),
      );

      if (response.statusCode == 200) {
        final userProfileModel = UserModel.fromJson(response.data);

        if (userProfileModel.success) {
          print('User profile updated successfully');
          return userProfileModel;
        } else {
          print('Failed to update profile: ${userProfileModel.message}');
          return null;
        }
      } else {
        print(
          'Failed to update user profile. Status code: ${response.statusCode}',
        );
        return null;
      }
    } on DioException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getAuthenticatedUserProfile() async {
    final isLoggedIn = await _authService.isLoggedIn();

    if (!isLoggedIn) {
      return null;
    }

    return await getUserProfile();
  }

  Future<int?> getUserWalletBalance() async {
    final profile = await getUserProfile();
    return profile?.user.wallet;
  }

  Future<bool> isProfileComplete() async {
    final profile = await getUserProfile();

    if (profile == null) return false;

    final user = profile.user;
    return user.name!.isNotEmpty;
  }
}
