
import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) => RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) => json.encode(data.toJson());

class RegisterUserModel {
    bool success;
    String message;
    User user;

    RegisterUserModel({
        required this.success,
        required this.message,
        required this.user,
    });

    factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
        success: json["success"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    String id;
    String mobile;
    String name;
    String email;

    User({
        required this.id,
        required this.mobile,
        required this.name,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        mobile: json["mobile"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "name": name,
        "email": email,
    };
}
