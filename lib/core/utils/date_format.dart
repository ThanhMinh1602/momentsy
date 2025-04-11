import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatTimeChat(DateTime time) {
    final now = DateTime.now();
    final isToday =
        time.day == now.day && time.month == now.month && time.year == now.year;
    return isToday
        ? DateFormat('HH:mm').format(time)
        : DateFormat('dd/MM').format(time);
  }
}
