import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model/bulk_sp_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulkSpBetService {
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

  Future<Map<String, dynamic>?> placeBulkSpBet(
    BuildContext context,
    BulkSpModel bulkSpModel,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post(
        '/user/bets/place-bet',
        data: bulkSpModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Bulk SP bet placed successfully!")),
        // );
        return response.data;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Failed to place bulk SP bet: ${response.statusCode}"),
        //   ),
        // );
        return null;
      }
    } catch (e) {
      String errorMessage =
          "Something went wrong while placing your bulk SP bet";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['msg'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    }
  }
}
