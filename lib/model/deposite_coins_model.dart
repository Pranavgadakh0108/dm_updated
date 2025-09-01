
import 'dart:convert';

DepositeCoinsModel depositeCoinsModelFromJson(String str) => DepositeCoinsModel.fromJson(json.decode(str));

String depositeCoinsModelToJson(DepositeCoinsModel data) => json.encode(data.toJson());

class DepositeCoinsModel {
    bool success;
    String message;
    Deposit deposit;

    DepositeCoinsModel({
        required this.success,
        required this.message,
        required this.deposit,
    });

    factory DepositeCoinsModel.fromJson(Map<String, dynamic> json) => DepositeCoinsModel(
        success: json["success"],
        message: json["message"],
        deposit: Deposit.fromJson(json["deposit"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "deposit": deposit.toJson(),
    };
}

class Deposit {
    int sn;
    String mobile;
    int amount;
    String method;
    String payId;
    DateTime createdAt;
    int status;
    dynamic updatedAt;
    DateTime date;
    String ipAddress;
    dynamic razorpayResponse;
    String id;
    int v;

    Deposit({
        required this.sn,
        required this.mobile,
        required this.amount,
        required this.method,
        required this.payId,
        required this.createdAt,
        required this.status,
        required this.updatedAt,
        required this.date,
        required this.ipAddress,
        required this.razorpayResponse,
        required this.id,
        required this.v,
    });

    factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        sn: json["sn"],
        mobile: json["mobile"],
        amount: json["amount"],
        method: json["method"],
        payId: json["pay_id"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        updatedAt: json["updated_at"],
        date: DateTime.parse(json["date"]),
        ipAddress: json["ip_address"],
        razorpayResponse: json["razorpay_response"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "sn": sn,
        "mobile": mobile,
        "amount": amount,
        "method": method,
        "pay_id": payId,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "updated_at": updatedAt,
        "date": date.toIso8601String(),
        "ip_address": ipAddress,
        "razorpay_response": razorpayResponse,
        "_id": id,
        "__v": v,
    };
}
