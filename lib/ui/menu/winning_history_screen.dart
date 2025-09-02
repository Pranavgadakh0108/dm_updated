import 'package:dmboss/provider/winning_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WinningHistory {
  final String dateTime;
  final String amount;
  final String narration;
  final int winDigit;

  WinningHistory({
    required this.dateTime,
    required this.amount,
    required this.narration,
    required this.winDigit,
  });
}

class WinningHistoryScreen extends StatefulWidget {
  const WinningHistoryScreen({super.key});

  @override
  State<WinningHistoryScreen> createState() => _WinningHistoryScreenState();
}

class _WinningHistoryScreenState extends State<WinningHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<WinningHistoryProvider>(
        context,
        listen: false,
      );
      provider.getWinningHistory(context);
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
          "Winning History",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        // padding: const EdgeInsets.all(10.0),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Consumer<WinningHistoryProvider>(
          builder: (context, winningHistoryProvider, _) {
            return ListView.builder(
              // padding: const EdgeInsets.all(6),
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.015,
              ),
              itemCount:
                  winningHistoryProvider.winningHistoryModel?.data.length,
              itemBuilder: (context, index) {
                final tx =
                    winningHistoryProvider.winningHistoryModel?.data[index];
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
                        Text(
                          tx?.date ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
                                  "Win Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  tx?.bidPoints.toString() ?? "0",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Narration",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    tx?.narration ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Winning Digit:- ${tx?.winningNumber}",
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
            );
          },
        ),
      ),
    );
  }
}
