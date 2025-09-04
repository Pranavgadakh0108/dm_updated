import 'package:dmboss/service/notification_polling_service.dart';
import 'package:dmboss/ui/splash_screen.dart';
import 'package:flutter/material.dart';

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
    NotificationPollingService.stopPolling();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground - start polling
        NotificationPollingService.startPolling();
        break;
      case AppLifecycleState.paused:
        // App is going to background
        break;
      default:
        // Handle other states (inactive, detached)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalKey<NavigatorState>(),
      theme: ThemeData(fontFamily: 'Poppins'),
      home: SplashScreen(),
      routes: {'/home': (context) => SplashScreen()},
    );
  }
}
