import 'package:dmboss/model/games_model.dart';
import 'package:dmboss/service/game_market_service.dart';
import 'package:flutter/material.dart';

class GameMarketProvider extends ChangeNotifier {
  GamesModel? _gamesModel;
  String? _errorMessage;
  bool _isLoading = false;
  String? _selectedGameId;

  GamesModel? get gamesModel => _gamesModel;

  List<Game>? get gamesList => _gamesModel?.games;

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  String? get selectedGameId => _selectedGameId;

  Future<void> getGames(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GameMarketService();
    final result = await service.getGamesService(context);

    if (result != null) {
      _gamesModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch games.';
      _gamesModel = null;
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

  Game? getGameById(String gameId) {
    if (_gamesModel?.games == null) return null;
    return _gamesModel?.games.firstWhere(
      (game) => game.id == gameId,
      orElse: () => throw Exception('Game not found'),
    );
  }
}
