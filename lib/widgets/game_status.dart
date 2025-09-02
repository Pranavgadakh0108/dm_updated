import 'package:flutter/material.dart';

String getGameStatus(String openTime) {
  try {
    // Get current time
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    
    // Parse open time (assuming format like "09:00" or "21:30")
    final openParts = openTime.split(':');
    if (openParts.length != 2) return "OPEN"; // Fallback if format is invalid
    
    final openHour = int.parse(openParts[0]);
    final openMinute = int.parse(openParts[1]);
    final openTimeOfDay = TimeOfDay(hour: openHour, minute: openMinute);
    
    // Convert both times to minutes for comparison
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final openMinutes = openTimeOfDay.hour * 60 + openTimeOfDay.minute;
    
    // Check if current time is greater than open time
    if (currentMinutes > openMinutes) {
      return "CLOSE";
    } else {
      return "OPEN";
    }
  } catch (e) {
    // Return "OPEN" as fallback in case of any parsing errors
    return "OPEN";
  }
}