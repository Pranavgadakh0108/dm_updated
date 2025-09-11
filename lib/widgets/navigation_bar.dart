// ignore_for_file: deprecated_member_use

import 'package:dmboss/ui/home_screen.dart';
import 'package:dmboss/ui/menu/bid_history_screen.dart';
import 'package:dmboss/ui/menu/transaction_history_screen.dart';
import 'package:dmboss/ui/my_wallet_screen.dart';
import 'package:dmboss/widgets/exit_dialog.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int selectedIndex = 2;
  final String supportPhoneNumber = "+919888195353";

  final List<Widget> screens = [
    const BidHistoryScreen(),
    const TransactionHistoryScreen(),
    const HomeScreen(),
    const MyWalletScreen(walletBalance: ''),
  ];

  void onTapSelectItem(int index) {
    if (index == 4) {
      openWhatsApp(supportPhoneNumber);
      return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex == 2) {
          showExitDialog(context);
          return false;
        } else {
          setState(() {
            selectedIndex = 2;
          });
          return false;
        }
      },
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          elevation: 2,
          onTap: onTapSelectItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restore_outlined, size: 30),
              label: "My Bids",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined, size: 30),
              label: "Passbook",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.price_change_outlined, size: 30),
              label: "Funds",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined, size: 30),
              label: "Support",
            ),
          ],
        ),
      ),
    );
  }
}
