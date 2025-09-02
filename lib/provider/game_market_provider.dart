import 'package:dmboss/model/games_model.dart';
import 'package:dmboss/service/game_market_service.dart';
import 'package:flutter/material.dart';

class GameMarketProvider extends ChangeNotifier {
  List<GamesModel>? _gamesList;
  String? _errorMessage;
  bool _isLoading = false;
  String? _selectedGameId;

  List<GamesModel>? get gamesList => _gamesList;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  String? get selectedGameId => _selectedGameId;

  Future<void> getGames(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GameMarketService();
    final result = await service.getGamesService(context);

    if (result != null) {
      _gamesList = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch games.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedGameId(String gameId) {
    _selectedGameId = gameId;
    notifyListeners();
  }

  void clearSelectedGameId() {
    _selectedGameId = null;
    notifyListeners();
  }

  // Get the selected game object
  GamesModel? getSelectedGame() {
    if (_selectedGameId == null || _gamesList == null) return null;
    return _gamesList!.firstWhere(
      (game) => game.id == _selectedGameId,
      orElse: () => GamesModel(
        id: '',
        game: '',
        bazar: '',
        open: '',
        close: '',
        days: '',
        active: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      ),
    );
  }

  // Optional: Helper method to get games by bazar type
  List<GamesModel>? getGamesByBazar(String bazarType) {
    return _gamesList?.where((game) => game.bazar == bazarType).toList();
  }

  // Optional: Helper method to get active games only
  List<GamesModel>? getActiveGames() {
    return _gamesList?.where((game) => game.active).toList();
  }

  // Optional: Helper method to get games by day
  List<GamesModel>? getGamesByDay(String day) {
    return _gamesList?.where((game) => game.days.contains(day)).toList();
  }
}
