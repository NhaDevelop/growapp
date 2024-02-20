class ConfigurationResponse {
  String? appName;
  String? appleLoginStatus;
  String? applicationLanguage;
  String? copyright;
  Currency? currency;
  String? customerAppAppStore;
  String? customerAppPlayStore;
  String? footerText;
  String? googleLoginStatus;
  String? googleMapsKey;
  String? helplineNumber;
  String? inquiryEmail;
  OnesignalModel? onesignalCustomerApp;
  String? otpLoginStatus;
  String? primaryColor;
  String? siteDescription;
  int? isForceUpdate;
  int? versionCode;

  ConfigurationResponse({
    this.appName,
    this.appleLoginStatus,
    this.applicationLanguage,
    this.copyright,
    this.currency,
    this.customerAppAppStore,
    this.customerAppPlayStore,
    this.footerText,
    this.googleLoginStatus,
    this.googleMapsKey,
    this.helplineNumber,
    this.inquiryEmail,
    this.onesignalCustomerApp,
    this.otpLoginStatus,
    this.primaryColor,
    this.siteDescription,
    this.isForceUpdate,
    this.versionCode,
  });

  factory ConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return ConfigurationResponse(
      appName: json['app_name'],
      appleLoginStatus: json['apple_login_status'],
      applicationLanguage: json['application_language'],
      copyright: json['copyright'],
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      customerAppAppStore: json['customer_app_app_store'],
      customerAppPlayStore: json['customer_app_play_store'],
      footerText: json['footer_text'],
      googleLoginStatus: json['google_login_status'],
      googleMapsKey: json['google_maps_key'],
      helplineNumber: json['helpline_number'],
      inquiryEmail: json['inquriy_email'],
      onesignalCustomerApp: json['onesignal_customer_app'] != null ? OnesignalModel.fromJson(json['onesignal_customer_app']) : null,
      otpLoginStatus: json['otp_login_status'],
      primaryColor: json['primary'],
      siteDescription: json['site_description'],
      isForceUpdate: json['isForceUpdate'],
      versionCode: json['version_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['apple_login_status'] = this.appleLoginStatus;
    data['application_language'] = this.applicationLanguage;
    data['copyright'] = this.copyright;
    data['customer_app_app_store'] = this.customerAppAppStore;
    data['customer_app_play_store'] = this.customerAppPlayStore;
    data['footer_text'] = this.footerText;
    data['google_login_status'] = this.googleLoginStatus;
    data['google_maps_key'] = this.googleMapsKey;
    data['helpline_number'] = this.helplineNumber;
    data['inquriy_email'] = this.inquiryEmail;
    data['otp_login_status'] = this.otpLoginStatus;
    data['primary'] = this.primaryColor;
    data['site_description'] = this.siteDescription;
    data['isForceUpdate'] = this.isForceUpdate;
    data['version_code'] = this.versionCode;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.onesignalCustomerApp != null) {
      data['onesignal_customer_app'] = this.onesignalCustomerApp!.toJson();
    }
    return data;
  }
}

class Currency {
  String? currencyCode;
  String? currencyName;
  String? currencyPosition;
  String? currencySymbol;
  String? decimalSeparator;
  int? noOfDecimal;
  String? thousandSeparator;

  Currency({this.currencyCode, this.currencyName, this.currencyPosition, this.currencySymbol, this.decimalSeparator, this.noOfDecimal, this.thousandSeparator});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyCode: json['currency_code'],
      currencyName: json['currency_name'],
      currencyPosition: json['currency_position'],
      currencySymbol: json['currency_symbol'],
      decimalSeparator: json['decimal_separator'],
      noOfDecimal: json['no_of_decimal'],
      thousandSeparator: json['thousand_separator'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_code'] = this.currencyCode;
    data['currency_name'] = this.currencyName;
    data['currency_position'] = this.currencyPosition;
    data['currency_symbol'] = this.currencySymbol;
    data['decimal_separator'] = this.decimalSeparator;
    data['no_of_decimal'] = this.noOfDecimal;
    data['thousand_separator'] = this.thousandSeparator;
    return data;
  }
}

class OnesignalModel {
  String? onesignalAppId;
  String? onesignalChannelId;
  String? onesignalRestApiKey;

  OnesignalModel({this.onesignalAppId, this.onesignalChannelId, this.onesignalRestApiKey});

  factory OnesignalModel.fromJson(Map<String, dynamic> json) {
    return OnesignalModel(
      onesignalAppId: json['onesignal_app_id'],
      onesignalChannelId: json['onesignal_channel_id'],
      onesignalRestApiKey: json['onesignal_rest_api_key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onesignal_app_id'] = this.onesignalAppId;
    data['onesignal_channel_id'] = this.onesignalChannelId;
    data['onesignal_rest_api_key'] = this.onesignalRestApiKey;
    return data;
  }
}
