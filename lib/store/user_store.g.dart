// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<String>? _$userFullNameComputed;

  @override
  String get userFullName =>
      (_$userFullNameComputed ??= Computed<String>(() => super.userFullName,
              name: '_UserStore.userFullName'))
          .value;
  Computed<double>? _$conversionRateComputed;

  @override
  double get conversionRate =>
      (_$conversionRateComputed ??= Computed<double>(() => super.conversionRate,
              name: '_UserStore.conversionRate'))
          .value;
  Computed<double>? _$pointToAmountComputed;

  @override
  double get pointToAmount =>
      (_$pointToAmountComputed ??= Computed<double>(() => super.pointToAmount,
              name: '_UserStore.pointToAmount'))
          .value;

  late final _$userIdAtom = Atom(name: '_UserStore.userId', context: context);

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$uidAtom = Atom(name: '_UserStore.uid', context: context);

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  late final _$loginTypeAtom =
      Atom(name: '_UserStore.loginType', context: context);

  @override
  String get loginType {
    _$loginTypeAtom.reportRead();
    return super.loginType;
  }

  @override
  set loginType(String value) {
    _$loginTypeAtom.reportWrite(value, super.loginType, () {
      super.loginType = value;
    });
  }

  late final _$userFirstNameAtom =
      Atom(name: '_UserStore.userFirstName', context: context);

  @override
  String get userFirstName {
    _$userFirstNameAtom.reportRead();
    return super.userFirstName;
  }

  @override
  set userFirstName(String value) {
    _$userFirstNameAtom.reportWrite(value, super.userFirstName, () {
      super.userFirstName = value;
    });
  }

  late final _$userLastNameAtom =
      Atom(name: '_UserStore.userLastName', context: context);

  @override
  String get userLastName {
    _$userLastNameAtom.reportRead();
    return super.userLastName;
  }

  @override
  set userLastName(String value) {
    _$userLastNameAtom.reportWrite(value, super.userLastName, () {
      super.userLastName = value;
    });
  }

  late final _$dobAtom = Atom(name: '_UserStore.dob', context: context);

  @override
  String get dob {
    _$dobAtom.reportRead();
    return super.dob;
  }

  @override
  set dob(String value) {
    _$dobAtom.reportWrite(value, super.dob, () {
      super.dob = value;
    });
  }

  late final _$nationalityAtom =
      Atom(name: '_UserStore.nationality', context: context);

  @override
  String get nationality {
    _$nationalityAtom.reportRead();
    return super.nationality;
  }

  @override
  set nationality(String value) {
    _$nationalityAtom.reportWrite(value, super.nationality, () {
      super.nationality = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_UserStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userProfileImageAtom =
      Atom(name: '_UserStore.userProfileImage', context: context);

  @override
  String get userProfileImage {
    _$userProfileImageAtom.reportRead();
    return super.userProfileImage;
  }

  @override
  set userProfileImage(String value) {
    _$userProfileImageAtom.reportWrite(value, super.userProfileImage, () {
      super.userProfileImage = value;
    });
  }

  late final _$userContactNumberAtom =
      Atom(name: '_UserStore.userContactNumber', context: context);

  @override
  String get userContactNumber {
    _$userContactNumberAtom.reportRead();
    return super.userContactNumber;
  }

  @override
  set userContactNumber(String value) {
    _$userContactNumberAtom.reportWrite(value, super.userContactNumber, () {
      super.userContactNumber = value;
    });
  }

  late final _$genderAtom = Atom(name: '_UserStore.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: '_UserStore.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_UserStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$userTypeAtom =
      Atom(name: '_UserStore.userType', context: context);

  @override
  String get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(String value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  late final _$playerIdAtom =
      Atom(name: '_UserStore.playerId', context: context);

  @override
  String get playerId {
    _$playerIdAtom.reportRead();
    return super.playerId;
  }

  @override
  set playerId(String value) {
    _$playerIdAtom.reportWrite(value, super.playerId, () {
      super.playerId = value;
    });
  }

  late final _$pointAmountAtom =
      Atom(name: '_UserStore.pointAmount', context: context);

  @override
  double get pointAmount {
    _$pointAmountAtom.reportRead();
    return super.pointAmount;
  }

  @override
  set pointAmount(double value) {
    _$pointAmountAtom.reportWrite(value, super.pointAmount, () {
      super.pointAmount = value;
    });
  }

  late final _$conversionRatesAtom =
      Atom(name: '_UserStore.conversionRates', context: context);

  @override
  Map<String, double> get conversionRates {
    _$conversionRatesAtom.reportRead();
    return super.conversionRates;
  }

  @override
  set conversionRates(Map<String, double> value) {
    _$conversionRatesAtom.reportWrite(value, super.conversionRates, () {
      super.conversionRates = value;
    });
  }

  late final _$unreadNotificationCountAtom =
      Atom(name: '_UserStore.unreadNotificationCount', context: context);

  @override
  int get unreadNotificationCount {
    _$unreadNotificationCountAtom.reportRead();
    return super.unreadNotificationCount;
  }

  @override
  set unreadNotificationCount(int value) {
    _$unreadNotificationCountAtom
        .reportWrite(value, super.unreadNotificationCount, () {
      super.unreadNotificationCount = value;
    });
  }

  late final _$setUIdAsyncAction =
      AsyncAction('_UserStore.setUId', context: context);

  @override
  Future<void> setUId(String val, {bool isInitializing = false}) {
    return _$setUIdAsyncAction
        .run(() => super.setUId(val, isInitializing: isInitializing));
  }

  late final _$setUserTypeAsyncAction =
      AsyncAction('_UserStore.setUserType', context: context);

  @override
  Future<void> setUserType(String val, {bool isInitializing = false}) {
    return _$setUserTypeAsyncAction
        .run(() => super.setUserType(val, isInitializing: isInitializing));
  }

  late final _$setUserProfileAsyncAction =
      AsyncAction('_UserStore.setUserProfile', context: context);

  @override
  Future<void> setUserProfile(String val, {bool isInitializing = false}) {
    return _$setUserProfileAsyncAction
        .run(() => super.setUserProfile(val, isInitializing: isInitializing));
  }

  late final _$setLoginTypeAsyncAction =
      AsyncAction('_UserStore.setLoginType', context: context);

  @override
  Future<void> setLoginType(String val, {bool isInitializing = false}) {
    return _$setLoginTypeAsyncAction
        .run(() => super.setLoginType(val, isInitializing: isInitializing));
  }

  late final _$setTokenAsyncAction =
      AsyncAction('_UserStore.setToken', context: context);

  @override
  Future<void> setToken(String val, {bool isInitializing = false}) {
    return _$setTokenAsyncAction
        .run(() => super.setToken(val, isInitializing: isInitializing));
  }

  late final _$setUserIdAsyncAction =
      AsyncAction('_UserStore.setUserId', context: context);

  @override
  Future<void> setUserId(int val, {bool isInitializing = false}) {
    return _$setUserIdAsyncAction
        .run(() => super.setUserId(val, isInitializing: isInitializing));
  }

  late final _$setUserEmailAsyncAction =
      AsyncAction('_UserStore.setUserEmail', context: context);

  @override
  Future<void> setUserEmail(String val, {bool isInitializing = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitializing: isInitializing));
  }

  late final _$setFirstNameAsyncAction =
      AsyncAction('_UserStore.setFirstName', context: context);

  @override
  Future<void> setFirstName(String val, {bool isInitializing = false}) {
    return _$setFirstNameAsyncAction
        .run(() => super.setFirstName(val, isInitializing: isInitializing));
  }

  late final _$setLastNameAsyncAction =
      AsyncAction('_UserStore.setLastName', context: context);

  @override
  Future<void> setLastName(String val, {bool isInitializing = false}) {
    return _$setLastNameAsyncAction
        .run(() => super.setLastName(val, isInitializing: isInitializing));
  }

  late final _$setDobAsyncAction =
      AsyncAction('_UserStore.setDob', context: context);

  @override
  Future<void> setDob(String val, {bool isInitializing = false}) {
    return _$setDobAsyncAction
        .run(() => super.setDob(val, isInitializing: isInitializing));
  }

  late final _$setNationalityAsyncAction =
      AsyncAction('_UserStore.setNationality', context: context);

  @override
  Future<void> setNationality(String val, {bool isInitializing = false}) {
    return _$setNationalityAsyncAction
        .run(() => super.setNationality(val, isInitializing: isInitializing));
  }

  late final _$setContactNumberAsyncAction =
      AsyncAction('_UserStore.setContactNumber', context: context);

  @override
  Future<void> setContactNumber(String val, {bool isInitializing = false}) {
    return _$setContactNumberAsyncAction
        .run(() => super.setContactNumber(val, isInitializing: isInitializing));
  }

  late final _$setGenderValueAsyncAction =
      AsyncAction('_UserStore.setGenderValue', context: context);

  @override
  Future<void> setGenderValue(String val, {bool isInitializing = false}) {
    return _$setGenderValueAsyncAction
        .run(() => super.setGenderValue(val, isInitializing: isInitializing));
  }

  late final _$setUserNameAsyncAction =
      AsyncAction('_UserStore.setUserName', context: context);

  @override
  Future<void> setUserName(String val, {bool isInitializing = false}) {
    return _$setUserNameAsyncAction
        .run(() => super.setUserName(val, isInitializing: isInitializing));
  }

  late final _$setPlayerIdAsyncAction =
      AsyncAction('_UserStore.setPlayerId', context: context);

  @override
  Future<void> setPlayerId(String val, {bool isInitializing = false}) {
    return _$setPlayerIdAsyncAction
        .run(() => super.setPlayerId(val, isInitializing: isInitializing));
  }

  late final _$setPointAmountAsyncAction =
      AsyncAction('_UserStore.setPointAmount', context: context);

  @override
  Future<void> setPointAmount(double val, {bool isInitializing = false}) {
    return _$setPointAmountAsyncAction
        .run(() => super.setPointAmount(val, isInitializing: isInitializing));
  }

  late final _$setConversionRatesAsyncAction =
      AsyncAction('_UserStore.setConversionRates', context: context);

  @override
  Future<void> setConversionRates(Map<String, double> val) {
    return _$setConversionRatesAsyncAction
        .run(() => super.setConversionRates(val));
  }

  late final _$setUnreadNotificationCountAsyncAction =
      AsyncAction('_UserStore.setUnreadNotificationCount', context: context);

  @override
  Future<void> setUnreadNotificationCount(int val) {
    return _$setUnreadNotificationCountAsyncAction
        .run(() => super.setUnreadNotificationCount(val));
  }

  @override
  String toString() {
    return '''
userId: ${userId},
uid: ${uid},
loginType: ${loginType},
userFirstName: ${userFirstName},
userLastName: ${userLastName},
dob: ${dob},
nationality: ${nationality},
userEmail: ${userEmail},
userProfileImage: ${userProfileImage},
userContactNumber: ${userContactNumber},
gender: ${gender},
userName: ${userName},
token: ${token},
userType: ${userType},
playerId: ${playerId},
pointAmount: ${pointAmount},
conversionRates: ${conversionRates},
unreadNotificationCount: ${unreadNotificationCount},
userFullName: ${userFullName},
conversionRate: ${conversionRate},
pointToAmount: ${pointToAmount}
    ''';
  }
}
