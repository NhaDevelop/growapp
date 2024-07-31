import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/locale/language_en.dart';
import 'package:grow_tokyo_app/screens/auth/services/apple_login_auth_service.dart';
import 'package:grow_tokyo_app/screens/auth/services/auth_service.dart';
import 'package:grow_tokyo_app/screens/auth/services/facebook_login_auth_service.dart';
import 'package:grow_tokyo_app/screens/auth/services/google_sign_in_auth_service.dart';
import 'package:grow_tokyo_app/screens/auth/services/user_service.dart';
import 'package:grow_tokyo_app/screens/booking/model/booking_list_response.dart';
import 'package:grow_tokyo_app/screens/booking/model/booking_status_response.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_configuration_response.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_detail_response.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_gallery_list_response.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_response.dart';
import 'package:grow_tokyo_app/screens/category/model/category_response.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/blog_post_model.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/dashboard_model.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_detail_response.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_service_list_response.dart';
import 'package:grow_tokyo_app/screens/notifications/model/notification_model.dart';
import 'package:grow_tokyo_app/screens/order/model/order_detail_response.dart';
import 'package:grow_tokyo_app/screens/order/model/order_status_response.dart';
import 'package:grow_tokyo_app/screens/product/model/product_dashboard_response.dart';
import 'package:grow_tokyo_app/screens/product/model/product_list_response.dart';
import 'package:grow_tokyo_app/screens/profile/model/pages_response.dart';
import 'package:grow_tokyo_app/screens/profile/model/social_data.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_data.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/store/booking_request_store.dart';
import 'package:grow_tokyo_app/store/product_store.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/one_signal_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import 'app_theme.dart';
import 'configs.dart';
import 'locale/app_localizations.dart';
import 'locale/languages.dart';
import 'models/configuration_response.dart';
import 'models/review_data.dart';
import 'screens/splash_screen.dart';
import 'store/app_store.dart';
import 'store/user_store.dart';
import 'utils/common_base.dart';

//region APP STORE
AppStore appStore = AppStore();
UserStore userStore = UserStore();
BookingRequestStore bookingRequestStore = BookingRequestStore();
ProductStore productStore = ProductStore();
//endregion

//region FIREBASE AUTH
final FirebaseAuth auth = FirebaseAuth.instance;
//endregion

//region USER SERVICE
UserService userService = UserService();
AuthService authService = AuthService();
GoogleSignInAuthService googleSignInAuthService = GoogleSignInAuthService();
AppleLoginAuthService appleLoginAuthService = AppleLoginAuthService();
FacebookLoginAuthService facebookLoginAuthService = FacebookLoginAuthService();
//endregion

//region LANGUAGE
BaseLanguage locale = LanguageEn();
//endregion

//region Cached Responses
ConfigurationResponse? appConfigurationResponseCached;
DashboardResponse? dashboardResponseCached;
ProductDashboardResponse? productDashboardResponseCached;
List<BranchData>? branchListCached;
List<CategoryData>? categoryListCached;
List<CategoryData>? productCategoryListCached;
List<EmployeeData>? employeeListCached;
List<BookingStatusData>? bookingStatusListCached;
List<OrderStatusData>? orderStatusListCached;
List<ReviewData>? branchReviewListResponseCached;
List<EmployeeData>? branchStaffListResponseCached;
List<BranchGalleryData>? branchGalleryListResponseCached;
List<ServiceListData>? branchServiceListResponseCached;
List<NotificationData>? notificationListCached;
List<ProductData>? getWishListCached;
List<BookingListData> bookingDetailCached = [];
List<OrderListData> orderDetailCached = [];
List<(int serviceId, EmployeeDetailResponse list)?> employeeDetailCachedData =
    [];
List<BranchDetailResponse> branchDetailCachedData = [];
BranchConfigurationData? branchConfigurationCached;
List<CouponData>? couponListCached;
ReferralData? referralDataCached;
Map<int, List<EmployeeServiceListData>>? employeeServiceListCached;
Map<int, List<EmployeeData>>? branchEmployeeListCached;
Map<int, List<EmployeeWorkingDayModel>>? employeeWorkingDayListCached;
List<PageModel>? pageListCached;
SocialData? socialDataCached;
List<BlogPostModel>? blogPostListCached;

//endregion

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;

  passwordLengthGlobal = 8;
  textBoldSizeGlobal = 14;
  textPrimarySizeGlobal = 14;
  textSecondarySizeGlobal = 12;

  await initialize(aLocaleLanguageList: languageList());

  await appStore.setLanguage(
      getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: DEFAULT_LANGUAGE));
  locale = await const AppLocalizations()
      .load(Locale(appStore.selectedLanguageCode));

  if (isMobile) {
    Firebase.initializeApp().then((value) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    });
  }

  appStore.setLoggedIn(getBoolAsync(SharedPreferenceConst.IS_LOGGED_IN),
      isInitializing: true);
  appStore.setCountryId(
      getIntAsync(SharedPreferenceConst.COUNTRY_ID,
          defaultValue: UNSELECTED_COUNTRY_ID),
      isInitializing: true);
  appStore.setCountryCode(
      getStringAsync(SharedPreferenceConst.COUNTRY_CODE, defaultValue: 'vn'),
      isInitializing: true);
  await appStore.setBranchId(
      getIntAsync(SharedPreferenceConst.BRANCH_ID,
          defaultValue: UNSELECTED_BRANCH_ID),
      isInitializing: true);
  await appStore.setBranchName(
      getStringAsync(SharedPreferenceConst.BRANCH_NAME),
      isInitializing: true);
  await appStore.setBranchAnyStylistOptions(
      getStringListAsync(SharedPreferenceConst.BRANCH_ANY_STYLIST_OPTIONS) ??
          [],
      isInitializing: true);
  if (appStore.isLoggedIn) {
    await userStore.setUserId(getIntAsync(SharedPreferenceConst.USER_ID),
        isInitializing: true);
    await userStore.setFirstName(
        getStringAsync(SharedPreferenceConst.FIRST_NAME),
        isInitializing: true);
    await userStore.setLastName(getStringAsync(SharedPreferenceConst.LAST_NAME),
        isInitializing: true);
    await userStore.setDob(getStringAsync(SharedPreferenceConst.DOB),
        isInitializing: true);
    await userStore.setNationality(
        getStringAsync(SharedPreferenceConst.NATIONALITY),
        isInitializing: true);
    await userStore.setUserEmail(
        getStringAsync(SharedPreferenceConst.USER_EMAIL),
        isInitializing: true);
    await userStore.setToken(getStringAsync(SharedPreferenceConst.TOKEN),
        isInitializing: true);
    await userStore.setUserProfile(getStringAsync(SharedPreferenceConst.AVTAR),
        isInitializing: true);
    await userStore.setLoginType(
        getStringAsync(SharedPreferenceConst.LOGIN_TYPE),
        isInitializing: true);
    await userStore.setContactNumber(
        getStringAsync(SharedPreferenceConst.CONTACT_NUMBER),
        isInitializing: true);
    await userStore.setPlayerId(getStringAsync(SharedPreferenceConst.PLAYER_ID),
        isInitializing: true);
    await userStore.setPointAmount(getDoubleAsync(SharedPreferenceConst.CREDIT),
        isInitializing: true);
    await appStore.setHelplineNumber(
        getStringAsync(SharedPreferenceConst.HELPLINE_NUMBER),
        isInitializing: true);
    await appStore.setInquiryEmail(
        getStringAsync(SharedPreferenceConst.INQUIRY_EMAIL),
        isInitializing: true);
    await appStore.setPrivacyPolicy(
        getStringAsync(SharedPreferenceConst.PRIVACY_POLICY),
        isInitializing: true);
    await appStore.setTermConditions(
        getStringAsync(SharedPreferenceConst.TERM_CONDITIONS),
        isInitializing: true);
  }

  if (!kIsWeb) initOneSignal();

  final runnableApp =
      _buildRunnableApp(isWeb: kIsWeb, webAppWidth: 428, app: const MyApp());

  runApp(runnableApp);
}

Widget _buildRunnableApp(
    {required bool isWeb, required double webAppWidth, required Widget app}) {
  if (!isWeb) return app;

  return LayoutBuilder(builder: (context, constraints) {
    if (constraints.maxWidth < webAppWidth) return app;
    return Center(
      child: ClipRect(child: SizedBox(width: webAppWidth, child: app)),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: Observer(
        builder: (_) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: const [
            AppLocalizations(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) =>
              Locale(appStore.selectedLanguageCode),
          locale: Locale(appStore.selectedLanguageCode),
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
