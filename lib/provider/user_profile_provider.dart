import 'package:dmboss/service/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:dmboss/model/user_profile_model.dart';

class UserProfileProvider extends ChangeNotifier {
  UserModel? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;
  final UserProfileService _userProfileService = UserProfileService();

  UserModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final profile = await _userProfileService.getUserProfile();

      if (profile != null && profile.success) {
        _userProfile = profile;
        _errorMessage = null;

        if (kDebugMode) {
          print('User profile fetched successfully:');
          print('Name: ${profile.user.name}');

          print('Wallet: ${profile.user.wallet}');
          print('Mobile: ${profile.user.mobile}');
        }
      } else {
        _errorMessage = profile?.message ?? 'Failed to fetch user profile';
        if (kDebugMode) {
          print('Failed to fetch user profile: $_errorMessage');
        }
      }
    } catch (e) {
      _errorMessage = 'An error occurred while fetching profile: $e';
      if (kDebugMode) {
        print('Exception in fetchUserProfile: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile({
    String? name,
    // String? email,
    String? paytm,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedProfile = await _userProfileService.updateUserProfile(
        name: name,
        // email: email,
        paytm: paytm,
      );

      if (updatedProfile != null && updatedProfile.success) {
        _userProfile = updatedProfile;
        _errorMessage = null;

        if (kDebugMode) {
          print('User profile updated successfully');
        }

        notifyListeners();
        return true;
      } else {
        _errorMessage = updatedProfile?.message ?? 'Failed to update profile';
        if (kDebugMode) {
          print('Failed to update profile: $_errorMessage');
        }
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred while updating profile: $e';
      if (kDebugMode) {
        print('Exception in updateUserProfile: $e');
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshUserProfile() async {
    await fetchUserProfile();
  }
}
