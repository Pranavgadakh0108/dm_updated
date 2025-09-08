import 'package:dmboss/model/withdraw_coins_model.dart';
import 'package:dmboss/service/withdraw_points_service.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class WithdrawCoinsProvider extends ChangeNotifier {
  bool _isLoading = false;
  WithdrawCoinsModel? _depositePoints;
  String? _errorMessage;
  String? _successMessage;

  String? _amount;

  bool get isLoading => _isLoading;
  WithdrawCoinsModel? get depositePoints => _depositePoints;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String get amount => _amount ?? '';

  void setAmount(String value) {
    _amount = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  // Clear all fields
  void clearFields() {
    _amount = null;

    notifyListeners();
  }

  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Check if all required fields are filled
  bool get isFormValid {
    return _amount != null && _amount!.isNotEmpty;
  }

  Future<void> addWithdrawCoins(
    BuildContext context,
    WithdrawCoinsModel withDrawCoinsModel,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final depositeService = WithdrawPointsService();

      final result = await depositeService.withdrawPointsService(
        context,
        withDrawCoinsModel,
      );

      _isLoading = false;

      if (result != null) {
        _depositePoints = result;
        _successMessage = 'Withdraw coins submitted successfully';

        clearFields();

        showCustomSnackBar(
          context: context,
          message: "Withdraw Coins submitted Successfully",
          backgroundColor: Colors.green,
          durationSeconds: 3,
        );
      } else {
        _errorMessage = 'Failed to submit withdraw coins';
        showCustomSnackBar(
          context: context,
          message: _errorMessage!,
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Add deposit points error: $e');

      showCustomSnackBar(
          context: context,
          message: e.toString(),
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
    }

    notifyListeners();
  }
}
