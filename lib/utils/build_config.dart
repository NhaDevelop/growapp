enum AppFlavor { stag, prod, local }

class BuildConfig {
  static AppFlavor appFlavor = AppFlavor.prod;

  static String get domainUrl {
    switch (appFlavor) {
      case AppFlavor.local:
      // If you are using Android Emulator, 10.0.2.2 points back to your computer's localhost
      // If you are using iOS Simulator, you can use "localhost"
        return 'http://10.0.2.2:8000';
      case AppFlavor.stag:
        return 'https://grow-cms.xclabs.io';
      case AppFlavor.prod:
        return 'https://demo-cms-hair-grow.camboinfo.com';
      default:
        return 'https://grow-cms.xclabs.io';
    }
  }

  static String get baseUrl => '$domainUrl/api/';

  static String get onesignalAppId {
    switch (appFlavor) {
      case AppFlavor.prod:
        return 'a6f4aa1c-438b-4820-90b1-994547b2da3d';
      case AppFlavor.stag:
        return '12f26bc1-9c4d-41cb-80c0-ccce6660bc96';
      case AppFlavor.local:
        return 'your-onesignal-app-id-for-local';
      default:
        return '';
    }
  }

  static String get blogPostHost {
    return 'hairmake-grow.com';
  }
}
