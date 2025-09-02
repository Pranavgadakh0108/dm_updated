import 'dart:convert';

List<GamesModel> gamesModelFromJson(String str) =>
    List<GamesModel>.from(json.decode(str).map((x) => GamesModel.fromJson(x)));

String gamesModelToJson(List<GamesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GamesModel {
  String id;
  String game;
  String bazar;
  String open;
  String close;
  String days;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GamesModel({
    required this.id,
    required this.game,
    required this.bazar,
    required this.open,
    required this.close,
    required this.days,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
    id: json["_id"],
    game: json["game"],
    bazar: json["bazar"],
    open: json["open"],
    close: json["close"],
    days: json["days"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "game": game,
    "bazar": bazar,
    "open": open,
    "close": close,
    "days": days,
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
