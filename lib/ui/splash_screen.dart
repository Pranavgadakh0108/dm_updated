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

    Timer(const Duration(seconds: 1), () {
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
          'assets/images/dmboss.jpg',
          height: 300,
          width: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
