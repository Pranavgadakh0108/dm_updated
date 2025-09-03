// ignore_for_file: deprecated_member_use

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/get_pending_request_count.dart';
import 'package:dmboss/provider/pending_withdraw_count.dart';
import 'package:dmboss/widgets/game_app_bar.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWalletScreen extends StatefulWidget {
  final String walletBalance;
  const MyWalletScreen({super.key, required this.walletBalance});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getPendingCount = Provider.of<GetPendingWithdrawCountProvider>(
        context,
        listen: false,
      );
      getPendingCount.getWithdrawPendingCount(context);

      final getPendingDepositeCount =
          Provider.of<GetPendingDepositeCountProvider>(context, listen: false);
      getPendingDepositeCount.getDepositePendingCount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "My Wallet",
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
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Wallet(),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Center(
          child: GridView.builder(
            itemCount: menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              childAspectRatio: 1, // square look
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => walletScreens[index],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Icon
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              menuIcons[index],
                              size: 45,
                              color: Colors.orange,
                            ),
                          ),

                          // Badge with count
                          Positioned(
                            top: 0,
                            right: 0,
                            child:
                                Consumer2<
                                  GetPendingDepositeCountProvider,
                                  GetPendingWithdrawCountProvider
                                >(
                                  builder:
                                      (
                                        context,
                                        depositeProvider,
                                        withDrawProvider,
                                        _,
                                      ) {
                                        print(
                                          depositeProvider
                                              .pendingWithdrawCountModel
                                              ?.data
                                              .pendingCount
                                              .toString(),
                                        );
                                        return menuItems[index] ==
                                                    "Deposite Status" ||
                                                menuItems[index] ==
                                                    "Withdraw Status"
                                            ? Container(
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                      minWidth: 20,
                                                      minHeight: 20,
                                                    ),
                                                child: Text(
                                                  menuItems[index] ==
                                                          "Deposite Status"
                                                      ? depositeProvider
                                                                .pendingWithdrawCountModel
                                                                ?.data
                                                                .pendingCount
                                                                .toString() ??
                                                            ""
                                                      : menuItems[index] ==
                                                            "Withdraw Status"
                                                      ? withDrawProvider
                                                                .pendingWithdrawCountModel
                                                                ?.data
                                                                .pendingCount
                                                                .toString() ??
                                                            ""
                                                      : "",

                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink();
                                      },
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Text(
                        menuItems[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
