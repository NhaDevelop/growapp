import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/experts/employee_repository.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/screens/experts/shimmer/table_calendar_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeCalendarComponent extends StatelessWidget {
  final int employeeId;
  const EmployeeCalendarComponent({super.key, required this.employeeId});

  String _getBranchName(DateTime date, List<EmployeeWorkingDayModel> snap) {
    final workingDay = snap.firstWhere((e) => e.date.isSameDateWith(date));

    return workingDay.branchName.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<EmployeeMonthScheduleResponse>(
      future: getEmployeeMonthSchedule(employeeId: employeeId),
      loadingWidget: const TableCalendarShimmer(),
      onSuccess: (snap) {
        final workingDays = snap.employeeWorkingDaysList;
        final availableDates = workingDays.map((e) => e.date).toList();

        return TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: firstDayOfTheMonth,
          lastDay: lastDayOfTheMonth,
          headerVisible: false,
          calendarStyle: const CalendarStyle(isTodayHighlighted: false),
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, date, _) {
            final isAvailable = date.isInList(availableDates);
            final isPast = date.isBefore(DateTime.now());
            final isToday = date.isToday;

            return Container(
              width: double.infinity,
              color: isAvailable ? Colors.transparent : Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date.day.toString(),
                    style: secondaryTextStyle(
                      color: isToday ? Colors.red : Colors.black,
                      weight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ).expand(),
                  isAvailable
                      ? Text(
                          _getBranchName(date, workingDays),
                          style: secondaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : !isPast
                          ? Text(
                              locale.off.capitalizeFirstLetter(),
                              style: secondaryTextStyle(),
                            )
                          : const SizedBox.shrink(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
