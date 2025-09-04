import 'dart:async';

import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/get_image_sliders.dart';
import 'package:dmboss/provider/game_market_provider.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/get_image_sliders.dart';
import 'package:dmboss/provider/get_notifications_provider.dart';
import 'package:dmboss/provider/pending_withdraw_count.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/ui/game/game_list_screen.dart';
import 'package:dmboss/ui/my_wallet_screen.dart';
import 'package:dmboss/ui/notifications_screen.dart';
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
  final PageController _pageController = PageController();
  bool _isLoading = true;
  String? _errorMessage;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactionHistory();
    });
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
      userProfileProvider.fetchUserProfile();

      final gamesMarketProvider = Provider.of<GameMarketProvider>(
        context,
        listen: false,
      );
      gamesMarketProvider.getGames(context);

      final getPendingCount = Provider.of<GetPendingWithdrawCountProvider>(
        context,
        listen: false,
      );
      getPendingCount.getWithdrawPendingCount(context);

      final getGameSettings = Provider.of<GamesSettingsProvider>(
        context,
        listen: false,
      );
      getGameSettings.getGameSettings(context);
      final getImageSliders = Provider.of<GetImageSlidersProvider>(
        context,
        listen: false,
      );
      getImageSliders.getImageSLiders(context);

      final getNotificationsCount = Provider.of<GetNotificationsProvider>(
        context,
        listen: false,
      );
      getNotificationsCount.getNotificationsProvider(context);

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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retryLoading,
            tooltip: 'Refresh',
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
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.notifications_active, color: Colors.black),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Consumer<GetNotificationsProvider>(
                  builder: (context, notificationsProvider, _) {
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
                        notificationsProvider.notificationModel?.count == 0
                            ? "0"
                            : notificationsProvider.notificationModel?.count
                                      .toString() ??
                                  "",

                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    );
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

          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    BlinkingTextContainer(),
                    Consumer<GetImageSlidersProvider>(
                      builder: (context, provider, _) {
                        return SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: provider.getImageSliders?.items.length,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "$baseUrl${provider.getImageSliders?.items[index].image}",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
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
                                    errorBuilder: (context, error, stackTrace) {
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
                        );
                      },
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
                                  FontAwesomeIcons.phone,
                                  size: 25,
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
                            onTap: () => openWhatsApp(
                              gameSettings.gameSettings?.data.whatsapp ?? "",
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  size: 32,
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
                                        game?.days ?? "",
                                      ) ==
                                      "Closed For Today" ||
                                  getMarketStatus(
                                        game?.open ?? "",
                                        game?.close ?? "",
                                        game?.days ?? "",
                                      ) ==
                                      "Holiday" ||
                                  game?.result.status == "completed") {
                                showMarketCloseDialog(context);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameListScreen(
                                      title: game?.bazar ?? "",
                                      openTime: game?.open ?? "",
                                      closeTime: game?.close ?? "",
                                      marketId: game?.id ?? "",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: GameCard(
                              title: game?.bazar ?? "",
                              numbers:
                                  "${game?.result.openPanna.isEmpty ?? false ? '***' : game?.result.openPanna}_"
                                  "${game?.result.open.isEmpty ?? false ? '*' : game?.result.open}"
                                  "${game?.result.close.isEmpty ?? false ? '*' : game?.result.close}_"
                                  "${game?.result.closePanna.isEmpty ?? false ? '***' : game?.result.closePanna}",
                              statusText: game?.result.status != "completed"
                                  ? getMarketStatus(
                                      game?.open ?? "",
                                      game?.close ?? "",
                                      game?.days ?? "",
                                    )
                                  : "Closed for Today",
                              statusColor: game?.result.status != "completed"
                                  ? getMarketStatusColor(
                                      getMarketStatus(
                                        game?.open ?? "",
                                        game?.close ?? "",
                                        game?.days ?? "",
                                      ),
                                    )
                                  : Colors.red,
                              buttonText: game?.result.status != "completed"
                                  ? getMarketStatusMessage(
                                      getMarketStatus(
                                        game?.open ?? "",
                                        game?.close ?? "",
                                        game?.days ?? "",
                                      ),
                                    )
                                  : "Colosed Now",
                              buttonColor: game?.result.status != "completed"
                                  ? getMarketButtonColor(
                                      getMarketStatus(
                                        game?.open ?? "",
                                        game?.close ?? "",
                                        game?.days ?? "",
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
