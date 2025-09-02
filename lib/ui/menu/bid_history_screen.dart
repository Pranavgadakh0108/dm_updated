import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/get_bet_history_provider.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bid {
  final String date;
  final String market;
  final String openStatus;
  final int bet;
  final int coin;
  final String status;

  Bid({
    required this.date,
    required this.market,
    required this.openStatus,
    required this.bet,
    required this.coin,
    required this.status,
  });
}

class BidHistoryScreen extends StatefulWidget {
  const BidHistoryScreen({super.key});

  @override
  State<BidHistoryScreen> createState() => _BidHistoryScreenState();
}

class _BidHistoryScreenState extends State<BidHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetBetHistoryProvider>(
        context,
        listen: false,
      );
      provider.getBetHistoryProvider(context);
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
          "Bid History",
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
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Consumer<GetBetHistoryProvider>(
          builder: (context, provider, _) {
            return ListView.builder(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              itemCount: provider.gamesList?.bets.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.gamesList?.bets[index].date ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  provider.gamesList?.bets[index].market ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  provider.gamesList?.bets[index].session ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  provider.gamesList?.bets[index].gameType ??
                                      "",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Bet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  provider.gamesList?.bets[index].number ?? "",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 40),
                              ],
                            ),

                            Column(
                              children: [
                                const Text(
                                  "Coin",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      provider.gamesList?.bets[index].amount
                                              .toString() ??
                                          "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.monetization_on,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.gamesList?.bets[index].status ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
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
