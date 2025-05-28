import 'package:flutter/material.dart';

import '../../../models/review_data.dart';
import '../../../utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeDetailResponse {
  EmployeeData? data;
  String? message;
  bool? status;

  EmployeeDetailResponse({this.data, this.message, this.status});

  factory EmployeeDetailResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailResponse(
      data: json['data'] != null ? EmployeeData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EmployeeData {
  String? profileImage;
  String? createdAt;
  String? dateOfBirth;
  String? deletedAt;
  String? email;
  String? emailVerifiedAt;
  String? firstName;
  String? fullName;
  String? gender;
  int? id;
  int? isBanned;
  int? isManager;
  String? lastName;
  String? mobile;
  String? playerId;
  int? showInCalender;
  int? status;
  String? updatedAt;
  String? expert;
  List<ReviewData>? reviewData;
  int? totalReview;

  int? branchesCount;
  int? serviceEmployeesCount;
  num? ratingStar;
  String? aboutSelf;
  String? joiningDate;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? dribbbleLink;

  Color? get ratingColor => getRatingBarColor(ratingStar.validate().toInt());

  ///For Booking Detail Response ( To show product info in booking detail )
  String? userName;
  String? loginType;
  String? webPlayerId;
  String? avatar;
  String? lastNotificationSeen;
  String? userSetting;
  int? isSubscribe;
  String? description;

  EmployeeData({
    this.profileImage,
    this.createdAt,
    this.dateOfBirth,
    this.deletedAt,
    this.email,
    this.emailVerifiedAt,
    this.firstName,
    this.fullName,
    this.gender,
    this.id,
    this.isBanned,
    this.isManager,
    this.lastName,
    this.mobile,
    this.playerId,
    this.showInCalender,
    this.status,
    this.updatedAt,
    this.expert,
    this.reviewData,
    this.totalReview,
    this.branchesCount,
    this.serviceEmployeesCount,
    this.ratingStar,
    this.aboutSelf,
    this.joiningDate,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.dribbbleLink,
    this.description,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      profileImage: json['profile_image'],
      createdAt: json['created_at'],
      dateOfBirth: json['date_of_birth'],
      deletedAt: json['deleted_at'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      gender: json['gender'],
      id: json['id'],
      isBanned: json['is_banned'],
      isManager: json['is_manager'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      playerId: json['player_id'],
      showInCalender: json['show_in_calender'],
      status: json['status'],
      updatedAt: json['updated_at'],
      expert: json['expert'],
      reviewData: json['review'] != null
          ? (json['review'] as List).map((i) => ReviewData.fromJson(i)).toList()
          : null,
      totalReview: json['total_review'],
      branchesCount: json['branches_count'],
      serviceEmployeesCount: json['service_employees_count'],
      ratingStar: json['rating_star'],
      aboutSelf: json['about_self'],
      joiningDate: json['joining_date'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      twitterLink: json['twitter_link'],
      dribbbleLink: json['dribbble_link'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['first_name'] = firstName;
    data['full_name'] = fullName;
    data['gender'] = gender;
    data['id'] = id;
    data['is_banned'] = isBanned;
    data['is_manager'] = isManager;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['show_in_calender'] = showInCalender;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['expert'] = expert;
    data['branches_count'] = branchesCount;

    data['about_self'] = aboutSelf;
    data['joining_date'] = joiningDate;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['twitter_link'] = twitterLink;
    data['dribbble_link'] = dribbbleLink;
    data['total_review'] = totalReview;

    data['service_employees_count'] = serviceEmployeesCount;

    data['rating_star'] = ratingStar;

    if (profileImage != null) {
      data['profile_image'] = profileImage;
    }
    if (dateOfBirth != null) {
      data['date_of_birth'] = dateOfBirth;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (playerId != null) {
      data['player_id'] = playerId;
    }
    if (reviewData != null) {
      data['review'] = reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
