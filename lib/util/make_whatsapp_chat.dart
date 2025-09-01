import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(String phoneNumber) async {
  String uri = "whatsapp://send?phone=${phoneNumber.replaceAll('+', '')}";
  final Uri whatsappUri = Uri.parse(uri);

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Could not launch WhatsApp for $phoneNumber");
  }
}
