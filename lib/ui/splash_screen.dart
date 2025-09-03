import 'dart:async';
import 'package:dmboss/ui/login_screen1.dart';
import 'package:dmboss/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token');
    return token;
  }

  @override
  void initState() {
    super.initState();
    getStoredToken();

    Timer(const Duration(seconds: 3), () {
      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen1()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AppNavigationBar()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/dmboss.png',
          height: 300,
          width: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:dmboss/ui/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:app_settings/app_settings.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     _initNotifications();
//   }

//   Future<void> _initNotifications() async {
//     // Initialize notifications plugin
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // Check and request notification permission
//     final status = await _checkAndRequestNotificationPermission();

//     if (status == true) {
//       // Permission granted - schedule notifications and proceed
//       _scheduleRepeatingNotification();
//       _navigateToNextScreen();
//     } else {
//       // Permission denied - close the app
//       _closeApp();
//     }
//   }

//   Future<bool> _checkAndRequestNotificationPermission() async {
//     // For Android 13+ (API level 33), we need to request the POST_NOTIFICATIONS permission
//     if (await Permission.notification.isRestricted) {
//       // The permission is permanently denied (user checked "Don't ask again")
//       // Open app settings
//       try {
//         await AppSettings.openAppSettings(); // Correct method name
//       } catch (e) {
//         debugPrint('Error opening settings: $e');
//       }
//       return false;
//     }

//     final status = await Permission.notification.request();
//     return status.isGranted;
//   }

//   Future<void> _scheduleRepeatingNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//           'repeating_channel_id',
//           'Repeating Notifications',
//           channelDescription: 'Channel for repeating notifications',
//           importance: Importance.defaultImportance,
//           priority: Priority.defaultPriority,
//           showWhen: false,
//         );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );

//     // Show first notification immediately
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Custom Notification',
//       'This is your custom message',
//       platformChannelSpecifics,
//     );

//     // Schedule repeating notification every 1 minute
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       1,
//       'Custom Notification',
//       'This is your recurring custom message',
//       RepeatInterval.everyMinute,
//       platformChannelSpecifics,
//     );
//   }

//   void _navigateToNextScreen() {
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }

//   void _closeApp() {
//     Future.delayed(Duration.zero, () {
//       SystemNavigator.pop();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Image.asset(
//           'assets/images/dmbossBlackLogo.jpg',
//           height: 300,
//           width: 300,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }
