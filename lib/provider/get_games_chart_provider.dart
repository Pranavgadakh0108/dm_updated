import 'package:dmboss/model/get_charts_data_model.dart';
import 'package:dmboss/service/get_chart_data_service.dart';
import 'package:flutter/material.dart';

class GetGamesChartProvider extends ChangeNotifier {
  GetChartDataModel? _getChartDataModel;
  String? _errorMessage;
  bool _isLoading = false;

  GetChartDataModel? get getChartDataModel => _getChartDataModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void resetData() {
    _getChartDataModel = null;
    notifyListeners();
  }

  Future<void> getChartDataProvider(
    BuildContext context,
    String marketId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = GetChartDataService();
    final result = await service.getChartData(context, marketId);

    if (result != null) {
      _getChartDataModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Games Chart.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
