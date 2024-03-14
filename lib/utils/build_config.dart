enum AppFlavor { stag, prod }

class BuildConfig {
  static AppFlavor appFlavor = AppFlavor.stag;

  static String get domainUrl {
    switch (appFlavor) {
      case AppFlavor.prod:
        return 'https://grow-cms.xclabs.io';
      default:
        return 'https://grow-cms.xclabs.io';
    }
  }

  static String get baseUrl => '$domainUrl/api/';

  static String get onesignalAppId {
    switch (appFlavor) {
      case AppFlavor.prod:
        return 'YOUR_ONESIGNAL_APP_ID';
      default:
        return 'YOUR_ONESIGNAL_APP_ID';
    }
  }
}
