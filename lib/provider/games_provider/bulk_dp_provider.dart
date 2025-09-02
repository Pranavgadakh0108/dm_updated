
import 'package:dmboss/model/games_model/bulk_sp_model.dart';
import 'package:dmboss/service/games_service/bulk_sp_service.dart';
import 'package:flutter/material.dart';

class BulkDpBetProvider extends ChangeNotifier {
  bool _isLoading = false;
  BulkSpModel _bulkSpModel = BulkSpModel(
    gameId: "",
    gameType: "",
    bulkSp: [],
  );
  Map<String, dynamic>? _betResponse;

  bool get isLoading => _isLoading;
  BulkSpModel get bulkSpModel => _bulkSpModel;
  Map<String, dynamic>? get betResponse => _betResponse;

  void updateBulkSpModel(BulkSpModel model) {
    _bulkSpModel = model;
    notifyListeners();
  }

  Future<void> placeBulkSpBet(
    BuildContext context,
    BulkSpModel bulkSpModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final bulkSpBetService = BulkSpBetService();
    final response = await bulkSpBetService.placeBulkSpBet(
      context,
      bulkSpModel,
    );

    _isLoading = false;

    if (response != null) {
      _betResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bulk DP bet placed successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to place bulk DP bet"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void resetBulkSpModel() {
    _bulkSpModel = BulkSpModel(
      gameId: "",
      gameType: "",
      bulkSp: [],
    );
    notifyListeners();
  }

  // Individual setters for each property
  void setGameId(String value) {
    _bulkSpModel = BulkSpModel(
      gameId: value,
      gameType: _bulkSpModel.gameType,
      bulkSp: _bulkSpModel.bulkSp,
    );
    notifyListeners();
  }

  void setGameType(String value) {
    _bulkSpModel = BulkSpModel(
      gameId: _bulkSpModel.gameId,
      gameType: value,
      bulkSp: _bulkSpModel.bulkSp,
    );
    notifyListeners();
  }

  // Methods to manage the bulkSp list
  void addBulkSpItem(BulkSp item) {
    _bulkSpModel = BulkSpModel(
      gameId: _bulkSpModel.gameId,
      gameType: _bulkSpModel.gameType,
      bulkSp: [..._bulkSpModel.bulkSp, item],
    );
    notifyListeners();
  }

  void removeBulkSpItem(int index) {
    final newBulkSpList = List<BulkSp>.from(_bulkSpModel.bulkSp);
    newBulkSpList.removeAt(index);
    _bulkSpModel = BulkSpModel(
      gameId: _bulkSpModel.gameId,
      gameType: _bulkSpModel.gameType,
      bulkSp: newBulkSpList,
    );
    notifyListeners();
  }

  void updateBulkSpItem(int index, BulkSp newItem) {
    final newBulkSpList = List<BulkSp>.from(_bulkSpModel.bulkSp);
    newBulkSpList[index] = newItem;
    _bulkSpModel = BulkSpModel(
      gameId: _bulkSpModel.gameId,
      gameType: _bulkSpModel.gameType,
      bulkSp: newBulkSpList,
    );
    notifyListeners();
  }

  void clearBulkSpItems() {
    _bulkSpModel = BulkSpModel(
      gameId: _bulkSpModel.gameId,
      gameType: _bulkSpModel.gameType,
      bulkSp: [],
    );
    notifyListeners();
  }

  // Helper method to get total amount from all bulkSp items
  int getTotalAmount() {
    return _bulkSpModel.bulkSp.fold(0, (sum, item) => sum + item.amount);
  }

  // Helper method to get count of bulkSp items
  int getBulkSpCount() {
    return _bulkSpModel.bulkSp.length;
  }
}