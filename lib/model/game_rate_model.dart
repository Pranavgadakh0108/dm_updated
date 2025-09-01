
import 'dart:convert';

GameRateModel gameRateModelFromJson(String str) => GameRateModel.fromJson(json.decode(str));

String gameRateModelToJson(GameRateModel data) => json.encode(data.toJson());

class GameRateModel {
    bool success;
    String message;
    Rates rates;

    GameRateModel({
        required this.success,
        required this.message,
        required this.rates,
    });

    factory GameRateModel.fromJson(Map<String, dynamic> json) => GameRateModel(
        success: json["success"],
        message: json["message"],
        rates: Rates.fromJson(json["rates"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "rates": rates.toJson(),
    };
}

class Rates {
    String id;
    String single;
    String jodi;
    String singlepatti;
    String doublepatti;
    String triplepatti;
    String halfsangam;
    String fullsangam;
    String sp;
    String dp;
    String round;
    String centerpanna;
    String aki;
    String beki;
    String chart50;
    String chart60;
    String chart70;
    String akibekicut30;
    String abr30Pana;
    String startend;
    String cyclepana;
    String groupjodi;
    String panelgroup;
    String bulkjodi;
    String bulksp;
    String bulkdp;
    String familypannel;
    String familyjodi;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Rates({
        required this.id,
        required this.single,
        required this.jodi,
        required this.singlepatti,
        required this.doublepatti,
        required this.triplepatti,
        required this.halfsangam,
        required this.fullsangam,
        required this.sp,
        required this.dp,
        required this.round,
        required this.centerpanna,
        required this.aki,
        required this.beki,
        required this.chart50,
        required this.chart60,
        required this.chart70,
        required this.akibekicut30,
        required this.abr30Pana,
        required this.startend,
        required this.cyclepana,
        required this.groupjodi,
        required this.panelgroup,
        required this.bulkjodi,
        required this.bulksp,
        required this.bulkdp,
        required this.familypannel,
        required this.familyjodi,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        id: json["_id"],
        single: json["single"],
        jodi: json["jodi"],
        singlepatti: json["singlepatti"],
        doublepatti: json["doublepatti"],
        triplepatti: json["triplepatti"],
        halfsangam: json["halfsangam"],
        fullsangam: json["fullsangam"],
        sp: json["Sp"],
        dp: json["Dp"],
        round: json["round"],
        centerpanna: json["centerpanna"],
        aki: json["aki"],
        beki: json["beki"],
        chart50: json["chart50"],
        chart60: json["chart60"],
        chart70: json["chart70"],
        akibekicut30: json["akibekicut30"],
        abr30Pana: json["abr30pana"],
        startend: json["startend"],
        cyclepana: json["cyclepana"],
        groupjodi: json["groupjodi"],
        panelgroup: json["panelgroup"],
        bulkjodi: json["bulkjodi"],
        bulksp: json["bulksp"],
        bulkdp: json["bulkdp"],
        familypannel: json["familypannel"],
        familyjodi: json["familyjodi"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "single": single,
        "jodi": jodi,
        "singlepatti": singlepatti,
        "doublepatti": doublepatti,
        "triplepatti": triplepatti,
        "halfsangam": halfsangam,
        "fullsangam": fullsangam,
        "Sp": sp,
        "Dp": dp,
        "round": round,
        "centerpanna": centerpanna,
        "aki": aki,
        "beki": beki,
        "chart50": chart50,
        "chart60": chart60,
        "chart70": chart70,
        "akibekicut30": akibekicut30,
        "abr30pana": abr30Pana,
        "startend": startend,
        "cyclepana": cyclepana,
        "groupjodi": groupjodi,
        "panelgroup": panelgroup,
        "bulkjodi": bulkjodi,
        "bulksp": bulksp,
        "bulkdp": bulkdp,
        "familypannel": familypannel,
        "familyjodi": familyjodi,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
