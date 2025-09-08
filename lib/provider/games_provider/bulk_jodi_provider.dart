

import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
import 'package:dmboss/service/games_service/bulk_jodi_service.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class BulkJodiBetProvider extends ChangeNotifier {
  bool _isLoading = false;
  BulkJodiModel _bulkJodiModel = BulkJodiModel(
    gameId: "",
    gameType: "",
    bulkJodi: [],
    userId: "",
    gameDate: DateTime.now(),
  );
  Map<String, dynamic>? _betResponse;

  bool get isLoading => _isLoading;
  BulkJodiModel get bulkJodiModel => _bulkJodiModel;
  Map<String, dynamic>? get betResponse => _betResponse;

  void updateBulkJodiModel(BulkJodiModel model) {
    _bulkJodiModel = model;
    notifyListeners();
  }

  Future<void> placeBulkJodiBet(
    BuildContext context,
    BulkJodiModel bulkJodiModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final bulkJodiBetService = BulkJodiBetService();
    final response = await bulkJodiBetService.placeBulkJodiBet(
      context,
      bulkJodiModel,
    );

    _isLoading = false;

    if (response != null) {
      _betResponse = response;
      showCustomSnackBar( 
        context: context,
        message: "Bet placed successfully!",
        backgroundColor: Colors.green,
        durationSeconds: 2,
      );
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

  void resetBulkJodiModel() {
    _bulkJodiModel = BulkJodiModel(
      gameId: "",
      gameType: "",
      bulkJodi: [],
      userId: "",
      gameDate: DateTime.now(),
    );
    notifyListeners();
  }

  // Individual setters for each property
  void setGameId(String value) {
    _bulkJodiModel = BulkJodiModel(
      gameId: value,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: _bulkJodiModel.bulkJodi,
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void setGameType(String value) {
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: value,
      bulkJodi: _bulkJodiModel.bulkJodi,
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void setUserId(String value) {
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: _bulkJodiModel.bulkJodi,
      userId: value,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void setGameDate(DateTime value) {
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: _bulkJodiModel.bulkJodi,
      userId: _bulkJodiModel.userId,
      gameDate: value,
    );
    notifyListeners();
  }

  // Methods to manage the bulkJodi list
  void addBulkJodiItem(BulkJodi item) {
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: [..._bulkJodiModel.bulkJodi, item],
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void removeBulkJodiItem(int index) {
    final newBulkJodiList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
    newBulkJodiList.removeAt(index);
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: newBulkJodiList,
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void updateBulkJodiItem(int index, BulkJodi newItem) {
    final newBulkJodiList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
    newBulkJodiList[index] = newItem;
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: newBulkJodiList,
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  void clearBulkJodiItems() {
    _bulkJodiModel = BulkJodiModel(
      gameId: _bulkJodiModel.gameId,
      gameType: _bulkJodiModel.gameType,
      bulkJodi: [],
      userId: _bulkJodiModel.userId,
      gameDate: _bulkJodiModel.gameDate,
    );
    notifyListeners();
  }

  // Helper method to get total amount from all bulkJodi items
  int getTotalAmount() {
    return _bulkJodiModel.bulkJodi.fold(0, (sum, item) => sum + item.amount);
  }

  // Helper method to get count of bulkJodi items
  int getBulkJodiCount() {
    return _bulkJodiModel.bulkJodi.length;
  }

  // Helper method to check if bulkJodi list is empty
  bool isBulkJodiEmpty() {
    return _bulkJodiModel.bulkJodi.isEmpty;
  }

  // Helper method to get a specific bulkJodi item by index
  BulkJodi? getBulkJodiItem(int index) {
    if (index >= 0 && index < _bulkJodiModel.bulkJodi.length) {
      return _bulkJodiModel.bulkJodi[index];
    }
    return null;
  }
}
