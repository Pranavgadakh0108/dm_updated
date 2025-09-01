import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

  Future<void> makePhoneCall(String number) async {
    final Uri uri = Uri.parse("tel:$number");

    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, 
      );

      if (!launched) {
        debugPrint("Could not launch dialer for $number");
      }
    } catch (e) {
      debugPrint("Error launching dialer: $e");
    }
  }


