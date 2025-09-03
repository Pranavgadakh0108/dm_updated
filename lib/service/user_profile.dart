import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/user_profile_model.dart';
import 'package:dmboss/service/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService {
  final AuthService _authService = AuthService();

  // Get Dio instance with authentication token
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
          print('No data received from API');
          return null;
        }

        final userProfileModel = UserModel.fromJson(response.data);

        if (userProfileModel.success) {
          print('User profile fetched successfully');
          return userProfileModel;
        } else {
          print('API returned success: false - ${userProfileModel.message}');
          return null;
        }
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        print('Authentication failed - token may be expired');
        // Optionally clear auth data and redirect to login
        await _authService.clearAuthData();
        return null;
      } else {
        print(
          'Failed to fetch user profile. Status code: ${response.statusCode}',
        );
        print('Response: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      print('DioException in getUserProfile: ${e.message}');
      print('Error type: ${e.type}');

      if (e.response != null) {
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');

        // Handle unauthorized access
        if (e.response?.statusCode == 401) {
          await _authService.clearAuthData();
        }
      }

      return null;
    } catch (e) {
      print('Exception in getUserProfile: $e');
      return null;
    }
  }

  // Update user profile
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
    } on DioException catch (e) {
      print('DioException in updateUserProfile: ${e.message}');
      return null;
    } catch (e) {
      print('Exception in updateUserProfile: $e');
      return null;
    }
  }

  // Check if user is authenticated and get profile
  Future<UserModel?> getAuthenticatedUserProfile() async {
    final isLoggedIn = await _authService.isLoggedIn();

    if (!isLoggedIn) {
      print('User is not authenticated');
      return null;
    }

    return await getUserProfile();
  }

  // Get user wallet balance
  Future<int?> getUserWalletBalance() async {
    final profile = await getUserProfile();
    return profile?.user.wallet;
  }

  // Verify if user profile is complete
  Future<bool> isProfileComplete() async {
    final profile = await getUserProfile();

    if (profile == null) return false;

    final user = profile.user;
    return user.name!.isNotEmpty;
  }
}
