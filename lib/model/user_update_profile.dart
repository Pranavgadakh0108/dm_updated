import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) =>
    UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  String name;
  String email;
  String mobile;
  int wallet;
  String paytm;
  String password;
  String confirmPassword;

  UpdateProfile({
    required this.name,
    required this.email,
    required this.mobile,
    required this.wallet,
    required this.paytm,
    required this.password,
    required this.confirmPassword,
  });

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    wallet: json["wallet"],
    paytm: json["paytm"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile": mobile,
    "wallet": wallet,
    "paytm": paytm,
    "password": password,
    "confirmPassword": confirmPassword,
  };
}
