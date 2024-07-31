/// DO NOT CHANGE THIS PACKAGE NAME
const APP_PACKAGE_NAME = 'com.growtokyo';
const IOS_APP_ID = '6479511235';

const ANDROID_DOWNLOAD_URL =
    'https://play.google.com/store/apps/details?id=$APP_PACKAGE_NAME';
const IOS_DOWNLOAD_URL = 'https://apps.apple.com/app/growtokyo/id$IOS_APP_ID';

const PER_PAGE_ITEM = 25;
const LABEL_TEXT_SIZE = 14;
const ICON_SIZE = 16.0;

const MAIL_TO = 'mailto:';
const TEL = 'tel:';
const GOOGLE_MAP_PREFIX = 'https://www.google.com/maps/search/?api=1&query=';
const MESSAGE = 'message';
const DECIMAL_POINT = 2;
const double CATEGORY_ICON_SIZE = 85;
const DEFAULT_FIREBASE_PASSWORD = '12345678';
const APPBAR_TEXT_SIZE = 18;
const UNSELECTED_BRANCH_ID = -1;
const UNSELECTED_COUNTRY_ID = -1;
const UNSELECTED_EMPLOYEE_ID = -1;
const UNSELECTED_EMPLOYEE_GROUP_ID = 'unselected';
const MARK_AS_READ = 'mark_as_read';
const DEFAULT_SLOT_INTERVAL_DURATION = '00:30';
const NOTIFICATION_TYPE_BOOKING = 'booking';
const IN_CART = 1;
const DEFAULT_QUANTITY = 1;
const SHIPPING_DELIVERY_TYPE_REGULAR = 'regular';

//region Branch Status
const BRANCH_STATUS_OPEN = 'Open';
const BRANCH_STATUS_CLOSED = 'Closed';

//endregion

class TaxType {
  static const FIXED = 'fixed';
  static const PERCENT = 'percent';
}

class PaymentMethods {
  static const PAYMENT_METHOD_CASH = 'cash';
  static const PAYMENT_METHOD_STRIPE = 'stripe';
  static const PAYMENT_METHOD_RAZORPAY = 'razorpay';
  static const PAYMENT_METHOD_PAYPAL = 'paypal';
  static const PAYMENT_METHOD_PAYSTACK = 'paystack';
  static const PAYMENT_METHOD_FLUTTER_WAVE = 'flutterwave';
  static const PAYMENT_METHOD_PAYTM = 'paytm';
}

class GenderConst {
  static const MALE = 'male';
  static const FEMALE = 'female';
  static const OTHER = 'other';
}

//region SERVICE PAYMENT STATUS
const SERVICE_PAYMENT_STATUS_PAID = 'paid';
const SERVICE_PAYMENT_STATUS_PENDING = 'pending';
const SERVICE_PAYMENT_STATUS_UNPAID = 'unpaid';
//endregion

//region DateFormats
class DateFormatConst {
  static const BE_DATE_FORMAT = 'MM/dd/yyyy';
  static const DATE_FORMAT_1 = 'dd-MMM-yyyy hh:mm a';
  static const NEW_FORMAT = 'yyyy-MM-dd HH:mm';
  static const DATE_FORMAT_2 = 'd MMM, yyyy';
  static const DATE_FORMAT_3 = 'dd-MMM-yyyy';
  static const DATE_FORMAT_4 = 'dd MMM';
  static const DATE_FORMAT_5 = 'yyyy-MM-dd';
  static const BOOK_DATE_FORMAT = 'dd/MM/yyyy';
  static const HOUR_12_FORMAT = 'hh:mm a';
  static const HOUR_24_FORMAT = 'HH:mm';
  static const DATE_FORMAT_HOUR_12 = 'hh:mm a';
  static const YEAR = 'yyyy';
}
//endregion

//region LOGIN TYPE
class LoginTypeConst {
  static const LOGIN_TYPE_USER = 'user';
  static const LOGIN_TYPE_GOOGLE = 'google';
  static const LOGIN_TYPE_APPLE = 'apple';
  static const LOGIN_TYPE_FACEBOOK = 'facebook';
  static const LOGIN_TYPE_OTP = 'mobile';
}
//endregion

//region BOOKING STATUS
class BookingStatusConst {
  static const COMPLETED = 'completed';
  static const PENDING = 'pending';
  static const CONFIRMED = 'confirmed';
  static const CHECK_IN = 'check_in';
  static const CHECKOUT = 'checkout';
  static const CANCELLED = 'cancelled';
}
//endregion

//region ORDER STATUS
class OrderStatusConst {
  static const ORDER_PLACED = 'order_placed';
  static const PENDING = 'pending';
  static const PROCESSING = 'processing';
  static const DELIVERED = 'delivered';
  static const CANCELLED = 'cancelled';
}
//endregion

// region LIVESTREAM KEYS
class LiveStreamKeyConst {
  static const LIVESTREAM_TOKEN = 'tokenStream';
  static const LIVESTREAM_CHANGE_STEP = 'LIVESTREAM_CHANGE_STEP';
//endregion
}
//endregion

//region CONFIGURATION KEYS
class ConfigurationKeyConst {
  static const CURRENCY_COUNTRY_CODE = 'CURRENCY_COUNTRY_CODE';
  static const CURRENCY_COUNTRY_ID = 'CURRENCY_COUNTRY_ID';
  static const CURRENCY_COUNTRY_SYMBOL = 'CURRENCY_COUNTRY_SYMBOL';
  static const ONESIGNAL_API_KEY = 'ONESIGNAL_API_KEY';
  static const ONESIGNAL_REST_API_KEY = 'ONESIGNAL_REST_API_KEY';
  static const ONESIGNAL_CHANNEL_KEY = 'ONESIGNAL_CHANNEL_KEY';
  static const APP_NAME = 'APP_NAME';
  static const FOOTER_TEXT = 'FOOTER_TEXT';
  static const HELPLINE_NUMBER = 'HELPLINE_NUMBER';
  static const COPYRIGHT = 'COPYRIGHT';
  static const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
  static const SITE_DESCRIPTION = 'SITE_DESCRIPTION';
  static const PRIMARY = 'PRIMARY';
  static const GOOGLE_MAPS_KEY = 'GOOGLE_MAPS_KEY';
  static const CUSTOMER_APP_PLAY_STORE = 'CUSTOMER_APP_PLAY_STORE';
  static const CUSTOMER_APP_APP_STORE = 'CUSTOMER_APP_APP_STORE';
  static const GOOGLE_LOGIN_STATUS = 'GOOGLE_LOGIN_STATUS';
  static const APPLE_LOGIN_STATUS = 'APPLE_LOGIN_STATUS';
  static const OTP_LOGIN_STATUS = 'OTP_LOGIN_STATUS';
  static const APPLICATION_LANGUAGE = 'APPLICATION_LANGUAGE';
  static const CURRENCY_NAME = 'CURRENCY_NAME';
  static const CURRENCY_SYMBOL = 'CURRENCY_SYMBOL';
  static const CURRENCY_CODE = 'CURRENCY_CODE';
  static const CURRENCY_POSITION = 'CURRENCY_POSITION';
  static const NO_OF_DECIMAL = 'NO_OF_DECIMAL';
  static const THOUSAND_SEPARATOR = 'THOUSAND_SEPARATOR';
  static const DECIMAL_SEPARATOR = 'DECIMAL_SEPARATOR';
  static const IS_FORCE_UPDATE = 'IS_FORCE_UPDATE';
  static const VERSION_CODE = 'VERSION_CODE';
}
//endregion

//region THEME MODE TYPE
class ThemeConst {
  static const THEME_MODE_LIGHT = 0;
  static const THEME_MODE_DARK = 1;
  static const THEME_MODE_SYSTEM = 2;
}

//endregion

//region FireBase Collection Name
const USER_COLLECTION = "users";
//endregion

//region CHAT LANGUAGE
const List<String> RTL_LanguageS = ['ar', 'ur'];
//endregion

//region SharedPreference Keys

class SharedPreferenceConst {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_ID = 'USER_ID';
  static const FIRST_NAME = 'FIRST_NAME';
  static const LAST_NAME = 'LAST_NAME';
  static const DOB = 'DOB';
  static const NATIONALITY = 'NATIONALITY';
  static const USER_EMAIL = 'USER_EMAIL';
  static const TOKEN = 'TOKEN';
  static const AVTAR = 'AVTAR';
  static const LOGIN_TYPE = 'LOGIN_TYPE';
  static const PLAYER_ID = 'PLAYER_ID';
  static const ONESIGNAL_API_KEY = 'ONESIGNAL_API_KEY';
  static const USER_PASSWORD = 'USER_PASSWORD';
  static const CONTACT_NUMBER = 'CONTACT_NUMBER';
  static const GENDER = 'GENDER';
  static const HELPLINE_NUMBER = 'HELPLINE_NUMBER';
  static const IS_SELECTED = 'IS_SELECTED';

  static const USERNAME = 'USERNAME';
  static const PROFILE_IMAGE = 'PROFILE_IMAGE';
  static const IS_REMEMBERED = 'IS_REMEMBERED';
  static const USER_TYPE = 'USER_TYPE';
  static const IS_FIRST_TIME = 'IS_FIRST_TIME';
  static const UID = 'UID';
  static const APPLE_UID = 'APPLE_UID';
  static const APPLE_EMAIL = 'APPLE_EMAIL';
  static const APPLE_GIVE_NAME = 'APPLE_GIVE_NAME';
  static const APPLE_FAMILY_NAME = 'APPLE_FAMILY_NAME';
  static const COUNTRY_ID = 'COUNTRY_ID';
  static const STATE_ID = 'STATE_ID';
  static const CITY_ID = 'CITY_ID';
  static const CURRENCY_POSITION = 'CURRENCY_POSITION';
  static const APPSTORE_URL = 'APPSTORE_URL';
  static const PLAY_STORE_URL = 'PLAY_STORE_URL';
  static const PRIVACY_POLICY = 'PRIVACY_POLICY';
  static const TERM_CONDITIONS = 'TERM_CONDITIONS';
  static const SERVER_LANGUAGES = 'SERVER_LANGUAGES';
  static const SITE_DESCRIPTION = 'SITE_DESCRIPTION';
  static const SITE_COPYRIGHT = 'SITE_COPYRIGHT';
  static const FACEBOOK_URL = 'FACEBOOK_URL';
  static const INSTAGRAM_URL = 'INSTAGRAM_URL';
  static const TWITTER_URL = 'TWITTER_URL';
  static const LINKEDIN_URL = 'LINKEDIN_URL';
  static const YOUTUBE_URL = 'YOUTUBE_URL';
  static const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
  static const AUTO_SLIDER_STATUS = 'AUTO_SLIDER_STATUS';
  static const BRANCH_ID = 'BRANCH_ID';
  static const BRANCH_NAME = 'BRANCH_NAME';
  static const BRANCH_ANY_STYLIST_OPTIONS = 'BRANCH_ANY_STYLIST_OPTIONS';
  static const CREDIT = 'CREDIT';
}

//endregion

const USER_NOT_CREATED = "User not created";
const USER_CANNOT_LOGIN = "User can't login";
const USER_NOT_FOUND = "User not found";

const ONESIGNAL_TAG_KEY = 'appType';
const ONESIGNAL_TAG_VALUE = 'userApp';

// Currency position
const CURRENCY_POSITION_LEFT = 'left';
const CURRENCY_POSITION_RIGHT = 'right';
const CURRENCY_POSITION_LEFT_WITH_SPACE = 'left_with_space';
const CURRENCY_POSITION_RIGHT_WITH_SPACE = 'right_with_space';
//endregion

//region BOOKING STATUS
const SLIDER_TYPE_CATEGORY = 'category';
const SLIDER_TYPE_SERVICE = 'service';

//endregion
