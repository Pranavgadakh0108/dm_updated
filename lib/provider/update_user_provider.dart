import 'package:dmboss/service/update_user.dart';
import 'package:flutter/material.dart';
import 'package:dmboss/model/update_profile_model.dart';

class ProfileUpdateProvider extends ChangeNotifier {
  bool _isLoading = false;
  UpdateProfileModel? _updateProfileModel;
  String? _errorMessage;
  String? _successMessage;

  String? _name;
  String? _newPassword;
  String? _confirmPassword;

  bool get isLoading => _isLoading;
  UpdateProfileModel? get updateProfileModel => _updateProfileModel;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String get name => _name ?? '';
  String get newPassword => _newPassword ?? '';
  String get confirmPassword => _confirmPassword ?? '';

  void setName(String value) {
    _name = value.isNotEmpty ? value : _updateProfileModel?.user.name;
    notifyListeners();
  }

  void setNewPassword(String value) {
    _newPassword = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final profileService = UpdateProfileService();

      // Use the service method that returns UpdateProfileModel
      final result = await profileService.updateProfile(
        name: _name,
        newPassword: _newPassword,
        confirmPassword: _confirmPassword,
      );

      _isLoading = false;

      if (result != null && result.success) {
        _updateProfileModel = result;
        _successMessage = 'Profile updated successfully';

        // Clear password fields after successful update
        _newPassword = null;
        _confirmPassword = null;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        _errorMessage = 'Failed to update profile';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Update error: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    notifyListeners();
  }

  // Alternative simple method that returns boolean
  Future<bool> updateProfileSimple() async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final profileService = UpdateProfileService();

      final success = await profileService.updateProfileSimple(
        name: _name,
        newPassword: _newPassword,
        confirmPassword: _confirmPassword,
      );

      _isLoading = false;

      if (success) {
        _successMessage = 'Profile updated successfully';
        _newPassword = null;
        _confirmPassword = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to update profile';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Update error: $e');
      notifyListeners();
      return false;
    }
  }
}
