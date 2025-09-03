import 'dart:convert';

FundHistoryModel fundHistoryModelFromJson(String str) =>
    FundHistoryModel.fromJson(json.decode(str));

String fundHistoryModelToJson(FundHistoryModel data) =>
    json.encode(data.toJson());

class FundHistoryModel {
  bool success;
  String message;
  List<Deposit> deposits;

  FundHistoryModel({
    required this.success,
    required this.message,
    required this.deposits,
  });

  factory FundHistoryModel.fromJson(Map<String, dynamic> json) =>
      FundHistoryModel(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        deposits: List<Deposit>.from(
          (json["deposits"] ?? []).map((x) => Deposit.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "deposits": List<dynamic>.from(deposits.map((x) => x.toJson())),
  };
}

class Deposit {
  String id;
  int sn;
  String userId;
  String mobile;
  int amount;
  String method;
  dynamic payId;
  DateTime createdAt;
  int status;
  DateTime updatedAt;
  DateTime date;
  String ipAddress;
  String razorpayResponse;
  dynamic gatewayRaw;
  Norapay norapay;
  int v;
  String? rejectionNote;

  Deposit({
    required this.id,
    required this.sn,
    required this.userId,
    required this.mobile,
    required this.amount,
    required this.method,
    required this.payId,
    required this.createdAt,
    required this.status,
    required this.updatedAt,
    required this.date,
    required this.ipAddress,
    required this.razorpayResponse,
    required this.gatewayRaw,
    required this.norapay,
    required this.v,
    required this.rejectionNote,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
    id: json["_id"] ?? '',
    sn: json["sn"] ?? 0,
    userId: json["user_id"] ?? '',
    mobile: json["mobile"] ?? '',
    amount: json["amount"] ?? 0,
    method: json["method"] ?? '',
    payId: json["pay_id"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : DateTime.now(),
    status: json["status"] ?? 0,
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : DateTime.now(),
    date: json["date"] != null ? DateTime.parse(json["date"]) : DateTime.now(),
    ipAddress: json["ip_address"] ?? '',
    razorpayResponse: json["razorpay_response"] ?? '',
    gatewayRaw: json["gateway_raw"],
    norapay: Norapay.fromJson(json["norapay"] ?? {}),
    v: json["__v"] ?? 0,
    rejectionNote: json["rejection_note"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sn": sn,
    "user_id": userId,
    "mobile": mobile,
    "amount": amount,
    "method": method,
    "pay_id": payId,
    "created_at": createdAt.toIso8601String(),
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "date": date.toIso8601String(),
    "ip_address": ipAddress,
    "razorpay_response": razorpayResponse,
    "gateway_raw": gatewayRaw,
    "norapay": norapay.toJson(),
    "__v": v,
    'rejection_note': rejectionNote,
  };
}

class Norapay {
  dynamic merchantTxnid;
  dynamic txnid;
  dynamic paymentLink;
  dynamic qrData;
  String lastStatus;
  dynamic lastStatusAt;

  Norapay({
    required this.merchantTxnid,
    required this.txnid,
    required this.paymentLink,
    required this.qrData,
    required this.lastStatus,
    required this.lastStatusAt,
  });

  factory Norapay.fromJson(Map<String, dynamic> json) => Norapay(
    merchantTxnid: json["merchant_txnid"],
    txnid: json["txnid"],
    paymentLink: json["payment_link"],
    qrData: json["qr_data"],
    lastStatus: json["last_status"] ?? '',
    lastStatusAt: json["last_status_at"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_txnid": merchantTxnid,
    "txnid": txnid,
    "payment_link": paymentLink,
    "qr_data": qrData,
    "last_status": lastStatus,
    "last_status_at": lastStatusAt,
  };
}
