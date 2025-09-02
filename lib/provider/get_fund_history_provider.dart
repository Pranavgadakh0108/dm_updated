import 'package:dmboss/model/fund_history.dart';
import 'package:dmboss/service/get_fund_history.dart';
import 'package:flutter/material.dart';

class GetFundHistoryProvider extends ChangeNotifier {
  FundHistoryModel? _fundHistoryModel;
  String? _errorMessage;
  bool _isLoading = false;

  FundHistoryModel? get gamesList => _fundHistoryModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getFundHistory(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetFundHistory();
    final result = await service.getFundHistoryService(context);

    if (result != null) {
      _fundHistoryModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Fund History.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
