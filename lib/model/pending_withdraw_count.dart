import 'dart:convert';

PendingWithdrawCountModel pendingWithdrawCountModelFromJson(String str) =>
    PendingWithdrawCountModel.fromJson(json.decode(str));

String pendingWithdrawCountModelToJson(PendingWithdrawCountModel data) =>
    json.encode(data.toJson());

class PendingWithdrawCountModel {
  int success;
  String msg;
  Data data;

  PendingWithdrawCountModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory PendingWithdrawCountModel.fromJson(Map<String, dynamic> json) =>
      PendingWithdrawCountModel(
        success: json["success"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  int pendingCount;

  Data({required this.pendingCount});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(pendingCount: json["pendingCount"]);

  Map<String, dynamic> toJson() => {"pendingCount": pendingCount};
}
