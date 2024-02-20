import 'package:frezka/configs.dart';
import 'package:frezka/network/network_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../models/configuration_response.dart';
import '../models/verify_transaction_response.dart';
import '../utils/api_end_points.dart';
import '../utils/constants.dart';

Future<void> clearPreferences() async {
  await userStore.setFirstName('');
  await userStore.setLastName('');
  await userStore.setUserId(0);
  await userStore.setUserName('');
  await userStore.setContactNumber('');
  await userStore.setGenderValue('');
  await userStore.setUserProfile('');
  await userStore.setUId('');
  await userStore.setToken('');

  await appStore.setHelplineNumber('');
  await appStore.setInquiryEmail('');
  await appStore.setLoggedIn(false);
}

//region Configurations Api
Future<ConfigurationResponse> getAppConfigurations({bool isCurrentLocation = false, double? lat, double? long}) async {
  try {
    appConfigurationResponseCached = ConfigurationResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.appConfiguration}?is_authenticated=${appStore.isLoggedIn.getIntBool()}', method: HttpMethodType.GET)));

    if (appConfigurationResponseCached!.onesignalCustomerApp != null) {
      await setValue(ConfigurationKeyConst.ONESIGNAL_API_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalAppId);
      await setValue(ConfigurationKeyConst.ONESIGNAL_CHANNEL_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalChannelId);
      await setValue(ConfigurationKeyConst.ONESIGNAL_REST_API_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalRestApiKey);

      /// Initialize OneSignal if we get API Keys
      // initOneSignal();
    }

    await setValue(ConfigurationKeyConst.APP_NAME, appConfigurationResponseCached!.appName);
    await setValue(ConfigurationKeyConst.FOOTER_TEXT, appConfigurationResponseCached!.footerText);
    await setValue(ConfigurationKeyConst.HELPLINE_NUMBER, appConfigurationResponseCached!.helplineNumber.validate(value: HELP_LINE_NUMBER));
    await setValue(ConfigurationKeyConst.COPYRIGHT, appConfigurationResponseCached!.copyright);
    await setValue(ConfigurationKeyConst.INQUIRY_EMAIL, appConfigurationResponseCached!.inquiryEmail.validate(value: INQUIRY_SUPPORT_EMAIL));
    await setValue(ConfigurationKeyConst.SITE_DESCRIPTION, appConfigurationResponseCached!.siteDescription);
    await setValue(ConfigurationKeyConst.PRIMARY, appConfigurationResponseCached!.primaryColor);

    await setValue(ConfigurationKeyConst.GOOGLE_MAPS_KEY, appConfigurationResponseCached!.googleMapsKey);
    await setValue(ConfigurationKeyConst.CUSTOMER_APP_PLAY_STORE, appConfigurationResponseCached!.customerAppPlayStore);
    await setValue(ConfigurationKeyConst.CUSTOMER_APP_APP_STORE, appConfigurationResponseCached!.customerAppAppStore);
    await setValue(ConfigurationKeyConst.GOOGLE_LOGIN_STATUS, appConfigurationResponseCached!.googleLoginStatus);
    await setValue(ConfigurationKeyConst.APPLE_LOGIN_STATUS, appConfigurationResponseCached!.appleLoginStatus);
    await setValue(ConfigurationKeyConst.OTP_LOGIN_STATUS, appConfigurationResponseCached!.otpLoginStatus);
    await setValue(ConfigurationKeyConst.APPLICATION_LANGUAGE, appConfigurationResponseCached!.applicationLanguage);
    await setValue(ConfigurationKeyConst.IS_FORCE_UPDATE, appConfigurationResponseCached!.isForceUpdate);
    await setValue(ConfigurationKeyConst.VERSION_CODE, appConfigurationResponseCached!.versionCode);

    if (appConfigurationResponseCached!.currency != null) {
      appStore.setCurrencySymbol(appConfigurationResponseCached!.currency!.currencySymbol.validate());
      appStore.setCurrencyCode(appConfigurationResponseCached!.currency!.currencyCode.validate());
      await setValue(ConfigurationKeyConst.CURRENCY_NAME, appConfigurationResponseCached!.currency!.currencyName);
      await setValue(ConfigurationKeyConst.CURRENCY_SYMBOL, appConfigurationResponseCached!.currency!.currencySymbol);
      await setValue(ConfigurationKeyConst.CURRENCY_CODE, appConfigurationResponseCached!.currency!.currencyCode);
      await setValue(ConfigurationKeyConst.CURRENCY_POSITION, appConfigurationResponseCached!.currency!.currencyPosition);
      await setValue(ConfigurationKeyConst.NO_OF_DECIMAL, appConfigurationResponseCached!.currency!.noOfDecimal);
      await setValue(ConfigurationKeyConst.THOUSAND_SEPARATOR, appConfigurationResponseCached!.currency!.thousandSeparator);
      await setValue(ConfigurationKeyConst.DECIMAL_SEPARATOR, appConfigurationResponseCached!.currency!.decimalSeparator);
    }

    return appConfigurationResponseCached!;
  } catch (e) {
    log(e);
    throw e;
  }
}
//endregion

//region FlutterWave Verify Transaction API
Future<VerifyTransactionResponse> verifyPayment({required String transactionId, required String flutterWaveSecretKey}) async {
  return VerifyTransactionResponse.fromJson(
    await handleResponse(await buildHttpResponse("https://api.flutterwave.com/v3/transactions/$transactionId/verify", extraKeys: {
      'isFlutterWave': true,
      'flutterWaveSecretKey': flutterWaveSecretKey,
    }),
      isFlutterWave: true,
    ),
  );
}
//endregion
