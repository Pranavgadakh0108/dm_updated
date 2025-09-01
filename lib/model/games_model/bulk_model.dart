
import 'dart:convert';

BulkModel bulkModelFromJson(String str) => BulkModel.fromJson(json.decode(str));

String bulkModelToJson(BulkModel data) => json.encode(data.toJson());

class BulkModel {
    String gameId;
    String gameType;
    List<BulkSp> bulkSp;

    BulkModel({
        required this.gameId,
        required this.gameType,
        required this.bulkSp,
    });

    factory BulkModel.fromJson(Map<String, dynamic> json) => BulkModel(
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
