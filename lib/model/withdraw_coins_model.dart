import 'dart:convert';

WithdrawCoinsModel withdrawCoinsModelFromJson(String str) =>
    WithdrawCoinsModel.fromJson(json.decode(str));

String withdrawCoinsModelToJson(WithdrawCoinsModel data) =>
    json.encode(data.toJson());

class WithdrawCoinsModel {
  int amount;

  WithdrawCoinsModel({required this.amount});

  factory WithdrawCoinsModel.fromJson(Map<String, dynamic> json) =>
      WithdrawCoinsModel(amount: json["amount"] ?? 0);

  Map<String, dynamic> toJson() => {"amount": amount};
}
