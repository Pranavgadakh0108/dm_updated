// import 'package:dio/dio.dart';
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/update_profile_model.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import your update profile model

// class UpdateProfileService {
//   Future<Dio> getDioInstance() async {
//     // Get token from storage
//     final token = await getStoredToken();
    
//     return Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//   }

//   // Get stored token (reuse from AuthService)
//   Future<String?> getStoredToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   // Update user profile
//   Future<UpdateProfileModel?> updateProfile({
//     String? name,
//     String? newPassword,
//     String? confirmPassword,
//   }) async {
//     try {
//       // Validate password confirmation
//       if (newPassword != null && newPassword != confirmPassword) {
//         throw Exception('New password and confirmation do not match');
//       }

//       final dio = await getDioInstance();

//       // Prepare data for update (only include fields that are provided)
//       final Map<String, dynamic> updateData = {};
      
//       if (name != null && name.isNotEmpty) {
//         updateData['name'] = name;
//       }
      
//       if (newPassword != null && newPassword.isNotEmpty) {
//         updateData['newpassword'] = newPassword;
//       }

//       final response = await dio.put(
//         '/users/me',
//         data: updateData,
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data == null) {
//           return null;
//         }
        
//         return UpdateProfileModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to update profile: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//       print('Response: ${e.response?.data}');
//       print('Error type: ${e.type}');
      
//       // Handle specific error cases
//       if (e.response != null) {
//         final errorData = e.response!.data;
//         if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
//           throw Exception(errorData['message']);
//         }
//       }
      
//       throw Exception('Failed to update profile: ${e.message}');
//     } catch (e) {
//       print('Exception caught during profile update: $e');
//       rethrow;
//     }
//   }

//   // Alternative simple method that returns just success status
//   Future<bool> updateProfileSimple({
//     String? name,
//     String? newPassword,
//     String? confirmPassword,
//   }) async {
//     try {
//       final result = await updateProfile(
//         name: name,
//         newPassword: newPassword,
//         confirmPassword: confirmPassword,
//       );
      
//       return result?.success ?? false;
//     } catch (e) {
//       print('Profile update failed: $e');
//       return false;
//     }
//   }
// }
// import 'package:dio/dio.dart';
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/update_profile_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UpdateProfileService {
//   Future<Dio> getDioInstance() async {
//     final token = await getStoredToken();
    
//     return Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//   }

//   Future<String?> getStoredToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   // Update user profile - FIXED VERSION
//   Future<UpdateProfileModel?> updateProfile({
//     String? name,
//     String? newPassword,
//     String? confirmPassword,
//   }) async {
//     try {
//       // Validate password confirmation only if newPassword is provided
//       if (newPassword != null && newPassword.isNotEmpty) {
//         if (confirmPassword == null || confirmPassword.isEmpty) {
//           throw Exception('Please confirm your new password');
//         }
//         if (newPassword != confirmPassword) {
//           throw Exception('New password and confirmation do not match');
//         }
//         if (newPassword.length < 6) {
//           throw Exception('Password must be at least 6 characters long');
//         }
//       }

//       final dio = await getDioInstance();

//       // Prepare data for update - only include non-null and non-empty fields
//       final Map<String, dynamic> updateData = {};
      
//       if (name != null && name.isNotEmpty) {
//         updateData['name'] = name;
//       }
      
//       if (newPassword != null && newPassword.isNotEmpty) {
//         updateData['password'] = newPassword; // Changed from 'newpassword' to 'password'
//         updateData['password_confirmation'] = confirmPassword; // Add confirmation if needed
//       }

//       // Debug print to see what's being sent
//       print('Sending update data: $updateData');

//       final response = await dio.put(
//         '/users/me',
//         data: updateData,
//       );

//       // Debug print to see response
//       print('Update response: ${response.data}');
//       print('Status code: ${response.statusCode}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data == null) {
//           return null;
//         }
        
//         return UpdateProfileModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to update profile: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//       print('Response: ${e.response?.data}');
//       print('Error type: ${e.type}');
//       print('Status code: ${e.response?.statusCode}');
      
//       if (e.response != null) {
//         final errorData = e.response!.data;
//         if (errorData is Map<String, dynamic>) {
//           if (errorData.containsKey('message')) {
//             throw Exception(errorData['message']);
//           }
//           if (errorData.containsKey('error')) {
//             throw Exception(errorData['error']);
//           }
//         }
//       }
      
//       throw Exception('Failed to update profile: ${e.message}');
//     } catch (e) {
//       print('Exception caught during profile update: $e');
//       rethrow;
//     }
//   }

//   Future<bool> updateProfileSimple({
//     String? name,
//     String? newPassword,
//     String? confirmPassword,
//   }) async {
//     try {
//       final result = await updateProfile(
//         name: name,
//         newPassword: newPassword,
//         confirmPassword: confirmPassword,
//       );
      
//       return result?.success ?? false;
//     } catch (e) {
//       print('Profile update failed: $e');
//       return false;
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/update_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileService {
  Future<Dio> getDioInstance() async {
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

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Update user profile - FIXED VERSION
  Future<UpdateProfileModel?> updateProfile({
    String? name,
    String? newPassword,
    String? confirmPassword,
  }) async {
    try {
      // Validate password confirmation only if newPassword is provided
      if (newPassword != null && newPassword.isNotEmpty) {
        if (confirmPassword == null || confirmPassword.isEmpty) {
          throw Exception('Please confirm your new password');
        }
        if (newPassword != confirmPassword) {
          throw Exception('New password and confirmation do not match');
        }
        if (newPassword.length < 6) {
          throw Exception('Password must be at least 6 characters long');
        }
      }

      final dio = await getDioInstance();

      // Prepare data for update - only include non-null and non-empty fields
      final Map<String, dynamic> updateData = {};
      
      if (name != null && name.isNotEmpty) {
        updateData['name'] = name;
      }
      
      if (newPassword != null && newPassword.isNotEmpty) {
        // Try the most common field name combination first
        updateData['password'] = newPassword;
        updateData['password_confirmation'] = confirmPassword;
      }

      // Debug print to see what's being sent
      print('Sending update data: $updateData');

      final response = await dio.put(
        '/users/me',
        data: updateData,
        options: Options(
          validateStatus: (status) {
            // Don't throw for 400 errors, let us handle them
            return status! < 500;
          },
        ),
      );

      // Debug print to see response
      print('Update response: ${response.data}');
      print('Status code: ${response.statusCode}');

      // Handle 400 errors gracefully
      if (response.statusCode == 400) {
        final errorData = response.data;
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            throw Exception(errorData['message']);
          }
          // Check for specific field errors
          if (errorData.containsKey('password')) {
            throw Exception(errorData['password'][0] ?? 'Invalid password');
          }
          if (errorData.containsKey('password_confirmation')) {
            throw Exception(errorData['password_confirmation'][0] ?? 'Password confirmation error');
          }
        }
        throw Exception('Bad request: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        }
        
        return UpdateProfileModel.fromJson(response.data);
      } else if (response.statusCode == 422) {
        // Handle validation errors
        final errorData = response.data;
        if (errorData is Map<String, dynamic>) {
          final errors = errorData['errors'] ?? errorData;
          if (errors is Map<String, dynamic>) {
            final errorMessages = [];
            errors.forEach((key, value) {
              if (value is List) {
                errorMessages.addAll(value);
              } else {
                errorMessages.add(value.toString());
              }
            });
            throw Exception(errorMessages.join(', '));
          }
        }
        throw Exception('Validation failed: ${response.data}');
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Error type: ${e.type}');
      print('Status code: ${e.response?.statusCode}');
      
      if (e.response != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            throw Exception(errorData['message']);
          }
          if (errorData.containsKey('error')) {
            throw Exception(errorData['error']);
          }
        }
      }
      
      throw Exception('Failed to update profile: ${e.message}');
    } catch (e) {
      print('Exception caught during profile update: $e');
      rethrow;
    }
  }

  // Alternative method if the first one fails with specific field names
  Future<UpdateProfileModel?> updateProfileWithFieldNames({
    String? name,
    String? newPassword,
    String? confirmPassword,
    required String passwordField,
    required String confirmField,
  }) async {
    try {
      final dio = await getDioInstance();

      final Map<String, dynamic> updateData = {};
      
      if (name != null && name.isNotEmpty) {
        updateData['name'] = name;
      }
      
      if (newPassword != null && newPassword.isNotEmpty) {
        updateData[passwordField] = newPassword;
        updateData[confirmField] = confirmPassword;
      }

      print('Trying field names: $passwordField, $confirmField');
      print('Sending update data: $updateData');

      final response = await dio.put(
        '/users/me',
        data: updateData,
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) return null;
        return UpdateProfileModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(response.data['message'] ?? 'Bad request');
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
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
      print('Profile update failed: $e');
      
      // If it fails with standard field names, try alternatives
      if (newPassword != null && newPassword.isNotEmpty) {
        try {
          // Try different field name combinations
          final combinations = [
            {'password': 'password', 'confirm': 'password_confirmation'},
            {'password': 'new_password', 'confirm': 'confirm_password'},
            {'password': 'newPassword', 'confirm': 'confirmPassword'},
            {'password': 'pass', 'confirm': 'cpass'},
          ];
          
          for (final combo in combinations) {
            try {
              final result = await updateProfileWithFieldNames(
                name: name,
                newPassword: newPassword,
                confirmPassword: confirmPassword,
                passwordField: combo['password']!,
                confirmField: combo['confirm']!,
              );
              return result?.success ?? false;
            } catch (e) {
              print('Failed with ${combo['password']}/${combo['confirm']}: $e');
              continue;
            }
          }
        } catch (e) {
          print('All field name combinations failed: $e');
        }
      }
      
      return false;
    }
  }
}