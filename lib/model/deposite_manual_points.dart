class DepositeManualPoints {
  String transactionId;
  int amount;

  DepositeManualPoints({required this.transactionId, required this.amount});

  factory DepositeManualPoints.fromJson(Map<String, dynamic> json) {
    // Handle amount field which might be string or int
    dynamic amountValue = json["amount"];
    int parsedAmount = 0;

    if (amountValue is int) {
      parsedAmount = amountValue;
    } else if (amountValue is String) {
      parsedAmount = int.tryParse(amountValue) ?? 0;
    } else if (amountValue is double) {
      parsedAmount = amountValue.toInt();
    }

    return DepositeManualPoints(
      transactionId: json["transaction_id"] ?? "",
      amount: parsedAmount,
    );
  }

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "amount": amount,
  };
}
