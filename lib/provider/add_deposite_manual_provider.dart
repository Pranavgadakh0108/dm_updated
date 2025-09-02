import 'package:dmboss/service/add_deposite_points_manual.dart';
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

  // Clear all fields
  void clearFields() {
    _amount = null;
    _transactionId = null;
    _paymentMethod = null;
    _remarks = null;
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

      final result = await depositeService.postDepositeManualDetails(
        context,
        depositeManualPoints,
      );

      _isLoading = false;

      if (result != null) {
        _depositePoints = result;
        _successMessage = 'Deposit points submitted successfully';

        clearFields();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deposit points submitted successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        _errorMessage = 'Failed to submit deposit points';
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
      print('Add deposit points error: $e');

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
}
