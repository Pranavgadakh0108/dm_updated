
import 'dart:convert';

GamesModel gamesModelFromJson(String? str) =>
    GamesModel.fromJson(json.decode(str ?? ""));

String? gamesModelToJson(GamesModel data) => json.encode(data.toJson());

class GamesModel {
  int success;
  String? date;
  List<Game> games;

  GamesModel({required this.success, required this.date, required this.games});

  factory GamesModel.fromJson(Map<String?, dynamic>? json) => GamesModel(
    success: json?["success"],
    date: json?["date"],
    games: List<Game>.from(json?["games"].map((x) => Game.fromJson(x))),
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "date": date,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class Game {
  String? id;
  String? game;
  String? bazar;
  String? open;
  String? close;
  Days days;
  bool? active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  Result result;

  Game({
    required this.id,
    required this.game,
    required this.bazar,
    required this.open,
    required this.close,
    required this.days,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.result,
  });

  factory Game.fromJson(Map<String?, dynamic>? json) => Game(
    id: json?["_id"],
    game: json?["game"],
    bazar: json?["bazar"],
    open: json?["open"],
    close: json?["close"],
    days: daysValues.map[json?["days"]] ?? Days.NULL,
    active: json?["active"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
    result: Result.fromJson(json?["result"]),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "game": game,
    "bazar": bazar,
    "open": open,
    "close": close,
    "days": daysValues.reverse[days],
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "result": result.toJson(),
  };
}

enum Days { NULL }

final daysValues = EnumValues({"null": Days.NULL});

class Result {
  String? open;
  String? openPanna;
  String? close;
  String? closePanna;
  String? pendingOpen;
  String? pendingOpenPanna;
  String? pendingClose;
  String? pendingClosePanna;
  String? pendingSession;
  Status status;

  Result({
    required this.open,
    required this.openPanna,
    required this.close,
    required this.closePanna,
    this.pendingOpen,
    this.pendingOpenPanna,
    this.pendingClose,
    this.pendingClosePanna,
    this.pendingSession,
    required this.status,
  });

  factory Result.fromJson(Map<String?, dynamic>? json) => Result(
    open: json?["open"],
    openPanna: json?["open_panna"],
    close: json?["close"],
    closePanna: json?["close_panna"],
    pendingOpen: json?["pending_open"],
    pendingOpenPanna: json?["pending_open_panna"],
    pendingClose: json?["pending_close"],
    pendingClosePanna: json?["pending_close_panna"],
    pendingSession: json?["pending_session"],
    status: statusValues.map[json?["status"]] ?? Status.OPEN_CLOSE,
  );

  Map<String?, dynamic>? toJson() => {
    "open": open,
    "open_panna": openPanna,
    "close": close,
    "close_panna": closePanna,
    "pending_open": pendingOpen,
    "pending_open_panna": pendingOpenPanna,
    "pending_close": pendingClose,
    "pending_close_panna": pendingClosePanna,
    "pending_session": pendingSession,
    "status": statusValues.reverse[status],
  };
}

enum Status { OPEN_CLOSE, PENDING }

final statusValues = EnumValues({
  "open_close": Status.OPEN_CLOSE,
  "pending": Status.PENDING,
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
