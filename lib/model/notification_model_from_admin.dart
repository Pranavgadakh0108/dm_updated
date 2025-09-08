// To parse this JSON data, do
//
//     final notificationModelFromAdmin = notificationModelFromAdminFromJson(jsonString);

import 'dart:convert';

NotificationModelFromAdmin notificationModelFromAdminFromJson(String str) =>
    NotificationModelFromAdmin.fromJson(json.decode(str));

String notificationModelFromAdminToJson(NotificationModelFromAdmin data) =>
    json.encode(data.toJson());

class NotificationModelFromAdmin {
  bool success;
  int count;
  List<Datum> data;

  NotificationModelFromAdmin({
    required this.success,
    required this.count,
    required this.data,
  });

  factory NotificationModelFromAdmin.fromJson(Map<String, dynamic> json) =>
      NotificationModelFromAdmin(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String title;
  String message;
  dynamic createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.title,
    required this.message,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    message: json["message"],
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "message": message,
    "createdBy": createdBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
