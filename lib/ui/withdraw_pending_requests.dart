import 'package:dmboss/provider/withdraw_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WithdrawPendingRequests extends StatefulWidget {
  const WithdrawPendingRequests({super.key});

  @override
  State<WithdrawPendingRequests> createState() =>
      _WithdrawPendingRequestsState();
}

class _WithdrawPendingRequestsState extends State<WithdrawPendingRequests> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetWithdrawHistoryProvider>(
        context,
        listen: false,
      );
      provider.withdrawHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Withdraw Requests",
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
        child: Consumer<GetWithdrawHistoryProvider>(
          builder: (context, provider, _) {
            return ListView.builder(
              // padding: const EdgeInsets.all(6),
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.015,
              ),
              itemCount: provider.withdrawHistoryModel?.data.length,
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
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                            provider
                                    .withdrawHistoryModel
                                    ?.data[index]
                                    .createdAt ??
                                DateTime.now(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                          .withdrawHistoryModel
                                          ?.data[index]
                                          .amount
                                          .toString() ??
                                      "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
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
                                    "Withdraw Request",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    provider
                                            .withdrawHistoryModel
                                            ?.data[index]
                                            .mode
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Status",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Status: ${provider.withdrawHistoryModel?.data[index].status == 0
                                        ? "Pending"
                                        : provider.withdrawHistoryModel?.data[index].status == 1
                                        ? "Approved"
                                        : "Reject"}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.orange,
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
