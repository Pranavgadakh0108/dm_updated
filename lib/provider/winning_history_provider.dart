import 'package:dmboss/model/winning_history_model.dart';
import 'package:dmboss/service/winning_history_service.dart';
import 'package:flutter/material.dart';

class WinningHistoryProvider extends ChangeNotifier {
  WinningHistoryModel? _winningHistoryModel;
  String? _errorMessage;
  bool _isLoading = false;

  WinningHistoryModel? get winningHistoryModel => _winningHistoryModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getWinningHistory(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = WinningHistoryService();
    final result = await service.getWinningHistory(context);

    if (result != null) {
      _winningHistoryModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Winning History.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
