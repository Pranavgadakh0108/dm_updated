import 'package:dmboss/model/register_user_model.dart';
import 'package:dmboss/service/register_user.dart';
import 'package:flutter/material.dart';

class RegisterUserProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  RegisterUserModel? _registerResponse;
  // String? _email;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RegisterUserModel? get registerResponse => _registerResponse;
  // String? get email => _email;

  // Set email for registration
  // void setEmail(String value) {
  //   _email = value;
  //   notifyListeners();
  // }

  // Clear all state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _registerResponse = null;
    // _email = null;
    notifyListeners();
  }

  // Register user
  Future<bool> registerUser({
    required String mobile,
    required String name,
    //required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    if (name.isEmpty || password.isEmpty) {
      _errorMessage = "All fields are required";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final authService = AuthService();
    final response = await authService.registerUser(
      mobile: mobile,
      name: name,
      // email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    _isLoading = false;

    if (response != null && response.success) {
      _registerResponse = response;
      _errorMessage = null;
      notifyListeners();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      _errorMessage = response?.message ?? "Registration failed";
      notifyListeners();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  // Simple registration without full response
  // Future<bool> registerUserSimple({
  //   required String mobile,
  //   required String name,
  //   required String email,
  //   required String password, // Added password parameter
  //   required BuildContext context,
  // }) async {
  //   if (name.isEmpty || email.isEmpty || password.isEmpty) {
  //     _errorMessage = "All fields are required";
  //     notifyListeners();
  //     return false;
  //   }

  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   final authService = AuthService();
  //   final response = await authService.registerUserSimple(
  //     mobile: mobile,
  //     name: name,
  //     email: email,
  //     password: password, // Pass password to service
  //   );

  //   _isLoading = false;

  //   if (response == true) {
  //     _errorMessage = null;
  //     notifyListeners();

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Registration successful!"),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     return true;
  //   } else {
  //     _errorMessage = "Registration failed";
  //     notifyListeners();

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(_errorMessage!),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return false;
  //   }
  // }
}
