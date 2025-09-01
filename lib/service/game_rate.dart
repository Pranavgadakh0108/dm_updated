import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/game_rate_model.dart';
import 'package:dmboss/service/login_user.dart';

class GameRateService {
  final AuthService _authService = AuthService();

  // Get Dio instance with authentication token
  Future<Dio> _getAuthenticatedDio() async {
    final token = await _authService.getStoredToken();
    
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  // Fetch game rates data
  Future<GameRateModel?> getGameRates() async {
    try {
      // Check if user is logged in first
      final isLoggedIn = await _authService.isLoggedIn();
      if (!isLoggedIn) {
        print('User is not logged in');
        return null;
      }

      final dio = await _getAuthenticatedDio();

      final response = await dio.get(
        '/markets/rates',
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          print('No data received from API');
          return null;
        }
        
        final gameRateModel = GameRateModel.fromJson(response.data);
        
        if (gameRateModel.success) {
          print('Game rates fetched successfully');
          return gameRateModel;
        } else {
          print('API returned success: false - ${gameRateModel.message}');
          return null;
        }
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        print('Authentication failed - token may be expired');
        // Optionally clear auth data and redirect to login
        await _authService.clearAuthData();
        return null;
      } else {
        print('Failed to fetch game rates. Status code: ${response.statusCode}');
        print('Response: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      print('DioException in getGameRates: ${e.message}');
      print('Error type: ${e.type}');
      
      if (e.response != null) {
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        
        // Handle unauthorized access
        if (e.response?.statusCode == 401) {
          await _authService.clearAuthData();
        }
      }
      
      return null;
    } catch (e) {
      print('Exception in getGameRates: $e');
      return null;
    }
  }

  // Get specific rate value by key
  Future<String?> getRateByKey(String rateKey) async {
    try {
      final rates = await getGameRates();
      if (rates == null || !rates.success) return null;

      switch (rateKey) {
        case 'single':
          return rates.rates.single;
        case 'jodi':
          return rates.rates.jodi;
        case 'singlepatti':
          return rates.rates.singlepatti;
        case 'doublepatti':
          return rates.rates.doublepatti;
        case 'triplepatti':
          return rates.rates.triplepatti;
        case 'halfsangam':
          return rates.rates.halfsangam;
        case 'fullsangam':
          return rates.rates.fullsangam;
        case 'sp':
          return rates.rates.sp;
        case 'dp':
          return rates.rates.dp;
        case 'round':
          return rates.rates.round;
        case 'centerpanna':
          return rates.rates.centerpanna;
        case 'aki':
          return rates.rates.aki;
        case 'beki':
          return rates.rates.beki;
        case 'chart50':
          return rates.rates.chart50;
        case 'chart60':
          return rates.rates.chart60;
        case 'chart70':
          return rates.rates.chart70;
        case 'akibekicut30':
          return rates.rates.akibekicut30;
        case 'abr30Pana':
          return rates.rates.abr30Pana;
        case 'startend':
          return rates.rates.startend;
        case 'cyclepana':
          return rates.rates.cyclepana;
        case 'groupjodi':
          return rates.rates.groupjodi;
        case 'panelgroup':
          return rates.rates.panelgroup;
        case 'bulkjodi':
          return rates.rates.bulkjodi;
        case 'bulksp':
          return rates.rates.bulksp;
        case 'bulkdp':
          return rates.rates.bulkdp;
        case 'familypannel':
          return rates.rates.familypannel;
        case 'familyjodi':
          return rates.rates.familyjodi;
        default:
          return null;
      }
    } catch (e) {
      print('Exception in getRateByKey: $e');
      return null;
    }
  }

  // Get all rates as a map for easy access
  Future<Map<String, String>?> getAllRatesMap() async {
    try {
      final rates = await getGameRates();
      if (rates == null || !rates.success) return null;

      return {
        'single': rates.rates.single,
        'jodi': rates.rates.jodi,
        'singlepatti': rates.rates.singlepatti,
        'doublepatti': rates.rates.doublepatti,
        'triplepatti': rates.rates.triplepatti,
        'halfsangam': rates.rates.halfsangam,
        'fullsangam': rates.rates.fullsangam,
        'sp': rates.rates.sp,
        'dp': rates.rates.dp,
        'round': rates.rates.round,
        'centerpanna': rates.rates.centerpanna,
        'aki': rates.rates.aki,
        'beki': rates.rates.beki,
        'chart50': rates.rates.chart50,
        'chart60': rates.rates.chart60,
        'chart70': rates.rates.chart70,
        'akibekicut30': rates.rates.akibekicut30,
        'abr30Pana': rates.rates.abr30Pana,
        'startend': rates.rates.startend,
        'cyclepana': rates.rates.cyclepana,
        'groupjodi': rates.rates.groupjodi,
        'panelgroup': rates.rates.panelgroup,
        'bulkjodi': rates.rates.bulkjodi,
        'bulksp': rates.rates.bulksp,
        'bulkdp': rates.rates.bulkdp,
        'familypannel': rates.rates.familypannel,
        'familyjodi': rates.rates.familyjodi,
      };
    } catch (e) {
      print('Exception in getAllRatesMap: $e');
      return null;
    }
  }

  // Check if user is authenticated and get rates
  Future<GameRateModel?> getAuthenticatedGameRates() async {
    final isLoggedIn = await _authService.isLoggedIn();
    
    if (!isLoggedIn) {
      print('User is not authenticated');
      return null;
    }

    return await getGameRates();
  }

  // Refresh rates (same as get but can be used for explicit refresh)
  Future<GameRateModel?> refreshGameRates() async {
    return await getGameRates();
  }
}