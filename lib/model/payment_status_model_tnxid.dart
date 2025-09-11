import 'dart:convert';

PaymentStatusModelTnxRedirected paymentStatusModelTnxRedirectedFromJson(
  String str,
) => PaymentStatusModelTnxRedirected.fromJson(json.decode(str));

String paymentStatusModelTnxRedirectedToJson(
  PaymentStatusModelTnxRedirected data,
) => json.encode(data.toJson());

class PaymentStatusModelTnxRedirected {
  String method;
  String txnid;

  PaymentStatusModelTnxRedirected({required this.method, required this.txnid});

  factory PaymentStatusModelTnxRedirected.fromJson(Map<String, dynamic> json) =>
      PaymentStatusModelTnxRedirected(
        method: json["method"],
        txnid: json["txnid"],
      );

  Map<String, dynamic> toJson() => {"method": method, "txnid": txnid};
}
