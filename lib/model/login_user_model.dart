import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  bool success;
  String message;
  String token;
  User user;

  LoginUserModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String mobile;
  String name;
  // String email;
  int wallet;

  User({
    required this.id,
    required this.mobile,
    required this.name,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    mobile: json["mobile"],
    name: json["name"],
    // email: json["email"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "name": name,
    // "email": email,
    "wallet": wallet,
  };
}
