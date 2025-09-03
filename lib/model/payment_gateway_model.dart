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
  String? name;
  String? phone;
  String? redirectUrl;

  PaymentGatewayIntegration({
    required this.amount,
    required this.name,
    required this.phone,
    required this.redirectUrl,
  });

  factory PaymentGatewayIntegration.fromJson(Map<String?, dynamic>? json) =>
      PaymentGatewayIntegration(
        amount: json?["amount"],
        name: json?["name"],
        phone: json?["phone"],
        redirectUrl: json?["redirect_url"],
      );

  Map<String?, dynamic>? toJson() => {
    "amount": amount,
    "name": name,
    "phone": phone,
    "redirect_url": redirectUrl,
  };
}
