// ignore_for_file: deprecated_member_use

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class MyWalletScreen extends StatefulWidget {
  final String walletBalance;
  const MyWalletScreen({super.key, required this.walletBalance});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  //final double walletBalance = 24897;

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
            child: Row(
              children: [
                const Icon(Icons.wallet, color: Colors.black),
                const SizedBox(width: 5),
                Text(
                  widget.walletBalance,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     const SizedBox(height: 40),
      //     // Center(
      //     //   child: Stack(
      //     //     alignment: Alignment.center,
      //     //     children: [
      //     //       Container(
      //     //         width: 120,
      //     //         height: 120,
      //     //         decoration: BoxDecoration(
      //     //           color: Colors.white,
      //     //           borderRadius: BorderRadius.circular(30),
      //     //           boxShadow: [
      //     //             BoxShadow(
      //     //               color: Colors.grey,
      //     //               spreadRadius: 1,
      //     //               blurRadius: 3,
      //     //             ),
      //     //           ],
      //     //         ),
      //     //         alignment: Alignment.center,
      //     //         child: Container(
      //     //           width: 90,
      //     //           height: 70,
      //     //           decoration: BoxDecoration(
      //     //             color: Colors.grey.shade100,
      //     //             borderRadius: BorderRadius.circular(20),
      //     //             boxShadow: [
      //     //               BoxShadow(
      //     //                 color: Colors.grey,
      //     //                 spreadRadius: 1,
      //     //                 blurRadius: 3,
      //     //               ),
      //     //             ],
      //     //           ),
      //     //           alignment: Alignment.center,
      //     //           child: Text(
      //     //             "${walletBalance.toInt()} ₹",
      //     //             style: const TextStyle(
      //     //               fontSize: 15,
      //     //               fontWeight: FontWeight.bold,
      //     //             ),
      //     //           ),
      //     //         ),
      //     //       ),
      //     //       // Positioned(
      //     //       //   top: 9,
      //     //       //   right: 6,
      //     //       //   child: Container(
      //     //       //     height: 35,
      //     //       //     width: 35,
      //     //       //     decoration: BoxDecoration(
      //     //       //       color: Colors.white,
      //     //       //       borderRadius: BorderRadius.circular(20),
      //     //       //       boxShadow: [
      //     //       //         BoxShadow(
      //     //       //           color: Colors.grey,
      //     //       //           spreadRadius: 1,
      //     //       //           blurRadius: 3,
      //     //       //         ),
      //     //       //       ],
      //     //       //     ),
      //     //       //     child: Icon(
      //     //       //       Icons.account_balance_wallet_outlined,
      //     //       //       color: Colors.black87,
      //     //       //     ),
      //     //       //   ),
      //     //       // ),
      //     //       Positioned(
      //     //         top: MediaQuery.of(context).size.height * 0.01,
      //     //         right: MediaQuery.of(context).size.width * 0.015,
      //     //         child: Container(
      //     //           height: MediaQuery.of(context).size.height * 0.04,
      //     //           width: MediaQuery.of(context).size.height * 0.04,
      //     //           decoration: BoxDecoration(
      //     //             color: Colors.white,
      //     //             borderRadius: BorderRadius.circular(
      //     //               MediaQuery.of(context).size.height * 0.04,
      //     //             ),
      //     //             boxShadow: [
      //     //               BoxShadow(
      //     //                 color: Colors.grey,
      //     //                 spreadRadius: 1,
      //     //                 blurRadius: 3,
      //     //               ),
      //     //             ],
      //     //           ),
      //     //           child: Icon(
      //     //             Icons.account_balance_wallet_outlined,
      //     //             color: Colors.black87,
      //     //             size: MediaQuery.of(context).size.height * 0.025,
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //     const SizedBox(height: 30),
      //     Expanded(
      //       child: Padding(
      //         // padding: const EdgeInsets.all(8.0),
      //         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      //         child: ListView.separated(
      //           itemCount: menuItems.length,
      //           separatorBuilder: (context, index) =>
      //               const SizedBox(height: 10),
      //           itemBuilder: (context, index) {
      //             return GestureDetector(
      //               onTap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => walletScreens[index],
      //                   ),
      //                 );
      //               },
      //               child: Container(
      //                 // margin: const EdgeInsets.symmetric(
      //                 //   horizontal: 15,
      //                 //   vertical: 3,
      //                 // ),
      //                 // padding: const EdgeInsets.symmetric(
      //                 //   horizontal: 20,
      //                 //   vertical: 15,
      //                 // ),
      //                 margin: EdgeInsets.symmetric(
      //                   horizontal: MediaQuery.of(context).size.width * 0.04,
      //                   vertical: MediaQuery.of(context).size.height * 0.003,
      //                 ),
      //                 padding: EdgeInsets.symmetric(
      //                   horizontal: MediaQuery.of(context).size.width * 0.053,
      //                   vertical: MediaQuery.of(context).size.height * 0.015,
      //                 ),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border.all(
      //                     color: Colors.orangeAccent,
      //                     width: 1.5,
      //                   ),
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(
      //                       menuItems[index],
      //                       style: const TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                     const Icon(Icons.arrow_forward_ios, size: 16),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Padding(
        // padding: const EdgeInsets.all(16.0),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // square look
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => walletScreens[index]),
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
                    Container(
                      color: Colors.orange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(menuIcons[index], size: 45, color: Colors.orange),
                      )),

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
    );
  }
}
