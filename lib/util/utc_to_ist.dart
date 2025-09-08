import 'package:intl/intl.dart';

String formatToIST(String utcTimeString) {
  try {
    // Parse the UTC time string
    final utcTime = DateTime.parse(utcTimeString);
    
    // Convert to IST (UTC +5:30)
    final istTime = utcTime.add(const Duration(hours: 5, minutes: 30));
    
    // Format to 12-hour format with AM/PM
    return DateFormat('h:mm a').format(istTime);
  } catch (e) {
    return 'Invalid time';
  }
}
