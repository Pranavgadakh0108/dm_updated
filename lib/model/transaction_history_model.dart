// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String? str) =>
    TransactionHistoryModel.fromJson(json.decode(str ?? ""));

String? transactionHistoryModelToJson(TransactionHistoryModel data) =>
    json.encode(data.toJson());

class TransactionHistoryModel {
  int success;
  List<Transaction> transactions;
  Pagination pagination;

  TransactionHistoryModel({
    required this.success,
    required this.transactions,
    required this.pagination,
  });

  factory TransactionHistoryModel.fromJson(Map<String?, dynamic>? json) =>
      TransactionHistoryModel(
        success: json?["success"],
        transactions: List<Transaction>.from(
          json?["transactions"].map((x) => Transaction.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json?["pagination"]),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
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

  factory Pagination.fromJson(Map<String?, dynamic>? json) => Pagination(
    page: json?["page"],
    limit: json?["limit"],
    total: json?["total"],
    pages: json?["pages"],
  );

  Map<String?, dynamic>? toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "pages": pages,
  };
}

class Transaction {
  String? id;
  Type? type;
  int amount;
  Status? status;
  dynamic date;
  String? time;
  String? narration;
  DateTime? createdAt;
  String? mode;
  String? transactionId;
  GameType? gameType;
  String? number;
  Market? market;
  Session? session;

  Transaction({
    required this.id,
    this.type,
    required this.amount,
    required this.status,
    required this.date,
    this.time,
    required this.narration,
    required this.createdAt,
    this.mode,
    this.transactionId,
    this.gameType,
    this.number,
    this.market,
    this.session,
  });

  factory Transaction.fromJson(Map<String?, dynamic>? json) => Transaction(
    id: json?["_id"] ?? "", // Provide default value
    type: json?["type"] != null
        ? typeValues.map[json?["type"]]
        : null, // Handle null
    amount: json?["amount"] ?? 0, // Provide default value
    status: statusValues.map[json?["status"]] ?? Status.LOSER,
    date: json?["date"],
    time: json?["time"],
    narration: json?["narration"] ?? "", // Provide default value
    createdAt: DateTime?.parse(
      json?["createdAt"] ?? DateTime?.now().toIso8601String(),
    ), // Handle null
    mode: json?["mode"],
    transactionId: json?["transactionId"],
    gameType: json?["gameType"] != null
        ? gameTypeValues.map[json?["gameType"]]
        : null, // Handle null
    number: json?["number"],
    market: json?["market"] != null
        ? marketValues.map[json?["market"]]
        : null, // Handle null
    session: json?["session"] != null
        ? sessionValues.map[json?["session"]]
        : null, // Handle null
  );
  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "type": type != null ? typeValues.reverse[type] : null,
    "amount": amount,
    "status": status != null ? statusValues.reverse[status] : null,
    "date": date,
    "time": time,
    "narration": narration,
    "createdAt": createdAt?.toIso8601String(),
    "mode": mode,
    "transactionId": transactionId,
    "gameType": gameType != null ? gameTypeValues.reverse[gameType] : null,
    "number": number,
    "market": market != null
        ? marketValues.reverse[market]
        : null, // Handle null
    "session": session != null ? sessionValues.reverse[session] : null,
  };
}

enum DateEnum { THE_01092025 }

final dateEnumValues = EnumValues({"01/09/2025": DateEnum.THE_01092025});

enum GameType { UNKNOWN }

final gameTypeValues = EnumValues({"Unknown": GameType.UNKNOWN});

enum Market {
  THE_68_B3_D562_A32_E4943520263_A4,
  THE_68_B3_D59_EA32_E4943520263_A6,
  THE_68_B543_BC8_BF58_D966656_F323,
}

final marketValues = EnumValues({
  "68b3d562a32e4943520263a4": Market.THE_68_B3_D562_A32_E4943520263_A4,
  "68b3d59ea32e4943520263a6": Market.THE_68_B3_D59_EA32_E4943520263_A6,
  "68b543bc8bf58d966656f323": Market.THE_68_B543_BC8_BF58_D966656_F323,
});

enum Session { CLOSE, OPEN }

final sessionValues = EnumValues({
  "CLOSE": Session.CLOSE,
  "OPEN": Session.OPEN,
});

enum Status { APPROVED, LOSER, PENDING, REJECTED, WINNER }

final statusValues = EnumValues({
  "Approved": Status.APPROVED,
  "LOSER": Status.LOSER,
  "Pending": Status.PENDING,
  "Rejected": Status.REJECTED,
  "WINNER": Status.WINNER,
});

enum Type { DEPOSIT, WITHDRAW }

final typeValues = EnumValues({
  "deposit": Type.DEPOSIT,
  "withdraw": Type.WITHDRAW,
});

class EnumValues<T> {
  Map<String?, T> map;
  late Map<T, String?> reverseMap;

  EnumValues(this.map);

  Map<T, String?> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
