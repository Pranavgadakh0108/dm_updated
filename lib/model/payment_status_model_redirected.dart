import 'dart:convert';

PaymentStatusModelRedirected paymentStatusModelRedirectedFromJson(String str) =>
    PaymentStatusModelRedirected.fromJson(json.decode(str));

String paymentStatusModelRedirectedToJson(PaymentStatusModelRedirected data) =>
    json.encode(data.toJson());

class PaymentStatusModelRedirected {
  bool success;
  String message;
  String method;
  String normalizedStatus;
  PaymentStatusModelRedirectedRaw raw;
  Deposit deposit;

  PaymentStatusModelRedirected({
    required this.success,
    required this.message,
    required this.method,
    required this.normalizedStatus,
    required this.raw,
    required this.deposit,
  });

  factory PaymentStatusModelRedirected.fromJson(Map<String, dynamic> json) =>
      PaymentStatusModelRedirected(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        method: json["method"] ?? "",
        normalizedStatus: json["normalized_status"] ?? "",
        raw: PaymentStatusModelRedirectedRaw.fromJson(json["raw"] ?? {}),
        deposit: Deposit.fromJson(json["deposit"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "method": method,
    "normalized_status": normalizedStatus,
    "raw": raw.toJson(),
    "deposit": deposit.toJson(),
  };
}

class Deposit {
  String id;
  int status;
  int amount;
  String userId;
  String lastStatus;
  DateTime lastStatusAt;

  Deposit({
    required this.id,
    required this.status,
    required this.amount,
    required this.userId,
    required this.lastStatus,
    required this.lastStatusAt,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
    id: json["_id"] ?? "",
    status: json["status"] ?? 0,
    amount: json["amount"] ?? 0,
    userId: json["user_id"] ?? "",
    lastStatus: json["last_status"] ?? "",
    lastStatusAt: DateTime.parse(
      json["last_status_at"] ?? DateTime.now().toIso8601String(),
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "amount": amount,
    "user_id": userId,
    "last_status": lastStatus,
    "last_status_at": lastStatusAt.toIso8601String(),
  };
}

class PaymentStatusModelRedirectedRaw {
  String status;
  String? utr;
  RawRaw raw;

  PaymentStatusModelRedirectedRaw({
    required this.status,
    this.utr,
    required this.raw,
  });

  factory PaymentStatusModelRedirectedRaw.fromJson(Map<String, dynamic> json) =>
      PaymentStatusModelRedirectedRaw(
        status: json["status"] ?? "",
        utr: json["utr"] ?? "",
        raw: RawRaw.fromJson(json["raw"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "utr": utr,
    "raw": raw.toJson(),
  };
}

class RawRaw {
  String status;
  String message;
  String? utr;
  String clientTxnId;
  String amount;

  RawRaw({
    required this.status,
    required this.message,
    this.utr,
    required this.clientTxnId,
    required this.amount,
  });

  factory RawRaw.fromJson(Map<String, dynamic> json) => RawRaw(
    status: json["status"] ?? "",
    message: json["message"] ?? "",
    utr: json["utr"] ?? "",
    clientTxnId: json["client_txn_id"] ?? "",
    amount: json["amount"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "utr": utr,
    "client_txn_id": clientTxnId,
    "amount": amount,
  };
}
