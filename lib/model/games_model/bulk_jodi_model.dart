
import 'dart:convert';

BulkJodiModel bulkJodiModelFromJson(String str) => BulkJodiModel.fromJson(json.decode(str));

String bulkJodiModelToJson(BulkJodiModel data) => json.encode(data.toJson());

class BulkJodiModel {
    String gameId;
    String gameType;
    List<BulkJodi> bulkJodi;
    String userId;
    DateTime gameDate;

    BulkJodiModel({
        required this.gameId,
        required this.gameType,
        required this.bulkJodi,
        required this.userId,
        required this.gameDate,
    });

    factory BulkJodiModel.fromJson(Map<String, dynamic> json) => BulkJodiModel(
        gameId: json["gameId"],
        gameType: json["gameType"],
        bulkJodi: List<BulkJodi>.from(json["bulkJodi"].map((x) => BulkJodi.fromJson(x))),
        userId: json["userId"],
        gameDate: DateTime.parse(json["gameDate"]),
    );

    Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "gameType": gameType,
        "bulkJodi": List<dynamic>.from(bulkJodi.map((x) => x.toJson())),
        "userId": userId,
        "gameDate": "${gameDate.year.toString().padLeft(4, '0')}-${gameDate.month.toString().padLeft(2, '0')}-${gameDate.day.toString().padLeft(2, '0')}",
    };
}

class BulkJodi {
    String jodi;
    int amount;

    BulkJodi({
        required this.jodi,
        required this.amount,
    });

    factory BulkJodi.fromJson(Map<String, dynamic> json) => BulkJodi(
        jodi: json["jodi"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "jodi": jodi,
        "amount": amount,
    };
}
