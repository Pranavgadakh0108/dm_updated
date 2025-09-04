import 'package:dmboss/model/game_rate_model.dart';
import 'package:dmboss/service/game_rate.dart';
import 'package:flutter/material.dart';

class GetGameRatesProvider extends ChangeNotifier {
  GameRatesModel? _gameRatesModel;
  String? _errorMessage;
  bool _isLoading = false;

  GameRatesModel? get gameRatesModel => _gameRatesModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getGameRates(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetGameRateService();
    final result = await service.getGameRateService(context);

    if (result != null) {
      _gameRatesModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch games rates.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
