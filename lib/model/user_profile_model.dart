// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString?);

import 'dart:convert';

UserModel userModelFromJson(String? str) =>
    UserModel.fromJson(json.decode(str ?? ""));

String? userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool success;
  String? message;
  User user;

  UserModel({required this.success, required this.message, required this.user});

  factory UserModel.fromJson(Map<String?, dynamic>? json) => UserModel(
    success: json?["success"],
    message: json?["message"],
    user: User.fromJson(json?["user"]),
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  String? id;
  String? mobile;
  String? name;
  String? email;
  int? wallet;
  String? session;
  String? code;
  DateTime? createdAt;
  int? active;
  String? verify;
  String? transferPointsStatus;
  String? paytm;
  dynamic pin;
  dynamic refcode;
  dynamic refId;
  dynamic ipAddress;
  DateTime? createdA;
  dynamic updatedAt;
  int? v;

  User({
    required this.id,
    required this.mobile,
    required this.name,
    required this.email,
    required this.wallet,
    required this.session,
    required this.code,
    required this.createdAt,
    required this.active,
    required this.verify,
    required this.transferPointsStatus,
    required this.paytm,
    required this.pin,
    required this.refcode,
    required this.refId,
    required this.ipAddress,
    required this.createdA,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String?, dynamic>? json) => User(
    id: json?["_id"],
    mobile: json?["mobile"],
    name: json?["name"],
    email: json?["email"],
    wallet: json?["wallet"],
    session: json?["session"],
    code: json?["code"],
    createdAt: DateTime.parse(json?["created_at"]),
    active: json?["active"],
    verify: json?["verify"],
    transferPointsStatus: json?["transfer_points_status"],
    paytm: json?["paytm"],
    pin: json?["pin"],
    refcode: json?["refcode"],
    refId: json?["ref_id"],
    ipAddress: json?["ip_address"],
    createdA: DateTime.parse(json?["created_a"]),
    updatedAt: json?["updated_at"],
    v: json?["__v"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "mobile": mobile,
    "name": name,
    "email": email,
    "wallet": wallet,
    "session": session,
    "code": code,
    "created_at": createdAt?.toIso8601String(),
    "active": active,
    "verify": verify,
    "transfer_points_status": transferPointsStatus,
    "paytm": paytm,
    "pin": pin,
    "refcode": refcode,
    "ref_id": refId,
    "ip_address": ipAddress,
    "created_a": createdA?.toIso8601String(),
    "updated_at": updatedAt,
    "__v": v,
  };
}
