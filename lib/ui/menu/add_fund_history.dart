import 'package:dmboss/provider/get_fund_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFundHistoryScreen extends StatefulWidget {
  const AddFundHistoryScreen({super.key});

  @override
  State<AddFundHistoryScreen> createState() => _AddFundHistoryScreenState();
}

class _AddFundHistoryScreenState extends State<AddFundHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetFundHistoryProvider>(
        context,
        listen: false,
      );

      provider.getFundHistory(context);
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
          "Add Fund History",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<GetFundHistoryProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            itemCount: provider.gamesList?.deposits.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 3,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and Points row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.gamesList?.deposits[index].date
                                  .toIso8601String() ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Points",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              provider.gamesList?.deposits[index].amount
                                      .toString() ??
                                  "",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Payment method
                    Text(
                      provider.gamesList?.deposits[index].method ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),

                    // Status message
                    Text(
                      provider.gamesList?.deposits[index].status == 1
                          ? "Your Request Approved & Fund Added Successfully!!!"
                          : provider.gamesList?.deposits[index].status == 2
                          ? "Your Request Rejected & Failed to Add funds!!!"
                          : "Your Request is Pending, Wait for approval!!!",
                      style: TextStyle(
                        color: provider.gamesList?.deposits[index].status == 1
                            ? Colors.green
                            : provider.gamesList?.deposits[index].status == 2
                            ? Colors.red
                            : Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.3,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
