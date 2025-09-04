// import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
// import 'package:dmboss/service/games_service/bulk_jodi_service.dart';
// import 'package:flutter/material.dart';

// class BulkJodiBetProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   BulkJodiModel _bulkJodiModel = BulkJodiModel(
//     gameId: "",
//     gameType: "",
//     bulkJodi: [],
//     userId: "",
//     gameDate: DateTime.now(),
//   );
//   Map<String, dynamic>? _betResponse;

//   bool get isLoading => _isLoading;
//   BulkJodiModel get bulkJodiModel => _bulkJodiModel;
//   Map<String, dynamic>? get betResponse => _betResponse;

//   void updateBulkJodiModel(BulkJodiModel model) {
//     _bulkJodiModel = model;
//     notifyListeners();
//   }

//   Future<void> placeBulkJodiBet(
//     BuildContext context,
//     BulkJodiModel bulkJodiModel,
//   ) async {
//     _isLoading = true;
//     notifyListeners();

//     final bulkJodiBetService = BulkJodiBetService();
//     final response = await bulkJodiBetService.placeBulkJodiBet(
//       context,
//       bulkJodiModel,
//     );

//     _isLoading = false;

//     if (response != null) {
//       _betResponse = response;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Bulk Jodi bet placed successfully!"),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Failed to place bulk jodi bet"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }

//     notifyListeners();
//   }

//   void resetBulkJodiModel() {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: "",
//       gameType: "",
//       bulkJodi: [],
//       userId: "",
//       gameDate: DateTime.now(),
//     );
//     notifyListeners();
//   }

//   // Individual setters for each property
//   void setGameId(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: value,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setGameType(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: value,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setBulkJodi(List<BulkJodi> value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: value,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setUserId(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: value,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setGameDate(DateTime value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: value,
//     );
//     notifyListeners();
//   }

//   // Helper methods for managing bulk jodi list
//   void addJodi(BulkJodi jodi) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList.add(jodi);
//     setBulkJodi(updatedList);
//   }

//   void removeJodi(int index) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList.removeAt(index);
//     setBulkJodi(updatedList);
//   }

//   void updateJodi(int index, BulkJodi jodi) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList[index] = jodi;
//     setBulkJodi(updatedList);
//   }

//   void clearAllJodi() {
//     setBulkJodi([]);
//   }
// }

// import 'package:dmboss/model/games_model/bulk_jodi_model.dart';
// import 'package:dmboss/service/games_service/bulk_jodi_service.dart';
// import 'package:flutter/material.dart';

// class BulkJodiBetProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   BulkJodiModel _bulkJodiModel = BulkJodiModel(
//     gameId: "",
//     gameType: "",
//     bulkJodi: [],
//     userId: "",
//     gameDate: DateTime.now(),
//   );
//   Map<String, dynamic>? _betResponse;

//   bool get isLoading => _isLoading;
//   BulkJodiModel get bulkJodiModel => _bulkJodiModel;
//   Map<String, dynamic>? get betResponse => _betResponse;

//   void updateBulkJodiModel(BulkJodiModel model) {
//     _bulkJodiModel = model;
//     notifyListeners();
//   }

//   Future<void> placeBulkJodiBet(BulkJodiModel bulkJodiModel) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final bulkJodiBetService = BulkJodiBetService();
//       final response = await bulkJodiBetService.placeBulkJodiBet(bulkJodiModel);

//       _betResponse = response;

//       if (response != null && response['success'] == true) {
//         // Success is handled by the service via global key
//       } else {
//         // Error is handled by the service via global key
//       }
//     } catch (error) {
//       // Any unexpected errors are handled by the service via global key
//       _betResponse = {'success': false, 'error': error.toString()};
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void resetBulkJodiModel() {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: "",
//       gameType: "",
//       bulkJodi: [],
//       userId: "",
//       gameDate: DateTime.now(),
//     );
//     _betResponse = null;
//     notifyListeners();
//   }

//   // Individual setters for each property
//   void setGameId(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: value,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setGameType(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: value,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setBulkJodi(List<BulkJodi> value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: value,
//       userId: _bulkJodiModel.userId,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setUserId(String value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: value,
//       gameDate: _bulkJodiModel.gameDate,
//     );
//     notifyListeners();
//   }

//   void setGameDate(DateTime value) {
//     _bulkJodiModel = BulkJodiModel(
//       gameId: _bulkJodiModel.gameId,
//       gameType: _bulkJodiModel.gameType,
//       bulkJodi: _bulkJodiModel.bulkJodi,
//       userId: _bulkJodiModel.userId,
//       gameDate: value,
//     );
//     notifyListeners();
//   }

//   // Helper methods for managing bulk jodi list
//   void addJodi(BulkJodi jodi) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList.add(jodi);
//     setBulkJodi(updatedList);
//   }

//   void removeJodi(int index) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList.removeAt(index);
//     setBulkJodi(updatedList);
//   }

//   void updateJodi(int index, BulkJodi jodi) {
//     final updatedList = List<BulkJodi>.from(_bulkJodiModel.bulkJodi);
//     updatedList[index] = jodi;
//     setBulkJodi(updatedList);
//   }

//   void clearAllJodi() {
//     setBulkJodi([]);
//   }

//   // Helper method to get total bet amount
//   int getTotalBetAmount() {
//     return _bulkJodiModel.bulkJodi.fold(0, (sum, jodi) => sum + jodi.amount);
//   }

//   // Helper method to check if a specific jodi exists
//   bool containsJodi(String jodi) {
//     return _bulkJodiModel.bulkJodi.any((element) => element.jodi == jodi);
//   }

//   // Helper method to get amount for a specific jodi
//   int getAmountForJodi(String jodi) {
//     final jodiEntry = _bulkJodiModel.bulkJodi.firstWhere(
//       (element) => element.jodi == jodi,
//       orElse: () => BulkJodi(jodi: jodi, amount: 0),
//     );
//     return jodiEntry.amount;
//   }

//   // Method to validate if the model is ready for submission
//   bool isReadyForSubmission() {
//     return _bulkJodiModel.gameId.isNotEmpty &&
//         _bulkJodiModel.gameType.isNotEmpty &&
//         _bulkJodiModel.userId.isNotEmpty &&
//         _bulkJodiModel.bulkJodi.isNotEmpty;
//   }

//   // Method to get summary of bets
//   Map<String, dynamic> getBetSummary() {
//     return {
//       'totalBets': _bulkJodiModel.bulkJodi.length,
//       'totalAmount': getTotalBetAmount(),
//       'gameId': _bulkJodiModel.gameId,
//       'gameType': _bulkJodiModel.gameType,
//     };
//   }
// }

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
