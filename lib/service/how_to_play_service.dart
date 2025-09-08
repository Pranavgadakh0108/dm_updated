// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/how_to_play_model.dart'; // Adjust import path as needed
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HowToPlayService {
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

  Future<HowToPlayModel?> getHowToPlayService(BuildContext context) async {
    try {
      final dio = await _getDioInstance();

      final result = await dio.get("/users/help-links/all");

      if (result.statusCode == 200) {
        // Parse the response as HowToPlayModel
        return HowToPlayModel.fromJson(result.data);
      } else {
        showCustomSnackBar(
          context: context,
          message: "Failed to Fetch Halp Information",
          backgroundColor: Colors.redAccent,
          durationSeconds: 2,
        );
        return null;
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
        durationSeconds: 2,
      );

      return null;
    }
  }
}
