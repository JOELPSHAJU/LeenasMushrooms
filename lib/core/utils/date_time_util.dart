
import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDateTime(String dateString, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat(format).format(dateTime);
  }

  static String formatDate(String dateString, {String format = 'yyyy-MM-dd'}) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat(format).format(dateTime);
  }

  static String formatTime(String dateString, {String format = 'HH:mm:ss'}) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat(format).format(dateTime);
  }
}