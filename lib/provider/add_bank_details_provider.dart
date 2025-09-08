import 'package:dmboss/service/add_bank_details_service.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
//import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:dmboss/model/add_bank_details_model.dart';

class AddBankDetailsProvider extends ChangeNotifier {
  bool _isLoading = false;
  AddBankDetails? _bankDetails;
  String? _errorMessage;
  String? _successMessage;

  String? _accountHolderName;
  String? _accountNumber;
  String? _ifscCode;

  bool get isLoading => _isLoading;
  AddBankDetails? get bankDetails => _bankDetails;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String get accountHolderName => _accountHolderName ?? '';
  String get accountNumber => _accountNumber ?? '';
  String get ifscCode => _ifscCode ?? '';

  void setAccountHolderName(String value) {
    _accountHolderName = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setAccountNumber(String value) {
    _accountNumber = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setIfscCode(String value) {
    _ifscCode = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  // Clear all fields
  void clearFields() {
    _accountHolderName = null;
    _accountNumber = null;
    _ifscCode = null;
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
    return _accountHolderName != null &&
        _accountHolderName!.isNotEmpty &&
        _accountNumber != null &&
        _accountNumber!.isNotEmpty &&
        _ifscCode != null &&
        _ifscCode!.isNotEmpty;
  }

  Future<void> addBankDetails(
    BuildContext context,
    AddBankDetails addBankDetails,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final bankService = AddBankDetailsService();

      final result = await bankService.postBankDetails(context, addBankDetails);
      // .then((_) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => AppNavigationBar()),
      //   );
      // }
      // );

      _isLoading = false;

      if (result != null) {
        _bankDetails = result;
       // _successMessage = 'Bank details added successfully';

        clearFields();
        showCustomSnackBar(
          context: context,
          message: "Bank Details added Successfully..!!",
          backgroundColor: Colors.green,
          durationSeconds: 3,
        );
      } else {
        showCustomSnackBar(
          context: context,
          message: "Failed Adding Bank Details",
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Add bank details error: $e');

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
