import 'package:dmboss/service/game_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:dmboss/model/game_rate_model.dart';

class GameRateProvider extends ChangeNotifier {
  GameRatesModel? _gameRates;
  bool _isLoading = false;
  String? _errorMessage;
  final GameRateService _gameRateService = GameRateService();

  GameRatesModel? get gameRates => _gameRates;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchGameRates() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final numeric = await _gameRateService.getGameRates();

      if (numeric != null && numeric.success) {
        _gameRates = numeric;
        _errorMessage = null;

        if (kDebugMode) {
          print('Game numeric fetched successfully');
          print('Single rate: ${numeric.numeric.singleAnk}');
          print('Jodi rate: ${numeric.numeric.jodi}');
          print('Single Patti rate: ${numeric.numeric.singlePatti}');
        }
      } else {
        _errorMessage = numeric?.message ?? 'Failed to fetch game numeric';
        if (kDebugMode) {
          print('Failed to fetch game numeric: $_errorMessage');
        }
      }
    } catch (e) {
      _errorMessage = 'An error occurred while fetching game numeric: $e';
      if (kDebugMode) {
        print('Exception in fetchGameRates: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshGameRates() async {
    await fetchGameRates();
  }

  // Check if numeric are available
  bool get hasRates => _gameRates != null && _gameRates!.success;

  // Get all numeric as a map
  Map<String, String> getAllRatesMap() {
    if (_gameRates == null) return {};

    return {
      'single': _gameRates!.numeric.singleAnk.toString(),
      'jodi': _gameRates!.numeric.jodi.toString(),
      'singlepatti': _gameRates!.numeric.singlePatti.toString(),
      'doublepatti': _gameRates!.numeric.doublePatti.toString(),
      'triplepatti': _gameRates!.numeric.triplePatti.toString(),
      'halfsangam': _gameRates!.numeric.halfSangam.toString(),
      'fullsangam': _gameRates!.numeric.fullSangam.toString(),
      'sp': _gameRates!.numeric.sp.toString(),
      'dp': _gameRates!.numeric.dp.toString(),
      'round': _gameRates!.numeric.round.toString(),
      'centerpanna': _gameRates!.numeric.centerpanna.toString(),
      'aki': _gameRates!.numeric.aki.toString(),
      'beki': _gameRates!.numeric.beki.toString(),
      'chart50': _gameRates!.numeric.chart50.toString(),
      'chart60': _gameRates!.numeric.chart60.toString(),
      'chart70': _gameRates!.numeric.chart70.toString(),
      'akibekicut30': _gameRates!.numeric.akibekicut30.toString(),
      'abr30Pana': _gameRates!.numeric.abr30Pana.toString(),
      'startend': _gameRates!.numeric.startend.toString(),
      'cyclepana': _gameRates!.numeric.cyclepana.toString(),
      'groupjodi': _gameRates!.numeric.groupJodi.toString(),
      'panelgroup': _gameRates!.numeric.panelGroup.toString(),
      'bulkjodi': _gameRates!.numeric.bulkJodi.toString(),
      'bulksp': _gameRates!.numeric.bulkSp.toString(),
      'bulkdp': _gameRates!.numeric.bulkDp.toString(),
      'familypannel': _gameRates!.numeric.familypannel.toString(),
      'familyjodi': _gameRates!.numeric.familyjodi.toString(),
    };
  }

  // Clear numeric data
  void clearRates() {
    _gameRates = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
