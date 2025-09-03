// ignore_for_file: use_build_context_synchronously

import 'package:dmboss/data/common.dart';
import 'package:dmboss/ui/menu/add_fund_history.dart';
import 'package:dmboss/ui/menu/add_fund_screen.dart';
import 'package:dmboss/ui/menu/charts_screen.dart';
import 'package:dmboss/ui/menu/enable_notifications.dart';
import 'package:dmboss/ui/menu/game_rate_screen.dart';
import 'package:dmboss/ui/menu/how_to_play_screen.dart';
import 'package:dmboss/ui/menu/my_profile_screen.dart';
import 'package:dmboss/ui/menu/refer_and_earn_screen.dart';
import 'package:dmboss/ui/menu/time_table_screen.dart';
import 'package:dmboss/ui/menu/winning_history_screen.dart';
import 'package:dmboss/ui/menu/withdraw_points.dart';
import 'package:dmboss/widgets/drawer_item.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final String phoneNumber;

  const AppDrawer({
    super.key,
    required this.username,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,

      child: Column(
        children: [
          SizedBox(
            //height: 180,
            height: MediaQuery.of(context).size.height * 0.15,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey.shade100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Logo Image
                  Padding(
                    //padding: const EdgeInsets.only(right: 20),
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset('assets/images/dmbossLogo.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // SizedBox(
                //   //height: 180,
                //   height: MediaQuery.of(context).size.height * 0.15,
                //   child: DrawerHeader(
                //     decoration: BoxDecoration(color: Colors.blueGrey.shade100),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         // Profile Info
                //         Expanded(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 username,
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //               const SizedBox(height: 4),
                //               Text(
                //                 phoneNumber,
                //                 style: const TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         // Logo Image
                //         Padding(
                //           //padding: const EdgeInsets.only(right: 20),
                //           padding: EdgeInsets.only(
                //             right: MediaQuery.of(context).size.width * 0.05,
                //           ),
                //           child: Container(
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //               color: Colors.black,
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(12.0),
                //               child: Image.asset(
                //                 'assets/images/dmbossLogo.png',
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Menu Items
                DrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppNavigationBar(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.person,
                  title: 'My Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          username: username,
                          phoneNumber: phoneNumber,
                        ),
                        //ProfilePage()
                      ),
                    );
                  },
                ),

                DrawerItem(
                  icon: Icons.notifications_active,
                  title: 'Notification',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnableNotifications(),
                      ),
                    );
                  },
                ),

                DrawerItem(
                  icon: Icons.bar_chart,
                  title: 'Charts',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChartsScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.attach_money,
                  title: 'Game Rate',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameRateScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.add_circle,
                  title: 'Add Fund',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFundScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.list_alt,
                  title: 'Fund History',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFundHistoryScreen(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.emoji_events,
                  title: 'Winning History',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WinningHistoryScreen(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.money_off,
                  title: 'Withdraw Points',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawPoints()),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.watch_later_outlined,
                  title: 'Time Table',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimeTableScreen(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.help_outline,
                  title: 'How To Play',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HowToPlayScreen(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.assistant_direction_rounded,
                  //title: 'Reffer And Earn',
                  title: 'Share App',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReferAndEarnPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () async {
                    clearAuthData(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
