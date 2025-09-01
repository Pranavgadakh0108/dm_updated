import 'package:dmboss/service/game_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:dmboss/model/game_rate_model.dart';

class GameRateProvider extends ChangeNotifier {
  GameRateModel? _gameRates;
  bool _isLoading = false;
  String? _errorMessage;
  final GameRateService _gameRateService = GameRateService();

  GameRateModel? get gameRates => _gameRates;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Convenience getters for common rates
  String get singleRate => _gameRates?.rates.single ?? '0';
  String get jodiRate => _gameRates?.rates.jodi ?? '0';
  String get singlePattiRate => _gameRates?.rates.singlepatti ?? '0';
  String get doublePattiRate => _gameRates?.rates.doublepatti ?? '0';
  String get triplePattiRate => _gameRates?.rates.triplepatti ?? '0';
  String get halfSangamRate => _gameRates?.rates.halfsangam ?? '0';
  String get fullSangamRate => _gameRates?.rates.fullsangam ?? '0';
  String get spRate => _gameRates?.rates.sp ?? '0';
  String get dpRate => _gameRates?.rates.dp ?? '0';

  // Get rate by key
  String getRateByKey(String key) {
    if (_gameRates == null) return '0';

    switch (key) {
      case 'single':
        return _gameRates!.rates.single;
      case 'jodi':
        return _gameRates!.rates.jodi;
      case 'singlepatti':
        return _gameRates!.rates.singlepatti;
      case 'doublepatti':
        return _gameRates!.rates.doublepatti;
      case 'triplepatti':
        return _gameRates!.rates.triplepatti;
      case 'halfsangam':
        return _gameRates!.rates.halfsangam;
      case 'fullsangam':
        return _gameRates!.rates.fullsangam;
      case 'sp':
        return _gameRates!.rates.sp;
      case 'dp':
        return _gameRates!.rates.dp;
      case 'round':
        return _gameRates!.rates.round;
      case 'centerpanna':
        return _gameRates!.rates.centerpanna;
      case 'aki':
        return _gameRates!.rates.aki;
      case 'beki':
        return _gameRates!.rates.beki;
      case 'chart50':
        return _gameRates!.rates.chart50;
      case 'chart60':
        return _gameRates!.rates.chart60;
      case 'chart70':
        return _gameRates!.rates.chart70;
      case 'akibekicut30':
        return _gameRates!.rates.akibekicut30;
      case 'abr30Pana':
        return _gameRates!.rates.abr30Pana;
      case 'startend':
        return _gameRates!.rates.startend;
      case 'cyclepana':
        return _gameRates!.rates.cyclepana;
      case 'groupjodi':
        return _gameRates!.rates.groupjodi;
      case 'panelgroup':
        return _gameRates!.rates.panelgroup;
      case 'bulkjodi':
        return _gameRates!.rates.bulkjodi;
      case 'bulksp':
        return _gameRates!.rates.bulksp;
      case 'bulkdp':
        return _gameRates!.rates.bulkdp;
      case 'familypannel':
        return _gameRates!.rates.familypannel;
      case 'familyjodi':
        return _gameRates!.rates.familyjodi;
      default:
        return '0';
    }
  }

  Future<void> fetchGameRates() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rates = await _gameRateService.getGameRates();

      if (rates != null && rates.success) {
        _gameRates = rates;
        _errorMessage = null;

        if (kDebugMode) {
          print('Game rates fetched successfully');
          print('Single rate: ${rates.rates.single}');
          print('Jodi rate: ${rates.rates.jodi}');
          print('Single Patti rate: ${rates.rates.singlepatti}');
        }
      } else {
        _errorMessage = rates?.message ?? 'Failed to fetch game rates';
        if (kDebugMode) {
          print('Failed to fetch game rates: $_errorMessage');
        }
      }
    } catch (e) {
      _errorMessage = 'An error occurred while fetching game rates: $e';
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

  // Check if rates are available
  bool get hasRates => _gameRates != null && _gameRates!.success;

  // Get all rates as a map
  Map<String, String> getAllRatesMap() {
    if (_gameRates == null) return {};

    return {
      'single': _gameRates!.rates.single,
      'jodi': _gameRates!.rates.jodi,
      'singlepatti': _gameRates!.rates.singlepatti,
      'doublepatti': _gameRates!.rates.doublepatti,
      'triplepatti': _gameRates!.rates.triplepatti,
      'halfsangam': _gameRates!.rates.halfsangam,
      'fullsangam': _gameRates!.rates.fullsangam,
      'sp': _gameRates!.rates.sp,
      'dp': _gameRates!.rates.dp,
      'round': _gameRates!.rates.round,
      'centerpanna': _gameRates!.rates.centerpanna,
      'aki': _gameRates!.rates.aki,
      'beki': _gameRates!.rates.beki,
      'chart50': _gameRates!.rates.chart50,
      'chart60': _gameRates!.rates.chart60,
      'chart70': _gameRates!.rates.chart70,
      'akibekicut30': _gameRates!.rates.akibekicut30,
      'abr30Pana': _gameRates!.rates.abr30Pana,
      'startend': _gameRates!.rates.startend,
      'cyclepana': _gameRates!.rates.cyclepana,
      'groupjodi': _gameRates!.rates.groupjodi,
      'panelgroup': _gameRates!.rates.panelgroup,
      'bulkjodi': _gameRates!.rates.bulkjodi,
      'bulksp': _gameRates!.rates.bulksp,
      'bulkdp': _gameRates!.rates.bulkdp,
      'familypannel': _gameRates!.rates.familypannel,
      'familyjodi': _gameRates!.rates.familyjodi,
    };
  }

  // Clear rates data
  void clearRates() {
    _gameRates = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
