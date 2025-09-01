
import 'dart:convert';

SingleAnkModel singleAnkModelFromJson(String str) => SingleAnkModel.fromJson(json.decode(str));

String singleAnkModelToJson(SingleAnkModel data) => json.encode(data.toJson());

class SingleAnkModel {
    String gameId;
    String gameType;
    String number;
    int amount;

    SingleAnkModel({
        required this.gameId,
        required this.gameType,
        required this.number,
        required this.amount,
    });

    factory SingleAnkModel.fromJson(Map<String, dynamic> json) => SingleAnkModel(
        gameId: json["gameId"],
        gameType: json["gameType"],
        number: json["number"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameType": gameType,
        "number": number,
        "amount": amount,
    };
}
