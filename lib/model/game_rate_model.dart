// To parse this JSON data, do
//
//     final gameRatesModel = gameRatesModelFromJson(jsonString);

import 'dart:convert';

GameRatesModel gameRatesModelFromJson(String str) =>
    GameRatesModel.fromJson(json.decode(str));

String gameRatesModelToJson(GameRatesModel data) => json.encode(data.toJson());

class GameRatesModel {
  bool success;
  String message;
  Numeric numeric;

  GameRatesModel({
    required this.success,
    required this.message,
    required this.numeric,
  });

  factory GameRatesModel.fromJson(Map<String, dynamic> json) => GameRatesModel(
    success: json["success"],
    message: json["message"],
    numeric: Numeric.fromJson(json["numeric"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "numeric": numeric.toJson(),
  };
}

class Numeric {
  String id;
  int singleAnk;
  int jodi;
  int singlePatti;
  int doublePatti;
  int triplePatti;
  int halfSangam;
  int fullSangam;
  int sp;
  int dp;
  int round;
  int centerpanna;
  int aki;
  int beki;
  int chart50;
  int chart60;
  int chart70;
  int akibekicut30;
  int abr30Pana;
  int startend;
  int cyclepana;
  int groupJodi;
  int panelGroup;
  int bulkJodi;
  int bulkSp;
  int bulkDp;
  int familypannel;
  int familyjodi;
  int v;

  Numeric({
    required this.id,
    required this.singleAnk,
    required this.jodi,
    required this.singlePatti,
    required this.doublePatti,
    required this.triplePatti,
    required this.halfSangam,
    required this.fullSangam,
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
    required this.groupJodi,
    required this.panelGroup,
    required this.bulkJodi,
    required this.bulkSp,
    required this.bulkDp,
    required this.familypannel,
    required this.familyjodi,
    required this.v,
  });

  factory Numeric.fromJson(Map<String, dynamic> json) => Numeric(
    id: json["_id"],
    singleAnk: json["SINGLE_ANK"],
    jodi: json["JODI"],
    singlePatti: json["SINGLE_PATTI"],
    doublePatti: json["DOUBLE_PATTI"],
    triplePatti: json["TRIPLE_PATTI"],
    halfSangam: json["HALF_SANGAM"],
    fullSangam: json["FULL_SANGAM"],
    sp: json["Sp"],
    dp: json["Dp"],
    round: json["ROUND"],
    centerpanna: json["CENTERPANNA"],
    aki: json["AKI"],
    beki: json["BEKI"],
    chart50: json["CHART50"],
    chart60: json["CHART60"],
    chart70: json["CHART70"],
    akibekicut30: json["AKIBEKICUT30"],
    abr30Pana: json["ABR30PANA"],
    startend: json["STARTEND"],
    cyclepana: json["CYCLEPANA"],
    groupJodi: json["GROUP_JODI"],
    panelGroup: json["PANEL_GROUP"],
    bulkJodi: json["BULK_JODI"],
    bulkSp: json["BULK_SP"],
    bulkDp: json["BULK_DP"],
    familypannel: json["FAMILYPANNEL"],
    familyjodi: json["FAMILYJODI"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "SINGLE_ANK": singleAnk,
    "JODI": jodi,
    "SINGLE_PATTI": singlePatti,
    "DOUBLE_PATTI": doublePatti,
    "TRIPLE_PATTI": triplePatti,
    "HALF_SANGAM": halfSangam,
    "FULL_SANGAM": fullSangam,
    "Sp": sp,
    "Dp": dp,
    "ROUND": round,
    "CENTERPANNA": centerpanna,
    "AKI": aki,
    "BEKI": beki,
    "CHART50": chart50,
    "CHART60": chart60,
    "CHART70": chart70,
    "AKIBEKICUT30": akibekicut30,
    "ABR30PANA": abr30Pana,
    "STARTEND": startend,
    "CYCLEPANA": cyclepana,
    "GROUP_JODI": groupJodi,
    "PANEL_GROUP": panelGroup,
    "BULK_JODI": bulkJodi,
    "BULK_SP": bulkSp,
    "BULK_DP": bulkDp,
    "FAMILYPANNEL": familypannel,
    "FAMILYJODI": familyjodi,
    "__v": v,
  };
}
