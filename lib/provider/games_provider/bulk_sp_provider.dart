import 'package:dmboss/model/games_model/bulk_model.dart';
import 'package:dmboss/service/games_service/bulk_service.dart';
import 'package:flutter/material.dart';

class BulkSPProvider extends ChangeNotifier {
  bool _isLoading = false;
  BulkModel _bulkModel = BulkModel(
    gameId: "",
    gameType: "",
    bulkSp: [],
  );
  Map<String, dynamic>? _betResponse;

  bool get isLoading => _isLoading;
  BulkModel get bulkModel => _bulkModel;
  Map<String, dynamic>? get betResponse => _betResponse;

  void updateBulkModel(BulkModel model) {
    _bulkModel = model;
    notifyListeners();
  }

  Future<void> placeBulkBet(
    BuildContext context,
    BulkModel bulkModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final bulkBetService = BulkBetService();
    final response = await bulkBetService.placeBulkBet(
      context,
      bulkModel,
    );

    _isLoading = false;

    if (response != null) {
      _betResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bulk bet placed successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to place bulk bet"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void resetBulkModel() {
    _bulkModel = BulkModel(
      gameId: "",
      gameType: "",
      bulkSp: [],
    );
    notifyListeners();
  }

  // Individual setters for each property
  void setGameId(String value) {
    _bulkModel = BulkModel(
      gameId: value,
      gameType: _bulkModel.gameType,
      bulkSp: _bulkModel.bulkSp,
    );
    notifyListeners();
  }

  void setGameType(String value) {
    _bulkModel = BulkModel(
      gameId: _bulkModel.gameId,
      gameType: value,
      bulkSp: _bulkModel.bulkSp,
    );
    notifyListeners();
  }

  // Methods to manage bulkSp list
  void addBulkSpItem(BulkSp item) {
    _bulkModel = BulkModel(
      gameId: _bulkModel.gameId,
      gameType: _bulkModel.gameType,
      bulkSp: [..._bulkModel.bulkSp, item],
    );
    notifyListeners();
  }

  void removeBulkSpItem(int index) {
    final newBulkSp = List<BulkSp>.from(_bulkModel.bulkSp);
    newBulkSp.removeAt(index);
    _bulkModel = BulkModel(
      gameId: _bulkModel.gameId,
      gameType: _bulkModel.gameType,
      bulkSp: newBulkSp,
    );
    notifyListeners();
  }

  void updateBulkSpItem(int index, BulkSp newItem) {
    final newBulkSp = List<BulkSp>.from(_bulkModel.bulkSp);
    newBulkSp[index] = newItem;
    _bulkModel = BulkModel(
      gameId: _bulkModel.gameId,
      gameType: _bulkModel.gameType,
      bulkSp: newBulkSp,
    );
    notifyListeners();
  }

  void clearBulkSp() {
    _bulkModel = BulkModel(
      gameId: _bulkModel.gameId,
      gameType: _bulkModel.gameType,
      bulkSp: [],
    );
    notifyListeners();
  }

  // Helper method to get total amount of all bulkSp items
  int get totalAmount {
    return _bulkModel.bulkSp.fold(0, (sum, item) => sum + item.amount);
  }

  // Helper method to get count of bulkSp items
  int get itemCount {
    return _bulkModel.bulkSp.length;
  }

  // Check if bulkSp is empty
  bool get isBulkSpEmpty {
    return _bulkModel.bulkSp.isEmpty;
  }
}