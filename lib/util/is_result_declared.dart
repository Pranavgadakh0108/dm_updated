// import 'package:flutter/material.dart';

// bool isGameActive(String resultStatus, String openTime, String closeTime) {
//   try {
//     print(
//       'Received - Status: "$resultStatus", Open: "$openTime", Close: "$closeTime"',
//     );

//     // Check if parameters might be in wrong order (time values in status parameter)
//     if (_looksLikeTimeFormat(resultStatus) && !_looksLikeTimeFormat(openTime)) {
//       print('WARNING: Parameters might be in wrong order!');
//       print('Expected: isGameActive(status, openTime, closeTime)');
//       print(
//         'But received what looks like: isGameActive(time, openTime, status)',
//       );

//       // Try to auto-correct by assuming parameters are in wrong order
//       return _tryAutoCorrectParameters(resultStatus, openTime, closeTime);
//     }

//     final status = resultStatus.toUpperCase();

//     if (status == 'COMPLETED' || status == 'PENDING') {
//       print('Game is completed or pending');
//       return false;
//     }

//     // Check if times are not provided (empty)
//     if (openTime.isEmpty || closeTime.isEmpty) {
//       print('Open or close time is empty');
//       return false;
//     }

//     final now = DateTime.now();
//     final currentTimeOfDay = TimeOfDay.fromDateTime(now);
//     print('Current time: ${_formatTimeOfDay(currentTimeOfDay)}');

//     if (status == 'OPEN_CLOSE') {
//       final openTimeOfDay = _parseTimeOfDay(openTime);
//       final isBefore = _isBeforeTimeOfDay(currentTimeOfDay, openTimeOfDay);
//       print(
//         'OPEN_CLOSE: Current ${_formatTimeOfDay(currentTimeOfDay)} < Open ${_formatTimeOfDay(openTimeOfDay)} = $isBefore',
//       );
//       return isBefore;
//     } else if (status == 'CLOSE_CLOSE') {
//       final closeTimeOfDay = _parseTimeOfDay(closeTime);
//       final isBefore = _isBeforeTimeOfDay(currentTimeOfDay, closeTimeOfDay);
//       print(
//         'CLOSE_CLOSE: Current ${_formatTimeOfDay(currentTimeOfDay)} < Close ${_formatTimeOfDay(closeTimeOfDay)} = $isBefore',
//       );
//       return isBefore;
//     } else {
//       print('Status not recognized: $resultStatus');
//       return false;
//     }
//   } catch (e) {
//     print('Error in isGameActive: $e');
//     return false;
//   }
// }

// bool _tryAutoCorrectParameters(
//   String possibleTime,
//   String possibleOpenTime,
//   String possibleStatus,
// ) {
//   try {
//     // Check if the third parameter looks like a status
//     final status = possibleStatus.toUpperCase();
//     if (status == 'OPEN_CLOSE' ||
//         status == 'CLOSE_CLOSE' ||
//         status == 'COMPLETED' ||
//         status == 'PENDING') {
//       print(
//         'Auto-correcting: Using "$possibleStatus" as status, "$possibleOpenTime" as openTime, "$possibleTime" as closeTime?',
//       );

//       // Try to parse the times to validate
//       final openTimeOfDay = _parseTimeOfDay(possibleOpenTime);
//       final closeTimeOfDay = _parseTimeOfDay(possibleTime);
//       final currentTimeOfDay = TimeOfDay.fromDateTime(DateTime.now());

//       if (status == 'OPEN_CLOSE') {
//         return _isBeforeTimeOfDay(currentTimeOfDay, openTimeOfDay);
//       } else if (status == 'CLOSE_CLOSE') {
//         return _isBeforeTimeOfDay(currentTimeOfDay, closeTimeOfDay);
//       }
//     }
//   } catch (e) {
//     print('Auto-correction failed: $e');
//   }
//   return false;
// }

// bool _looksLikeTimeFormat(String text) {
//   return RegExp(r'^\d{1,2}:\d{2}$').hasMatch(text);
// }

// TimeOfDay _parseTimeOfDay(String timeString) {
//   final parts = timeString.split(':');
//   final hour = int.parse(parts[0]);
//   final minute = int.parse(parts[1]);

//   return TimeOfDay(hour: hour, minute: minute);
// }

// bool _isBeforeTimeOfDay(TimeOfDay current, TimeOfDay target) {
//   final currentMinutes = current.hour * 60 + current.minute;
//   final targetMinutes = target.hour * 60 + target.minute;

//   return currentMinutes < targetMinutes;
// }

// String _formatTimeOfDay(TimeOfDay time) {
//   return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
// }

import 'package:flutter/material.dart';

bool isGameActive(
  String resultStatus,
  String openTime,
  String closeTime, {
  String? resultDeclaredTime,
}) {
  try {
    print(
      'Received - Status: "$resultStatus", Open: "$openTime", Close: "$closeTime", Result Declared: "$resultDeclaredTime"',
    );

    // Check if parameters might be in wrong order (time values in status parameter)
    if (_looksLikeTimeFormat(resultStatus) && !_looksLikeTimeFormat(openTime)) {
      print('WARNING: Parameters might be in wrong order!');
      print('Expected: isGameActive(status, openTime, closeTime)');
      print(
        'But received what looks like: isGameActive(time, openTime, status)',
      );

      // Try to auto-correct by assuming parameters are in wrong order
      return _tryAutoCorrectParameters(
        resultStatus,
        openTime,
        closeTime,
        resultDeclaredTime: resultDeclaredTime,
      );
    }

    final status = resultStatus.toUpperCase();

    if (status == 'COMPLETED' || status == 'PENDING') {
      print('Game is completed or pending');
      return false;
    }

    // Check if times are not provided (empty)
    if (openTime.isEmpty || closeTime.isEmpty) {
      print('Open or close time is empty');
      return false;
    }

    final now = DateTime.now();
    final currentTimeOfDay = TimeOfDay.fromDateTime(now);
    print('Current time: ${_formatTimeOfDay(currentTimeOfDay)}');

    // NEW LOGIC: Check if result was declared early (before close time)
    if (resultDeclaredTime != null && resultDeclaredTime.isNotEmpty) {
      final declaredTimeOfDay = _parseTimeOfDay(resultDeclaredTime);
      final scheduledCloseTimeOfDay = _parseTimeOfDay(closeTime);

      // If result was declared before the scheduled close time
      if (_isBeforeTimeOfDay(declaredTimeOfDay, scheduledCloseTimeOfDay)) {
        print(
          'Result declared early at ${_formatTimeOfDay(declaredTimeOfDay)} '
          '(before scheduled close time ${_formatTimeOfDay(scheduledCloseTimeOfDay)})',
        );

        // Check if current time is before the early declaration time
        final isBeforeDeclaration = _isBeforeTimeOfDay(
          currentTimeOfDay,
          declaredTimeOfDay,
        );
        print('Current time before declaration time: $isBeforeDeclaration');

        // Game is only active if current time is BEFORE the early declaration time
        if (status == 'OPEN_CLOSE') {
          final openTimeOfDay = _parseTimeOfDay(openTime);
          final isBeforeOpen = _isBeforeTimeOfDay(
            currentTimeOfDay,
            openTimeOfDay,
          );
          return isBeforeOpen && isBeforeDeclaration;
        } else if (status == 'CLOSE_CLOSE') {
          return isBeforeDeclaration;
        }
      }
    }

    // Original logic (if no early declaration or result not declared yet)
    if (status == 'OPEN_CLOSE') {
      final openTimeOfDay = _parseTimeOfDay(openTime);
      final isBefore = _isBeforeTimeOfDay(currentTimeOfDay, openTimeOfDay);
      print(
        'OPEN_CLOSE: Current ${_formatTimeOfDay(currentTimeOfDay)} < Open ${_formatTimeOfDay(openTimeOfDay)} = $isBefore',
      );
      return isBefore;
    } else if (status == 'CLOSE_CLOSE') {
      final closeTimeOfDay = _parseTimeOfDay(closeTime);
      final isBefore = _isBeforeTimeOfDay(currentTimeOfDay, closeTimeOfDay);
      print(
        'CLOSE_CLOSE: Current ${_formatTimeOfDay(currentTimeOfDay)} < Close ${_formatTimeOfDay(closeTimeOfDay)} = $isBefore',
      );
      return isBefore;
    } else {
      print('Status not recognized: $resultStatus');
      return false;
    }
  } catch (e) {
    print('Error in isGameActive: $e');
    return false;
  }
}

bool isAllResultDeclared(
  String open,
  String close,
  String openPanna,
  String closePanna,
) {
  if (close != "" && open != "" && openPanna != "" && closePanna != "") {
    return true;
  } else {
    return false;
  }
}

bool _tryAutoCorrectParameters(
  String possibleTime,
  String possibleOpenTime,
  String possibleStatus, {
  String? resultDeclaredTime,
}) {
  try {
    // Check if the third parameter looks like a status
    final status = possibleStatus.toUpperCase();
    if (status == 'OPEN_CLOSE' ||
        status == 'CLOSE_CLOSE' ||
        status == 'COMPLETED' ||
        status == 'PENDING') {
      print(
        'Auto-correcting: Using "$possibleStatus" as status, "$possibleOpenTime" as openTime, "$possibleTime" as closeTime?',
      );

      // Try to parse the times to validate
      final openTimeOfDay = _parseTimeOfDay(possibleOpenTime);
      final closeTimeOfDay = _parseTimeOfDay(possibleTime);
      final currentTimeOfDay = TimeOfDay.fromDateTime(DateTime.now());

      // NEW: Handle early result declaration in auto-correct mode
      if (resultDeclaredTime != null && resultDeclaredTime.isNotEmpty) {
        final declaredTimeOfDay = _parseTimeOfDay(resultDeclaredTime);
        if (_isBeforeTimeOfDay(declaredTimeOfDay, closeTimeOfDay)) {
          final isBeforeDeclaration = _isBeforeTimeOfDay(
            currentTimeOfDay,
            declaredTimeOfDay,
          );

          if (status == 'OPEN_CLOSE') {
            return _isBeforeTimeOfDay(currentTimeOfDay, openTimeOfDay) &&
                isBeforeDeclaration;
          } else if (status == 'CLOSE_CLOSE') {
            return isBeforeDeclaration;
          }
        }
      }

      // Original auto-correct logic
      if (status == 'OPEN_CLOSE') {
        return _isBeforeTimeOfDay(currentTimeOfDay, openTimeOfDay);
      } else if (status == 'CLOSE_CLOSE') {
        return _isBeforeTimeOfDay(currentTimeOfDay, closeTimeOfDay);
      }
    }
  } catch (e) {
    print('Auto-correction failed: $e');
  }
  return false;
}

bool _looksLikeTimeFormat(String text) {
  return RegExp(r'^\d{1,2}:\d{2}$').hasMatch(text);
}

TimeOfDay _parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

bool _isBeforeTimeOfDay(TimeOfDay current, TimeOfDay target) {
  final currentMinutes = current.hour * 60 + current.minute;
  final targetMinutes = target.hour * 60 + target.minute;

  return currentMinutes < targetMinutes;
}

String _formatTimeOfDay(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
