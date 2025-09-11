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

    if (_looksLikeTimeFormat(resultStatus) && !_looksLikeTimeFormat(openTime)) {
      print('WARNING: Parameters might be in wrong order!');
      print('Expected: isGameActive(status, openTime, closeTime)');
      print(
        'But received what looks like: isGameActive(time, openTime, status)',
      );

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

    if (openTime.isEmpty || closeTime.isEmpty) {
      print('Open or close time is empty');
      return false;
    }

    final now = DateTime.now();
    final currentTimeOfDay = TimeOfDay.fromDateTime(now);
    print('Current time: ${_formatTimeOfDay(currentTimeOfDay)}');

    if (resultDeclaredTime != null && resultDeclaredTime.isNotEmpty) {
      final declaredTimeOfDay = _parseTimeOfDay(resultDeclaredTime);
      final scheduledCloseTimeOfDay = _parseTimeOfDay(closeTime);

      if (_isBeforeTimeOfDay(declaredTimeOfDay, scheduledCloseTimeOfDay)) {
        print(
          'Result declared early at ${_formatTimeOfDay(declaredTimeOfDay)} '
          '(before scheduled close time ${_formatTimeOfDay(scheduledCloseTimeOfDay)})',
        );

        final isBeforeDeclaration = _isBeforeTimeOfDay(
          currentTimeOfDay,
          declaredTimeOfDay,
        );
        print('Current time before declaration time: $isBeforeDeclaration');

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
  } else if (close != "" && closePanna != "") {
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
    final status = possibleStatus.toUpperCase();
    if (status == 'OPEN_CLOSE' ||
        status == 'CLOSE_CLOSE' ||
        status == 'COMPLETED' ||
        status == 'PENDING') {
      print(
        'Auto-correcting: Using "$possibleStatus" as status, "$possibleOpenTime" as openTime, "$possibleTime" as closeTime?',
      );

      final openTimeOfDay = _parseTimeOfDay(possibleOpenTime);
      final closeTimeOfDay = _parseTimeOfDay(possibleTime);
      final currentTimeOfDay = TimeOfDay.fromDateTime(DateTime.now());

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
