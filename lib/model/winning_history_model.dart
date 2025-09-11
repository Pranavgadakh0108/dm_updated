import 'dart:convert';

WinningHistoryModel winningHistoryModelFromJson(String str) =>
    WinningHistoryModel.fromJson(json.decode(str));

String winningHistoryModelToJson(WinningHistoryModel data) =>
    json.encode(data.toJson());

class WinningHistoryModel {
  int success;
  List<Datum> data;
  Pagination pagination;

  WinningHistoryModel({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory WinningHistoryModel.fromJson(Map<String, dynamic> json) =>
      WinningHistoryModel(
        success: json["success"] ?? 0,
        data: List<Datum>.from(
          (json["data"] ?? []).map((x) => Datum.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json["pagination"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  String userName;
  String mobile;
  double bidPoints;
  double winningPoints;
  String marketName;
  String gameName;
  String session;
  String bidNumber;
  String date;
  String status;

  Datum({
    required this.userName,
    required this.mobile,
    required this.bidPoints,
    required this.winningPoints,
    required this.marketName,
    required this.gameName,
    required this.session,
    required this.bidNumber,
    required this.date,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userName: json["userName"] ?? "",
    mobile: json["mobile"] ?? "",
    bidPoints:
        (json["bidPoints"] is int
                ? json["bidPoints"].toDouble()
                : json["bidPoints"] ?? 0.0)
            .toDouble(),
    winningPoints:
        (json["winningPoints"] is int
                ? json["winningPoints"].toDouble()
                : json["winningPoints"] ?? 0.0)
            .toDouble(),
    marketName: json["marketName"] ?? "",
    gameName: json["gameName"] ?? "",
    session: json["session"] ?? "",
    bidNumber: json["bidNumber"] ?? "",
    date: json["date"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "mobile": mobile,
    "bidPoints": bidPoints,
    "winningPoints": winningPoints,
    "marketName": marketName,
    "gameName": gameName,
    "session": session,
    "bidNumber": bidNumber,
    "date": date,
    "status": status,
  };
}

class Pagination {
  int page;
  int limit;
  int total;
  int pages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"] ?? 0,
    limit: json["limit"] ?? 0,
    total: json["total"] ?? 0,
    pages: json["pages"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "pages": pages,
  };
}
