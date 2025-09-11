import 'dart:convert';

PaymentGatewayResponse paymentGatewayResponseFromJson(String str) =>
    PaymentGatewayResponse.fromJson(json.decode(str));

String paymentGatewayResponseToJson(PaymentGatewayResponse data) =>
    json.encode(data.toJson());

class PaymentGatewayResponse {
  bool success;
  String method;
  String action;
  List<Result> results;

  PaymentGatewayResponse({
    required this.success,
    required this.method,
    required this.action,
    required this.results,
  });

  factory PaymentGatewayResponse.fromJson(Map<String, dynamic> json) =>
      PaymentGatewayResponse(
        success: json["success"] as bool? ?? false,
        method: json["method"] as String? ?? "",
        action: json["action"] as String? ?? "",
        results: List<Result>.from(
          (json["results"] as List? ?? []).map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "method": method,
    "action": action,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  CreateData? getCreateData() {
    for (var result in results) {
      if (result.label == "create") {
        return CreateData.fromJson(result.data);
      }
    }
    return null;
  }
}

class Result {
  String label;
  int httpStatus;
  Map<String, dynamic> data;

  Result({required this.label, required this.httpStatus, required this.data});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    label: json["label"] as String? ?? "",
    httpStatus: json["http_status"] as int? ?? 0,
    data: (json["data"] as Map<String, dynamic>?) ?? {},
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "http_status": httpStatus,
    "data": data,
  };
}

class CreateData {
  bool success;
  String message;
  String depositId;
  String? merchantTxnid;
  String? norapayTxnid;
  String? paymentLink;
  String? qrData;
  String? upiIntent;
  String? androidIntentUrl;

  CreateData({
    required this.success,
    required this.message,
    required this.depositId,
    this.merchantTxnid,
    this.norapayTxnid,
    this.paymentLink,
    this.qrData,
    this.upiIntent,
    this.androidIntentUrl,
  });

  factory CreateData.fromJson(Map<String, dynamic> json) => CreateData(
    success: json["success"] as bool? ?? false,
    message: json["message"] as String? ?? "",
    depositId: json["deposit_id"] as String? ?? "",
    merchantTxnid: json["merchant_txnid"] as String?,
    norapayTxnid: json["norapay_txnid"] as String?,
    paymentLink: json["payment_link"] as String?,
    qrData: json["qr_data"] as String?,
    upiIntent: json["upi_intent"] as String?,
    androidIntentUrl: json["android_intent_url"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "deposit_id": depositId,
    "merchant_txnid": merchantTxnid,
    "norapay_txnid": norapayTxnid,
    "payment_link": paymentLink,
    "qr_data": qrData,
    "upi_intent": upiIntent,
    "android_intent_url": androidIntentUrl,
  };
}
