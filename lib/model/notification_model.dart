// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  bool success;
  int count;
  List<Datum> data;

  NotificationModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String title;
  String message;
  bool isResult;
  DateTime createdAt;
  DateTime updatedAt;
  ResultData? resultData;
  String? createdBy;
  int? v;

  Datum({
    required this.id,
    required this.title,
    required this.message,
    required this.isResult,
    required this.createdAt,
    required this.updatedAt,
    this.resultData,
    this.createdBy,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    message: json["message"],
    isResult: json["isResult"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    resultData: json["resultData"] == null
        ? null
        : ResultData.fromJson(json["resultData"]),
    createdBy: json["createdBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "message": message,
    "isResult": isResult,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "resultData": resultData?.toJson(),
    "createdBy": createdBy,
    "__v": v,
  };
}

class ResultData {
  String id;
  Market? market;
  String date;
  String open;
  String openPanna;
  String close;
  String closePanna;
  String pendingOpen;
  String pendingOpenPanna;
  String pendingClose;
  String pendingClosePanna;
  String pendingSession;
  String openBatchId;
  String closeBatchId;
  String createdAt;
  int v;

  ResultData({
    required this.id,
    required this.market,
    required this.date,
    required this.open,
    required this.openPanna,
    required this.close,
    required this.closePanna,
    required this.pendingOpen,
    required this.pendingOpenPanna,
    required this.pendingClose,
    required this.pendingClosePanna,
    required this.pendingSession,
    required this.openBatchId,
    required this.closeBatchId,
    required this.createdAt,
    required this.v,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    id: json["_id"],
    market: json["market"] == null ? null : Market.fromJson(json["market"]),
    date: json["date"],
    open: json["open"],
    openPanna: json["open_panna"],
    close: json["close"],
    closePanna: json["close_panna"],
    pendingOpen: json["pending_open"],
    pendingOpenPanna: json["pending_open_panna"],
    pendingClose: json["pending_close"],
    pendingClosePanna: json["pending_close_panna"],
    pendingSession: json["pending_session"],
    openBatchId: json["openBatchId"],
    closeBatchId: json["closeBatchId"],
    createdAt: json["created_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "market": market?.toJson(),
    "date": date,
    "open": open,
    "open_panna": openPanna,
    "close": close,
    "close_panna": closePanna,
    "pending_open": pendingOpen,
    "pending_open_panna": pendingOpenPanna,
    "pending_close": pendingClose,
    "pending_close_panna": pendingClosePanna,
    "pending_session": pendingSession,
    "openBatchId": openBatchId,
    "closeBatchId": closeBatchId,
    "created_at": createdAt,
    "__v": v,
  };
}

class Market {
  String id;
  String game;
  String bazar;

  Market({required this.id, required this.game, required this.bazar});

  factory Market.fromJson(Map<String, dynamic> json) =>
      Market(id: json["_id"], game: json["game"], bazar: json["bazar"]);

  Map<String, dynamic> toJson() => {"_id": id, "game": game, "bazar": bazar};
}
