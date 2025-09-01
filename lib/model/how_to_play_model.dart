
import 'dart:convert';

HowToPlayModel howToPlayModelFromJson(String str) => HowToPlayModel.fromJson(json.decode(str));

String howToPlayModelToJson(HowToPlayModel data) => json.encode(data.toJson());

class HowToPlayModel {
    bool success;
    String message;
    Data data;

    HowToPlayModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory HowToPlayModel.fromJson(Map<String, dynamic> json) => HowToPlayModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String howToPlay;
    String howToDeposite;
    String howToWithdraw;

    Data({
        required this.howToPlay,
        required this.howToDeposite,
        required this.howToWithdraw,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        howToPlay: json["how_to_play"],
        howToDeposite: json["how_to_deposite"],
        howToWithdraw: json["how_to_withdraw"],
    );

    Map<String, dynamic> toJson() => {
        "how_to_play": howToPlay,
        "how_to_deposite": howToDeposite,
        "how_to_withdraw": howToWithdraw,
    };
}
