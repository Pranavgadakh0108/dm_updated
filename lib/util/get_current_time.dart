String getCurrentTimeFormatted() {
  final now = DateTime.now();

  int hour = now.hour;
  String period = 'am';

  if (hour >= 12) {
    period = 'pm';
    if (hour > 12) {
      hour -= 12;
    }
  }
  if (hour == 0) {
    hour = 12;
  }

  final minute = now.minute.toString().padLeft(2, '0');

  return '$hour:$minute $period';
}
