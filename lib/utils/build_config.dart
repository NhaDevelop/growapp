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
        return 'a6f4aa1c-438b-4820-90b1-994547b2da3d';
      default:
        return '12f26bc1-9c4d-41cb-80c0-ccce6660bc96';
    }
  }
}
