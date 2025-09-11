// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/model/mobile_exist_model.dart';
import 'package:dmboss/service/mobile_exist.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class MobileCheckProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _mobileExists = false;
  String _mobileNumber = '';
  String? _errorMessage;
  MobileExistModel? _mobileExistResponse;

  bool get isLoading => _isLoading;
  bool get mobileExists => _mobileExists;
  String get mobileNumber => _mobileNumber;
  String? get errorMessage => _errorMessage;
  MobileExistModel? get mobileExistResponse => _mobileExistResponse;

  void setMobileNumber(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _mobileExists = false;
    _mobileNumber = '';
    _errorMessage = null;
    _mobileExistResponse = null;
    notifyListeners();
  }

  Future<void> checkMobileExists(
    BuildContext context,
    String mobileNumber,
  ) async {
    if (mobileNumber.isEmpty) {
      _errorMessage = "Mobile number is required";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _mobileExistResponse = null;
    notifyListeners();

    final authService = AuthService();
    final response = await authService.checkMobileExists(mobileNumber, context);

    _isLoading = false;

    if (response != null) {
      _mobileExistResponse = response;
      _mobileExists = response.exists;

      if (response.exists) {
        showCustomSnackBar(
          context: context,
          message: "Mobile number already exists",
          backgroundColor: Colors.green,
          durationSeconds: 2,
        );
      } else {
        showCustomSnackBar(
          context: context,
          message: "Mobile number not Exist. Register First.",
          backgroundColor: Colors.orange,
          durationSeconds: 2,
        );
      }
    } else {
      _errorMessage = "Failed to check mobile number";

      showCustomSnackBar(
        context: context,
        message: "Failed to check mobile number",
        backgroundColor: Colors.red,
        durationSeconds: 2,
      );
    }

    notifyListeners();
  }

  Future<bool?> checkMobileExistsSimple(String mobileNumber) async {
    if (mobileNumber.isEmpty) {
      _errorMessage = "Mobile number is required";
      notifyListeners();
      return null;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final authService = AuthService();
    final response = await authService.checkMobileExistsSimple(mobileNumber);

    _isLoading = false;

    if (response != null) {
      _mobileExists = response;
      _errorMessage = null;
      notifyListeners();
      return response;
    } else {
      _errorMessage = "Failed to check mobile number";
      notifyListeners();
      return null;
    }
  }
}
