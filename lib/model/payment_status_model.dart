class PaymentStatusModel {
  String method;
  String orderid;

  PaymentStatusModel({required this.method, required this.orderid});

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      PaymentStatusModel(
        method: (json["method"] as String?) ?? "",
        orderid: (json["orderid"] as String?) ?? "",
      );

  Map<String, dynamic> toJson() => {"method": method, "orderid": orderid};
}
