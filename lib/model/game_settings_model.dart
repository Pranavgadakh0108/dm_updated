
import 'dart:convert';

GameSettings gameSettingsFromJson(String? str) =>
    GameSettings.fromJson(json.decode(str ?? ""));

String? gameSettingsToJson(GameSettings data) => json.encode(data.toJson());

class GameSettings {
  bool? success;
  String? message;
  Data data;

  GameSettings({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GameSettings.fromJson(Map<String?, dynamic> json) => GameSettings(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String?, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String? historyDeleteDays;
  String? signupReward;
  String? minBalanceAfterWithdraw;
  String? minDeposit;
  String? minWithdraw;
  String? maxWithdraw;
  String? withdrawTimesPerDay;
  String? upi;
  String? merchant;
  String? upi2;
  String? merchant2;
  String? upi3;
  String? merchant3;
  String? whatsappActive;
  String? whatsapp;
  String? whatsappSupport;
  String? withdrawOpenTime;
  String? withdrawCloseTime;
  String? verifyUpiPayment;
  String? whatsappReset;
  String? gpay;
  String? phonepe;
  String? paytm;
  String? razorpay;
  String? otpVerification;
  String? chatSupport;
  String? welcomeMsg;
  String? howToDeposite;
  String? howToWithdraw;
  String? howToPlay;

  Data({
    required this.historyDeleteDays,
    required this.signupReward,
    required this.minBalanceAfterWithdraw,
    required this.minDeposit,
    required this.minWithdraw,
    required this.maxWithdraw,
    required this.withdrawTimesPerDay,
    required this.upi,
    required this.merchant,
    required this.upi2,
    required this.merchant2,
    required this.upi3,
    required this.merchant3,
    required this.whatsappActive,
    required this.whatsapp,
    required this.whatsappSupport,
    required this.withdrawOpenTime,
    required this.withdrawCloseTime,
    required this.verifyUpiPayment,
    required this.whatsappReset,
    required this.gpay,
    required this.phonepe,
    required this.paytm,
    required this.razorpay,
    required this.otpVerification,
    required this.chatSupport,
    required this.welcomeMsg,
    required this.howToDeposite,
    required this.howToWithdraw,
    required this.howToPlay,
  });

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    historyDeleteDays: json["history_delete_days"],
    signupReward: json["signup_reward"],
    minBalanceAfterWithdraw: json["minBalanceAfterWithdraw"],
    minDeposit: json["min_deposit"],
    minWithdraw: json["min_withdraw"],
    maxWithdraw: json["max_withdraw"],
    withdrawTimesPerDay: json["withdraw_times_per_day"],
    upi: json["upi"],
    merchant: json["merchant"],
    upi2: json["upi_2"],
    merchant2: json["merchant_2"],
    upi3: json["upi_3"],
    merchant3: json["merchant_3"],
    whatsappActive: json["whatsapp_active"],
    whatsapp: json["whatsapp"],
    whatsappSupport: json["whatsapp_support"],
    withdrawOpenTime: json["withdrawOpenTime"],
    withdrawCloseTime: json["withdrawCloseTime"],
    verifyUpiPayment: json["verify_upi_payment"],
    whatsappReset: json["whatsapp_reset"],
    gpay: json["gpay"],
    phonepe: json["phonepe"],
    paytm: json["paytm"],
    razorpay: json["razorpay"],
    otpVerification: json["otp_verification"],
    chatSupport: json["chat_support"],
    welcomeMsg: json["welcome_msg"],
    howToDeposite: json["how_to_deposite"],
    howToWithdraw: json["how_to_withdraw"],
    howToPlay: json["how_to_play"],
  );

  Map<String?, dynamic> toJson() => {
    "history_delete_days": historyDeleteDays,
    "signup_reward": signupReward,
    "minBalanceAfterWithdraw": minBalanceAfterWithdraw,
    "min_deposit": minDeposit,
    "min_withdraw": minWithdraw,
    "max_withdraw": maxWithdraw,
    "withdraw_times_per_day": withdrawTimesPerDay,
    "upi": upi,
    "merchant": merchant,
    "upi_2": upi2,
    "merchant_2": merchant2,
    "upi_3": upi3,
    "merchant_3": merchant3,
    "whatsapp_active": whatsappActive,
    "whatsapp": whatsapp,
    "whatsapp_support": whatsappSupport,
    "withdrawOpenTime": withdrawOpenTime,
    "withdrawCloseTime": withdrawCloseTime,
    "verify_upi_payment": verifyUpiPayment,
    "whatsapp_reset": whatsappReset,
    "gpay": gpay,
    "phonepe": phonepe,
    "paytm": paytm,
    "razorpay": razorpay,
    "otp_verification": otpVerification,
    "chat_support": chatSupport,
    "welcome_msg": welcomeMsg,
    "how_to_deposite": howToDeposite,
    "how_to_withdraw": howToWithdraw,
    "how_to_play": howToPlay,
  };
}
