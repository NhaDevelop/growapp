import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/num_extensions.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeMonthScheduleResponse {
  final List<EmployeeWorkingDayModel> employeeWorkingDaysList;

  EmployeeMonthScheduleResponse({required this.employeeWorkingDaysList});

  factory EmployeeMonthScheduleResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeMonthScheduleResponse(
      employeeWorkingDaysList: List<EmployeeWorkingDayModel>.from(
          (json['data'] as List)
              .map((x) => EmployeeWorkingDayModel.fromJson(x))),
    );
  }
}

class EmployeeWorkingDayModel {
  final int branchId;
  final String branchName;
  final DateTime date;
  final int startingHour;
  final int endingHour;

  EmployeeWorkingDayModel(
      {required this.branchId,
      required this.branchName,
      required this.date,
      required this.startingHour,
      required this.endingHour});

  String get startTime => '${startingHour.formatDoubleDigit}:00';

  String get endTime => '${endingHour.formatDoubleDigit}:00';

  bool slotAvailability(DateTime date) => date.isToday
      ? isTimeBefore(TimeOfDay.now(), startTime.getTimeOfDay()) &&
          isTimeAfter(TimeOfDay.now(), endTime.getTimeOfDay())
      : true;

  factory EmployeeWorkingDayModel.fromJson(Map<String, dynamic> json) {
    return EmployeeWorkingDayModel(
      branchId: json['branch_id'],
      branchName: json['branch_name'],
      date: DateTime.parse(json['date']),
      startingHour: json['starting_hour'],
      endingHour: json['end_hour'],
    );
  }
}
