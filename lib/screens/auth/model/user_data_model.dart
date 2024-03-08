class UserData {
  int? id;
  String? firstName;
  String? lastName;
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
  String? referralCode;
  int? credit;

  UserData({
    this.apiToken,
    this.mobile,
    this.gender,
    this.email,
    this.firstName,
    this.id,
    this.lastName,
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
    this.referralCode,
    this.credit,
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
      referralCode: json['referral_code'],
      credit: json['credit'],
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
    return data;
  }
}
