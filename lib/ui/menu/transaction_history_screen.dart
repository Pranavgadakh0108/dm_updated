import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/transaction_history_provider.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transaction {
  final String dateTime;
  final int amount;
  final String narration;

  Transaction({
    required this.dateTime,
    required this.amount,
    required this.narration,
  });
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getTransactionHistoryProvider =
          Provider.of<GetTransactionHistoryProvider>(context, listen: false);

      getTransactionHistoryProvider.getTransactionHistoryFunc(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppNavigationBar()),
            );
          },
        ),
      ),
      body: Consumer<GetTransactionHistoryProvider>(
        builder: (context, provider, _) {
          return Padding(
            // padding: const EdgeInsets.all(10.0),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: ListView.builder(
              // padding: const EdgeInsets.all(6),
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.015,
              ),
              itemCount: provider.transactionHistoryModel?.transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.03,
                    ), // responsive padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(
                                provider
                                        .transactionHistoryModel
                                        ?.transactions[index]
                                        .createdAt ??
                                    DateTime.now(),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.008,
                            ),
                            Text(
                              provider
                                      .transactionHistoryModel
                                      ?.transactions[index]
                                      .time ??
                                  "",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Amount + Narration
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  provider
                                          .transactionHistoryModel
                                          ?.transactions[index]
                                          .amount
                                          .toString() ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Narration",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    provider
                                            .transactionHistoryModel
                                            ?.transactions[index]
                                            .narration ??
                                        "",
                                    // textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
