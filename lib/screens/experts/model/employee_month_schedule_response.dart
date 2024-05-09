import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
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
  final String startTimeRaw;
  final String endTimeRaw;

  EmployeeWorkingDayModel({
    required this.branchId,
    required this.branchName,
    required this.date,
    required this.startTimeRaw,
    required this.endTimeRaw,
  });

  String get startTime {
    final time = startTimeRaw.split(':');
    final startTime = time[0].toInt();
    final startMinute = time[1].toInt();
    return '${startTime < 10 ? '0$startTime' : startTime}:${startMinute < 10 ? '0$startMinute' : startMinute}';
  }

  String get endTime {
    final time = endTimeRaw.split(':');
    final endTime = time[0].toInt();
    final endMinute = time[1].toInt();
    return '${endTime < 10 ? '0$endTime' : endTime}:${endMinute < 10 ? '0$endMinute' : endMinute}';
  }

  bool slotAvailability(DateTime date) => date.isToday
      ? isTimeBefore(TimeOfDay.now(), startTime.getTimeOfDay()) &&
          isTimeAfter(TimeOfDay.now(), endTime.getTimeOfDay())
      : true;

  factory EmployeeWorkingDayModel.fromJson(Map<String, dynamic> json) {
    return EmployeeWorkingDayModel(
      branchId: json['branch_id'],
      branchName: json['branch_name'],
      date: DateTime.parse(json['date']),
      startTimeRaw: json['start_time'],
      endTimeRaw: json['end_time'],
    );
  }
}
