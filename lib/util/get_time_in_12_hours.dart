String convertTimeStringTo12HourFormat(String timeString) {
  try {
    // Split the time string into hours and minutes
    List<String> parts = timeString.split(':');

    if (parts.length < 2) {
      throw FormatException('Invalid time format: $timeString');
    }

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Validate time values
    if (hour < 0 || hour > 23) {
      throw FormatException('Invalid hour: $hour');
    }
    if (minute < 0 || minute > 59) {
      throw FormatException('Invalid minute: $minute');
    }

    // Determine AM/PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    int hour12 = hour % 12;
    if (hour12 == 0) {
      hour12 = 12; // 0 becomes 12 (12 AM or 12 PM)
    }

    // Format minute with leading zero if needed
    String minuteStr = minute.toString().padLeft(2, '0');

    return '$hour12:$minuteStr $period';
  } catch (e) {
    throw FormatException(
      'Failed to parse time string: $timeString. Error: $e',
    );
  }
}
