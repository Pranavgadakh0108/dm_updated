import 'package:dmboss/model/how_to_play_model.dart';
import 'package:dmboss/service/how_to_play_service.dart';
import 'package:flutter/material.dart';

class HowToPlayProvider extends ChangeNotifier {
  HowToPlayModel? _howToPlayData;
  String? _errorMessage;
  bool _isLoading = false;

  HowToPlayModel? get howToPlayData => _howToPlayData;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Getter methods for easy access to the nested data
  String get howToPlay => _howToPlayData?.data.howToPlay ?? '';
  String get howToDeposit => _howToPlayData?.data.howToDeposite ?? '';
  String get howToWithdraw => _howToPlayData?.data.howToWithdraw ?? '';

  Future<void> getHowToPlayInfo(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = HowToPlayService();
    final result = await service.getHowToPlayService(context);

    if (result != null && result.success) {
      _howToPlayData = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch help information.';
      _howToPlayData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Helper method to check if data is available
  bool get hasData => _howToPlayData != null && _howToPlayData!.success;

  // Helper method to get all help sections as a map for easy access
  Map<String, String> getHelpSections() {
    if (_howToPlayData == null) return {};
    
    return {
      'How to Play': _howToPlayData!.data.howToPlay,
      'How to Deposit': _howToPlayData!.data.howToDeposite,
      'How to Withdraw': _howToPlayData!.data.howToWithdraw,
    };
  }

  // Clear the stored data
  void clearData() {
    _howToPlayData = null;
    _errorMessage = null;
    notifyListeners();
  }
}