// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// const String marketStatusRunningForToday = "Running For Today";
// const String marketStatusRunningForClose = "Running For Today";
// const String marketStatusClosedForToday = "Closed For Today";
// const String marketStatusHoliday = "Holiday";
// const String marketStatusInvalidData = "Invalid Data";

// const List<String> allWeekDays = [
//   "MONDAY",
//   "TUESDAY",
//   "WEDNESDAY",
//   "THURSDAY",
//   "FRIDAY",
//   "SATURDAY",
//   "SUNDAY",
// ];

// String getMarketStatus(String openTime, String closeTime, String days) {
//   print("---------------------------------");
//   print("days: $days");
//   try {
//     if (!isMarketDayToday(days)) {
//       return marketStatusHoliday;
//     }

//     final now = DateTime.now();
//     final currentTime = TimeOfDay.fromDateTime(now);

//     final openParts = openTime.split(':');
//     final closeParts = closeTime.split(':');

//     final openHour = int.parse(openParts[0]);
//     final openMinute = int.parse(openParts[1]);
//     final closeHour = int.parse(closeParts[0]);
//     final closeMinute = int.parse(closeParts[1]);

//     final openTimeOfDay = TimeOfDay(hour: openHour, minute: openMinute);
//     final closeTimeOfDay = TimeOfDay(hour: closeHour, minute: closeMinute);

//     final currentMinutes = currentTime.hour * 60 + currentTime.minute;
//     final openMinutes = openTimeOfDay.hour * 60 + openTimeOfDay.minute;
//     final closeMinutes = closeTimeOfDay.hour * 60 + closeTimeOfDay.minute;

//     if (currentMinutes < openMinutes) {
//       return marketStatusRunningForClose;
//     }

//     if (currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
//       return marketStatusRunningForToday;
//     } else if (currentMinutes >= closeMinutes) {
//       return marketStatusClosedForToday;
//     }

//     return marketStatusInvalidData;
//   } catch (e) {
//     return marketStatusInvalidData;
//   }
// }

// bool isMarketDayToday(String days) {
//   try {
//     final now = DateTime.now();
//     final currentDay = DateFormat('EEEE').format(now).toUpperCase();

//     if (days.isEmpty || days.trim().isEmpty) {
//       return true;
//     }

//     final daysUpper = days.toUpperCase().trim();

//     final daysList = daysUpper.split(',');

//     for (var dayEntry in daysList) {
//       final trimmedDay = dayEntry.trim();

//       if (trimmedDay.contains(currentDay) && trimmedDay.contains("(CLOSED)")) {
//         return false;
//       }
//     }
//     return true;
//   } catch (e) {
//     return true;
//   }
// }

// String getMarketStatusMessage(String status) {
//   switch (status) {
//     case marketStatusRunningForToday:
//       return 'Play Now';
//     case marketStatusRunningForClose:
//       return 'Play Now';
//     case marketStatusClosedForToday:
//       return 'Closed Now';
//     case marketStatusHoliday:
//       return 'Closed Now';
//     case marketStatusInvalidData:
//       return 'Invalid Market Data';
//     default:
//       return 'Unknown Status';
//   }
// }

// String getCompleteMarketStatus(String openTime, String closeTime, String days) {
//   if (!isMarketDayToday(days)) {
//     return marketStatusHoliday;
//   }

//   return getMarketStatus(openTime, closeTime, days);
// }

// Color getMarketStatusColor(String status) {
//   switch (status) {
//     case marketStatusRunningForToday:
//       return Colors.green;
//     case marketStatusRunningForClose:
//       return Colors.green;
//     case marketStatusClosedForToday:
//       return Colors.red;
//     case marketStatusHoliday:
//       return Colors.purple;
//     case marketStatusInvalidData:
//       return Colors.grey;
//     default:
//       return Colors.grey;
//   }
// }

// Color getMarketButtonColor(String status) {
//   switch (status) {
//     case marketStatusRunningForToday:
//       return Colors.orange;
//     case marketStatusRunningForClose:
//       return Colors.orange;
//     case marketStatusClosedForToday:
//       return Colors.red;
//     case marketStatusHoliday:
//       return Colors.purple;
//     case marketStatusInvalidData:
//       return Colors.grey;
//     default:
//       return Colors.grey;
//   }
// }

// bool isMarketOpen(String status) {
//   return status == marketStatusRunningForToday;
// }

// bool isMarketRunning(String status) {
//   return status == marketStatusRunningForToday ||
//       status == marketStatusRunningForClose;
// }

// String getDayStatus(String days) {
//   try {
//     final now = DateTime.now();
//     final currentDay = DateFormat('EEEE').format(now);

//     if (!isMarketDayToday(days)) {
//       return "Holiday ($currentDay)";
//     }

//     return "Open ($currentDay)";
//   } catch (e) {
//     return "Unknown Day Status";
//   }
// }

// String getFormattedDays(String days) {
//   try {
//     if (days.isEmpty) return "Open All Days";

//     final daysList = days.split(',');
//     final closedDays = daysList.where((day) => day.contains("(CLOSED)")).map((
//       day,
//     ) {
//       return day.replaceAll("(CLOSED)", "").trim();
//     }).toList();

//     if (closedDays.isEmpty) {
//       return "Open All Days";
//     } else {
//       return "Closed on: ${closedDays.join(', ')}";
//     }
//   } catch (e) {
//     return days;
//   }
// }

// String getTimeUntilOpen(String openTime) {
//   try {
//     final now = DateTime.now();
//     final openParts = openTime.split(':');
//     final openHour = int.parse(openParts[0]);
//     final openMinute = int.parse(openParts[1]);

//     final openToday = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       openHour,
//       openMinute,
//     );

//     if (now.isBefore(openToday)) {
//       final difference = openToday.difference(now);
//       final hours = difference.inHours;
//       final minutes = difference.inMinutes.remainder(60);

//       if (hours > 0) {
//         return 'Opens in $hours ${minutes}m';
//       } else {
//         return 'Opens in ${minutes}m';
//       }
//     }

//     return 'Open now';
//   } catch (e) {
//     return 'Opening time unknown';
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String marketStatusRunningForToday = "Running For Today";
const String marketStatusRunningForClose = "Running For Today";
const String marketStatusClosedForToday = "Closed For Today";
const String marketStatusHoliday = "Holiday";
const String marketStatusInvalidData = "Invalid Data";

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
  print("---------------------------------");
  print("days: $days");
  try {
    // If days parameter contains specific time slots for each day
    if (days.isNotEmpty && days.contains('(') && days.contains(')')) {
      return getMarketStatusFromDays(days);
    }
    
    // Original logic for when days is null/empty or just contains closed days
    if (!isMarketDayToday(days)) {
      return marketStatusHoliday;
    }

    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    final openParts = openTime.split(':');
    final closeParts = closeTime.split(':');

    final openHour = int.parse(openParts[0]);
    final openMinute = int.parse(openParts[1]);
    final closeHour = int.parse(closeParts[0]);
    final closeMinute = int.parse(closeParts[1]);

    final openTimeOfDay = TimeOfDay(hour: openHour, minute: openMinute);
    final closeTimeOfDay = TimeOfDay(hour: closeHour, minute: closeMinute);

    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final openMinutes = openTimeOfDay.hour * 60 + openTimeOfDay.minute;
    final closeMinutes = closeTimeOfDay.hour * 60 + closeTimeOfDay.minute;

    if (currentMinutes < openMinutes) {
      return marketStatusRunningForClose;
    }

    if (currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
      return marketStatusRunningForToday;
    } else if (currentMinutes >= closeMinutes) {
      return marketStatusClosedForToday;
    }

    return marketStatusInvalidData;
  } catch (e) {
    return marketStatusInvalidData;
  }
}

// New function to handle day-specific time slots
String getMarketStatusFromDays(String days) {
  try {
    final now = DateTime.now();
    final currentDay = DateFormat('EEEE').format(now).toUpperCase();
    final currentTime = TimeOfDay.fromDateTime(now);
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;

    final daysList = days.toUpperCase().trim().split(',');

    for (var dayEntry in daysList) {
      final trimmedDay = dayEntry.trim();
      
      // Check if this entry is for the current day
      if (trimmedDay.startsWith(currentDay)) {
        // Extract time slots from format like MONDAY(21:30-23:59)
        final timeMatch = RegExp(r'\((\d{1,2}:\d{2})-(\d{1,2}:\d{2})\)').firstMatch(trimmedDay);
        
        if (timeMatch != null && timeMatch.groupCount == 2) {
          final openTimeStr = timeMatch.group(1)!;
          final closeTimeStr = timeMatch.group(2)!;
          
          final openParts = openTimeStr.split(':');
          final closeParts = closeTimeStr.split(':');
          
          final openHour = int.parse(openParts[0]);
          final openMinute = int.parse(openParts[1]);
          final closeHour = int.parse(closeParts[0]);
          final closeMinute = int.parse(closeParts[1]);
          
          final openMinutes = openHour * 60 + openMinute;
          final closeMinutes = closeHour * 60 + closeMinute;
          
          if (currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
            return marketStatusRunningForToday;
          } else if (currentMinutes < openMinutes) {
            return marketStatusRunningForClose;
          } else {
            return marketStatusClosedForToday;
          }
        }
        return marketStatusRunningForToday; // If time format is invalid but day matches
      }
    }
    
    // Current day not found in the days list
    return marketStatusClosedForToday;
    
  } catch (e) {
    return marketStatusInvalidData;
  }
}

bool isMarketDayToday(String days) {
  try {
    final now = DateTime.now();
    final currentDay = DateFormat('EEEE').format(now).toUpperCase();

    if (days.isEmpty || days.trim().isEmpty) {
      return true;
    }

    final daysUpper = days.toUpperCase().trim();

    // If days contains time slots format, use the new logic
    if (daysUpper.contains('(') && daysUpper.contains(')')) {
      final daysList = daysUpper.split(',');
      for (var dayEntry in daysList) {
        final trimmedDay = dayEntry.trim();
        if (trimmedDay.startsWith(currentDay)) {
          return true;
        }
      }
      return false;
    }

    // Original logic for closed days format
    final daysList = daysUpper.split(',');

    for (var dayEntry in daysList) {
      final trimmedDay = dayEntry.trim();

      if (trimmedDay.contains(currentDay) && trimmedDay.contains("(CLOSED)")) {
        return false;
      }
    }
    return true;
  } catch (e) {
    return true;
  }
}

String getMarketStatusMessage(String status) {
  switch (status) {
    case marketStatusRunningForToday:
      return 'Play Now';
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

String getCompleteMarketStatus(String openTime, String closeTime, String days) {
  // If days parameter contains specific time slots
  if (days.isNotEmpty && days.contains('(') && days.contains(')')) {
    return getMarketStatusFromDays(days);
  }
  
  if (!isMarketDayToday(days)) {
    return marketStatusHoliday;
  }

  return getMarketStatus(openTime, closeTime, days);
}

Color getMarketStatusColor(String status) {
  switch (status) {
    case marketStatusRunningForToday:
      return Colors.green;
    case marketStatusRunningForClose:
      return Colors.green;
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

bool isMarketOpen(String status) {
  return status == marketStatusRunningForToday;
}

bool isMarketRunning(String status) {
  return status == marketStatusRunningForToday ||
      status == marketStatusRunningForClose;
}

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

String getFormattedDays(String days) {
  try {
    if (days.isEmpty) return "Open All Days";

    // Handle time slots format
    if (days.contains('(') && days.contains(')')) {
      final daysList = days.split(',');
      final openDays = daysList.map((day) {
        return day.replaceAll(RegExp(r'\([^)]*\)'), "").trim();
      }).toList();
      return "Open on: ${openDays.join(', ')}";
    }

    // Original logic for closed days format
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

String getTimeUntilOpen(String openTime) {
  try {
    final now = DateTime.now();
    final openParts = openTime.split(':');
    final openHour = int.parse(openParts[0]);
    final openMinute = int.parse(openParts[1]);

    final openToday = DateTime(
      now.year,
      now.month,
      now.day,
      openHour,
      openMinute,
    );

    if (now.isBefore(openToday)) {
      final difference = openToday.difference(now);
      final hours = difference.inHours;
      final minutes = difference.inMinutes.remainder(60);

      if (hours > 0) {
        return 'Opens in $hours ${hours == 1 ? 'hour' : 'hours'} ${minutes}m';
      } else {
        return 'Opens in ${minutes}m';
      }
    }

    return 'Open now';
  } catch (e) {
    return 'Opening time unknown';
  }
}