// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/model/games_model/bulk_dp_model.dart';
import 'package:dmboss/service/games_service/bulk_dp_service.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class BulkDpBetProvider extends ChangeNotifier {
  bool _isLoading = false;
  BulkDpModel _bulkDpModel = BulkDpModel(
    gameId: "",
    gameType: "gameType",
    bulkDp: [],
  );
  Map<String, dynamic>? _betResponse;

  bool get isLoading => _isLoading;
  BulkDpModel get bulkDpModel => _bulkDpModel;
  Map<String, dynamic>? get betResponse => _betResponse;

  get bulkDpBetService => null;

  void updateBulkDpModel(BulkDpModel model) {
    _bulkDpModel = model;
    notifyListeners();
  }

  Future<void> placeBulkDpBet(
    BuildContext context,
    BulkDpModel bulkDpModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final bulkDpBetService = BulkDpBetService();
    final response = await bulkDpBetService.placeBulkDpBet(
      context,
      bulkDpModel,
    );

    _isLoading = false;

    if (response != null) {
      print("--------------------------------------");
      print(response);
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

  void resetBulkDpModel() {
    _bulkDpModel = BulkDpModel(gameId: "", gameType: "", bulkDp: []);
    notifyListeners();
  }

  // Individual setters for each property
  void setGameId(String value) {
    _bulkDpModel = BulkDpModel(
      gameId: value,
      gameType: _bulkDpModel.gameType,
      bulkDp: _bulkDpModel.bulkDp,
    );
    notifyListeners();
  }

  void setGameType(String value) {
    _bulkDpModel = BulkDpModel(
      gameId: _bulkDpModel.gameId,
      gameType: value,
      bulkDp: _bulkDpModel.bulkDp,
    );
    notifyListeners();
  }

  // Methods to manage the bulkSp list
  void addBulkDpItem(BulkDp item) {
    _bulkDpModel = BulkDpModel(
      gameId: _bulkDpModel.gameId,
      gameType: _bulkDpModel.gameType,
      bulkDp: [..._bulkDpModel.bulkDp, item],
    );
    notifyListeners();
  }

  void removeBulkDpItem(int index) {
    final newBulkDpList = List<BulkDp>.from(_bulkDpModel.bulkDp);
    newBulkDpList.removeAt(index);
    _bulkDpModel = BulkDpModel(
      gameId: _bulkDpModel.gameId,
      gameType: _bulkDpModel.gameType,
      bulkDp: newBulkDpList,
    );
    notifyListeners();
  }

  void updateBulkDpItem(int index, BulkDp newItem) {
    final newBulkDpList = List<BulkDp>.from(_bulkDpModel.bulkDp);
    newBulkDpList[index] = newItem;
    _bulkDpModel = BulkDpModel(
      gameId: _bulkDpModel.gameId,
      gameType: _bulkDpModel.gameType,
      bulkDp: newBulkDpList,
    );
    notifyListeners();
  }

  void clearBulkDpItems() {
    _bulkDpModel = BulkDpModel(
      gameId: _bulkDpModel.gameId,
      gameType: _bulkDpModel.gameType,
      bulkDp: [],
    );
    notifyListeners();
  }

  // Helper method to get total amount from all bulkSp items
  int getTotalAmount() {
    return _bulkDpModel.bulkDp.fold(0, (sum, item) => sum + item.amount);
  }

  // Helper method to get count of bulkSp items
  int getBulkDpCount() {
    return _bulkDpModel.bulkDp.length;
  }
}
