import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/auth_repository.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../utils/colors.dart';
import '../component/gender_selection_component.dart';
import '../model/user_data_model.dart';

class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  final bool isOTPLogin;
  final String? uid;

  const SignUpScreen(
      {super.key,
      this.phoneNumber,
      this.isOTPLogin = false,
      this.countryCode,
      this.uid});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();

  String? genderValue;

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    //
  }

  /// region Register with OTP

  Future<void> registerWithOTP() async {
    hideKeyboard(context);
    if (appStore.isLoading) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appStore.setLoading(true);

      UserData userResponse = UserData()
        ..username = widget.phoneNumber.validate().trim()
        ..loginType = LoginTypeConst.LOGIN_TYPE_OTP
        ..email = emailCont.text.trim()
        ..userType = LoginTypeConst.LOGIN_TYPE_USER
        ..password = widget.phoneNumber.validate().trim();

      await createUser(userResponse.toJson()).then((register) async {});

      appStore.setLoading(false);
      return;
    }
  }

  /// endregion

  /// region Register User
  void registerUser() async {
    hideKeyboard(context);

    if (appStore.isLoading) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      /// Create a temporary request to send
      UserData tempRegisterData = UserData()
        // ..userType = LoginTypeConst.LOGIN_TYPE_USER
        ..firstName = firstNameCont.text.trim()
        ..lastName = lastNameCont.text.trim()
        ..email = emailCont.text.trim()
        ..password = passwordCont.text.trim()
        ..mobile = mobileCont.text.trim()
        ..gender = genderValue.validate().toLowerCase();

      await createUser(tempRegisterData.toJson())
          .then((registerResponse) async {
        appStore.setLoading(false);
        toast(registerResponse.message.validate());

        finish(context);
      }).catchError((e) {
        appStore.setLoading(false);

        toast(e.toString());
      });
    }
  }

  /// endregion

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Container(
        color: white,
        height: context.height(),
        width: context.width(),
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            children: [
              Container(
                width: context.width(),
                color: context.primaryColor,
                padding: EdgeInsets.only(
                  top: context.statusBarHeight + 16,
                  bottom: 46,
                ),
                child: Center(
                  child: Image.asset(
                    logo_long,
                    width: context.width() * 0.4,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(topLeft: 20, topRight: 20),
                  ),
                  child: Column(
                    children: [
                      Text(locale.welcomeToGrowTokyo,
                          style: boldTextStyle(size: 20)),
                      8.height,
                      Text(locale.createYourAccountFor,
                          style: secondaryTextStyle(),
                          textAlign: TextAlign.center),
                      Column(
                        children: [
                          16.height,
                          Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextField(
                                  controller: firstNameCont,
                                  focus: firstNameFocus,
                                  nextFocus: lastNameFocus,
                                  textFieldType: TextFieldType.NAME,
                                  readOnly: widget.isOTPLogin.validate()
                                      ? widget.isOTPLogin
                                      : false,
                                  decoration: inputDecoration(context,
                                      label: locale.firstName),
                                ),
                                16.height,
                                AppTextField(
                                  controller: lastNameCont,
                                  focus: lastNameFocus,
                                  nextFocus: emailFocus,
                                  textFieldType: TextFieldType.NAME,
                                  readOnly: widget.isOTPLogin.validate()
                                      ? widget.isOTPLogin
                                      : false,
                                  decoration: inputDecoration(context,
                                      label: locale.lastName),
                                ),
                                16.height,
                                AppTextField(
                                  controller: emailCont,
                                  focus: emailFocus,
                                  nextFocus: passwordFocus,
                                  textFieldType: TextFieldType.EMAIL,
                                  decoration: inputDecoration(context,
                                      label: locale.email),
                                ),
                                16.height,
                                AppTextField(
                                  controller: passwordCont,
                                  textFieldType: TextFieldType.PASSWORD,
                                  focus: passwordFocus,
                                  nextFocus: mobileFocus,
                                  readOnly: widget.isOTPLogin.validate()
                                      ? widget.isOTPLogin
                                      : false,
                                  decoration: inputDecoration(context,
                                      label: locale.password),
                                  autoFillHints: const [AutofillHints.password],
                                  onFieldSubmitted: (s) {
                                    if (widget.isOTPLogin) {
                                      registerWithOTP();
                                    } else {
                                      registerUser();
                                    }
                                  },
                                ),
                                16.height,
                                GenderSelectionComponent(
                                  onTap: (value) {
                                    genderValue = value;
                                    setState(() {});
                                  },
                                ),
                                16.height,
                                AppTextField(
                                  textFieldType: TextFieldType.PHONE,
                                  controller: mobileCont,
                                  focus: mobileFocus,
                                  errorThisFieldRequired:
                                      locale.thisFieldIsRequired,
                                  decoration: inputDecoration(context,
                                      label: locale.contactNumber),
                                  maxLength: 15,
                                ),
                                16.height,
                              ],
                            ),
                          ),
                          16.height,
                          AppButton(
                            width: context.width(),
                            color: secondaryColor,
                            onTap: () async {
                              if (widget.isOTPLogin) {
                                registerWithOTP();
                              } else {
                                registerUser();
                              }
                            },
                            child: Text(locale.signUp,
                                style: boldTextStyle(color: white)),
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(locale.alreadyHaveAnAccount,
                                  style: secondaryTextStyle()),
                              TextButton(
                                onPressed: () {
                                  hideKeyboard(context);
                                  finish(context);
                                },
                                child: Text(
                                  locale.signIn,
                                  style: boldTextStyle(
                                      color: primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: RichTextWidget(list: [
                              TextSpan(
                                text: locale.bySigningUpYouAgreeToOur,
                                style: secondaryTextStyle(),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: locale.termsConditions,
                                style: boldTextStyle(color: primaryColor),
                              ),
                            ]),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 16),
                    ],
                  ).paddingOnly(top: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
