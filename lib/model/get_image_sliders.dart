// To parse this JSON data, do
//
//     final getImageSliders = getImageSlidersFromJson(jsonString);

import 'dart:convert';

GetImageSliders getImageSlidersFromJson(String? str) =>
    GetImageSliders.fromJson(json.decode(str ?? ""));

String? getImageSlidersToJson(GetImageSliders data) =>
    json.encode(data.toJson());

class GetImageSliders {
  bool success;
  String? message;
  int? total;
  int? page;
  int? limit;
  List<Item> items;

  GetImageSliders({
    required this.success,
    required this.message,
    required this.total,
    required this.page,
    required this.limit,
    required this.items,
  });

  factory GetImageSliders.fromJson(Map<String?, dynamic> json) =>
      GetImageSliders(
        success: json?["success"],
        message: json?["message"],
        total: json?["total"],
        page: json?["page"],
        limit: json?["limit"],
        items: List<Item>.from(json?["items"].map((x) => Item.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "page": page,
    "limit": limit,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String? id;
  String? image;
  int? verify;
  String? refer;
  String? data;
  DateTime createdAt;
  DateTime updatedAt;
  int? sn;
  int? v;

  Item({
    required this.id,
    required this.image,
    required this.verify,
    required this.refer,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.sn,
    required this.v,
  });

  factory Item.fromJson(Map<String?, dynamic>? json) => Item(
    id: json?["_id"],
    image: json?["image"],
    verify: json?["verify"],
    refer: json?["refer"],
    data: json?["data"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    sn: json?["sn"],
    v: json?["__v"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "image": image,
    "verify": verify,
    "refer": refer,
    "data": data,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "sn": sn,
    "__v": v,
  };
}
