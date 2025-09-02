// To parse this JSON data, do
//
//     final winningHistoryModel = winningHistoryModelFromJson(jsonString);

import 'dart:convert';

WinningHistoryModel winningHistoryModelFromJson(String str) =>
    WinningHistoryModel.fromJson(json.decode(str));

String winningHistoryModelToJson(WinningHistoryModel data) =>
    json.encode(data.toJson());

class WinningHistoryModel {
  int success;
  List<Datum> data;

  WinningHistoryModel({required this.success, required this.data});

  factory WinningHistoryModel.fromJson(Map<String, dynamic> json) =>
      WinningHistoryModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String userName;
  String mobile;
  int bidPoints;
  int winningPoints;
  String marketName;
  String gameName;
  String winningNumber;
  String narration;
  String date;
  String status;

  Datum({
    required this.userName,
    required this.mobile,
    required this.bidPoints,
    required this.winningPoints,
    required this.marketName,
    required this.gameName,
    required this.winningNumber,
    required this.narration,
    required this.date,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userName: json["userName"],
    mobile: json["mobile"],
    bidPoints: json["bidPoints"],
    winningPoints: json["winningPoints"],
    marketName: json["marketName"],
    gameName: json["gameName"],
    winningNumber: json["winningNumber"],
    narration: json["narration"],
    date: json["date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "mobile": mobile,
    "bidPoints": bidPoints,
    "winningPoints": winningPoints,
    "marketName": marketName,
    "gameName": gameName,
    "winningNumber": winningNumber,
    "narration": narration,
    "date": date,
    "status": status,
  };
}
