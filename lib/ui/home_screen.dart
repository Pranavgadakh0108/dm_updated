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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
  bool _initialLoadComplete = false;

  @override
  void initState() {
    super.initState();
    _loadPersistedData();
    // Delay initial loading to allow UI to render first
    Future.delayed(Duration.zero, () {
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
    if (_isLoading && _initialLoadComplete) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load all APIs in parallel
      await Future.wait([
        // Critical data for initial UI
        Provider.of<UserProfileProvider>(
          context,
          listen: false,
        ).fetchUserProfile(),
        Provider.of<GameMarketProvider>(
          context,
          listen: false,
        ).getGames(context),

        // Secondary data (can load in background)
        _loadPendingCount(),
        _loadGameSettings(),
        _loadImageSliders(),
        _loadNotifications(),
      ], eagerError: false); // Don't stop on first error

      _initialLoadComplete = true;
      _startAutoScroll();
    } catch (error) {
      setState(() {
        _errorMessage =
            'Failed to load some data. Some features may be limited.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadPendingCount() async {
    final getPendingCount = Provider.of<GetPendingWithdrawCountProvider>(
      context,
      listen: false,
    );
    await getPendingCount.getWithdrawPendingCount(context);
  }

  Future<void> _loadGameSettings() async {
    final getGameSettings = Provider.of<GamesSettingsProvider>(
      context,
      listen: false,
    );
    await getGameSettings.getGameSettings(context);
  }

  Future<void> _loadImageSliders() async {
    final getImageSliders = Provider.of<GetImageSlidersProvider>(
      context,
      listen: false,
    );
    await getImageSliders.getImageSLiders(context);
  }

  Future<void> _loadNotifications() async {
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
    _timer?.cancel(); // Cancel existing timer if any
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = _currentPage + 1;
        final itemCount =
            Provider.of<GetImageSlidersProvider>(
              context,
              listen: false,
            ).getImageSliders?.items.length ??
            1;

        if (itemCount <= 1) {
          return; // Don't scroll if only one item
        }

        if (nextPage < itemCount) {
          _currentPage = nextPage;
        } else {
          _currentPage = 0;
        }

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

  // Shimmer widget for image loading
  Widget _buildImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Shimmer widget for game card loading
  Widget _buildGameCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 120, height: 20, color: Colors.white),
            const SizedBox(height: 12),
            Container(width: double.infinity, height: 16, color: Colors.white),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 80, height: 16, color: Colors.white),
                Container(width: 80, height: 16, color: Colors.white),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shimmer widget for contact info loading
  Widget _buildContactInfoShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: const Color.fromARGB(235, 238, 237, 237),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.007,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(width: 20, height: 20, color: Colors.white),
                const SizedBox(width: 5),
                Container(width: 100, height: 15, color: Colors.white),
              ],
            ),
            Row(
              children: [
                Container(width: 20, height: 20, color: Colors.white),
                const SizedBox(width: 5),
                Container(width: 100, height: 15, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      drawer: Consumer<UserProfileProvider>(
        builder: (context, provider, child) {
          if (_isLoading && provider.userProfile == null) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: AppDrawer(
                username: 'Loading...',
                phoneNumber: 'Loading...',
              ),
            );
          }
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
        title: const Row(
          children: [
            Text(
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
              if (_isLoading && provider.userProfile == null) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const Row(
                    children: [
                      Icon(Icons.wallet_outlined, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "0000",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                );
              }
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
                icon: const Icon(
                  Icons.notifications_active,
                  color: Colors.black,
                ),
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
      body: _isLoading && !_initialLoadComplete
          ? _buildLoadingState()
          : Consumer2<GameMarketProvider, GamesSettingsProvider>(
              builder: (context, provider, gameSettings, child) {
                if (provider.isLoading) {
                  return _buildLoadingState();
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
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const BlinkingTextContainer(),
                            Consumer<GetImageSlidersProvider>(
                              builder: (context, provider, _) {
                                final items = provider.getImageSliders?.items;
                                final itemCount = items?.length ?? 0;

                                if (itemCount == 0) {
                                  return const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }

                                return itemCount != 1
                                    ? SizedBox(
                                        height: 200,
                                        child: PageView.builder(
                                          controller: _pageController,
                                          itemCount: itemCount,
                                          onPageChanged: (int page) {
                                            setState(() {
                                              _currentPage = page;
                                            });
                                          },
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$baseUrl${items?[index].image}",
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  placeholder: (context, url) =>
                                                      _buildImageShimmer(),
                                                  errorWidget:
                                                      (
                                                        context,
                                                        url,
                                                        error,
                                                      ) => Container(
                                                        color: Colors.grey[200],
                                                        child: const Icon(
                                                          Icons.error,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$baseUrl${items?[0].image}",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            placeholder: (context, url) =>
                                                _buildImageShimmer(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      color: Colors.grey[200],
                                                      child: const Icon(
                                                        Icons.error,
                                                      ),
                                                    ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                            Consumer<GamesSettingsProvider>(
                              builder: (context, gameSettings, _) {
                                if (gameSettings.isLoading) {
                                  return _buildContactInfoShimmer();
                                }
                                return Container(
                                  color: const Color.fromARGB(
                                    235,
                                    238,
                                    237,
                                    237,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                        0.007,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => makePhoneCall(
                                          gameSettings
                                                      .gameSettings
                                                      ?.data
                                                      .whatsapp ==
                                                  ""
                                              ? "9888195353"
                                              : gameSettings
                                                        .gameSettings
                                                        ?.data
                                                        .whatsapp ??
                                                    "",
                                        ),
                                        child: const Row(
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
                                          gameSettings
                                                      .gameSettings
                                                      ?.data
                                                      .whatsapp ==
                                                  ""
                                              ? "9888195353"
                                              : gameSettings
                                                        .gameSettings
                                                        ?.data
                                                        .whatsapp ??
                                                    "",
                                        ),
                                        child: const Row(
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
                                );
                              },
                            ),
                          ],
                        ),
                        Consumer<GameMarketProvider>(
                          builder: (context, provider, _) {
                            if (provider.isLoading) {
                              return Column(
                                children: List.generate(
                                  3,
                                  (index) => _buildGameCardShimmer(),
                                ),
                              );
                            }

                            return provider.gamesList?.isNotEmpty ?? true
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider.gamesList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final game = provider.gamesList?[index];

                                      if (game == null) {
                                        return const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.history_toggle_off,
                                                size: 64,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                'No winning history found',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
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
                                                    game.open ?? "",
                                                    game.close ?? "",
                                                    game.days ?? "",
                                                  ) ==
                                                  "Closed For Today" ||
                                              getMarketStatus(
                                                    game.open ?? "",
                                                    game.close ?? "",
                                                    game.days ?? "",
                                                  ) ==
                                                  "Holiday" ||
                                              game.result.status.name ==
                                                  "completed" ||
                                              isGameActive(
                                                game.result.status.name ?? "",
                                                game.open ?? "",
                                                game.close ?? "",
                                              ) ||
                                              isAllResultDeclared(
                                                game.result.open ?? "",
                                                game.result.close ?? "",
                                                game.result.openPanna ?? "",
                                                game.result.closePanna ?? "",
                                              )) {
                                            showMarketCloseDialog(context);
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GameListScreen(
                                                      title: game.bazar ?? "",
                                                      openTime: game.open ?? "",
                                                      closeTime:
                                                          game.close ?? "",
                                                      marketId: game.id ?? "",
                                                      resultStatus:
                                                          game
                                                              .result
                                                              .status
                                                              .name ??
                                                          "",
                                                    ),
                                              ),
                                            );
                                          }
                                        },
                                        child: GameCard(
                                          title: game.bazar ?? "",
                                          numbers:
                                              "${game.result.openPanna.isEmpty ?? false ? '***' : game.result.openPanna}-"
                                              "${game.result.open.isEmpty ?? false ? '*' : game.result.open}"
                                              "${game.result.close.isEmpty ?? false ? '*' : game.result.close}-"
                                              "${game.result.closePanna.isEmpty ?? false ? '***' : game.result.closePanna}",
                                          statusText:
                                              game.result.status.name !=
                                                  "completed"
                                              ? getMarketStatus(
                                                  game.open ?? "",
                                                  game.close ?? "",
                                                  game.days ?? "",
                                                )
                                              : "Closed for Today",
                                          statusColor:
                                              game.result.status.name !=
                                                  "completed"
                                              ? getMarketStatusColor(
                                                  getMarketStatus(
                                                    game.open ?? "",
                                                    game.close ?? "",
                                                    game.days ?? "",
                                                  ),
                                                )
                                              : Colors.red,
                                          buttonText:
                                              game.result.status.name !=
                                                  "completed"
                                              ? getMarketStatusMessage(
                                                  getMarketStatus(
                                                    game.open ?? "",
                                                    game.close ?? "",
                                                    game.days ?? "",
                                                  ),
                                                )
                                              : "Colosed Now",
                                          buttonColor:
                                              game.result.status.name !=
                                                  "completed"
                                              ? getMarketButtonColor(
                                                  getMarketStatus(
                                                    game.open ?? "",
                                                    game.close ?? "",
                                                    game.days ?? "",
                                                  ),
                                                )
                                              : Colors.red,
                                          openTime:
                                              convertTimeStringTo12HourFormat(
                                                game.open ?? "",
                                              ),
                                          closeTime:
                                              convertTimeStringTo12HourFormat(
                                                game.close ?? "",
                                              ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Refresh'),
                                        ),
                                      ],
                                    ),
                                  );
                          },
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
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const BlinkingTextContainer(),
          // Image slider shimmer
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildImageShimmer(),
                );
              },
            ),
          ),
          // Contact info shimmer
          _buildContactInfoShimmer(),
          // Game cards shimmer
          Column(
            children: List.generate(4, (index) => _buildGameCardShimmer()),
          ),
        ],
      ),
    );
  }
}
