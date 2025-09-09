// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/provider/game_market_provider.dart';
// import 'package:dmboss/provider/games_settings_provider.dart';
// import 'package:dmboss/provider/get_image_sliders.dart';
// import 'package:dmboss/provider/notification_admin_provider.dart';
// import 'package:dmboss/provider/pending_withdraw_count.dart';
// import 'package:dmboss/provider/user_profile_provider.dart';
// import 'package:dmboss/ui/game/game_list_screen.dart';
// import 'package:dmboss/ui/my_wallet_screen.dart';
// import 'package:dmboss/ui/notifications_screen.dart';
// import 'package:dmboss/util/get_market_status.dart';
// import 'package:dmboss/util/get_time_in_12_hours.dart';
// import 'package:dmboss/util/is_result_declared.dart';
// import 'package:dmboss/widgets/blinking_container.dart';
// import 'package:dmboss/util/make_call.dart';
// import 'package:dmboss/widgets/game_card.dart';
// import 'package:dmboss/util/make_whatsapp_chat.dart';
// import 'package:dmboss/widgets/market_close_popup.dart';
// import 'package:dmboss/widgets/menu.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   bool _isLoading = true;
//   String? _errorMessage;
//   int _currentPage = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadTransactionHistory();
//     });
//   }

//   Future<void> _loadTransactionHistory() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final userProfileProvider = Provider.of<UserProfileProvider>(
//         context,
//         listen: false,
//       );
//       await userProfileProvider.fetchUserProfile();

//       final gamesMarketProvider = Provider.of<GameMarketProvider>(
//         context,
//         listen: false,
//       );
//       await gamesMarketProvider.getGames(context);

//       final getPendingCount = Provider.of<GetPendingWithdrawCountProvider>(
//         context,
//         listen: false,
//       );
//       await getPendingCount.getWithdrawPendingCount(context);

//       final getGameSettings = Provider.of<GamesSettingsProvider>(
//         context,
//         listen: false,
//       );
//       await getGameSettings.getGameSettings(context);

//       final getImageSliders = Provider.of<GetImageSlidersProvider>(
//         context,
//         listen: false,
//       );
//       await getImageSliders.getImageSLiders(context);

//       final getNotificationsCount = Provider.of<GetNotificationsAdminProvider>(
//         context,
//         listen: false,
//       );
//       await getNotificationsCount.getNotificationsFromAdmin(context);

//       _startAutoScroll();
//     } catch (error) {
//       setState(() {
//         _errorMessage = 'Failed to load Games. Please try again.';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _retryLoading() {
//     _loadTransactionHistory();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (_currentPage < 6) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(236, 255, 255, 255),
//       drawer: Consumer<UserProfileProvider>(
//         builder: (context, provider, child) {
//           return AppDrawer(
//             username: provider.userProfile?.user.name != null
//                 ? provider.userProfile?.user.name ?? ""
//                 : 'Guest',
//             phoneNumber: provider.userProfile?.user.mobile != null
//                 ? provider.userProfile?.user.mobile ?? ""
//                 : 'Not available',
//           );
//         },
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(Icons.menu, color: Colors.black, size: 30),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         title: Row(
//           children: [
//             const Text(
//               "DM Boss",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Consumer<UserProfileProvider>(
//             builder: (context, provider, child) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MyWalletScreen(
//                         walletBalance:
//                             provider.userProfile?.user.wallet.toString() ?? "",
//                       ),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     const Icon(Icons.wallet_outlined, color: Colors.black),
//                     const SizedBox(width: 4),
//                     Text(
//                       provider.userProfile?.user.wallet.toString() ?? "",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Stack(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NotificationsScreen(),
//                     ),
//                   );
//                 },
//                 icon: Icon(Icons.notifications_active, color: Colors.black),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Consumer<GetNotificationsAdminProvider>(
//                   builder: (context, notificationsProvider, _) {
//                     return Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 20,
//                         minHeight: 20,
//                       ),
//                       child: Text(
//                         notificationsProvider.notificationModel?.count == 0
//                             ? "0"
//                             : notificationsProvider.notificationModel?.count
//                                       .toString() ??
//                                   "",

//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Consumer2<GameMarketProvider, GamesSettingsProvider>(
//         builder: (context, provider, gameSettings, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.errorMessage != null) {
//             return Center(
//               child: Text(
//                 'Error: ${provider.errorMessage}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }

//           return RefreshIndicator(
//             onRefresh: _loadTransactionHistory,
//             color: Colors.orange,
//             backgroundColor: Colors.white,
//             strokeWidth: 2.0,
//             child: SingleChildScrollView(
//               physics:
//                   const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
//               child: Column(
//                 children: [
//                   Column(
//                     children: [
//                       BlinkingTextContainer(),
//                       Consumer<GetImageSlidersProvider>(
//                         builder: (context, provider, _) {
//                           return provider.getImageSliders?.items.length != 1
//                               ? SizedBox(
//                                   height: 200,
//                                   child: PageView.builder(
//                                     controller: _pageController,
//                                     itemCount:
//                                         provider.getImageSliders?.items.length,
//                                     onPageChanged: (int page) {
//                                       setState(() {
//                                         _currentPage = page;
//                                       });
//                                     },
//                                     itemBuilder: (_, index) {
//                                       return Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(
//                                             12,
//                                           ),
//                                           child: Image.network(
//                                             "$baseUrl${provider.getImageSliders?.items[index].image}",
//                                             fit: BoxFit.cover,
//                                             width: double.infinity,
//                                             loadingBuilder: (context, child, loadingProgress) {
//                                               if (loadingProgress == null) {
//                                                 return child;
//                                               }
//                                               return Container(
//                                                 color: Colors.grey[200],
//                                                 child: Center(
//                                                   child: CircularProgressIndicator(
//                                                     value:
//                                                         loadingProgress
//                                                                 .expectedTotalBytes !=
//                                                             null
//                                                         ? loadingProgress
//                                                                   .cumulativeBytesLoaded /
//                                                               loadingProgress
//                                                                   .expectedTotalBytes!
//                                                         : null,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                                   return Container(
//                                                     color: Colors.grey[200],
//                                                     child: const Icon(
//                                                       Icons.error,
//                                                     ),
//                                                   );
//                                                 },
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 )
//                               : Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.network(
//                                       "$baseUrl${provider.getImageSliders?.items[0].image}",
//                                       fit: BoxFit.cover,
//                                       width: double.infinity,
//                                       loadingBuilder: (context, child, loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           return child;
//                                         }
//                                         return Container(
//                                           color: Colors.grey[200],
//                                           child: Center(
//                                             child: CircularProgressIndicator(
//                                               value:
//                                                   loadingProgress
//                                                           .expectedTotalBytes !=
//                                                       null
//                                                   ? loadingProgress
//                                                             .cumulativeBytesLoaded /
//                                                         loadingProgress
//                                                             .expectedTotalBytes!
//                                                   : null,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                             return Container(
//                                               color: Colors.grey[200],
//                                               child: const Icon(Icons.error),
//                                             );
//                                           },
//                                     ),
//                                   ),
//                                 );
//                         },
//                       ),
//                       Container(
//                         color: const Color.fromARGB(235, 238, 237, 237),
//                         padding: EdgeInsets.symmetric(
//                           vertical: MediaQuery.of(context).size.height * 0.007,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             GestureDetector(
//                               onTap: () => makePhoneCall(
//                                 gameSettings.gameSettings?.data.whatsapp ??
//                                     "9888195353",
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.phone,
//                                     size: 20,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "9888195353",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => openWhatsApp(
//                                 gameSettings.gameSettings?.data.whatsapp == ""
//                                     ? "9888195353"
//                                     : gameSettings
//                                               .gameSettings
//                                               ?.data
//                                               .whatsapp ??
//                                           "",
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     FontAwesomeIcons.whatsapp,
//                                     size: 20,
//                                     color: Colors.green,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "9888195353",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   provider.gamesList?.isNotEmpty ?? true
//                       ? ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: provider.gamesList?.length ?? 0,
//                           itemBuilder: (context, index) {
//                             final game = provider.gamesList?[index];

//                             if (game == null) {
//                               Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.history_toggle_off,
//                                       size: 64,
//                                       color: Colors.grey,
//                                     ),
//                                     const SizedBox(height: 16),
//                                     const Text(
//                                       'No winning history found',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     const Text(
//                                       'Your winning transactions will appear here',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }

//                             return GestureDetector(
//                               onTap: () {
//                                 if (getMarketStatus(
//                                           game?.open ?? "",
//                                           game?.close ?? "",
//                                           game?.days.name ?? "",
//                                         ) ==
//                                         "Closed For Today" ||
//                                     getMarketStatus(
//                                           game?.open ?? "",
//                                           game?.close ?? "",
//                                           game?.days.name ?? "",
//                                         ) ==
//                                         "Holiday" ||
//                                     game?.result.status.name == "completed" ||
//                                     isGameActive(
//                                       game?.result.status.name ?? "",
//                                       game?.open ?? "",
//                                       game?.close ?? "",
//                                     )) {
//                                   print(
//                                     isGameActive(
//                                       game?.result.status.name ?? "",
//                                       game?.open ?? "",
//                                       game?.close ?? "",
//                                     ),
//                                   );
//                                   showMarketCloseDialog(context);
//                                 } else {
//                                   print(
//                                     isGameActive(
//                                       game?.open ?? "",
//                                       game?.close ?? "",
//                                       game?.result.status.name ?? "",
//                                     ),
//                                   );
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => GameListScreen(
//                                         title: game?.bazar ?? "",
//                                         openTime: game?.open ?? "",
//                                         closeTime: game?.close ?? "",
//                                         marketId: game?.id ?? "",
//                                         resultStatus:
//                                             game?.result.status.name ?? "",
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                               child: GameCard(
//                                 title: game?.bazar ?? "",
//                                 numbers:
//                                     "${game?.result.openPanna?.isEmpty ?? false ? '***' : game?.result.openPanna}-"
//                                     "${game?.result.open?.isEmpty ?? false ? '*' : game?.result.open}"
//                                     "${game?.result.close?.isEmpty ?? false ? '*' : game?.result.close}-"
//                                     "${game?.result.closePanna?.isEmpty ?? false ? '***' : game?.result.closePanna}",
//                                 statusText:
//                                     game?.result.status.name != "completed"
//                                     ? getMarketStatus(
//                                         game?.open ?? "",
//                                         game?.close ?? "",
//                                         game?.days.name ?? "",
//                                       )
//                                     : "Closed for Today",
//                                 statusColor:
//                                     game?.result.status.name != "completed"
//                                     ? getMarketStatusColor(
//                                         getMarketStatus(
//                                           game?.open ?? "",
//                                           game?.close ?? "",
//                                           game?.days.name ?? "",
//                                         ),
//                                       )
//                                     : Colors.red,
//                                 buttonText:
//                                     game?.result.status.name != "completed"
//                                     ? getMarketStatusMessage(
//                                         getMarketStatus(
//                                           game?.open ?? "",
//                                           game?.close ?? "",
//                                           game?.days.name ?? "",
//                                         ),
//                                       )
//                                     : "Colosed Now",
//                                 buttonColor:
//                                     game?.result.status.name != "completed"
//                                     ? getMarketButtonColor(
//                                         getMarketStatus(
//                                           game?.open ?? "",
//                                           game?.close ?? "",
//                                           game?.days.name ?? "",
//                                         ),
//                                       )
//                                     : Colors.red,
//                                 openTime: convertTimeStringTo12HourFormat(
//                                   game?.open ?? "",
//                                 ),
//                                 closeTime: convertTimeStringTo12HourFormat(
//                                   game?.close ?? "",
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       : Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.gamepad,
//                                 size: 64,
//                                 color: Colors.grey,
//                               ),
//                               const SizedBox(height: 16),
//                               const Text(
//                                 'No Games found',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               const Text(
//                                 'Your Games will appear here',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 20),
//                               ElevatedButton(
//                                 onPressed: _retryLoading,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orange,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text('Refresh'),
//                               ),
//                             ],
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Loading Games...',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/provider/game_market_provider.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/get_image_sliders.dart';
import 'package:dmboss/provider/notification_admin_provider.dart';
import 'package:dmboss/provider/pending_withdraw_count.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/ui/game/game_list_screen.dart';
import 'package:dmboss/ui/my_wallet_screen.dart';
import 'package:dmboss/ui/notifications_screen.dart';
import 'package:dmboss/util/get_market_status.dart';
import 'package:dmboss/util/get_time_in_12_hours.dart';
import 'package:dmboss/util/is_result_declared.dart';
import 'package:dmboss/widgets/blinking_container.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/widgets/game_card.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/market_close_popup.dart';
import 'package:dmboss/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = true;
  String? _errorMessage;
  int _currentPage = 0;
  Timer? _timer;
  int _lastSeenNotificationCount = 0;
  int _currentNotificationCount = 0;
  bool _notificationsViewed = false;

  @override
  void initState() {
    super.initState();
    _loadPersistedData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactionHistory();
    });
  }

  Future<void> _loadPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastSeenNotificationCount =
          prefs.getInt('lastSeenNotificationCount') ?? 0;
      _notificationsViewed = prefs.getBool('notificationsViewed') ?? false;
    });
  }

  Future<void> _savePersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastSeenNotificationCount', _lastSeenNotificationCount);
    await prefs.setBool('notificationsViewed', _notificationsViewed);
  }

  Future<void> _loadTransactionHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userProfileProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      await userProfileProvider.fetchUserProfile();

      final gamesMarketProvider = Provider.of<GameMarketProvider>(
        context,
        listen: false,
      );
      await gamesMarketProvider.getGames(context);

      final getPendingCount = Provider.of<GetPendingWithdrawCountProvider>(
        context,
        listen: false,
      );
      await getPendingCount.getWithdrawPendingCount(context);

      final getGameSettings = Provider.of<GamesSettingsProvider>(
        context,
        listen: false,
      );
      await getGameSettings.getGameSettings(context);

      final getImageSliders = Provider.of<GetImageSlidersProvider>(
        context,
        listen: false,
      );
      await getImageSliders.getImageSLiders(context);

      final getNotificationsCount = Provider.of<GetNotificationsAdminProvider>(
        context,
        listen: false,
      );

      await getNotificationsCount.getNotificationsFromAdmin(context);

      // Update current notification count
      setState(() {
        _currentNotificationCount =
            getNotificationsCount.notificationModel?.count ?? 0;

        // If notifications were viewed and count hasn't increased, keep last seen count
        if (_notificationsViewed &&
            _currentNotificationCount <= _lastSeenNotificationCount) {
          _lastSeenNotificationCount = _currentNotificationCount;
        }

        // If new notifications arrived, reset the viewed flag
        if (_currentNotificationCount > _lastSeenNotificationCount) {
          _notificationsViewed = false;
        }
      });

      await _savePersistedData();
      _startAutoScroll();
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load Games. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadTransactionHistory();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 6) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  int get _unreadNotificationCount {
    if (_notificationsViewed) {
      // After viewing notifications, show 0 until new ones arrive
      return 0;
    } else {
      // Show the difference between current and last seen count
      return (_currentNotificationCount - _lastSeenNotificationCount).clamp(
        0,
        _currentNotificationCount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      drawer: Consumer<UserProfileProvider>(
        builder: (context, provider, child) {
          return AppDrawer(
            username: provider.userProfile?.user.name != null
                ? provider.userProfile?.user.name ?? ""
                : 'Guest',
            phoneNumber: provider.userProfile?.user.mobile != null
                ? provider.userProfile?.user.mobile ?? ""
                : 'Not available',
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Text(
              "DM Boss",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<UserProfileProvider>(
            builder: (context, provider, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWalletScreen(
                        walletBalance:
                            provider.userProfile?.user.wallet.toString() ?? "",
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.wallet_outlined, color: Colors.black),
                    const SizedBox(width: 4),
                    Text(
                      provider.userProfile?.user.wallet.toString() ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () async {
                  // Mark notifications as viewed before navigating
                  setState(() {
                    _notificationsViewed = true;
                    _lastSeenNotificationCount = _currentNotificationCount;
                  });
                  await _savePersistedData();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(),
                    ),
                  ).then((_) {
                    // Refresh after returning from notifications
                    _loadTransactionHistory();
                  });
                },
                icon: Icon(Icons.notifications_active, color: Colors.black),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Consumer<GetNotificationsAdminProvider>(
                  builder: (context, notificationsProvider, _) {
                    // Only show badge if there are unread notifications
                    if (_unreadNotificationCount > 0) {
                      return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          _unreadNotificationCount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer2<GameMarketProvider, GamesSettingsProvider>(
        builder: (context, provider, gameSettings, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${provider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadTransactionHistory,
            color: Colors.orange,
            backgroundColor: Colors.white,
            strokeWidth: 2.0,
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
              child: Column(
                children: [
                  Column(
                    children: [
                      BlinkingTextContainer(),
                      Consumer<GetImageSlidersProvider>(
                        builder: (context, provider, _) {
                          return provider.getImageSliders?.items.length != 1
                              ? SizedBox(
                                  height: 200,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount:
                                        provider.getImageSliders?.items.length,
                                    onPageChanged: (int page) {
                                      setState(() {
                                        _currentPage = page;
                                      });
                                    },
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.network(
                                            "$baseUrl${provider.getImageSliders?.items[index].image}",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Container(
                                                color: Colors.grey[200],
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    value:
                                                        loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey[200],
                                                    child: const Icon(
                                                      Icons.error,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      "$baseUrl${provider.getImageSliders?.items[0].image}",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Icon(Icons.error),
                                            );
                                          },
                                    ),
                                  ),
                                );
                        },
                      ),
                      Container(
                        color: const Color.fromARGB(235, 238, 237, 237),
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.007,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => makePhoneCall(
                                gameSettings.gameSettings?.data.whatsapp == ""
                                    ? "9888195353"
                                    : gameSettings
                                              .gameSettings
                                              ?.data
                                              .whatsapp ??
                                          "",
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.phone,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "9888195353",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => openWhatsApp(
                                gameSettings.gameSettings?.data.whatsapp == ""
                                    ? "9888195353"
                                    : gameSettings
                                              .gameSettings
                                              ?.data
                                              .whatsapp ??
                                          "",
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "9888195353",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  provider.gamesList?.isNotEmpty ?? true
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.gamesList?.length ?? 0,
                          itemBuilder: (context, index) {
                            final game = provider.gamesList?[index];

                            if (game == null) {
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.history_toggle_off,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'No winning history found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Your winning transactions will appear here',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                if (getMarketStatus(
                                          game?.open ?? "",
                                          game?.close ?? "",
                                          game?.days.name ?? "",
                                        ) ==
                                        "Closed For Today" ||
                                    getMarketStatus(
                                          game?.open ?? "",
                                          game?.close ?? "",
                                          game?.days.name ?? "",
                                        ) ==
                                        "Holiday" ||
                                    game?.result.status.name == "completed" ||
                                    isGameActive(
                                      game?.result.status.name ?? "",
                                      game?.open ?? "",
                                      game?.close ?? "",
                                    ) ||
                                    isAllResultDeclared(
                                      game?.result.open ?? "",
                                      game?.result.close ?? "",
                                      game?.result.openPanna ?? "",
                                      game?.result.closePanna ?? "",
                                    )) {
                                  showMarketCloseDialog(context);
                                } else {
                                  print(
                                    isGameActive(
                                      game?.open ?? "",
                                      game?.close ?? "",
                                      game?.result.status.name ?? "",
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameListScreen(
                                        title: game?.bazar ?? "",
                                        openTime: game?.open ?? "",
                                        closeTime: game?.close ?? "",
                                        marketId: game?.id ?? "",
                                        resultStatus:
                                            game?.result.status.name ?? "",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: GameCard(
                                title: game?.bazar ?? "",
                                numbers:
                                    "${game?.result.openPanna?.isEmpty ?? false ? '***' : game?.result.openPanna}-"
                                    "${game?.result.open?.isEmpty ?? false ? '*' : game?.result.open}"
                                    "${game?.result.close?.isEmpty ?? false ? '*' : game?.result.close}-"
                                    "${game?.result.closePanna?.isEmpty ?? false ? '***' : game?.result.closePanna}",
                                statusText:
                                    game?.result.status.name != "completed"
                                    ? getMarketStatus(
                                        game?.open ?? "",
                                        game?.close ?? "",
                                        game?.days.name ?? "",
                                      )
                                    : "Closed for Today",
                                statusColor:
                                    game?.result.status.name != "completed"
                                    ? getMarketStatusColor(
                                        getMarketStatus(
                                          game?.open ?? "",
                                          game?.close ?? "",
                                          game?.days.name ?? "",
                                        ),
                                      )
                                    : Colors.red,
                                buttonText:
                                    game?.result.status.name != "completed"
                                    ? getMarketStatusMessage(
                                        getMarketStatus(
                                          game?.open ?? "",
                                          game?.close ?? "",
                                          game?.days.name ?? "",
                                        ),
                                      )
                                    : "Colosed Now",
                                buttonColor:
                                    game?.result.status.name != "completed"
                                    ? getMarketButtonColor(
                                        getMarketStatus(
                                          game?.open ?? "",
                                          game?.close ?? "",
                                          game?.days.name ?? "",
                                        ),
                                      )
                                    : Colors.red,
                                openTime: convertTimeStringTo12HourFormat(
                                  game?.open ?? "",
                                ),
                                closeTime: convertTimeStringTo12HourFormat(
                                  game?.close ?? "",
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.gamepad,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'No Games found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Your Games will appear here',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _retryLoading,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Refresh'),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 16),
          Text(
            'Loading Games...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
