// To parse this JSON data, do
//
//     final GetBankDetailsModel = GetBankDetailsModelFromJson(jsonString);

import 'dart:convert';

GetBankDetailsModel getBankDetailsModelFromJson(String str) =>
    GetBankDetailsModel.fromJson(json.decode(str));

String getBankDetailsModelToJson(GetBankDetailsModel data) =>
    json.encode(data.toJson());

class GetBankDetailsModel {
  bool success;
  String message;
  List<Bank> banks;
  int totalPages;
  int currentPage;
  int total;

  GetBankDetailsModel({
    required this.success,
    required this.message,
    required this.banks,
    required this.totalPages,
    required this.currentPage,
    required this.total,
  });

  factory GetBankDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetBankDetailsModel(
        success: json["success"],
        message: json["message"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "total": total,
  };
}

class Bank {
  String id;
  String accountHolderName;
  String accountNumber;
  String ifscCode;
  String bankName;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int bankId;
  int v;

  Bank({
    required this.id,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.bankId,
    required this.v,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["_id"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    bankName: json["bank_name"],
    createdBy: CreatedBy.fromJson(json["created_by"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    bankId: json["bank_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "bank_name":bankName,
    "created_by": createdBy.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "bank_id": bankId,
    "__v": v,
  };
}

class CreatedBy {
  String id;
  String mobile;
  String name;

  CreatedBy({required this.id, required this.mobile, required this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      CreatedBy(id: json["_id"], mobile: json["mobile"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "mobile": mobile, "name": name};
}
