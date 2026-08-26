import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String formatTime12Hour(String time) {
    final dateTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('h:mm a').format(dateTime);
  }
}
