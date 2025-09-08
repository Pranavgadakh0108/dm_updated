import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/game_rate_model.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetGameRateService {
  Future<Dio> _getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<GameRatesModel?> getGameRateService(BuildContext context) async {
    try {
      final dio = await _getDioInstance();

      final result = await dio.get("/users/rates/mark");

      if (result.statusCode == 200) {
        return GameRatesModel.fromJson(result.data);
      } else {
        showCustomSnackBar(
          context: context,
          message: "Failed to Fetch Game Rates",
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      showCustomSnackBar(
          context: context,
          message: errorMessage,
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      return null;
    }
    return null;
  }
}
