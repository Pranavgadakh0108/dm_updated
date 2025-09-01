
import 'dart:convert';

MobileExistModel mobileExistModelFromJson(String str) => MobileExistModel.fromJson(json.decode(str));

String mobileExistModelToJson(MobileExistModel data) => json.encode(data.toJson());

class MobileExistModel {
    bool success;
    String message;
    bool exists;

    MobileExistModel({
        required this.success,
        required this.message,
        required this.exists,
    });

    factory MobileExistModel.fromJson(Map<String, dynamic> json) => MobileExistModel(
        success: json["success"],
        message: json["message"],
        exists: json["exists"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "exists": exists,
    };
}
