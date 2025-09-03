// To parse this JSON data, do
//
//     final addBankDetails = addBankDetailsFromJson(jsonString);

import 'dart:convert';

AddBankDetails addBankDetailsFromJson(String str) =>
    AddBankDetails.fromJson(json.decode(str));

String addBankDetailsToJson(AddBankDetails data) => json.encode(data.toJson());

class AddBankDetails {
  String accountHolderName;
  String accountNumber;
  String confirmAccountNumber;
  String ifscCode;
  String bankName;

  AddBankDetails({
    required this.accountHolderName,
    required this.accountNumber,
    required this.confirmAccountNumber,
    required this.ifscCode,
    required this.bankName,
  });

  factory AddBankDetails.fromJson(Map<String, dynamic> json) => AddBankDetails(
    accountHolderName: json["account_holder_name"] ?? "",
    accountNumber: json["account_number"] ?? "",
    confirmAccountNumber: json["confirm_account_number"] ?? "",
    ifscCode: json["ifsc_code"] ?? "",
    bankName: json["bank_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "confirm_account_number": confirmAccountNumber,
    "ifsc_code": ifscCode,
    "bank_name": bankName,
  };
}
