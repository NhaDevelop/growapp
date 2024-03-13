import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String setFormattedDate(String format) {
    return DateFormat(format).format(this);
  }

  bool isInList(List<DateTime> dateList) {
    return dateList.any((element) {
      return element.year == year &&
          element.month == month &&
          element.day == day;
    });
  }
}
