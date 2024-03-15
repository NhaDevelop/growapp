import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/experts/employee_repository.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/screens/experts/shimmer/table_calendar_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeCalendarComponent extends StatefulWidget {
  final int employeeId;
  final int? branchId;
  final Function(DateTime)? onSelect;

  const EmployeeCalendarComponent(
      {super.key, required this.employeeId, this.onSelect, this.branchId});

  @override
  State<EmployeeCalendarComponent> createState() =>
      _EmployeeCalendarComponentState();
}

class _EmployeeCalendarComponentState extends State<EmployeeCalendarComponent> {
  DateTime? _selectedDate;

  String _getBranchName(DateTime date, List<EmployeeWorkingDayModel> snap) {
    final workingDay = snap.firstWhere((e) => e.date.isSameDateWith(date));

    return workingDay.branchName.validate();
  }

  void _onSelected(DateTime date) {
    _selectedDate = date;
    widget.onSelect?.call(date);
  }

  bool _isAvailable(DateTime date, List<EmployeeWorkingDayModel> workingDays) {
    if (widget.branchId == null) {
      return workingDays.any((e) => e.date.isSameDateWith(date));
    } else {
      return workingDays.any(
          (e) => e.date.isSameDateWith(date) && e.branchId == widget.branchId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<EmployeeMonthScheduleResponse>(
      future: getEmployeeMonthSchedule(employeeId: widget.employeeId),
      loadingWidget: const TableCalendarShimmer(),
      onSuccess: (snap) {
        final workingDays = snap.employeeWorkingDaysList;
        return TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: firstDayOfTheMonth,
          lastDay: lastDayOfTheMonth,
          headerVisible: false,
          daysOfWeekHeight: 25,
          calendarStyle: const CalendarStyle(isTodayHighlighted: false),
          availableGestures: AvailableGestures.none,
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, date, _) {
            final isAvailable = _isAvailable(date, workingDays);
            final isPast = date.isBefore(DateTime.now());
            final isToday = date.isToday;
            final isSelected =
                _selectedDate != null && date.isSameDateWith(_selectedDate!);

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: isAvailable ? () => _onSelected(date) : null,
              child: Container(
                width: double.infinity,
                color: isSelected
                    ? greenColor.withOpacity(0.2)
                    : isAvailable
                        ? Colors.transparent
                        : Colors.grey.shade200,
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date.day.toString(),
                      style: secondaryTextStyle(
                        color: isToday
                            ? greenColor
                            : isAvailable
                                ? Colors.black
                                : Colors.grey,
                        weight: isToday ? FontWeight.bold : FontWeight.w500,
                      ),
                    ).expand(),
                    isAvailable
                        ? Text(
                            _getBranchName(date, workingDays),
                            style: secondaryTextStyle(size: 10),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : !isPast
                            ? Text(
                                locale.off.capitalizeFirstLetter(),
                                style: secondaryTextStyle(color: Colors.grey),
                              )
                            : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
