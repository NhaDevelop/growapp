enum AppFlavor { stag, prod, local }

class BuildConfig {
  static AppFlavor appFlavor = AppFlavor.prod;

  static String get domainUrl {
    switch (appFlavor) {
      case AppFlavor.local:
      // If you are using Android Emulator, 10.0.2.2 points back to your computer's localhost
      // If you are using iOS Simulator, you can use "localhost"
        return 'http://192.168.0.106:8000';
      case AppFlavor.stag:
        return 'http://192.168.0.106:8000';
      case AppFlavor.prod:
        return 'http://192.168.0.106:8000';
      default:
        return 'http://192.168.0.106:8000';
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
