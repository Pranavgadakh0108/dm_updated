import 'dart:convert';

WithdrawHistoryModel withdrawHistoryModelFromJson(String? str) =>
    WithdrawHistoryModel.fromJson(json.decode(str ?? "{}"));

String? withdrawHistoryModelToJson(WithdrawHistoryModel data) =>
    json.encode(data.toJson());

class WithdrawHistoryModel {
  int? success;
  String? msg;
  List<Datum> data;

  WithdrawHistoryModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory WithdrawHistoryModel.fromJson(Map<String?, dynamic>? json) {
    // Handle null json
    json ??= {};

    return WithdrawHistoryModel(
      success: json["success"] ?? 0,
      msg: json["msg"],
      data: List<Datum>.from(
        (json["data"] as List?)?.map((x) => Datum.fromJson(x)) ?? [],
      ),
    );
  }

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? userMobile;
  int? amount;
  String? mode;
  String? note;
  Details details;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? rejectionNote;

  Datum({
    required this.id,
    required this.userMobile,
    required this.amount,
    required this.mode,
    required this.note,
    required this.details,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.rejectionNote
  });

  factory Datum.fromJson(Map<String?, dynamic>? json) {
    // Handle null json
    json ??= {};

    return Datum(
      id: json["_id"],
      userMobile: json["userMobile"],
      amount: json["amount"] ?? 0,
      mode: json["mode"],
      note: json["note"],
      details: Details.fromJson(json["details"]),
      status: json["status"] ?? 0,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"].toString())
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"].toString())
          : null,
      v: json["__v"] ?? 0,
      rejectionNote: json["rejection_note"] ?? " "
    );
  }

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "userMobile": userMobile,
    "amount": amount,
    "mode": mode,
    "note": note,
    "details": details.toJson(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "rejection_note":rejectionNote
  };
}

class Details {
  String? id;
  String? userMobile;
  String? acno;
  String? name;
  String? ifsc;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Details({
    required this.id,
    required this.userMobile,
    required this.acno,
    required this.name,
    required this.ifsc,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Details.fromJson(Map<String?, dynamic>? json) {
    // Handle null json
    json ??= {};

    return Details(
      id: json["_id"],
      userMobile: json["userMobile"],
      acno: json["acno"],
      name: json["name"],
      ifsc: json["ifsc"],
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"].toString())
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"].toString())
          : null,
      v: json["__v"] ?? 0,
    );
  }

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "userMobile": userMobile,
    "acno": acno,
    "name": name,
    "ifsc": ifsc,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
