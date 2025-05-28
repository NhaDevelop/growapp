import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';

class BranchResponse {
  List<BranchData>? data;
  String? message;
  bool? status;

  BranchResponse({this.data, this.message, this.status});

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => BranchData.fromJson(i)).toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class BranchData {
  String? addressLine1;
  String? branchFor;
  String? contactEmail;
  String? contactNumber;
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  num? latitude;
  num? longitude;
  int? managerId;
  String? name;
  List<String>? paymentMethod;
  num? ratingStar;
  String? slug;
  int? status;
  String? updatedAt;
  int? updatedBy;
  String? branchImg;
  String? description;
  int? totalReview;
  List<WorkingHourList>? workingHourList;
  List<String>? anyStylistOptions;

  ///LOCAL
  WorkingHourList? get todayTime => workingHourList.validate().isNotEmpty
      ? workingHourList!.firstWhere((element) =>
          element.day.validate().toLowerCase().getWeekDayCount ==
          DateTime.now().weekday.validate())
      : null;

  Color? get ratingColor => getRatingBarColor(ratingStar.validate().toInt());

  BranchData({
    this.addressLine1,
    this.branchFor,
    this.contactEmail,
    this.contactNumber,
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.latitude,
    this.longitude,
    this.managerId,
    this.name,
    this.paymentMethod,
    this.ratingStar,
    this.slug,
    this.status,
    this.updatedAt,
    this.updatedBy,
    this.branchImg,
    this.totalReview,
    this.description,
    this.workingHourList,
    this.anyStylistOptions,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      addressLine1: json['address_line_1'],
      branchFor: json['branch_for'],
      contactEmail: json['contact_email'],
      contactNumber: json['contact_number'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      managerId: json['manager_id'],
      name: json['name'],
      paymentMethod: json['payment_method'] != null
          ? List<String>.from(json['payment_method'])
          : null,
      ratingStar: json['rating_star'],
      slug: json['slug'],
      status: json['status'],
      updatedAt: json['updated_at'],
      totalReview: json['total_review'],
      updatedBy: json['updated_by'],
      branchImg: json['branch_image'],
      description: json['description'],
      workingHourList: json['working_days'] != null
          ? (json['working_days'] as List)
              .map((e) => WorkingHourList.fromJson(e))
              .toList()
          : null,
      anyStylistOptions: json['any_stylist_options'] != null
          ? List<String>.from(json['any_stylist_options'])
          : null,
    );
  }
}

class WorkingHourList {
  String? day;
  String? endTime;
  int? isHoliday;
  String? startTime;
  List<BranchBreaks>? branchBreaks;

  WorkingHourList(
      {this.day,
      this.endTime,
      this.isHoliday,
      this.startTime,
      this.branchBreaks});

  factory WorkingHourList.fromJson(Map<String, dynamic> json) {
    return WorkingHourList(
      day: json['day'],
      endTime: json['end_time'],
      isHoliday: json['is_holiday'],
      startTime: json['start_time'],
      branchBreaks: json['breaks'] != null
          ? (json['breaks'] as List)
              .map((i) => BranchBreaks.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['end_time'] = endTime;
    data['is_holiday'] = isHoliday;
    data['start_time'] = startTime;
    if (branchBreaks != null) {
      data['breaks'] =
          data['breaks'] = branchBreaks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchBreaks {
  String? startBreak;
  String? endBreak;

  BranchBreaks({this.startBreak, this.endBreak});

  factory BranchBreaks.fromJson(Map<String, dynamic> json) {
    return BranchBreaks(
      startBreak: json['start_break'],
      endBreak: json['end_break'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_break'] = startBreak;
    data['end_break'] = endBreak;
    return data;
  }
}
