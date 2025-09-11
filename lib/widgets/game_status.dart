import 'package:flutter/material.dart';

String getGameStatus(String openTime) {
  try {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    final openParts = openTime.split(':');
    if (openParts.length != 2) return "OPEN";

    final openHour = int.parse(openParts[0]);
    final openMinute = int.parse(openParts[1]);
    final openTimeOfDay = TimeOfDay(hour: openHour, minute: openMinute);

    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final openMinutes = openTimeOfDay.hour * 60 + openTimeOfDay.minute;

    if (currentMinutes > openMinutes) {
      return "CLOSE";
    } else {
      return "OPEN";
    }
  } catch (e) {
    return "OPEN";
  }
}
