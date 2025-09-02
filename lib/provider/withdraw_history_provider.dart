import 'package:dmboss/model/withdraw_history_model.dart';
import 'package:dmboss/service/withdraw_history_service.dart';
import 'package:flutter/material.dart';

class GetWithdrawHistoryProvider extends ChangeNotifier {
  WithdrawHistoryModel? _withdrawHistoryModel;
  String? _errorMessage;
  bool _isLoading = false;

  WithdrawHistoryModel? get withdrawHistoryModel => _withdrawHistoryModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> withdrawHistory(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = WithdrawHistoryService();
    final result = await service.withDrawHistoryService(context);

    if (result != null) {
      _withdrawHistoryModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Withdraw History.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
