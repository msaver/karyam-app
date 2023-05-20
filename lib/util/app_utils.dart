import 'package:intl/intl.dart';

class AppUtils{
  static String getValueOfDate(DateTime dateTime) {
    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (date ==
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      return "Today";
    } else if (date ==
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(const Duration(days: 1))) {
      return "Tomorrow";
    } else if (date ==
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      return DateFormat("EEE, MMM dd").format(dateTime).toString();
    }
  }
}