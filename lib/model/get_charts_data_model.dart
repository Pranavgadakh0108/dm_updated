
import 'dart:convert';

GetChartDataModel getChartDataModelFromJson(String str) =>
    GetChartDataModel.fromJson(json.decode(str));

String getChartDataModelToJson(GetChartDataModel data) =>
    json.encode(data.toJson());

class GetChartDataModel {
  int success;
  List<Datum> data;

  GetChartDataModel({required this.success, required this.data});

  factory GetChartDataModel.fromJson(Map<String, dynamic> json) =>
      GetChartDataModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String market;
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
  String jodi;

  Datum({
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
    required this.jodi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    market: json["market"],
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
    jodi: json["jodi"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "market": market,
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
    "jodi": jodi,
  };
}
