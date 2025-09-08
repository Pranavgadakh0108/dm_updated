import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/deposite_manual_points.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDepositePointsManual {
  Future<Dio> _getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');

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

  Future<DepositeManualPoints?> postDepositeManualDetails(
    BuildContext context,
    DepositeManualPoints depositeManualPoints,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post(
        '/users/deposit/manual/create',
        data: depositeManualPoints.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DepositeManualPoints.fromJson(response.data);
      } else {
        throw Exception('Failed to Deposite points: ${response.statusCode}');
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.response != null && e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          errorMessage =
              e.response!.data['message'] ??
              e.response!.data['error'] ??
              errorMessage;
        } else if (e.response!.data is String) {
          errorMessage = e.response!.data;
        }
      } else {
        errorMessage = e.message ?? "Network error occurred";
      }

      if (context.mounted) {
        showCustomSnackBar(
          context: context,
          message: errorMessage,
          backgroundColor: Colors.redAccent,
          durationSeconds: 3,
        );
      }

      return null;
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
  }
}
