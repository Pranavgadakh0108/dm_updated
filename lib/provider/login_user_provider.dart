// import 'package:dmboss/model/login_user_model.dart';
// import 'package:dmboss/service/login_user.dart';
// import 'package:flutter/material.dart';

// class LoginUserProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   LoginUserModel? _loginResponse;
//   String? _mobile;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   LoginUserModel? get loginResponse => _loginResponse;
//   String? get mobile => _mobile;

//   // Set mobile for login
//   void setMobile(String value) {
//     _mobile = value;
//     notifyListeners();
//   }

//   // Clear all state
//   void reset() {
//     _isLoading = false;
//     _errorMessage = null;
//     _loginResponse = null;
//     _mobile = null;
//     notifyListeners();
//   }

//   // Login user
//   Future<bool> loginUser({
//     required String mobile,
//     required String password,
//     required BuildContext context,
//   }) async {
//     if (mobile.isEmpty || password.isEmpty) {
//       _errorMessage = "Mobile number and password are required";
//       notifyListeners();
//       return false;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     final authService = AuthService();
//     final response = await authService.loginUser(
//       mobile: mobile,
//       password: password,
//     );

//     _isLoading = false;

//     if (response != null && response.success) {
//       _loginResponse = response;
//       _errorMessage = null;
//       notifyListeners();

//       // Store login data (token, user info)
//       await authService.storeLoginData(response);

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response.message),
//           backgroundColor: Colors.green,
//         ),
//       );
//       return true;
//     } else {
//       _errorMessage = response?.message ?? "Login failed. Please check your credentials.";
//       notifyListeners();

//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(_errorMessage!),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }
//   }

//   // Simple login without full response
//   Future<bool> loginUserSimple({
//     required String mobile,
//     required String password,
//     required BuildContext context,
//   }) async {
//     if (mobile.isEmpty || password.isEmpty) {
//       _errorMessage = "Mobile number and password are required";
//       notifyListeners();
//       return false;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     final authService = AuthService();
//     final response = await authService.loginUserSimple(
//       mobile: mobile,
//       password: password,
//     );

//     _isLoading = false;

//     if (response == true) {
//       _errorMessage = null;
//       notifyListeners();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Login successful!"),
//           backgroundColor: Colors.green,
//         ),
//       );
//       return true;
//     } else {
//       _errorMessage = "Login failed. Please check your credentials.";
//       notifyListeners();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(_errorMessage!),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/model/login_user_model.dart';
import 'package:dmboss/service/login_user.dart';
import 'package:flutter/material.dart';

class LoginUserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  LoginUserModel? _loginResponse;
  String? _mobile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginUserModel? get loginResponse => _loginResponse;
  String? get mobile => _mobile;

  // Set mobile for login
  void setMobile(String value) {
    _mobile = value;
    notifyListeners();
  }

  // Clear all state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _loginResponse = null;
    _mobile = null;
    notifyListeners();
  }

  // Login user
  Future<bool> loginUser({
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    if (mobile.isEmpty || password.isEmpty) {
      _errorMessage = "Mobile number and password are required";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final authService = AuthService();
    final response = await authService.loginUser(
      mobile: mobile,
      password: password,
    );

    _isLoading = false;

    if (response != null && response.success) {
      _loginResponse = response;
      _errorMessage = null;
      notifyListeners();

      // Store login data (token, user info) - This now properly stores the token
      await authService.storeLoginData(response);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      _errorMessage =
          response?.message ?? "Login failed. Please check your credentials.";
      notifyListeners();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  // Simple login without full response
  Future<bool> loginUserSimple({
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    if (mobile.isEmpty || password.isEmpty) {
      _errorMessage = "Mobile number and password are required";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final authService = AuthService();
    final response = await authService.loginUserSimple(
      mobile: mobile,
      password: password,
    );

    _isLoading = false;

    if (response == true) {
      _errorMessage = null;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      _errorMessage = "Login failed. Please check your credentials.";
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  // Check login status
  Future<bool> checkLoginStatus() async {
    final authService = AuthService();
    return await authService.isLoggedIn();
  }

  // Get stored token
  Future<String?> getStoredToken() async {
    final authService = AuthService();
    return await authService.getStoredToken();
  }

  // Logout
  // Future<void> logout() async {
  //   clearAuthData(context);
  //   reset(); // Reset provider state
  // }
}
