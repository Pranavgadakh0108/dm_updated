// // To parse this JSON data, do
// //
// //     final paymentModel = paymentModelFromJson(jsonString);

// import 'dart:convert';

// PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

// String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

// class PaymentModel {
//     String method;
//     String action;
//     int amount;

//     PaymentModel({
//         required this.method,
//         required this.action,
//         required this.amount,
//     });

//     factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
//         method: json["method"],
//         action: json["action"],
//         amount: json["amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "method": method,
//         "action": action,
//         "amount": amount,
//     };
// }

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
        method: json["method"] as String? ?? "", // Default empty string if null
        action: json["action"] as String? ?? "", // Default empty string if null
        amount: json["amount"] as int? ?? 0, // Also added for amount
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "action": action,
        "amount": amount,
    };
}