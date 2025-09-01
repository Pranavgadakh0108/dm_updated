// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/mobile_exist_model.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<Dio> getDioInstance() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final token = sharedPreferences.getString('token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<MobileExistModel?> checkMobileExists(
    String mobileNumber,
    BuildContext context,
  ) async {
    try {
      final dio = await getDioInstance();
      print('Sending request to: $baseUrl/auth/check-mobile');
      print('Mobile number: $mobileNumber');

      final response = await dio.post(
        '/auth/check-mobile',
        data: {'mobile': mobileNumber},
      );
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      print('Response headers: ${response.headers}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        if (response.data == null) {
          print('Response data is null!');
          return null;
        }
        return MobileExistModel.fromJson(response.data);
      } else {
        print('Unexpected status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to check mobile: ${response.statusCode}"),
          ),
        );
        return null;
      }
    } catch (e) {
      print('Exception caught: $e');
      if (e is DioException) {
        print('DioException: ${e.message}');
        print('Response: ${e.response?.data}');
        print('Error type: ${e.type}');
      }
      return null;
    }
  }

  // Alternative method that returns just the boolean exists value
  Future<bool?> checkMobileExistsSimple(String mobileNumber) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.post(
        '/auth/check-mobile',
        data: {'mobile': mobileNumber},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final mobileExistModel = MobileExistModel.fromJson(response.data);
        return mobileExistModel.exists; // Fixed: directly access exists property
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}