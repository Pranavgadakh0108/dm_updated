
import 'dart:convert';

BulkSpModel bulkSpModelFromJson(String str) => BulkSpModel.fromJson(json.decode(str));

String bulkSpModelToJson(BulkSpModel data) => json.encode(data.toJson());

class BulkSpModel {
    String gameId;
    String gameType;
    List<BulkSp> bulkSp;

    BulkSpModel({
        required this.gameId,
        required this.gameType,
        required this.bulkSp,
    });

    factory BulkSpModel.fromJson(Map<String, dynamic> json) => BulkSpModel(
        gameId: json["gameId"],
        gameType: json["gameType"],
        bulkSp: List<BulkSp>.from(json["bulkSP"].map((x) => BulkSp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameType": gameType,
        "bulkSP": List<dynamic>.from(bulkSp.map((x) => x.toJson())),
    };
}

class BulkSp {
    String number;
    int amount;

    BulkSp({
        required this.number,
        required this.amount,
    });

    factory BulkSp.fromJson(Map<String, dynamic> json) => BulkSp(
        number: json["number"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "amount": amount,
    };
}
