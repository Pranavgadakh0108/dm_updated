// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/payment_gateway_response.dart';
import 'package:dmboss/model/payment_model.dart';
import 'package:dmboss/model/payment_status_model.dart';
import 'package:dmboss/model/payment_status_model_tnxid.dart';
import 'package:dmboss/provider/payment_provider.dart';
import 'package:dmboss/provider/payment_status_provider.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
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

  // Add this method to check payment status
  Future<void> _checkPaymentStatusRepeatedly(
    BuildContext context,
    String orderId,
    String method,
    String txnid,

    int? durationMinutes,
  ) async {
    final paymentStatus = Provider.of<PaymentStatusProvider>(
      context,
      listen: false,
    );

    // final endTime = DateTime.now().add(Duration(minutes: durationMinutes ?? 0));
    // int attemptCount = 0;
    // final maxAttempts = durationMinutes ?? 0 * 60 * 60; // 5 minutes * 60 seconds

    final duration = durationMinutes ?? 5; // Default to 5 minutes if null
    final endTime = DateTime.now().add(Duration(minutes: duration));
    int attemptCount = 0;
    final maxAttempts = duration * 60; // Convert minutes to seconds

    // Function to check status
    Future<void> checkStatus() async {
      if (DateTime.now().isAfter(endTime) || attemptCount >= maxAttempts) {
        print('Status checking completed after $durationMinutes minutes');
        return;
      }

      try {
        attemptCount++;
        print('Checking payment status - Attempt $attemptCount');

        final statusModel = PaymentStatusModel(
          method: method,
          orderid: orderId,
        );

        final statusTnxModel = PaymentStatusModelTnxRedirected(
          method: method,
          txnid: txnid,
        );

        await paymentStatus.postPaymentGateway(
          context,
          statusModel,
          statusTnxModel,
          method,
        );

        // Check if payment is successful to stop polling
        if (paymentStatus.paymentGatewayResponse?.raw.status.toLowerCase() ==
                'success' ||
            paymentStatus.paymentGatewayResponse?.raw.status.toLowerCase() ==
                'completed') {
          print('Payment successful, stopping status checks');
          return;
        }

        // Wait for 1 second before next check
        await Future.delayed(const Duration(seconds: 1));
        await checkStatus(); // Recursive call for next check
      } catch (e) {
        print('Error checking payment status: $e');
        // Wait for 1 second before retrying even if there's an error
        await Future.delayed(const Duration(seconds: 1));
        await checkStatus(); // Continue checking despite errors
      }
    }

    // Start the status checking
    await checkStatus();
  }

  Future<PaymentGatewayResponse?> postPaymentGateway(
    BuildContext context,
    PaymentModel paymentGateWay,
    String method,
  ) async {
    try {
      final dio = await _getDioInstance();

      final response = await dio.post(
        '/deposit/pg',
        data: paymentGateWay.toJson(),
      );

      // Replace the problematic section in postPaymentGateway method
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("---------------------");
        print(response.data);

        final provider = Provider.of<PaymentProvider>(context, listen: false);

        // Safe extraction with null checks
        final results = response.data['results'] as List?;
        final firstResult = results != null && results.isNotEmpty
            ? results[0]
            : null;
        final data = firstResult != null
            ? firstResult['data'] as Map<String, dynamic>?
            : null;

        String orderId = data?['orderid'] as String? ?? '';
        String? depositId = data?['deposit_id'] as String?;
        String? payUrl = data?['pay_url'] as String?;
        String? upiIntent = data?['upi_intent'] as String?;
        String? paymentLink = data?['payment_link'] as String?;
        String txnid = data?['norapay_txnid'] as String? ?? "";

        provider.setOrderId(orderId);

        print("------ UPI Intent: $upiIntent");

        // Determine which URL to use for payment
        String? paymentUrl;
        if (method == "Finixpay") {
          paymentUrl = payUrl ?? data?['deeplink'] as String?;
        } else {
          paymentUrl = upiIntent ?? paymentLink;
        }

        if (paymentUrl != null && paymentUrl.isNotEmpty) {
          makePayment(paymentUrl);
        } else {
          print('No valid payment URL found');
          if (context.mounted) {
            showCustomSnackBar(
              context: context,
              message: 'Payment URL not available',
              backgroundColor: Colors.orange,
              durationSeconds: 2,
            );
          }
        }

        // Then start continuous status checking for 5 minutes
        if (orderId.isNotEmpty) {
          _checkPaymentStatusRepeatedly(context, orderId, method, txnid, 5);
        } else {
          print('Order ID not available, skipping status checks');
        }

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
