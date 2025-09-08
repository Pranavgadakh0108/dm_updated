import 'package:dmboss/model/games_model.dart';
import 'package:dmboss/service/game_market_service.dart';
import 'package:flutter/material.dart';

class GameMarketProvider extends ChangeNotifier {
  GamesModel? _gamesModel; // Changed from List<GamesModel> to GamesModel
  String? _errorMessage;
  bool _isLoading = false;
  String? _selectedGameId;

  // Getter for the entire games model
  GamesModel? get gamesModel => _gamesModel;

  // Getter for the list of games (convenience accessor)
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
      _gamesModel = result; // Store the entire GamesModel
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

  // Helper method to get a specific game by ID
  Game? getGameById(String gameId) {
    if (_gamesModel?.games == null) return null;
    return _gamesModel?.games.firstWhere(
      (game) => game.id == gameId,
      orElse: () => throw Exception('Game not found'),
    );
  }

  // Helper method to get a specific game by market name
  // Game? getGameByMarketName(String marketName) {
  //   if (_gamesModel?.games == null) return null;
  //   return _gamesModel?.games.firstWhere(
  //     (game) =>
  //         game.bazar?.toLowerCase().contains(marketName.toLowerCase()) ||
  //         marketName.toLowerCase().contains(game.bazar?.toLowerCase()),
  //     orElse: () => throw Exception('Game not found'),
  //   );
  // }
}
