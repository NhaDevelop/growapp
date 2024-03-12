import 'package:country_picker/country_picker.dart';

const APP_NAME = 'growTokyo';
const DEFAULT_LANGUAGE = 'en';

const DOMAIN_URL = "https://grow-cms.xclabs.io";
const BASE_URL = '$DOMAIN_URL/api/';
const appStoreAppBaseURL = '';

//ONESIGNAL
const ONESIGNAL_APP_ID = "<YOUR_ONESIGNAL_APP_ID>";

//region Payment Key
// const RAZORPAY_TEST_KEY = '<YOUR_RAZORPAY_KEY>';
// const RAZORPAY_CURRENCY_CODE = 'INR';

// const FLUTTER_WAVE_TEST_PUBLIC_KEY = '<YOUR_FLUTTER_WAVE_PUBLIC_KEY>';
// const FLUTTER_WAVE_TEST_SECRET_KEY = '<YOUR_FLUTTER_WAVE_SECRET_KEY>';
// const FLUTTER_WAVE_ENCRYPTION_KEY = '<YOUR_FLUTTER_WAVE_ENCRYPTION_KEY>';

// const PAYPAL_CLIENT_ID = '<YOUR_PAYPAL_CLIENT_ID>';
// const PAYPAL_TEST_SECRET_KEY = '<YOUR_PAYPAL_SECRET_KEY>';
// const PAYPAL_CURRENCY_CODE = 'USD';

/// United States Currency

// const PAYSTACK_TEST_SECRET_KEY = '<YOUR_PAYSTACK_SECRET_KEY>';
// const PAYSTACK_TEST_PUBLIC_KEY = '<YOUR_PAYSTACK_PUBLIC_KEY>';
// const PAYSTACK_CURRENCY_CODE = 'NGN';

/// Nigeria Currency

// const STRIPE_TEST_SECRET_KEY = '<YOUR_STRIPE_SECRET_KEY>';
// const STRIPE_TEST_PUBLIC_KEY = '<YOUR_STRIPE_PUBLIC_KEY>';
// const STRIPE_URL = 'https://api.stripe.com/v1/payment_intents';
// const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';
// const STRIPE_CURRENCY_CODE = 'INR';

//endregion

const APP_PLAY_STORE_URL = '';
const APP_APPSTORE_URL = '';

const TERMS_CONDITION_URL = 'https://iqonic.design/terms-of-use';
const PRIVACY_POLICY_URL = 'https://iqonic.design/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'demo@gmail.com';
const DASHBOARD_AUTO_SLIDER_SECOND = 5;

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+15265897485';

Country defaultCountry() {
  return Country(
    phoneCode: '855',
    countryCode: 'KH',
    e164Sc: 855,
    geographic: true,
    level: 1,
    name: 'Cambodia',
    example: '232345678',
    displayName: 'Cambodia (KH) [+855]',
    displayNameNoCountryCode: 'Cambodia (KH)',
    e164Key: '855-KH-0',
    fullExampleWithPlusSign: '+855232345678',
  );
}
