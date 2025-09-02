import 'dart:convert';

AddBankDetails addBankDetailsFromJson(String str) =>
    AddBankDetails.fromJson(json.decode(str));

String addBankDetailsToJson(AddBankDetails data) => json.encode(data.toJson());

class AddBankDetails {
  String accountHolderName;
  String accountNumber;
  String ifscCode;

  AddBankDetails({
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
  });

  factory AddBankDetails.fromJson(Map<String, dynamic> json) => AddBankDetails(
    accountHolderName: json["account_holder_name"] ?? '',
    accountNumber: json["account_number"] ?? '',
    ifscCode: json["ifsc_code"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
  };
}
