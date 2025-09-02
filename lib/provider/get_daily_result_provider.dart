import 'package:dmboss/model/daily_result_model.dart';
import 'package:dmboss/service/daily_result_service.dart';
import 'package:flutter/material.dart';

class GetDailyResultProvider extends ChangeNotifier {
  DailyResultModel? _dailyResultModel;
  String? _errorMessage;
  bool _isLoading = false;

  DailyResultModel? get gamesList => _dailyResultModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getDailyResult(BuildContext context, String marketId) async {
    _isLoading = true;
    notifyListeners();

    final service = GetDailyResultService();
    final result = await service.getResultService(context, marketId);

    if (result != null) {
      _dailyResultModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Result.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
