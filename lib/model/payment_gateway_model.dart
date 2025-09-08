// To parse this JSON data, do
//
//     final paymentGatewayIntegration = paymentGatewayIntegrationFromJson(jsonString);

import 'dart:convert';

PaymentGatewayIntegration paymentGatewayIntegrationFromJson(String? str) =>
    PaymentGatewayIntegration.fromJson(json.decode(str ?? ""));

String? paymentGatewayIntegrationToJson(PaymentGatewayIntegration data) =>
    json.encode(data.toJson());

class PaymentGatewayIntegration {
  int? amount;

  PaymentGatewayIntegration({required this.amount});

  factory PaymentGatewayIntegration.fromJson(Map<String?, dynamic>? json) =>
      PaymentGatewayIntegration(amount: json?["amount"]);

  Map<String?, dynamic>? toJson() => {"amount": amount};
}
