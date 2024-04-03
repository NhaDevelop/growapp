import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_response.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/num_extensions.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../booking/model/booking_detail_response.dart';

class BranchConfigurationResponse {
  BranchConfigurationData? data;
  bool? status;

  BranchConfigurationResponse({this.data, this.status});

  factory BranchConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return BranchConfigurationResponse(
      data: json['data'] != null
          ? BranchConfigurationData.fromJson(json['data'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BranchConfigurationData {
  List<SlotData>? slot;
  String? slotDuration;
  List<TaxPercentage>? tax;
  List<DateTime> employeeSchedule;

  BranchConfigurationData(
      {this.slot,
      this.slotDuration,
      this.tax,
      this.employeeSchedule = const []});

  factory BranchConfigurationData.fromJson(Map<String, dynamic> json) {
    return BranchConfigurationData(
      slot: json['slot'] != null
          ? (json['slot'] as List).map((i) => SlotData.fromJson(i)).toList()
          : null,
      slotDuration: json['slot_duration'],
      tax: json['tax'] != null
          ? (json['tax'] as List).map((i) => TaxPercentage.fromJson(i)).toList()
          : null,
      employeeSchedule: json['employee_schedule'] != null
          ? (json['employee_schedule'] as List)
              .map((i) => DateTime.parse(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slot != null) {
      data['slot'] = slot!.map((v) => v.toJson()).toList();
    }
    data['slot_duration'] = slotDuration;
    if (tax != null) {
      data['tax'] = tax!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlotData {
  int? branchId;
  List<BranchBreaks>? breaks;
  String? createdAt;
  int? createdBy;
  String? createdGuard;
  String? day;
  String? deletedAt;
  int? deletedBy;
  String? deletedGuard;
  String? endTime;
  int? id;
  int? isHoliday;
  String? startTime;
  String? updatedAt;
  int? updatedBy;
  String? updatedGuard;
  DateTime? previousTimeSlot;
  String? sessionText;
  bool isAvailable;

  // local
  bool slotAvailability(DateTime date) => date.isToday
      ? isTimeBefore(TimeOfDay.now(), startTime!.getTimeOfDay())
      : true;

  SlotData({
    this.branchId,
    this.breaks,
    this.createdAt,
    this.createdBy,
    this.createdGuard,
    this.day,
    this.deletedAt,
    this.deletedBy,
    this.deletedGuard,
    this.endTime,
    this.id,
    this.isHoliday,
    this.startTime,
    this.updatedAt,
    this.updatedBy,
    this.updatedGuard,
    this.isAvailable = true,
  });

  String? getStartTimeWithEmployeeStartHour(int employeeStartHour) {
    final startHour = startTime!.split(':').first.toInt();
    final startMinute = startTime!.split(':').last.toInt();

    if (startHour > employeeStartHour) return startTime;
    if (startHour == employeeStartHour && startMinute > 0) return startTime;
    return '${employeeStartHour.formatDoubleDigit}:00';
  }

  String? getEndTimeWithEmployeeEndHour(int employeeEndHour) {
    final endHour = endTime!.split(':').first.toInt();

    if (endHour < employeeEndHour) return endTime;
    return '${employeeEndHour.formatDoubleDigit}:00';
  }

  factory SlotData.fromJson(Map<String, dynamic> json) {
    return SlotData(
      branchId: json['branch_id'],
      breaks: json['breaks'] != null
          ? (json['breaks'] as List)
              .map((i) => BranchBreaks.fromJson(i))
              .toList()
          : null,
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      createdGuard: json['created_guard'],
      day: json['day'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      deletedGuard: json['deleted_guard'],
      endTime: json['end_time'],
      id: json['id'],
      isHoliday: json['is_holiday'],
      startTime: json['start_time'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      updatedGuard: json['updated_guard'],
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_id'] = branchId;
    data['created_at'] = createdAt;
    data['created_guard'] = createdGuard;
    data['day'] = day;
    data['deleted_guard'] = deletedGuard;
    data['end_time'] = endTime;
    data['id'] = id;
    data['is_holiday'] = isHoliday;
    data['start_time'] = startTime;
    data['updated_at'] = updatedAt;
    data['updated_guard'] = updatedGuard;
    data['is_available'] = isAvailable;
    if (breaks != null) {
      data['breaks'] = data['breaks'] = breaks!.map((v) => v.toJson()).toList();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy;
    }
    return data;
  }
}

class TaxData {
  String? createdAt;
  int? createdBy;
  String? createdGuard;
  String? deletedAt;
  int? deletedBy;
  String? deletedGuard;
  int? id;
  int? status;
  String? title;
  String? type;
  String? updatedAt;
  int? updatedBy;
  String? updatedGuard;
  int? value;

  TaxData(
      {this.createdAt,
      this.createdBy,
      this.createdGuard,
      this.deletedAt,
      this.deletedBy,
      this.deletedGuard,
      this.id,
      this.status,
      this.title,
      this.type,
      this.updatedAt,
      this.updatedBy,
      this.updatedGuard,
      this.value});

  factory TaxData.fromJson(Map<String, dynamic> json) {
    return TaxData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      createdGuard: json['created_guard'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      deletedGuard: json['deleted_guard'],
      id: json['id'],
      status: json['status'],
      title: json['title'],
      type: json['type'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      updatedGuard: json['updated_guard'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['created_guard'] = createdGuard;
    data['deleted_guard'] = deletedGuard;
    data['id'] = id;
    data['status'] = status;
    data['title'] = title;
    data['type'] = type;
    data['updated_at'] = updatedAt;
    data['updated_guard'] = updatedGuard;
    data['value'] = value;
    if (createdBy != null) {
      data['created_by'] = createdBy;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy;
    }
    return data;
  }
}
