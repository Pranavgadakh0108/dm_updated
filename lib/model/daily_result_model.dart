// To parse this JSON data, do
//
//     final dailyResultModel = dailyResultModelFromJson(jsonString);

import 'dart:convert';

DailyResultModel dailyResultModelFromJson(String str) =>
    DailyResultModel.fromJson(json.decode(str));

String dailyResultModelToJson(DailyResultModel data) =>
    json.encode(data.toJson());

class DailyResultModel {
  int success;
  List<Datum> data;

  DailyResultModel({required this.success, required this.data});

  factory DailyResultModel.fromJson(Map<String, dynamic> json) =>
      DailyResultModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String market;
  String date;
  String openPanna;
  String open;
  String close;
  String closePanna;
  int openWinners;
  int closeWinners;

  Datum({
    required this.market,
    required this.date,
    required this.openPanna,
    required this.open,
    required this.close,
    required this.closePanna,
    required this.openWinners,
    required this.closeWinners,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    market: json["market"],
    date: json["date"],
    openPanna: json["open_panna"],
    open: json["open"],
    close: json["close"],
    closePanna: json["close_panna"],
    openWinners: json["openWinners"],
    closeWinners: json["closeWinners"],
  );

  Map<String, dynamic> toJson() => {
    "market": market,
    "date": date,
    "open_panna": openPanna,
    "open": open,
    "close": close,
    "close_panna": closePanna,
    "openWinners": openWinners,
    "closeWinners": closeWinners,
  };
}
