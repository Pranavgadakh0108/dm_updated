// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/service/add_deposite_points_manual.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:dmboss/model/deposite_manual_points.dart';

class AddDepositePointsManualProvider extends ChangeNotifier {
  bool _isLoading = false;
  DepositeManualPoints? _depositePoints;
  String? _errorMessage;
  String? _successMessage;

  String? _amount;
  String? _transactionId;
  String? _paymentMethod;
  String? _remarks;

  bool get isLoading => _isLoading;
  DepositeManualPoints? get depositePoints => _depositePoints;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String get amount => _amount ?? '';
  String get transactionId => _transactionId ?? '';
  String get paymentMethod => _paymentMethod ?? '';
  String get remarks => _remarks ?? '';

  void setAmount(String value) {
    _amount = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setTransactionId(String value) {
    _transactionId = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setPaymentMethod(String value) {
    _paymentMethod = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setRemarks(String value) {
    _remarks = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void clearFields() {
    _amount = null;
    _transactionId = null;
    _paymentMethod = null;
    _remarks = null;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  bool get isFormValid {
    return _amount != null &&
        _amount!.isNotEmpty &&
        _transactionId != null &&
        _transactionId!.isNotEmpty &&
        _paymentMethod != null &&
        _paymentMethod!.isNotEmpty;
  }

  Future<void> addDepositePointsManual(
    BuildContext context,
    DepositeManualPoints depositeManualPoints,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final depositeService = AddDepositePointsManual();

      final result = await depositeService
          .postDepositeManualDetails(context, depositeManualPoints)
          .then((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AppNavigationBar()),
            );
          });

      _isLoading = false;

      //if (result != null) {
      if (result == null) {
        _depositePoints = result;

        _successMessage = 'Deposit points submitted successfully';

        clearFields();

        showCustomSnackBar(
          context: context,
          message: "Deposite points submitted Successfully",
          backgroundColor: Colors.green,
          durationSeconds: 2,
        );
      } else {
        _errorMessage = 'Failed to submit deposit points';
        showCustomSnackBar(
          context: context,
          message: _errorMessage!,
          backgroundColor: Colors.redAccent,
          durationSeconds: 2,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();

      showCustomSnackBar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.redAccent,
        durationSeconds: 2,
      );
    }

    notifyListeners();
  }
}
