import 'package:dmboss/service/notification_polling_service.dart';
import 'package:dmboss/ui/splash_screen.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Update app state in notification service
    switch (state) {
      case AppLifecycleState.resumed:
        NotificationPollingService.setAppState(true);
        NotificationPollingService.startPolling();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        NotificationPollingService.setAppState(false);
        NotificationPollingService.stopPolling();
        break;
      case AppLifecycleState.hidden:
        // Handle if needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: ThemeData(fontFamily: 'Poppins'),
      home: SplashScreen(),
      routes: {'/home': (context) => SplashScreen()},
    );
  }
}
