import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// String constants for market status
const String marketStatusRunningForToday = "Running For Today";
const String marketStatusRunningForClose = "Running For Today";
const String marketStatusClosedForToday = "Closed For Today";
const String marketStatusHoliday = "Holiday";
const String marketStatusInvalidData = "Invalid Data";

// List of all week days
const List<String> allWeekDays = [
  "MONDAY",
  "TUESDAY",
  "WEDNESDAY",
  "THURSDAY",
  "FRIDAY",
  "SATURDAY",
  "SUNDAY",
];

String getMarketStatus(String openTime, String closeTime, String days) {
  try {
    // First check if today is a market day
    if (!isMarketDayToday(days)) {
      return marketStatusHoliday;
    }

    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    // Parse open and close times
    final openParts = openTime.split(':');
    final closeParts = closeTime.split(':');

    final openHour = int.parse(openParts[0]);
    final openMinute = int.parse(openParts[1]);
    final closeHour = int.parse(closeParts[0]);
    final closeMinute = int.parse(closeParts[1]);

    final openTimeOfDay = TimeOfDay(hour: openHour, minute: openMinute);
    final closeTimeOfDay = TimeOfDay(hour: closeHour, minute: closeMinute);

    // Convert TimeOfDay to minutes for easier comparison
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final openMinutes = openTimeOfDay.hour * 60 + openTimeOfDay.minute;
    final closeMinutes = closeTimeOfDay.hour * 60 + closeTimeOfDay.minute;

    // Check market status based on your exact conditions
    if (currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
      return marketStatusRunningForToday;
    } else if (currentMinutes >= closeMinutes || currentMinutes < openMinutes) {
      return marketStatusClosedForToday;
    }

    return marketStatusInvalidData;
  } catch (e) {
    return marketStatusInvalidData;
  }
}

// Helper function to check if market is open on a specific day
bool isMarketDayToday(String days) {
  try {
    final now = DateTime.now();
    final currentDay = DateFormat('EEEE').format(now).toUpperCase();

    // Handle empty or null days - assume all days are open
    if (days.isEmpty || days.trim().isEmpty) {
      return true;
    }

    final daysUpper = days.toUpperCase().trim();

    // If the days string only contains closed days, then all other days are open
    // Check if current day is explicitly marked as closed
    final daysList = daysUpper.split(',');

    for (var dayEntry in daysList) {
      final trimmedDay = dayEntry.trim();

      // Check if this entry contains the current day and is marked as closed
      if (trimmedDay.contains(currentDay) && trimmedDay.contains("(CLOSED)")) {
        return false; // Today is a holiday
      }
    }

    // If current day is not explicitly marked as closed, it's open
    return true;
  } catch (e) {
    return true; // Assume open if there's an error
  }
}

// Helper function to get status message
String getMarketStatusMessage(String status) {
  switch (status) {
    case marketStatusRunningForToday:
    case marketStatusRunningForClose:
      return 'Play Now';
    case marketStatusClosedForToday:
      return 'Closed Now';
    case marketStatusHoliday:
      return 'Closed Now';
    case marketStatusInvalidData:
      return 'Invalid Market Data';
    default:
      return 'Unknown Status';
  }
}

// Complete market status check with day validation
String getCompleteMarketStatus(String openTime, String closeTime, String days) {
  if (!isMarketDayToday(days)) {
    return marketStatusHoliday;
  }

  return getMarketStatus(openTime, closeTime, days);
}

// Helper function to get status color
Color getMarketStatusColor(String status) {
  switch (status) {
    case marketStatusRunningForToday:
      return Colors.green;
    case marketStatusRunningForClose:
      return Colors.orange;
    case marketStatusClosedForToday:
      return Colors.red;
    case marketStatusHoliday:
      return Colors.purple;
    case marketStatusInvalidData:
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

Color getMarketButtonColor(String status) {
  switch (status) {
    case marketStatusRunningForToday:
      return Colors.orange;
    case marketStatusRunningForClose:
      return Colors.orange;
    case marketStatusClosedForToday:
      return Colors.red;
    case marketStatusHoliday:
      return Colors.purple;
    case marketStatusInvalidData:
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

// Helper function to check if market is open
bool isMarketOpen(String status) {
  return status == marketStatusRunningForToday ||
      status == marketStatusRunningForClose;
}

// Helper function to get day status (for display purposes)
String getDayStatus(String days) {
  try {
    final now = DateTime.now();
    final currentDay = DateFormat('EEEE').format(now);

    if (!isMarketDayToday(days)) {
      return "Holiday ($currentDay)";
    }

    return "Open ($currentDay)";
  } catch (e) {
    return "Unknown Day Status";
  }
}

// Helper function to get formatted days list for display
String getFormattedDays(String days) {
  try {
    if (days.isEmpty) return "Open All Days";

    final daysList = days.split(',');
    final closedDays = daysList.where((day) => day.contains("(CLOSED)")).map((
      day,
    ) {
      return day.replaceAll("(CLOSED)", "").trim();
    }).toList();

    if (closedDays.isEmpty) {
      return "Open All Days";
    } else {
      return "Closed on: ${closedDays.join(', ')}";
    }
  } catch (e) {
    return days;
  }
}
