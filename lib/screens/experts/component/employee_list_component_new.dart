import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/experts/employee_repository.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/screens/experts/shimmer/table_calendar_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../experts/model/employee_detail_response.dart';

class EmployeeListComponentNew extends StatefulWidget {
  final EmployeeData expertData;
  final bool selected;

  const EmployeeListComponentNew({
    super.key,
    required this.expertData,
    required this.selected,
  });

  @override
  State<EmployeeListComponentNew> createState() =>
      _EmployeeListComponentNewState();
}

class _EmployeeListComponentNewState extends State<EmployeeListComponentNew> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(12),
        backgroundColor: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedImageWidget(
                url: widget.expertData.profileImage.validate(),
                height: 58,
                width: 58,
                circle: true,
                fit: BoxFit.cover,
                child: const DefaultUserImagePlaceholder(),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.expertData.fullName.validate(),
                    style: boldTextStyle(size: 14),
                  ),
                  if (widget.expertData.expert.validate().isNotEmpty) ...[
                    4.height,
                    Text(widget.expertData.expert.validate(),
                        style: secondaryTextStyle()),
                  ],
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Text(
                      locale.viewSchedule,
                      style: secondaryTextStyle(
                          decoration: TextDecoration.underline),
                    ).paddingOnly(top: 4, bottom: 4, right: 8),
                  ),
                ],
              ).expand(),
              SizedBox(
                width: 21,
                height: 21,
                child: Icon(
                  widget.selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
              )
            ],
          ).paddingAll(16),
          AnimatedSize(
            duration: defaultAnimationDuration,
            child: _expanded
                ? _EmployeeCalendar(employeeId: widget.expertData.id.validate())
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _EmployeeCalendar extends StatelessWidget {
  final int employeeId;
  const _EmployeeCalendar({required this.employeeId});

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
