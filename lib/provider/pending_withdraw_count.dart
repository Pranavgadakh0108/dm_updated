import 'package:dmboss/model/pending_withdraw_count.dart';
import 'package:dmboss/service/pending_withdraw_count.dart';
import 'package:flutter/material.dart';

class GetPendingWithdrawCountProvider extends ChangeNotifier {
  PendingWithdrawCountModel? _pendingWithdrawCountModel;
  String? _errorMessage;
  bool _isLoading = false;

  PendingWithdrawCountModel? get pendingWithdrawCountModel =>
      _pendingWithdrawCountModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getWithdrawPendingCount(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = PendingWithdrawCountService();
    final result = await service.getWithDrawHistory(context);

    if (result != null) {
      _pendingWithdrawCountModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch withdraw count.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
