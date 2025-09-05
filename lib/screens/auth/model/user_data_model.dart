import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? dob;
  String? nationality;
  String? username;
  int? status;
  String? email;
  String? socialImage;
  String? mobile;
  String? gender;
  String? uid;
  String? loginType;
  String? displayName;
  String? apiToken;
  String? playerId;
  String? createdAt;
  String? updatedAt;
  List<String>? userRole;
  String? password;
  String? userType;
  String? profileImage;
  double? credit;
  int? branchId;
  String? branchName;

  UserData({
    this.apiToken,
    this.mobile,
    this.gender,
    this.nationality,
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.dob,
    this.playerId,
    this.socialImage,
    this.uid,
    this.status,
    this.userRole,
    this.displayName,
    this.username,
    this.loginType,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.userType,
    this.profileImage,
    this.credit,
    this.branchId,
    this.branchName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      apiToken: json['api_token'],
      mobile: json['mobile'],
      gender: json['gender'],
      email: json['email'],
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
      dob: json['date_of_birth'] == null
          ? null
          : formatDate(
              json['date_of_birth'],
              format: DateFormatConst.BOOK_DATE_FORMAT,
            ),
      nationality: json['nationality'],
      playerId: json['player_id'],
      status: json['status'],
      displayName: json['display_name'],
      uid: json['uid'],
      userRole: json['user_role'] != null
          ? List<String>.from(json['user_role'])
          : null,
      username: json['username'],
      loginType: json['login_type'],
      socialImage: json['social_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      password: json['password'],
      userType: json['user_type'],
      profileImage: json['profile_image'],
      credit: (json['credit'] as num?)?.toDouble(),
      branchId: json['branch_id'],
      branchName: json['branch_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiToken != null) data['api_token'] = apiToken;
    if (mobile != null) data['mobile'] = mobile;
    if (gender != null) data['gender'] = gender;
    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (id != null) data['id'] = id;
    if (lastName != null) data['last_name'] = lastName;
    if (playerId != null) data['player_id'] = playerId;
    if (status != null) data['status'] = status;
    if (username != null) data['username'] = username;
    if (displayName != null) data['display_name'] = displayName;
    if (loginType != null) data['login_type'] = loginType;
    if (socialImage != null) data['social_image'] = socialImage;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (uid != null) data['uid'] = uid;
    if (password != null) data['password'] = password;
    if (userType != null) data['user_type'] = userType;
    if (profileImage != null) data['profile_image'] = profileImage;
    if (userRole != null) {
      data['user_role'] = userRole;
    }
    if (credit != null) data['credit'] = credit;
    if (branchId != null) data['branch_id'] = branchId;
    if (branchName != null) data['branch_name'] = branchName;
    return data;
  }

  factory UserData.fromFirebaseUserCredential(UserCredential userCredential) {
    final User user = userCredential.user!;
    assert(!user.isAnonymous);

    final User currentUser = auth.currentUser!;
    assert(user.uid == currentUser.uid);

    log(currentUser);

    String firstName = '';
    String lastName = '';
    if (currentUser.displayName.validate().split(' ').isNotEmpty) {
      firstName = currentUser.displayName.splitBefore(' ');
    }
    if (currentUser.displayName.validate().split(' ').length >= 2) {
      lastName = currentUser.displayName.splitAfter(' ');
    }

    /// Create a temporary request to send
    UserData tempUserData = UserData()
      ..mobile = currentUser.phoneNumber.validate()
      ..email = currentUser.email.validate()
      ..firstName = firstName.validate()
      ..lastName = lastName.validate()
      ..socialImage = currentUser.photoURL.validate()
      ..profileImage = currentUser.photoURL.validate()
      ..userType = LoginTypeConst.LOGIN_TYPE_USER
      ..loginType = LoginTypeConst.LOGIN_TYPE_GOOGLE
      ..playerId = appStore.playerId
      ..uid = user.uid
      ..username =
          (currentUser.email.validate().splitBefore('@').replaceAll('.', ''))
              .toLowerCase();

    return tempUserData;
  }
}
