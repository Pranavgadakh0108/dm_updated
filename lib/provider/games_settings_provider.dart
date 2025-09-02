import 'package:dmboss/model/game_settings_model.dart';
import 'package:dmboss/service/get_game_settings.dart';
import 'package:flutter/material.dart';

class GamesSettingsProvider extends ChangeNotifier {
  GameSettings? _gameSettings;
  String? _errorMessage;
  bool _isLoading = false;

  GameSettings? get gameSettings => _gameSettings;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getGameSettings(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetGameSettingsService();
    final result = await service.getGameSettings(context);

    if (result != null) {
      _gameSettings = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Game Settings.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
