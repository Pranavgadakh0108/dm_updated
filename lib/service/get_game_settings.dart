import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/game_settings_model.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetGameSettingsService {
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

  Future<GameSettings?> getGameSettings(BuildContext context) async {
    try {
      final dio = await _getDioInstance();

      final result = await dio.get("/users/settings/all");

      if (result.statusCode == 200) {
        return GameSettings.fromJson(result.data);
      } else {
        showCustomSnackBar(
          context: context,
          message: "Failed to Fetch Game Settings",
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['msg'] ?? errorMessage;
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
