// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/model/payment_gateway_model.dart';
import 'package:dmboss/model/payment_gateway_response.dart';
import 'package:dmboss/service/post_payment_gateway.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class PaymentGatewayProvider extends ChangeNotifier {
  bool _isLoading = false;
  PaymentGatewayResponse? _paymentGatewayResponse;
  String? _errorMessage;
  String? _successMessage;

  String? _amount;
  String? _name;
  String? _phone;
  String? _redirectUrl;

  bool get isLoading => _isLoading;
  PaymentGatewayResponse? get paymentGatewayResponse => _paymentGatewayResponse;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String get amount => _amount ?? '';
  String get name => _name ?? '';
  String get phone => _phone ?? '';
  String get redirectUrl => _redirectUrl ?? '';

  void setAmount(String value) {
    _amount = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setName(String value) {
    _name = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void setRedirectUrl(String value) {
    _redirectUrl = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void clearFields() {
    _amount = null;
    _name = null;
    _phone = null;
    _redirectUrl = null;
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
        _name != null &&
        _name!.isNotEmpty &&
        _phone != null &&
        _phone!.isNotEmpty &&
        _redirectUrl != null &&
        _redirectUrl!.isNotEmpty;
  }

  Future<void> postPaymentGateway(
    BuildContext context,
    PaymentGatewayIntegration paymentGateWayIntegration,
    String method,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final service = PostPaymentGateway();

      final result = await service
          .postPaymentGateway(context, paymentGateWayIntegration, method)
          .then((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AppNavigationBar()),
            );
          });

      if (result != null) {
        _paymentGatewayResponse = result;
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to fetch withdraw count.';
      }

      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      print('Add Payment details error: $e');

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
