// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    String method;
    String action;
    int amount;

    PaymentModel({
        required this.method,
        required this.action,
        required this.amount,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        method: json["method"],
        action: json["action"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "action": action,
        "amount": amount,
    };
}
