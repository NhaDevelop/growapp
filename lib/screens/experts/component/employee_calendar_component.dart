import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
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
  final int branchId;
  final bool disableOtherBranchsDate;
  final Function(DateTime)? onSelect;
  final Function(List<EmployeeWorkingDayModel>)? onEmployeeScheduleLoaded;

  const EmployeeCalendarComponent(
      {super.key,
      required this.employeeId,
      required this.branchId,
      this.disableOtherBranchsDate = false,
      this.onSelect,
      this.onEmployeeScheduleLoaded});

  @override
  State<EmployeeCalendarComponent> createState() =>
      _EmployeeCalendarComponentState();
}

class _EmployeeCalendarComponentState extends State<EmployeeCalendarComponent> {
  late final initialData = employeeWorkingDayListCached?[widget.employeeId];
  Future<List<EmployeeWorkingDayModel>>? future;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onEmployeeScheduleLoaded?.call(initialData ?? []);
    });
    init();
  }

  Future<void> init() async {
    future = getEmployeeMonthSchedule(
      employeeId: widget.employeeId,
      branchId: widget.branchId,
      callback: widget.onEmployeeScheduleLoaded,
    );
  }

  String? _getBranchName(DateTime date, List<EmployeeWorkingDayModel> snap) {
    final index = widget.disableOtherBranchsDate
        ? snap.indexWhere(
            (e) => e.date.isSameDateWith(date) && e.branchId == widget.branchId,
          )
        : snap.indexWhere((e) => e.date.isSameDateWith(date));
    return index < 0 ? null : snap[index].branchName;
  }

  bool _isAvailable(DateTime date, List<EmployeeWorkingDayModel> snap) {
    if (widget.disableOtherBranchsDate) {
      return snap.any(
        (e) => e.date.isSameDateWith(date) && e.branchId == widget.branchId,
      );
    } else {
      return snap.any((e) => e.date.isSameDateWith(date));
    }
  }

  void _onSelect(DateTime date) {
    setState(() => selectedDate = focusedDay = date);

    widget.onSelect?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<List<EmployeeWorkingDayModel>>(
      future: future,
      initialData: initialData,
      loadingWidget: const TableCalendarShimmer(),
      errorBuilder: (error) {
        return NoDataWidget(
          title: error,
          retryText: locale.reload,
          imageWidget: const ErrorStateWidget(),
          onRetry: () {
            init();
            setState(() {});
          },
        );
      },
      onSuccess: (workingDays) {
        if (selectedDate == null &&
            widget.onSelect != null &&
            workingDays.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final index = workingDays.indexWhere(
                (e) => e.date.isToday || e.date.isAfter(DateTime.now()));
            if (index < 0) return;
            final firstAvailableDate = workingDays[index].date;
            _onSelect(firstAvailableDate);
          });
        }
        return TableCalendar(
          focusedDay: focusedDay,
          firstDay: firstDayOfTheMonth,
          lastDay: DateTime(DateTime.now().year, DateTime.now().month + 3, 0),
          headerVisible: true,
          daysOfWeekHeight: 25,
          calendarStyle: const CalendarStyle(isTodayHighlighted: false),
          availableGestures: AvailableGestures.none,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: secondaryTextStyle(size: 16),
          ),
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, date, _) {
            final isToday = date.isToday;
            final isPast = !isToday && date.isBefore(DateTime.now());
            final isAvailable = !isPast && _isAvailable(date, workingDays);
            final isSelected = date.isSameDateWith(selectedDate);
            final branchName = _getBranchName(date, workingDays);

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: isAvailable ? () => _onSelect(date) : null,
              child: Container(
                width: double.infinity,
                color: isSelected
                    ? context.primaryColor
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
                            : isSelected
                                ? white
                                : isAvailable
                                    ? black
                                    : grey,
                        weight: isToday ? FontWeight.bold : FontWeight.w500,
                      ),
                    ).expand(),
                    isAvailable
                        ? Text(
                            branchName.validate(),
                            style: secondaryTextStyle(
                              size: 10,
                              color: isSelected ? white : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : isPast
                            ? const SizedBox.shrink()
                            : Text(
                                branchName ??
                                    locale.off.capitalizeFirstLetter(),
                                style: secondaryTextStyle(
                                  size: 10,
                                  color: isSelected ? white : null,
                                ),
                              ),
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
