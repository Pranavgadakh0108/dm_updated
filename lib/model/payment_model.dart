class PaymentModel {
  String method;
  String action;
  int amount;

  PaymentModel({
    required this.method,
    required this.action,
    required this.amount,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    method: json["method"] as String? ?? "",
    action: json["action"] as String? ?? "",
    amount: json["amount"] as int? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "method": method,
    "action": action,
    "amount": amount,
  };
}
