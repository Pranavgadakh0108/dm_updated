// // To parse this JSON data, do
// //
// //     final getMarketModel = getMarketModelFromJson(jsonString);

// import 'dart:convert';

// GetMarketModel getMarketModelFromJson(String str) =>
//     GetMarketModel.fromJson(json.decode(str));

// String getMarketModelToJson(GetMarketModel data) => json.encode(data.toJson());

// class GetMarketModel {
//   bool success;
//   String message;
//   List<Market> markets;

//   GetMarketModel({
//     required this.success,
//     required this.message,
//     required this.markets,
//   });

//   factory GetMarketModel.fromJson(Map<String, dynamic> json) => GetMarketModel(
//     success: json["success"],
//     message: json["message"],
//     markets: List<Market>.from(json["markets"].map((x) => Market.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "markets": List<dynamic>.from(markets.map((x) => x.toJson())),
//   };
// }

// class Market {
//   String id;
//   int sn;
//   String market;
//   String open;
//   String close;
//   String days;
//   int sortNo;
//   String active;
//   int type;
//   int openStatus;
//   int closeStatus;
//   int v;

//   Market({
//     required this.id,
//     required this.sn,
//     required this.market,
//     required this.open,
//     required this.close,
//     required this.days,
//     required this.sortNo,
//     required this.active,
//     required this.type,
//     required this.openStatus,
//     required this.closeStatus,
//     required this.v,
//   });

//   factory Market.fromJson(Map<String, dynamic> json) => Market(
//     id: json["_id"],
//     sn: json["sn"],
//     market: json["market"],
//     open: json["open"],
//     close: json["close"],
//     days: json["days"],
//     sortNo: json["sort_no"],
//     active: json["active"],
//     type: json["type"],
//     openStatus: json["open_status"],
//     closeStatus: json["close_status"],
//     v: json["__v"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "sn": sn,
//     "market": market,
//     "open": open,
//     "close": close,
//     "days": days,
//     "sort_no": sortNo,
//     "active": active,
//     "type": type,
//     "open_status": openStatus,
//     "close_status": closeStatus,
//     "__v": v,
//   };
// }

// To parse this JSON data, do
//
//     final gamesModel = gamesModelFromJson(jsonString);

import 'dart:convert';

List<GamesModel> gamesModelFromJson(String str) => List<GamesModel>.from(json.decode(str).map((x) => GamesModel.fromJson(x)));

String gamesModelToJson(List<GamesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
