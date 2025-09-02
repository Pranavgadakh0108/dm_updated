import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/add_bank_details_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBankDetailsService {
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

  Future<AddBankDetails?> postBankDetails(
    BuildContext context,
    AddBankDetails addBankDetails,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post('/bank', data: addBankDetails.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddBankDetails.fromJson(response.data);
      } else {
        throw Exception('Failed to add bank details: ${response.statusCode}');
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.response != null && e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          errorMessage =
              e.response!.data['msg'] ??
              e.response!.data['error'] ??
              errorMessage;
        } else if (e.response!.data is String) {
          errorMessage = e.response!.data;
        }
      } else {
        errorMessage = e.message ?? "Network error occurred";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $errorMessage"),
            backgroundColor: Colors.red,
          ),
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    }
  }
}
