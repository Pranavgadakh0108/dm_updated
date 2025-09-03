import 'package:dmboss/model/pending_withdraw_count.dart';
import 'package:dmboss/service/get_deposite_count.dart';
import 'package:flutter/material.dart';

class GetPendingDepositeCountProvider extends ChangeNotifier {
  PendingWithdrawCountModel? _pendingWithdrawCountModel;
  String? _errorMessage;
  bool _isLoading = false;

  PendingWithdrawCountModel? get pendingWithdrawCountModel =>
      _pendingWithdrawCountModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getDepositePendingCount(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = PendingDepositeCountService();
    final result = await service.getDepositeHistory(context);

    if (result != null) {
      _pendingWithdrawCountModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Deposite count.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
