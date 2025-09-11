String convertTimeStringTo12HourFormat(String timeString) {
  try {
    List<String> parts = timeString.split(':');

    if (parts.length < 2) {
      throw FormatException('Invalid time format: $timeString');
    }

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    if (hour < 0 || hour > 23) {
      throw FormatException('Invalid hour: $hour');
    }
    if (minute < 0 || minute > 59) {
      throw FormatException('Invalid minute: $minute');
    }

    String period = hour >= 12 ? 'PM' : 'AM';

    int hour12 = hour % 12;
    if (hour12 == 0) {
      hour12 = 12;
    }

    String minuteStr = minute.toString().padLeft(2, '0');

    return '$hour12:$minuteStr $period';
  } catch (e) {
    throw FormatException(
      'Failed to parse time string: $timeString. Error: $e',
    );
  }
}
