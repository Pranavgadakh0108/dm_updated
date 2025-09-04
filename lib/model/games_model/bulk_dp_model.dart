// To parse this JSON data, do
//
//     final bulkDpModel = bulkDpModelFromJson(jsonString);

import 'dart:convert';

BulkDpModel bulkDpModelFromJson(String str) => BulkDpModel.fromJson(json.decode(str));

String bulkDpModelToJson(BulkDpModel data) => json.encode(data.toJson());

class BulkDpModel {
    String gameId;
    String gameType;
    List<BulkDp> bulkDp;

    BulkDpModel({
        required this.gameId,
        required this.gameType,
        required this.bulkDp,
    });

    factory BulkDpModel.fromJson(Map<String, dynamic> json) => BulkDpModel(
        gameId: json["gameId"],
        gameType: json["gameType"],
        bulkDp: List<BulkDp>.from(json["bulkDp"].map((x) => BulkDp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameType": gameType,
        "bulkDp": List<dynamic>.from(bulkDp.map((x) => x.toJson())),
    };
}

class BulkDp {
    String number;
    int amount;

    BulkDp({
        required this.number,
        required this.amount,
    });

    factory BulkDp.fromJson(Map<String, dynamic> json) => BulkDp(
        number: json["number"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "amount": amount,
    };
}
