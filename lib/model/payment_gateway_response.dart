// To parse this JSON data, do
//
//     final paymentGatewayResponse = paymentGatewayResponseFromJson(jsonString);

import 'dart:convert';

PaymentGatewayResponse paymentGatewayResponseFromJson(String? str) =>
    PaymentGatewayResponse.fromJson(json.decode(str ?? ""));

String? paymentGatewayResponseToJson(PaymentGatewayResponse data) =>
    json.encode(data.toJson());

class PaymentGatewayResponse {
  bool? success;
  String? message;
  String? depositId;
  String? merchantTxnid;
  String? norapayTxnid;
  String? paymentLink;
  String? qrData;

  PaymentGatewayResponse({
    required this.success,
    required this.message,
    required this.depositId,
    required this.merchantTxnid,
    required this.norapayTxnid,
    required this.paymentLink,
    required this.qrData,
  });

  factory PaymentGatewayResponse.fromJson(Map<String?, dynamic>? json) =>
      PaymentGatewayResponse(
        success: json?["success"],
        message: json?["message"],
        depositId: json?["deposit_id"],
        merchantTxnid: json?["merchant_txnid"],
        norapayTxnid: json?["norapay_txnid"],
        paymentLink: json?["payment_link"],
        qrData: json?["qr_data"],
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "message": message,
    "deposit_id": depositId,
    "merchant_txnid": merchantTxnid,
    "norapay_txnid": norapayTxnid,
    "payment_link": paymentLink,
    "qr_data": qrData,
  };
}
