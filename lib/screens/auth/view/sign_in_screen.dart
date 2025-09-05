import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/auth_repository.dart';
import 'package:grow_tokyo_app/screens/auth/view/edit_profile_screen.dart';
import 'package:grow_tokyo_app/screens/auth/view/forgot_password_screen.dart';
import 'package:grow_tokyo_app/screens/auth/view/sign_up_screen.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:grow_tokyo_app/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/back_widget.dart';
import '../../../network/network_utils.dart';

class SignInScreen extends StatefulWidget {
  final bool isRegeneratingToken;
  final bool? isFromDashboard;
  final bool? isFromServiceBooking;
  final bool returnExpected;

  const SignInScreen({
    super.key,
    this.returnExpected = false,
    this.isRegeneratingToken = false,
    this.isFromDashboard,
    this.isFromServiceBooking,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    isRemember =
        getBoolAsync(SharedPreferenceConst.IS_REMEMBERED, defaultValue: true);
    if (isRemember && !isLoginTypeGoogle && !isLoginTypeApple) {
      emailCont.text = getStringAsync(SharedPreferenceConst.USER_EMAIL);
      passwordCont.text = getStringAsync(SharedPreferenceConst.USER_PASSWORD);
    }
  }

  /// region SignInTapped
  Future<void> onSignIn() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      Map request = {
        CommonKey.email: emailCont.text.validate(),
        CommonKey.password: passwordCont.text.validate(),
        CommonKey.playerId: getStringAsync(SharedPreferenceConst.PLAYER_ID),
      };

      await loginUser(request).then((value) {
        userStore.setPlayerId(getStringAsync(SharedPreferenceConst.PLAYER_ID));
        if (isRemember) {
          setValue(SharedPreferenceConst.USER_EMAIL, emailCont.text);
          setValue(SharedPreferenceConst.USER_PASSWORD, passwordCont.text);
        }

        ///This method called for update onesignal playerId to database
        reGenerateToken();

        onLoginSuccessRedirection();
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });

      appStore.setLoading(false);
    }
  }

  void _editProfileIfMissingCriticalInfo(
      {required VoidCallback callback}) async {
    if (userStore.userContactNumber.isEmpty ||
        userStore.dob.isEmpty ||
        userStore.gender.isEmpty) {
      await const EditProfileScreen(canPop: false)
          .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    }

    callback();
  }

  void onLoginSuccessRedirection() {
    TextInput.finishAutofillContext();
    if (widget.isFromServiceBooking.validate() ||
        widget.isFromDashboard.validate() ||
        widget.returnExpected.validate()) {
      if (widget.isFromDashboard.validate()) {
        setStatusBarColor(context.primaryColor);
      }

      _editProfileIfMissingCriticalInfo(
        callback: () => finish(context, true),
      );
    } else {
      _editProfileIfMissingCriticalInfo(
        callback: () => const DashboardScreen().launch(context,
            isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade),
      );
    }
    appStore.setLoading(false);
  }

  void appleSign() async {
    appStore.setLoading(true);

    await authService.appleSignIn().then((value) async {
      appStore.setLoading(false);

      onLoginSuccessRedirection();
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void googleSignIn() async {
    appStore.setLoading(true);
    await googleSignInAuthService.signIn().then((value) async {
      /// Social Login Api
      await loginUser(value.toJson(), isSocialLogin: true).then((value) {
        if (isRemember) {
          setValue(SharedPreferenceConst.USER_EMAIL, emailCont.text);
          setValue(SharedPreferenceConst.USER_PASSWORD, passwordCont.text);
        }
        onLoginSuccessRedirection();
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      log(e);
      toast(e.toString(), print: true);
      appStore.setLoading(false);
    });
  }

  void facebookSignIn() async {
    appStore.setLoading(true);
    await facebookLoginAuthService.signIn().then((value) async {
      /// Social Login Api
      await loginUser(value.toJson(), isSocialLogin: true).then((value) {
        if (isRemember) {
          setValue(SharedPreferenceConst.USER_EMAIL, emailCont.text);
          setValue(SharedPreferenceConst.USER_PASSWORD, passwordCont.text);
        }
        onLoginSuccessRedirection();
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      log(e);
      toast(e.toString(), print: true);
      appStore.setLoading(false);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    color: context.primaryColor,
                    padding: EdgeInsets.only(
                      top: context.statusBarHeight + 16,
                      bottom: 46,
                    ),
                    child: Center(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Image.asset(
                          logo_long,
                          width: constraints.maxWidth * 0.4,
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    top: context.statusBarHeight + 16,
                    left: 8,
                    child: const BackWidget(),
                  ).visible(context.canPop),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(topLeft: 20, topRight: 20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        locale.welcomeBack,
                        style:
                            primaryTextStyle(size: 20, weight: FontWeight.w500),
                      ),
                      8.height,
                      Text(locale.pleaseLogin,
                          style: secondaryTextStyle(),
                          textAlign: TextAlign.center),
                      Column(
                        children: [
                          Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextField(
                                  controller: emailCont,
                                  focus: emailFocus,
                                  nextFocus: passwordFocus,
                                  textFieldType: TextFieldType.EMAIL,
                                  decoration: inputDecoration(context,
                                      label: locale.email),
                                  autoFillHints: const [AutofillHints.email],
                                  selectionControls:
                                      MaterialTextSelectionControls(),
                                ),
                                16.height,
                                AppTextField(
                                  controller: passwordCont,
                                  textFieldType: TextFieldType.PASSWORD,
                                  focus: passwordFocus,
                                  decoration: inputDecoration(context,
                                      label: locale.password),
                                  autoFillHints: const [AutofillHints.password],
                                  onFieldSubmitted: (s) {
                                    onSignIn();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              16.height,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RoundedCheckBox(
                                    borderColor: secondaryColor,
                                    checkedColor: secondaryColor,
                                    isChecked: isRemember,
                                    text: locale.rememberMe,
                                    textStyle: secondaryTextStyle(size: 11),
                                    size: 16,
                                    onTap: (value) async {
                                      await setValue(SharedPreferenceConst.IS_REMEMBERED, isRemember);
                                      isRemember = !isRemember;
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(width: 18), // space between checkbox and link
                                  Flexible(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(0, 0),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        showInDialog(
                                          context,
                                          contentPadding: EdgeInsets.zero,
                                          builder: (_) => const ForgotPasswordScreen(),
                                        );
                                      },
                                      child: Text(
                                        locale.forgotPassword,
                                        style: secondaryTextStyle(
                                          size: 11,
                                          color: appStore.isDarkMode ? territoryButtonColor : null,
                                          decoration: TextDecoration.underline,
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              8.height,
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: context.cardColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, size: 16, color: Colors.grey),
                                    8.width,
                                    Expanded(
                                      child: Text(
                                        locale.alreadyBookedNote,
                                        style: secondaryTextStyle(size: 11, color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          16.height,
                          AppButton(
                            width: context.width(),
                            color: secondaryColor,
                            onTap: () async {
                              onSignIn();
                            },
                            child: Text(locale.signIn,
                                style: boldTextStyle(color: white)),
                          ),
                          24.height,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Divider(color: context.dividerColor).expand(),
                                  8.width,
                                  Text(locale.or,
                                      style: boldTextStyle(
                                          color: textSecondaryColorGlobal)),
                                  8.width,
                                  Divider(color: context.dividerColor).expand(),
                                ],
                              ),
                              24.height,
                              AppButton(
                                color: context.cardColor,
                                padding: const EdgeInsets.all(16),
                                width: context.width() -
                                    context.navigationBarHeight,
                                onTap: googleSignIn,
                                elevation: 0,
                                shapeBorder: RoundedRectangleBorder(
                                  borderRadius: radius(10),
                                  side: const BorderSide(color: primaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(ic_login_google, width: 24),
                                    Text("${locale.signInWith} ${locale.google}",
                                            style: boldTextStyle(),
                                            textAlign: TextAlign.center)
                                        .expand(),
                                  ],
                                ),
                              ),
                              // 24.height,
                              // AppButton(
                              //   color: const Color(0xFF4267B2),
                              //   padding: const EdgeInsets.all(16),
                              //   elevation: 0,
                              //   width: context.width() -
                              //       context.navigationBarHeight,
                              //   onTap: facebookSignIn,
                              //   child: Row(
                              //     children: [
                              //       Image.asset(ic_login_facebook, width: 24),
                              //       Text("${locale.signInWith} ${locale.facebook}",
                              //               style: boldTextStyle(color: white),
                              //               textAlign: TextAlign.center)
                              //           .expand(),
                              //     ],
                              //   ),
                              // ),
                              24.height,
                              if (isIOS)
                                AppButton(
                                  color: primaryColor,
                                  padding: const EdgeInsets.all(16),
                                  elevation: 0,
                                  width: context.width() -
                                      context.navigationBarHeight,
                                  onTap: appleSign,
                                  child: Row(
                                    children: [
                                      Image.asset(ic_login_apple, width: 24),
                                      Text("${locale.signInWith} ${locale.apple}",
                                              style:
                                                  boldTextStyle(color: white),
                                              textAlign: TextAlign.center)
                                          .expand(),
                                    ],
                                  ),
                                ),
                              24.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(locale.notAMember,
                                      style: secondaryTextStyle()),
                                  TextButton(
                                    onPressed: () {
                                      hideKeyboard(context);
                                      const SignUpScreen().launch(context);
                                    },
                                    child: Text(
                                      locale.signUp,
                                      style: boldTextStyle(
                                          color: primaryColor,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 16),
                    ],
                  ).paddingTop(24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
