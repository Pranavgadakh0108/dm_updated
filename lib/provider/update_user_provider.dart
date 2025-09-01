// import 'package:dmboss/service/update_user.dart';
// import 'package:flutter/material.dart';
// import 'package:dmboss/model/update_profile_model.dart';

// class ProfileUpdateProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   UpdateProfileModel? _updateProfileModel;
//   String? _errorMessage;
//   String? _successMessage;

//   // Form fields - use null to represent "no change"
//   String? _name;
//   String? _newPassword;
//   String? _confirmPassword;

//   // Store original user data
//   User? _originalUser;

//   bool get isLoading => _isLoading;
//   UpdateProfileModel? get updateProfileModel => _updateProfileModel;
//   String? get errorMessage => _errorMessage;
//   String? get successMessage => _successMessage;

//   // Form field getters - return empty string for null values for text fields
//   String get name => _name ?? '';
//   String get newPassword => _newPassword ?? '';
//   String get confirmPassword => _confirmPassword ?? '';

//   // Set original user data
//   void setOriginalUser(User user) {
//     _originalUser = user;
//     // Prefill name with original value
//     _name = user.name;
//     notifyListeners();
//   }

//   // Update form fields
//   void setName(String value) {
//     _name = value.isNotEmpty ? value : _originalUser?.name;
//     notifyListeners();
//   }

//   void setNewPassword(String value) {
//     _newPassword = value.isNotEmpty ? value : null;
//     notifyListeners();
//   }

//   void setConfirmPassword(String value) {
//     _confirmPassword = value.isNotEmpty ? value : null;
//     notifyListeners();
//   }

//   // Clear messages
//   void clearMessages() {
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//   }

//   // Reset form to original values
//   void resetForm() {
//     if (_originalUser != null) {
//       _name = _originalUser!.name;
//     } else {
//       _name = null;
//     }
//     _newPassword = null;
//     _confirmPassword = null;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//   }

//   // Check if any field has been changed
//   bool get hasChanges {
//     if (_originalUser == null) return false;

//     final nameChanged = _name != null && _name != _originalUser!.name;
//     final passwordChanged = _newPassword != null && _newPassword!.isNotEmpty;

//     return nameChanged || passwordChanged;
//   }

//   // Update profile method
//   Future<void> updateProfile(BuildContext context) async {
//     // If no changes, show message and return
//     if (!hasChanges) {
//       _successMessage = 'No changes to update';
//       notifyListeners();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No changes to update'),
//           backgroundColor: Colors.blue,
//         ),
//       );
//       return;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();

//     try {
//       final profileService = UpdateProfileService();

//       // Prepare data for service (only send non-null values)
//       final String? nameToSend = _name != _originalUser?.name ? _name : null;
//       final String? passwordToSend = _newPassword?.isNotEmpty == true ? _newPassword : null;
//       final String? confirmToSend = _confirmPassword?.isNotEmpty == true ? _confirmPassword : null;

//       final response = await profileService.updateProfile(
//         name: nameToSend,
//         newPassword: passwordToSend,
//         confirmPassword: confirmToSend,
//       );

//       _isLoading = false;

//       if (response != null && response.success) {
//         _updateProfileModel = response;
//         _successMessage = response.message;

//         // Update original user data with new values
//         if (response.user != null) {
//           _originalUser = response.user;
//           // Reset name to the updated value
//           _name = response.user!.name;
//         }

//         print("---------------------------");
//         print(name);
//         print(newPassword);
//         print(confirmPassword);

//         // Clear password fields after successful update
//         _newPassword = null;
//         _confirmPassword = null;

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(response.message),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         _errorMessage = response?.message ?? 'Failed to update profile';
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(_errorMessage!),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.toString()}'),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }

//     notifyListeners();
//   }

//   // Simple update method without context
//   Future<bool> updateProfileSimple() async {
//     if (!hasChanges) {
//       _successMessage = 'No changes to update';
//       notifyListeners();
//       return true;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();

//     try {
//       final profileService = UpdateProfileService();

//       // Prepare data for service (only send non-null values)
//       final String? nameToSend = _name != _originalUser?.name ? _name : null;
//       final String? passwordToSend = _newPassword?.isNotEmpty == true ? _newPassword : null;
//       final String? confirmToSend = _confirmPassword?.isNotEmpty == true ? _confirmPassword : null;

//       final success = await profileService.updateProfileSimple(
//         name: nameToSend,
//         newPassword: passwordToSend,
//         confirmPassword: confirmToSend,
//       );

//       _isLoading = false;

//       if (success) {
//         _successMessage = 'Profile updated successfully';
//         // Clear password fields after successful update
//         _newPassword = null;
//         _confirmPassword = null;
//         return true;
//       } else {
//         _errorMessage = 'Failed to update profile';
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }

//   // Validate form
//   bool validateForm() {
//     // If no changes, it's technically valid (but update won't proceed)
//     if (!hasChanges) {
//       return true;
//     }

//     // Only validate passwords if password field is filled
//     if (_newPassword != null && _newPassword!.isNotEmpty) {
//       if (_confirmPassword == null || _confirmPassword!.isEmpty) {
//         _errorMessage = 'Please confirm your new password';
//         notifyListeners();
//         return false;
//       }

//       if (_newPassword != _confirmPassword) {
//         _errorMessage = 'New password and confirmation do not match';
//         notifyListeners();
//         return false;
//       }

//       if (_newPassword!.length < 8) {
//         _errorMessage = 'Password must be at least 8 characters long';
//         notifyListeners();
//         return false;
//       }
//     }

//     return true;
//   }

//   // Get current values for display
//   String get currentName => _originalUser?.name ?? '';

//   // Check if name field is modified
//   bool get isNameModified => _name != null && _name != _originalUser?.name;

//   // Check if password fields are filled
//   bool get isPasswordFilled => _newPassword != null && _newPassword!.isNotEmpty;
// }

// import 'package:dmboss/service/update_user.dart';
// import 'package:flutter/material.dart';
// import 'package:dmboss/model/update_profile_model.dart';

// class ProfileUpdateProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   UpdateProfileModel? _updateProfileModel;
//   String? _errorMessage;
//   String? _successMessage;

//   // Form fields - use null to represent "no change"
//   String? _name;
//   String? _newPassword;
//   String? _confirmPassword;

//   // Store original user data
//   User? _originalUser;

//   // Controllers for text fields (added)
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   bool get isLoading => _isLoading;
//   UpdateProfileModel? get updateProfileModel => _updateProfileModel;
//   String? get errorMessage => _errorMessage;
//   String? get successMessage => _successMessage;

//   // Form field getters - return empty string for null values for text fields
//   String get name => _name ?? '';
//   String get newPassword => _newPassword ?? '';
//   String get confirmPassword => _confirmPassword ?? '';

//   // Set original user data
//   void setOriginalUser(User user) {
//     _originalUser = user;
//     // Prefill name with original value
//     _name = user.name;
//     nameController.text = user.name; // Initialize controller
//     notifyListeners();
//   }

//   // Update form fields
//   void setName(String value) {
//     _name = value.isNotEmpty ? value : _originalUser?.name;
//     notifyListeners();
//   }

//   void setNewPassword(String value) {
//     _newPassword = value.isNotEmpty ? value : null;
//     notifyListeners();
//   }

//   void setConfirmPassword(String value) {
//     _confirmPassword = value.isNotEmpty ? value : null;
//     notifyListeners();
//   }

//   // Clear messages
//   void clearMessages() {
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//   }

//   // Reset form to original values
//   void resetForm() {
//     if (_originalUser != null) {
//       _name = _originalUser!.name;
//       nameController.text = _originalUser!.name;
//     } else {
//       _name = null;
//       nameController.clear();
//     }
//     _newPassword = null;
//     _confirmPassword = null;
//     newPasswordController.clear();
//     confirmPasswordController.clear();
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//   }

//   // Check if any field has been changed
//   bool get hasChanges {
//     if (_originalUser == null) return false;
//     print(nameController.text);
//     print("---------------------------");
//     print(_originalUser!.name);
//     final nameChanged = nameController.text != _originalUser!.name;
//     final passwordChanged = newPasswordController.text.isNotEmpty;

//     return nameChanged || passwordChanged;
//   }

//   // Update profile method - UPDATED VERSION
//   Future<void> updateProfile(BuildContext context) async {
//     // If no changes, show message and return
//     if (!hasChanges) {
//       _successMessage = 'No changes to update';
//       notifyListeners();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No changes to update'),
//           backgroundColor: Colors.blue,
//         ),
//       );
//       return;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();

//     try {
//       final profileService = UpdateProfileService();

//       // Get the actual values from controllers (not from provider state)
//       final String? nameToSend = nameController.text != _originalUser?.name
//           ? nameController.text
//           : null;

//       final String? passwordToSend = newPasswordController.text.isNotEmpty
//           ? newPasswordController.text
//           : null;

//       final String? confirmToSend = confirmPasswordController.text.isNotEmpty
//           ? confirmPasswordController.text
//           : null;

//       print('Sending to API - Name: $nameToSend, Password: ${passwordToSend != null ? "***" : "null"}');

//       final response = await profileService.updateProfile(
//         name: nameToSend,
//         newPassword: passwordToSend,
//         confirmPassword: confirmToSend,
//       );

//       _isLoading = false;

//       if (response != null && response.success) {
//         _updateProfileModel = response;
//         _successMessage = response.message;

//         // Update original user data with new values
//         if (response.user != null) {
//           _originalUser = response.user;
//           // Update the name controller with the new name
//           nameController.text = response.user!.name;
//           _name = response.user!.name;
//         }

//         // Clear password fields after successful update
//         newPasswordController.clear();
//         confirmPasswordController.clear();
//         _newPassword = null;
//         _confirmPassword = null;

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(response.message),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       } else {
//         _errorMessage = response?.message ?? 'Failed to update profile';
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(_errorMessage!),
//             backgroundColor: Colors.redAccent,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       print('Update error: $e');

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.toString()}'),
//           backgroundColor: Colors.redAccent,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }

//     notifyListeners();
//   }

//   // Simple update method without context - UPDATED VERSION
//   Future<bool> updateProfileSimple() async {
//     if (!hasChanges) {
//       _successMessage = 'No changes to update';
//       notifyListeners();
//       return true;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();

//     try {
//       final profileService = UpdateProfileService();

//       // Get the actual values from controllers
//       final String? nameToSend = nameController.text != _originalUser?.name
//           ? nameController.text
//           : null;

//       final String? passwordToSend = newPasswordController.text.isNotEmpty
//           ? newPasswordController.text
//           : null;

//       final String? confirmToSend = confirmPasswordController.text.isNotEmpty
//           ? confirmPasswordController.text
//           : null;

//       final success = await profileService.updateProfileSimple(
//         name: nameToSend,
//         newPassword: passwordToSend,
//         confirmPassword: confirmToSend,
//       );

//       _isLoading = false;

//       if (success) {
//         _successMessage = 'Profile updated successfully';
//         // Clear password fields after successful update
//         newPasswordController.clear();
//         confirmPasswordController.clear();
//         _newPassword = null;
//         _confirmPassword = null;
//         return true;
//       } else {
//         _errorMessage = 'Failed to update profile';
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _errorMessage = e.toString();
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }

//   // Validate form - UPDATED VERSION
//   bool validateForm() {
//     // If no changes, it's technically valid (but update won't proceed)
//     if (!hasChanges) {
//       return true;
//     }

//     // Only validate passwords if password field is filled
//     if (newPasswordController.text.isNotEmpty) {
//       if (confirmPasswordController.text.isEmpty) {
//         _errorMessage = 'Please confirm your new password';
//         notifyListeners();
//         return false;
//       }

//       if (newPasswordController.text != confirmPasswordController.text) {
//         _errorMessage = 'New password and confirmation do not match';
//         notifyListeners();
//         return false;
//       }

//       if (newPasswordController.text.length < 6) {
//         _errorMessage = 'Password must be at least 6 characters long';
//         notifyListeners();
//         return false;
//       }
//     }

//     return true;
//   }

//   // Get current values for display
//   String get currentName => _originalUser?.name ?? '';

//   // Check if name field is modified
//   bool get isNameModified => nameController.text != _originalUser?.name;

//   // Check if password fields are filled
//   bool get isPasswordFilled => newPasswordController.text.isNotEmpty;

//   // Dispose controllers
//   void dispose() {
//     nameController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
// }

import 'package:dmboss/service/update_user.dart';
import 'package:flutter/material.dart';
import 'package:dmboss/model/update_profile_model.dart';

class ProfileUpdateProvider extends ChangeNotifier {
  bool _isLoading = false;
  UpdateProfileModel? _updateProfileModel;
  String? _errorMessage;
  String? _successMessage;

  // Form fields - use null to represent "no change"
  String? _name;
  String? _newPassword;
  String? _confirmPassword;

  // Store original user data
  User? _originalUser;

  // Controllers for text fields (added)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool get isLoading => _isLoading;
  UpdateProfileModel? get updateProfileModel => _updateProfileModel;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Form field getters - return empty string for null values for text fields
  String get name => _name ?? '';
  String get newPassword => _newPassword ?? '';
  String get confirmPassword => _confirmPassword ?? '';

  // Set original user data
  void setOriginalUser(User user) {
    _originalUser = user;
    // Prefill name with original value
    _name = user.name;
    nameController.text = user.name; // Initialize controller
    notifyListeners();
  }

  // Update form fields
  void setName(String value) {
    _name = value.isNotEmpty ? value : _originalUser?.name;
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

  // Reset form to original values
  void resetForm() {
    if (_originalUser != null) {
      _name = _originalUser!.name;
      nameController.text = _originalUser!.name;
    } else {
      _name = null;
      nameController.clear();
    }
    _newPassword = null;
    _confirmPassword = null;
    newPasswordController.clear();
    confirmPasswordController.clear();
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Check if any field has been changed
  bool get hasChanges {
    if (_originalUser == null) return false;

    final nameChanged = nameController.text != _originalUser!.name;
    final passwordChanged = newPasswordController.text.isNotEmpty;

    return nameChanged || passwordChanged;
  }

  // Update profile method - UPDATED VERSION
  Future<void> updateProfile(BuildContext context) async {
    // If no changes, show message and return
    if (!hasChanges) {
      _successMessage = 'No changes to update';
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No changes to update'),
          backgroundColor: Colors.blue,
        ),
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final profileService = UpdateProfileService();

      // Get the actual values from controllers (not from provider state)
      final String? nameToSend = nameController.text != _originalUser?.name
          ? nameController.text
          : null;

      final String? passwordToSend = newPasswordController.text.isNotEmpty
          ? newPasswordController.text
          : null;

      final String? confirmToSend = confirmPasswordController.text.isNotEmpty
          ? confirmPasswordController.text
          : null;

      print(
        'Sending to API - Name: $nameToSend, Password: ${passwordToSend != null ? "***" : "null"}',
      );

      // Use the simple method that handles field name variations
      final success = await profileService.updateProfileSimple(
        name: nameToSend,
        newPassword: passwordToSend,
        confirmPassword: confirmToSend,
      );

      _isLoading = false;

      if (success) {
        _successMessage = 'Profile updated successfully';

        // Update original user data with new values from controllers
        if (nameToSend != null) {
          _originalUser = User(
            id: _originalUser!.id,
            name: nameController.text,
            email: _originalUser!.email,
            mobile: _originalUser!.mobile,
            wallet: _originalUser!.wallet,
            session: _originalUser!.session,
            code: _originalUser!.code,
            createdAt: _originalUser!.createdAt,
            active: _originalUser!.active,
            verify: _originalUser!.verify,
            transferPointsStatus: _originalUser!.transferPointsStatus,
            paytm: _originalUser!.paytm,
            pin: _originalUser!.pin,
            refcode: _originalUser!.refcode,
            refId: _originalUser!.refId,
            ipAddress: _originalUser!.ipAddress,
            createdA: _originalUser!.ipAddress,
            updatedAt: _originalUser!.updatedAt,
            v: _originalUser!.v,
          );
          _name = nameController.text;
        }

        // Clear password fields after successful update
        newPasswordController.clear();
        confirmPasswordController.clear();
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

  // Simple update method without context - UPDATED VERSION
  Future<bool> updateProfileSimple() async {
    if (!hasChanges) {
      _successMessage = 'No changes to update';
      notifyListeners();
      return true;
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final profileService = UpdateProfileService();

      // Get the actual values from controllers
      final String? nameToSend = nameController.text != _originalUser?.name
          ? nameController.text
          : null;

      final String? passwordToSend = newPasswordController.text.isNotEmpty
          ? newPasswordController.text
          : null;

      final String? confirmToSend = confirmPasswordController.text.isNotEmpty
          ? confirmPasswordController.text
          : null;

      final success = await profileService.updateProfileSimple(
        name: nameToSend,
        newPassword: passwordToSend,
        confirmPassword: confirmToSend,
      );

      _isLoading = false;

      if (success) {
        _successMessage = 'Profile updated successfully';
        // Update original user data if name was changed
        if (nameToSend != null) {
          _originalUser = User(
            id: _originalUser!.id,
            name: nameController.text,
            email: _originalUser!.email,
            mobile: _originalUser!.mobile,
            wallet: _originalUser!.wallet,
            session: _originalUser!.session,
            code: _originalUser!.code,
            createdAt: _originalUser!.createdAt,
            active: _originalUser!.active,
            verify: _originalUser!.verify,
            transferPointsStatus: _originalUser!.transferPointsStatus,
            paytm: _originalUser!.paytm,
            pin: _originalUser!.pin,
            refcode: _originalUser!.refcode,
            refId: _originalUser!.refId,
            ipAddress: _originalUser!.ipAddress,
            createdA: _originalUser!.ipAddress,
            updatedAt: _originalUser!.updatedAt,
            v: _originalUser!.v,
          );
          _name = nameController.text;
        }

        // Clear password fields after successful update
        newPasswordController.clear();
        confirmPasswordController.clear();
        _newPassword = null;
        _confirmPassword = null;
        return true;
      } else {
        _errorMessage = 'Failed to update profile';
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      return false;
    } finally {
      notifyListeners();
    }
  }

  // Validate form - UPDATED VERSION
  bool validateForm() {
    // If no changes, it's technically valid (but update won't proceed)
    if (!hasChanges) {
      return true;
    }

    // Only validate passwords if password field is filled
    if (newPasswordController.text.isNotEmpty) {
      if (confirmPasswordController.text.isEmpty) {
        _errorMessage = 'Please confirm your new password';
        notifyListeners();
        return false;
      }

      if (newPasswordController.text != confirmPasswordController.text) {
        _errorMessage = 'New password and confirmation do not match';
        notifyListeners();
        return false;
      }

      if (newPasswordController.text.length < 6) {
        _errorMessage = 'Password must be at least 6 characters long';
        notifyListeners();
        return false;
      }
    }

    return true;
  }

  // Get current values for display
  String get currentName => _originalUser?.name ?? '';

  // Check if name field is modified
  bool get isNameModified => nameController.text != _originalUser?.name;

  // Check if password fields are filled
  bool get isPasswordFilled => newPasswordController.text.isNotEmpty;

  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
