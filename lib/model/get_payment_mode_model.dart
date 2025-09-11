
import 'dart:convert';

GetPaymentMode getPaymentModeFromJson(String? str) =>
    GetPaymentMode.fromJson(json.decode(str ?? ""));

String? getPaymentModeToJson(GetPaymentMode data) => json.encode(data.toJson());

class GetPaymentMode {
  bool? success;
  Data data;
  String? message;

  GetPaymentMode({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetPaymentMode.fromJson(Map<String?, dynamic>? json) =>
      GetPaymentMode(
        success: json?["success"],
        data: Data.fromJson(
          json?["data"] ?? {},
        ), // Provide empty map as fallback
        message: json?["message"],
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String? active;
  int minDeposit;
  List<ManualQr> manualQr;

  Data({
    required this.active,
    required this.minDeposit,
    required this.manualQr,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    active: json?["active"],
    minDeposit: json?["min_deposit"] ?? 0, // Provide default value
    manualQr: List<ManualQr>.from(
      (json?["manual_qr"] as List?)?.map((x) => ManualQr.fromJson(x)) ??
          [], // Handle null case
    ),
  );

  Map<String?, dynamic>? toJson() => {
    "active": active,
    "min_deposit": minDeposit,
    "manual_qr": List<dynamic>.from(manualQr.map((x) => x.toJson())),
  };
}

class ManualQr {
  String? id;
  String? upiId;
  String? qrImage;
  String? note;
  DateTime createdAt;

  ManualQr({
    required this.id,
    required this.upiId,
    required this.qrImage,
    required this.note,
    required this.createdAt,
  });

  factory ManualQr.fromJson(Map<String?, dynamic>? json) => ManualQr(
    id: json?["_id"],
    upiId: json?["upi_id"],
    qrImage: json?["qr_image"],
    note: json?["note"],
    createdAt: DateTime.parse(
      json?["createdAt"] ?? DateTime.now().toIso8601String(),
    ), // Handle null case
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "upi_id": upiId,
    "qr_image": qrImage,
    "note": note,
    "createdAt": createdAt.toIso8601String(),
  };
}
