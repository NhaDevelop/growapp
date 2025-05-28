import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String setFormattedDate(String format) {
    return DateFormat(format).format(this);
  }

  bool isSameDateWith(DateTime? date) {
    return date?.year == year && date?.month == month && date?.day == day;
  }

  bool isInList(List<DateTime> dateList) {
    return dateList.any((element) => element.isSameDateWith(this));
  }
}
