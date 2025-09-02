// To parse this JSON data, do
//
//     final getQrCodeModel = getQrCodeModelFromJson(jsonString);

import 'dart:convert';

GetQrCodeModel getQrCodeModelFromJson(String str) =>
    GetQrCodeModel.fromJson(json.decode(str));

String getQrCodeModelToJson(GetQrCodeModel data) => json.encode(data.toJson());

class GetQrCodeModel {
  bool success;
  String message;
  List<QrCode> qrCodes;

  GetQrCodeModel({
    required this.success,
    required this.message,
    required this.qrCodes,
  });

  factory GetQrCodeModel.fromJson(Map<String, dynamic> json) => GetQrCodeModel(
    success: json["success"],
    message: json["message"],
    qrCodes: List<QrCode>.from(json["qrCodes"].map((x) => QrCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "qrCodes": List<dynamic>.from(qrCodes.map((x) => x.toJson())),
  };
}

class QrCode {
  String id;
  String upiId;
  String qrImage;
  String isActive;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  QrCode({
    required this.id,
    required this.upiId,
    required this.qrImage,
    required this.isActive,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QrCode.fromJson(Map<String, dynamic> json) => QrCode(
    id: json["_id"],
    upiId: json["upi_id"],
    qrImage: json["qr_image"],
    isActive: json["is_active"],
    note: json["note"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "upi_id": upiId,
    "qr_image": qrImage,
    "is_active": isActive,
    "note": note,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
