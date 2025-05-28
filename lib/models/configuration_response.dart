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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['apple_login_status'] = appleLoginStatus;
    data['application_language'] = applicationLanguage;
    data['copyright'] = copyright;
    data['customer_app_app_store'] = customerAppAppStore;
    data['customer_app_play_store'] = customerAppPlayStore;
    data['footer_text'] = footerText;
    data['google_login_status'] = googleLoginStatus;
    data['google_maps_key'] = googleMapsKey;
    data['helpline_number'] = helplineNumber;
    data['inquriy_email'] = inquiryEmail;
    data['otp_login_status'] = otpLoginStatus;
    data['primary'] = primaryColor;
    data['site_description'] = siteDescription;
    data['isForceUpdate'] = isForceUpdate;
    data['version_code'] = versionCode;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    if (onesignalCustomerApp != null) {
      data['onesignal_customer_app'] = onesignalCustomerApp!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_code'] = currencyCode;
    data['currency_name'] = currencyName;
    data['currency_position'] = currencyPosition;
    data['currency_symbol'] = currencySymbol;
    data['decimal_separator'] = decimalSeparator;
    data['no_of_decimal'] = noOfDecimal;
    data['thousand_separator'] = thousandSeparator;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['onesignal_app_id'] = onesignalAppId;
    data['onesignal_channel_id'] = onesignalChannelId;
    data['onesignal_rest_api_key'] = onesignalRestApiKey;
    return data;
  }
}
