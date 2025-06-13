import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../auth_repository.dart';
import '../component/gender_selection_component.dart';

class EditProfileScreen extends StatefulWidget {
  final bool canPop;
  const EditProfileScreen({super.key, this.canPop = true});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UniqueKey genderKey = UniqueKey();

  File? imageFile;
  XFile? pickedFile;
  DateTime? dob;

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController genderCont = TextEditingController();
  TextEditingController dobCont = TextEditingController();
  TextEditingController nationalityCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode nationalityFocus = FocusNode();

  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });

    fNameCont.text = userStore.userFirstName.validate();
    lNameCont.text = userStore.userLastName.validate();
    emailCont.text = userStore.userEmail.validate();
    mobileCont.text = userStore.userContactNumber.validate();
    genderCont.text = userStore.gender.validate();
    dobCont.text = userStore.dob.validate();
    nationalityCont.text = userStore.nationality.validate();
    genderKey = UniqueKey();

    if (!widget.canPop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        toast(locale.pleaseUpdateYourProfile, length: Toast.LENGTH_LONG);
      });
    }
  }

  Future<void> update() async {
    hideKeyboard(context);
    appStore.setLoading(true);

    updateProfile(
      firstName: fNameCont.text,
      lastName: lNameCont.text,
      mobile: mobileCont.text,
      gender: genderCont.text,
      dob: dob == null
          ? ''
          : formatDate(dob.toString(), format: DateFormatConst.BE_DATE_FORMAT),
      nationality: selectedCountry?.countryCode.validate() ?? '',
      imageFile: imageFile,
      onSuccess: (data) {
        appStore.setLoading(false);
        if (data != null) {
          if ((data as String).isJson()) {
            viewProfile().then((value) {}).catchError(onError);

            finish(context);
          }
        }
      },
    ).then((data) {
      toast(locale.profileUpdatedSuccessfully);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 10);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 10);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.gallery,
              leading: Icon(Icons.image, color: context.iconColor),
              onTap: () async {
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.camera,
              leading: Icon(Icons.camera, color: context.iconColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  Future<void> changeCountry() async {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
          textStyle: secondaryTextStyle(color: textSecondaryColorGlobal)),
      onSelect: (Country country) {
        selectedCountry = country;
        nationalityCont.text = country.name;
        setState(() {});
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: SafeArea(
          child: Scaffold(
            appBar: commonAppBarWidget(
              context,
              title: locale.editProfile,
              appBarHeight: 70,
              showLeadingIcon: widget.canPop,
              roundCornerShape: true,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          child: Stack(
                            children: [
                              Container(
                                decoration: boxDecorationDefault(
                                  border: Border.all(
                                      color: context.scaffoldBackgroundColor,
                                      width: 4),
                                  shape: BoxShape.circle,
                                ),
                                child: imageFile != null
                                    ? Image.file(imageFile!,
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover)
                                        .cornerRadiusWithClipRRect(45)
                                    : Observer(
                                        builder: (_) => CachedImageWidget(
                                          url: userStore.userProfileImage,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          radius: 64,
                                          child:
                                              const DefaultUserImagePlaceholder(),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: boxDecorationWithRoundedCorners(
                                    boxShape: BoxShape.circle,
                                    backgroundColor: primaryColor,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Icon(Icons.camera,
                                          color: Colors.white, size: 16)
                                      .paddingAll(4.0),
                                ).onTap(
                                  () async {
                                    _showBottomSheet(context);
                                  },
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                ),
                              ).visible(!isLoginTypeGoogle && !isLoginTypeApple)
                            ],
                          ),
                        ),
                        24.height,
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: fNameCont,
                          focus: fNameFocus,
                          nextFocus: lNameFocus,
                          enabled: true,
                          textStyle: isSocialLoginType
                              ? secondaryTextStyle()
                              : primaryTextStyle(),
                          decoration:
                              inputDecoration(context, label: locale.firstName),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: lNameCont,
                          focus: lNameFocus,
                          nextFocus: dobFocus,
                          enabled: true,
                          textStyle: isSocialLoginType
                              ? secondaryTextStyle()
                              : primaryTextStyle(),
                          decoration:
                              inputDecoration(context, label: locale.lastName),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.NUMBER,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          controller: dobCont,
                          focus: dobFocus,
                          nextFocus: emailFocus,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                dob = value;
                                dobCont.text = formatDate(
                                  value.toString(),
                                  format: DateFormatConst.BOOK_DATE_FORMAT,
                                );
                              }
                            });
                          },
                          textStyle: isSocialLoginType
                              ? secondaryTextStyle()
                              : primaryTextStyle(),
                          decoration:
                              inputDecoration(context, label: locale.dob),
                        ),
                        16.height,
                        GenderSelectionComponent(
                          key: genderKey,
                          type: genderCont.text,
                          onTap: (value) {
                            genderCont.text = value;
                          },
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.EMAIL_ENHANCED,
                          controller: emailCont,
                          focus: emailFocus,
                          nextFocus: mobileFocus,
                          enabled: false,
                          textStyle: secondaryTextStyle(),
                          decoration:
                              inputDecoration(context, label: locale.email),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.PHONE,
                          controller: mobileCont,
                          focus: mobileFocus,
                          nextFocus: nationalityFocus,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          decoration: inputDecoration(context,
                              label: locale.contactNumber),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: nationalityCont,
                          focus: nationalityFocus,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          decoration: inputDecoration(context,
                              label: locale.nationality),
                          onTap: changeCountry,
                        ),
                        16.height,
                        AppButton(
                          text: locale.update,
                          height: 40,
                          color: secondaryColor,
                          textStyle: primaryTextStyle(color: white),
                          width: context.width() - context.navigationBarHeight,
                          onTap: () async {
                            final isFormValidate =
                                formKey.currentState?.validate() ?? false;
                            if (!isFormValidate) return;

                            if (await isNetworkAvailable()) {
                              update();
                            } else {
                              toast(locale.yourInternetIsNotWorking);
                            }
                          },
                        ),
                        24.height,
                      ],
                    ),
                  ),
                ),
                Observer(
                    builder: (_) =>
                        const LoaderWidget().visible(appStore.isLoading)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
