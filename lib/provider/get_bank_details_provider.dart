import 'package:dmboss/model/get_bank_details_model.dart';
import 'package:dmboss/service/get_bank_details.dart';
import 'package:flutter/material.dart';

class GetBankDetailsProvider extends ChangeNotifier {
  GetBankDetailsModel? _getBankDetailsProvider;
  String? _errorMessage;
  bool _isLoading = false;

  GetBankDetailsModel? get gamesList => _getBankDetailsProvider;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getBankDetails(BuildContext context, String? userId) async {
    _isLoading = true;
    notifyListeners();

    final service = GetBankDetails();
    final result = await service.getBankDetailsService(context, userId);

    if (result != null) {
      _getBankDetailsProvider = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch games.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
