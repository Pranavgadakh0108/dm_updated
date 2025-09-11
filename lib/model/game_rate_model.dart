
import 'dart:convert';

GameRatesModel gamesRatesModelFromJson(String str) =>
    GameRatesModel.fromJson(json.decode(str));

String gamesRatesModelToJson(GameRatesModel data) => json.encode(data.toJson());

class GameRatesModel {
  bool success;
  String message;
  List<ListElement> list;

  GameRatesModel({
    required this.success,
    required this.message,
    required this.list,
  });

  factory GameRatesModel.fromJson(Map<String, dynamic> json) => GameRatesModel(
    success: json["success"],
    message: json["message"],
    list: List<ListElement>.from(
      json["list"].map((x) => ListElement.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  String key;
  int value;

  ListElement({required this.key, required this.value});

  factory ListElement.fromJson(Map<String, dynamic> json) =>
      ListElement(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}
