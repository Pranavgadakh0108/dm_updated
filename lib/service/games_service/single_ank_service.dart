// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/single_ank_model.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleAnkBetService {
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

  Future<Map<String, dynamic>?> placeSingleAnkBet(
    BuildContext context,
    SingleAnkModel singleAnkModel,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post(
        '/user/bets/place-bet',
        data: singleAnkModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      String errorMessage = "Something went wrong while placing your bet";

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
        durationSeconds: 2,
      );

      return null;
    }
  }
}
