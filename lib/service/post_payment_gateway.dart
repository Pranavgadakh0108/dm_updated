// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/payment_gateway_model.dart';
import 'package:dmboss/model/payment_gateway_response.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPaymentGateway {
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

  Future<PaymentGatewayResponse?> postPaymentGateway(
    BuildContext context,
    PaymentGatewayIntegration paymentGateWay,
    String method,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post(
        method == 'Norapay'
            ? '/deposit/norapay/create-order'
            : '/deposit/finixpay/create',
        data: paymentGateWay.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data['payment_link']);
        print("---------------------");
        print(response.data);
        method == 'Norapay'
            ? makePayment(response.data['upi_intent'])
            : makePayment(response.data['pay_url']);
        return PaymentGatewayResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to do payment: ${response.statusCode}');
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

      print(e.response?.data);

      if (context.mounted) {
        showCustomSnackBar(
          context: context,
          message: errorMessage,
          backgroundColor: Colors.redAccent,
          durationSeconds: 2,
        );
      }

      return null;
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
        durationSeconds: 2,
      );

      return null;
    }
  }
}
