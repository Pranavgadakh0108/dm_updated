import 'package:dmboss/model/transaction_history_model.dart';
import 'package:dmboss/service/transaction_history_service.dart';
import 'package:flutter/material.dart';

class GetTransactionHistoryProvider extends ChangeNotifier {
  TransactionHistoryModel? _transactionHistoryModel;
  String? _errorMessage;
  bool _isLoading = false;

  TransactionHistoryModel? get transactionHistoryModel =>
      _transactionHistoryModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getTransactionHistoryFunc(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetTransactionHistoryService();
    final result = await service.getTransactionHistory(context);

    if (result != null) {
      _transactionHistoryModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Transaction History.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
