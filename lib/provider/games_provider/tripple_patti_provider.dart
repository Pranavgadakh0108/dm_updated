import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/service/games_service/single_ank_service.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class TripplePattiProvider extends ChangeNotifier {
  bool _isLoading = false;
  SingleAnkModel _singleAnkModel = SingleAnkModel(
    gameId: "",
    gameType: "",
    number: "",
    amount: 0,
  );
  Map<String, dynamic>? _betResponse;
  // Track if we've shown the success message for the current operation
  bool _hasShownSuccess = false;

  bool get isLoading => _isLoading;
  SingleAnkModel get singleAnkModel => _singleAnkModel;
  Map<String, dynamic>? get betResponse => _betResponse;

  void updateSingleAnkModel(SingleAnkModel model) {
    _singleAnkModel = model;
    notifyListeners();
  }

  Future<void> placeSingleAnkBet(
    BuildContext context,
    SingleAnkModel singleAnkModel,
  ) async {
    _isLoading = true;
    _hasShownSuccess = false; // Reset for new operation
    notifyListeners();

    final singleAnkBetService = SingleAnkBetService();
    final response = await singleAnkBetService.placeSingleAnkBet(
      context,
      singleAnkModel,
    );

    _isLoading = false;

    if (response != null) {
      _betResponse = response;
      // Only show success if we haven't shown it already
      if (!_hasShownSuccess) {
        showCustomSnackBar(
          context: context,
          message: "Bet placed successfully!",
          backgroundColor: Colors.green,
          durationSeconds: 2,
        );
        _hasShownSuccess = true; // Mark as shown
      }
    } else {
      showCustomSnackBar(
        context: context,
        message: "Failed to place bet",
        backgroundColor: Colors.redAccent,
        durationSeconds: 2,
      );
    }

    notifyListeners();
  }

  void resetSingleAnkModel() {
    _singleAnkModel = SingleAnkModel(
      gameId: "",
      gameType: "",
      number: "",
      amount: 0,
    );
    _hasShownSuccess = false; // Reset when model is reset
    notifyListeners();
  }

  // Individual setters for each property
  void setGameId(String value) {
    _singleAnkModel = SingleAnkModel(
      gameId: value,
      gameType: _singleAnkModel.gameType,
      number: _singleAnkModel.number,
      amount: _singleAnkModel.amount,
    );
    notifyListeners();
  }

  void setGameType(String value) {
    _singleAnkModel = SingleAnkModel(
      gameId: _singleAnkModel.gameId,
      gameType: value,
      number: _singleAnkModel.number,
      amount: _singleAnkModel.amount,
    );
    notifyListeners();
  }

  void setNumber(String value) {
    _singleAnkModel = SingleAnkModel(
      gameId: _singleAnkModel.gameId,
      gameType: _singleAnkModel.gameType,
      number: value,
      amount: _singleAnkModel.amount,
    );
    notifyListeners();
  }

  void setAmount(int value) {
    _singleAnkModel = SingleAnkModel(
      gameId: _singleAnkModel.gameId,
      gameType: _singleAnkModel.gameType,
      number: _singleAnkModel.number,
      amount: value,
    );
    notifyListeners();
  }
}
