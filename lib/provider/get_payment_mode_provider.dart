import 'package:dmboss/model/get_payment_mode_model.dart';
import 'package:dmboss/service/get_payment_mode_service.dart';
import 'package:flutter/material.dart';

class GetPaymentModeProvider extends ChangeNotifier {
  GetPaymentMode? _getPaymentMode;
  String? _errorMessage;
  bool _isLoading = false;

  GetPaymentMode? get gamesList => _getPaymentMode;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getPaymentMode(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetPaymentModeService();
    final result = await service.getPaymentMode(context);

    if (result != null) {
      _getPaymentMode = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Payment mode.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
