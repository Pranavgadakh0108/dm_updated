import 'dart:convert';

BidHistoryModel bidHistoryModelFromJson(String str) =>
    BidHistoryModel.fromJson(json.decode(str));

String bidHistoryModelToJson(BidHistoryModel data) =>
    json.encode(data.toJson());

class BidHistoryModel {
  int success;
  List<Bet> bets;
  Pagination pagination;

  BidHistoryModel({
    required this.success,
    required this.bets,
    required this.pagination,
  });

  factory BidHistoryModel.fromJson(Map<String, dynamic> json) =>
      BidHistoryModel(
        success: json["success"],
        bets: List<Bet>.from(json["bets"].map((x) => Bet.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "bets": List<dynamic>.from(bets.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Bet {
  String id;
  String gameType;
  String number;
  int amount;
  String market;
  String date;
  String session;
  String status;
  DateTime createdAt;

  Bet({
    required this.id,
    required this.gameType,
    required this.number,
    required this.amount,
    required this.market,
    required this.date,
    required this.session,
    required this.status,
    required this.createdAt,
  });

  factory Bet.fromJson(Map<String, dynamic> json) => Bet(
    id: json["_id"],
    gameType: json["gameType"],
    number: json["number"],
    amount: json["amount"],
    market: json["market"],
    date: json["date"],
    session: json["session"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gameType": gameType,
    "number": number,
    "amount": amount,
    "market": market,
    "date": date,
    "session": session,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
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
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    pages: json["pages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "pages": pages,
  };
}
