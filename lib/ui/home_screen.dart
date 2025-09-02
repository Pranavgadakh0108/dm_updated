// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/ui/game/game_list_screen.dart';
// import 'package:dmboss/ui/my_wallet_screen.dart';
// import 'package:dmboss/widgets/blinking_container.dart';
// import 'package:dmboss/util/make_call.dart';
// import 'package:dmboss/widgets/game_card.dart';
// import 'package:dmboss/util/make_whatsapp_chat.dart';
// import 'package:dmboss/widgets/market_close_popup.dart';
// import 'package:dmboss/widgets/menu.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(236, 255, 255, 255),
//       drawer: AppDrawer(username: 'Rudra 2', phoneNumber: '9763292525'),
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
//             ClipOval(
//               child: Image.asset(
//                 "assets/images/dmbossLogo.png",
//                 height: 35,
//                 width: 35,
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Text(
//               "DM Boss",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(onPressed: (){}, icon: Icon(Icons.access_time, color: Colors.pink,)),
//           IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active, color: Colors.pinkAccent,)),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyWalletScreen()),
//               );
//             },
//             child: Row(
//               children: [
//                 const Icon(Icons.wallet_outlined, color: Colors.black),
//                 const SizedBox(width: 4),
//                 const Text(
//                   "24897",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//               ],
//             ),
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Advertisement section
//             Column(
//               children: [
//                 BlinkingTextContainer(),
//                 Image.asset(
//                   "assets/images/advertise.jpeg",
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//                 Container(
//                   color: const Color.fromARGB(235, 238, 237, 237),
//                   //padding: const EdgeInsets.symmetric(vertical: 10),
//                   padding: EdgeInsets.symmetric(
//                     vertical: MediaQuery.of(context).size.height * 0.01,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () => makePhoneCall("+919888395353"),
//                         child: Row(
//                           children: const [
//                             Icon(
//                               FontAwesomeIcons.squarePhone,
//                               size: 35,
//                               color: Colors.lightBlue,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "9888395353",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => openWhatsApp("+919888195353"),
//                         child: Row(
//                           children: const [
//                             Icon(
//                               FontAwesomeIcons.squareWhatsapp,
//                               size: 35,
//                               color: Colors.green,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "9888195353",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Games List (Now non-scrollable)
//             Column(
//               children: games
//                   .map(
//                     (game) => GestureDetector(
//                       onTap: () {
//                         if (game["buttonText"] == "Closed Now") {
//                           showMarketCloseDialog(context);
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GameListScreen(
//                                 title: game["title"],
//                                 openTime: game["openTime"],
//                                 closeTime: game["closeTime"],
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: GameCard(
//                         title: game["title"],
//                         numbers: game["numbers"],
//                         statusText: game["statusText"],
//                         statusColor: game["statusColor"],
//                         buttonText: game["buttonText"],
//                         buttonColor: game["buttonColor"],
//                         openTime: game["openTime"],
//                         closeTime: game["closeTime"],
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:dmboss/provider/game_market_provider.dart';
// import 'package:dmboss/provider/user_profile_provider.dart';
// import 'package:dmboss/ui/game/game_list_screen.dart';
// import 'package:dmboss/ui/my_wallet_screen.dart';
// import 'package:dmboss/util/get_market_status.dart';
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
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final userProfileProvider = Provider.of<UserProfileProvider>(
//         context,
//         listen: false,
//       );
//       userProfileProvider.fetchUserProfile();

//       final gamesMarketProvider = Provider.of<GameMarketProvider>(
//         context,
//         listen: false,
//       );
//       gamesMarketProvider.getGameMarkets(context);
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
//             ClipOval(
//               child: Image.asset(
//                 "assets/images/dmbossLogo.png",
//                 height: 35,
//                 width: 35,
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Text(
//               "DM Boss",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.access_time, color: Colors.pink),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.notifications_active, color: Colors.pinkAccent),
//           ),
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
//         ],
//       ),
//       body: Consumer<GameMarketProvider>(
//         builder: (context, provider, child) {
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

//           return Column(
//             children: [
//               Column(
//                 children: [
//                   BlinkingTextContainer(),
//                   Image.asset(
//                     "assets/images/advertise.jpeg",
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                   Container(
//                     color: const Color.fromARGB(235, 238, 237, 237),
//                     padding: EdgeInsets.symmetric(
//                       vertical: MediaQuery.of(context).size.height * 0.01,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () => makePhoneCall("+919888395353"),
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 FontAwesomeIcons.squarePhone,
//                                 size: 35,
//                                 color: Colors.lightBlue,
//                               ),
//                               SizedBox(width: 5),
//                               Text(
//                                 "9888395353",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => openWhatsApp("+919888195353"),
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 FontAwesomeIcons.squareWhatsapp,
//                                 size: 35,
//                                 color: Colors.green,
//                               ),
//                               SizedBox(width: 5),
//                               Text(
//                                 "9888195353",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               // Scrollable list of games
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: provider.gamesModel?.markets.length ?? 0,
//                   itemBuilder: (context, index) {
//                     final game = provider.gamesModel?.markets[index];
//                     print(game?.market ?? "");
//                     return GestureDetector(
//                       onTap: () {
//                         if (getMarketStatus(
//                                   game?.open ?? "",
//                                   game?.close ?? "",
//                                   game?.days ?? "",
//                                 ) ==
//                                 "Closed For Today" ||
//                             getMarketStatus(
//                                   game?.open ?? "",
//                                   game?.close ?? "",
//                                   game?.days ?? "",
//                                 ) ==
//                                 "Holiday") {
//                           showMarketCloseDialog(context);
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GameListScreen(
//                                 title: game?.market ?? "",
//                                 openTime: game?.open ?? "",
//                                 closeTime: game?.close ?? "",
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: GameCard(
//                         title: game?.market ?? "",
//                         numbers: "***_**_***",
//                         statusText: getMarketStatus(
//                           game?.open ?? "",
//                           game?.close ?? "",
//                           game?.days ?? "",
//                         ),
//                         statusColor: getMarketStatusColor(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         buttonText: getMarketStatusMessage(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         buttonColor: getMarketButtonColor(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         openTime: game?.open ?? "",
//                         closeTime: game?.close ?? "",
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:dmboss/provider/game_market_provider.dart';
// import 'package:dmboss/provider/user_profile_provider.dart';
// import 'package:dmboss/ui/game/game_list_screen.dart';
// import 'package:dmboss/ui/my_wallet_screen.dart';
// import 'package:dmboss/util/get_market_status.dart';
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
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final userProfileProvider = Provider.of<UserProfileProvider>(
//         context,
//         listen: false,
//       );
//       userProfileProvider.fetchUserProfile();

//       final gamesMarketProvider = Provider.of<GameMarketProvider>(
//         context,
//         listen: false,
//       );
//       gamesMarketProvider.getGames(context); // Updated method name
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
//             ClipOval(
//               child: Image.asset(
//                 "assets/images/dmbossLogo.png",
//                 height: 35,
//                 width: 35,
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Text(
//               "DM Boss",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.access_time, color: Colors.pink),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.notifications_active, color: Colors.pinkAccent),
//           ),
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
//         ],
//       ),
//       body: Consumer<GameMarketProvider>(
//         builder: (context, provider, child) {
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

//           return Column(
//             children: [
//               Column(
//                 children: [
//                   BlinkingTextContainer(),
//                   Image.asset(
//                     "assets/images/advertise.jpeg",
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                   Container(
//                     color: const Color.fromARGB(235, 238, 237, 237),
//                     padding: EdgeInsets.symmetric(
//                       vertical: MediaQuery.of(context).size.height * 0.01,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () => makePhoneCall("+919888395353"),
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 FontAwesomeIcons.squarePhone,
//                                 size: 35,
//                                 color: Colors.lightBlue,
//                               ),
//                               SizedBox(width: 5),
//                               Text(
//                                 "9888395353",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => openWhatsApp("+919888195353"),
//                           child: Row(
//                             children: const [
//                               Icon(
//                                 FontAwesomeIcons.squareWhatsapp,
//                                 size: 35,
//                                 color: Colors.green,
//                               ),
//                               SizedBox(width: 5),
//                               Text(
//                                 "9888195353",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               // Scrollable list of games
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: provider.gamesList?.length ?? 0, // Updated to gamesList
//                   itemBuilder: (context, index) {
//                     final game = provider.gamesList?[index]; // Direct access to game object
//                     print(game?.bazar ?? "");
//                     return GestureDetector(
//                       onTap: () {
//                         if (getMarketStatus(
//                                   game?.open ?? "",
//                                   game?.close ?? "",
//                                   game?.days ?? "",
//                                 ) ==
//                                 "Closed For Today" ||
//                             getMarketStatus(
//                                   game?.open ?? "",
//                                   game?.close ?? "",
//                                   game?.days ?? "",
//                                 ) ==
//                                 "Holiday") {
//                           showMarketCloseDialog(context);
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GameListScreen(
//                                 title: game?.bazar ?? "", // Changed from market to bazar
//                                 openTime: game?.open ?? "",
//                                 closeTime: game?.close ?? "",
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: GameCard(
//                         title: game?.bazar ?? "", // Changed from market to bazar
//                         numbers: "***_**_***",
//                         statusText: getMarketStatus(
//                           game?.open ?? "",
//                           game?.close ?? "",
//                           game?.days ?? "",
//                         ),
//                         statusColor: getMarketStatusColor(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         buttonText: getMarketStatusMessage(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         buttonColor: getMarketButtonColor(
//                           getMarketStatus(
//                             game?.open ?? "",
//                             game?.close ?? "",
//                             game?.days ?? "",
//                           ),
//                         ),
//                         openTime: game?.open ?? "",
//                         closeTime: game?.close ?? "",
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:dmboss/provider/game_market_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/ui/game/game_list_screen.dart';
import 'package:dmboss/ui/my_wallet_screen.dart';
import 'package:dmboss/util/get_market_status.dart';
import 'package:dmboss/util/get_time_in_12_hours.dart';
import 'package:dmboss/widgets/blinking_container.dart';
import 'package:dmboss/util/make_call.dart';
import 'package:dmboss/widgets/game_card.dart';
import 'package:dmboss/util/make_whatsapp_chat.dart';
import 'package:dmboss/widgets/market_close_popup.dart';
import 'package:dmboss/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProfileProvider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );
      userProfileProvider.fetchUserProfile();

      final gamesMarketProvider = Provider.of<GameMarketProvider>(
        context,
        listen: false,
      );
      gamesMarketProvider.getGames(context);
    });
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
            // ClipOval(
            //   child: Image.asset(
            //     "assets/images/dmbossLogo.png",
            //     height: 35,
            //     width: 35,
            //   ),
            // ),
            // const SizedBox(width: 4),
            const Text(
              "DM Boss",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.access_time, color: Colors.pink),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_active, color: Colors.pinkAccent),
          ),
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
                        fontWeight: FontWeight.bold,
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
        ],
      ),
      body: Consumer<GameMarketProvider>(
        builder: (context, provider, child) {
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

          return Column(
            children: [
              Column(
                children: [
                  BlinkingTextContainer(),
                  Image.asset(
                    "assets/images/advertise.jpeg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    color: const Color.fromARGB(235, 238, 237, 237),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => makePhoneCall("+919888395353"),
                          child: Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.squarePhone,
                                size: 35,
                                color: Colors.lightBlue,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "9888395353",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => openWhatsApp("+919888195353"),
                          child: Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.squareWhatsapp,
                                size: 35,
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

              // Scrollable list of games
              Expanded(
                child: ListView.builder(
                  itemCount: provider.gamesList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final game = provider.gamesList?[index];
                    print(game?.bazar ?? "");
                    return GestureDetector(
                      onTap: () {
                        if (getMarketStatus(
                                  game?.open ?? "",
                                  game?.close ?? "",
                                  game?.days ?? "",
                                ) ==
                                "Closed For Today" ||
                            getMarketStatus(
                                  game?.open ?? "",
                                  game?.close ?? "",
                                  game?.days ?? "",
                                ) ==
                                "Holiday") {
                          showMarketCloseDialog(context);
                        } else {
                          // Set the selected game ID in the provider
                          final gameProvider = Provider.of<GameMarketProvider>(
                            context,
                            listen: false,
                          );
                          gameProvider.setSelectedGameId(game?.id ?? "");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameListScreen(
                                title: game?.bazar ?? "",
                                openTime: game?.open ?? "",
                                closeTime: game?.close ?? "",
                                marketId:
                                    game?.id ??
                                    "", // Pass the market ID directly
                              ),
                            ),
                          );
                        }
                      },
                      child: GameCard(
                        title: game?.bazar ?? "",
                        numbers: "***_**_***",
                        statusText: getMarketStatus(
                          game?.open ?? "",
                          game?.close ?? "",
                          game?.days ?? "",
                        ),
                        statusColor: getMarketStatusColor(
                          getMarketStatus(
                            game?.open ?? "",
                            game?.close ?? "",
                            game?.days ?? "",
                          ),
                        ),
                        buttonText: getMarketStatusMessage(
                          getMarketStatus(
                            game?.open ?? "",
                            game?.close ?? "",
                            game?.days ?? "",
                          ),
                        ),
                        buttonColor: getMarketButtonColor(
                          getMarketStatus(
                            game?.open ?? "",
                            game?.close ?? "",
                            game?.days ?? "",
                          ),
                        ),
                        openTime: convertTimeStringTo12HourFormat(
                          game?.open ?? "",
                        ),
                        closeTime: convertTimeStringTo12HourFormat(
                          game?.close ?? "",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
