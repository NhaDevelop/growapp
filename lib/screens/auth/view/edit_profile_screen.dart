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
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_response.dart';
import '../../branch/model/branch_detail_response.dart';

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
  TextEditingController branchCont = TextEditingController(); // Added branch controller

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode nationalityFocus = FocusNode();
  FocusNode branchFocus = FocusNode(); // Added branch focus node

  Country? selectedCountry;
  String? selectedBranch;
  int? selectedBranchId; // Added to store branch ID
  List<BranchData> branchList = []; // Changed from fixed list to dynamic list
  bool isLoadingBranches = false; // Added loading state for branches

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

    // Load saved branch data
    selectedBranchId = getIntAsync('selected_branch_id');
    selectedBranch = getStringAsync('selected_branch_name');
    branchCont.text = selectedBranch ?? '';

    if (selectedBranchId != null) {
      try {
        BranchDetailResponse branchDetail = await getBranchDetail(selectedBranchId!);
        if (branchDetail.data != null) {
          selectedBranch = branchDetail.data!.name.validate();
          branchCont.text = selectedBranch ?? '';
          setValue('selected_branch_name', selectedBranch);
        }
      } catch (e) {
        print('Failed to get branch detail: $e');
      }
    }

    print('Loaded branch data: ID=$selectedBranchId, Name=$selectedBranch'); // Debug

    genderKey = UniqueKey();

    // Load branches from API
    await loadBranches();

    if (!widget.canPop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        toast(locale.pleaseUpdateYourProfile, length: Toast.LENGTH_LONG);
      });
    }
  }

  // Added method to load branches from API
  Future<void> loadBranches() async {
    try {
      setState(() {
        isLoadingBranches = true;
      });

      List<BranchData> branches = await getBranchList(
        branchList: [],
        lastPageCallBack: (isLastPage) {},
      );

      setState(() {
        branchList = branches;
        isLoadingBranches = false;

        // If we have a saved branch ID, make sure it's still valid in current branch list
        if (selectedBranchId != null) {
          BranchData? foundBranch;
          try {
            foundBranch = branches.firstWhere(
                  (branch) => branch.id == selectedBranchId,
            );
          } catch (e) {
            foundBranch = null;
          }

          if (foundBranch != null) {
            selectedBranch = foundBranch.name.validate();
            branchCont.text = selectedBranch ?? '';
          }
        }
      });
    } catch (e) {
      setState(() {
        isLoadingBranches = false;
      });
      toast('Failed to load branches: ${e.toString()}');
    }
  }

  Future<void> update() async {
    hideKeyboard(context);
    appStore.setLoading(true);

    print('Sending branchId to API: $selectedBranchId'); // Debug line

    updateProfile(
      firstName: fNameCont.text,
      lastName: lNameCont.text,
      email: emailCont.text,
      mobile: mobileCont.text,
      gender: genderCont.text,
      dob: dob == null
          ? ''
          : formatDate(dob.toString(), format: DateFormatConst.BE_DATE_FORMAT),
      nationality: selectedCountry?.countryCode.validate() ?? '',
      branchId: selectedBranchId,
      imageFile: imageFile,
      onSuccess: (data) async {
        appStore.setLoading(false);

        // Save branch data locally if selected
        if (selectedBranchId != null && selectedBranch != null) {
          setValue('selected_branch_id', selectedBranchId);
          setValue('selected_branch_name', selectedBranch);

          // Update global app store with new branch
          appStore.setBranchId(selectedBranchId!);
        }

        // Refresh user profile data and wait for it to complete
        try {
          await viewProfile();

          // After profile refresh, just keep our selected branch data
          // The backend update was successful, so keep what user selected
          setState(() {
            branchCont.text = selectedBranch ?? '';
          });

          print('Profile refreshed, keeping selected branch: ID=$selectedBranchId, Name=$selectedBranch');

        } catch (e) {
          print('Error refreshing profile: $e');
          // If profile refresh fails, just keep the selected branch data
          setState(() {
            branchCont.text = selectedBranch ?? '';
          });
        }

        // Show success message
        toast(locale.profileUpdatedSuccessfully);

        // Always close page after first successful update
        if (widget.canPop) {
          finish(context);
        } else {
          // Force close even when canPop is false (first-time update)
          Navigator.of(context).pop(true);
        }
      },
    ).catchError((e) {
      print('Update error: $e'); // Debug line
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

        // Clear branch selection when country changes
        selectedBranch = null;
        selectedBranchId = null;
        branchCont.text = '';

        // Remove saved branch data since country changed
        removeKey('selected_branch_id');
        removeKey('selected_branch_name');

        print('Country changed, clearing branch selection'); // Debug

        setState(() {});

        // Reload branches for new country
        loadBranches();
      },
    );
  }

  // Updated branch selection method with proper loading handling
  Future<void> showBranchSelector() async {
    // Show loading dialog first if branches are still loading
    if (isLoadingBranches || branchList.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  16.height,
                  Text(
                    'Loading branches...',
                    style: primaryTextStyle(),
                  ),
                ],
              ),
            ),
          );
        },
      );

      // Wait for branches to load
      await loadBranches();

      // Close loading dialog
      Navigator.of(context).pop();

      // Check if branches loaded successfully
      if (branchList.isEmpty) {
        toast('No branches available for your country');
        return;
      }
    }

    // Show branch selection bottom sheet
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Branch',
                style: primaryTextStyle(size: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 1),
            ...branchList.map((branch) {
              return ListTile(
                title: Text(
                  branch.name.validate(),
                  style: primaryTextStyle(),
                ),
                subtitle: branch.addressLine1.validate().isNotEmpty
                    ? Text(
                  branch.addressLine1.validate(),
                  style: secondaryTextStyle(),
                )
                    : null,
                onTap: () {
                  print('Selected branch: ${branch.name.validate()} (ID: ${branch.id})');

                  selectedBranch = branch.name.validate();
                  selectedBranchId = branch.id;
                  branchCont.text = branch.name.validate();

                  // Save immediately when selected
                  setValue('selected_branch_id', selectedBranchId ?? 0);
                  setValue('selected_branch_name', selectedBranch ?? '');

                  print('Saved branch data: ID=$selectedBranchId, Name=$selectedBranch');

                  Navigator.pop(context);
                  setState(() {});
                },
                trailing: selectedBranchId == branch.id
                    ? Icon(Icons.check, color: primaryColor)
                    : null,
              );
            }),
            16.height,
          ],
        );
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
                          nextFocus: emailFocus,
                          enabled: true,
                          textStyle: isSocialLoginType
                              ? secondaryTextStyle()
                              : primaryTextStyle(),
                          decoration:
                          inputDecoration(context, label: locale.lastName),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.EMAIL_ENHANCED,
                          controller: emailCont,
                          focus: emailFocus,
                          nextFocus: dobFocus,
                          enabled: true,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          textStyle: primaryTextStyle(),
                          decoration:
                          inputDecoration(context, label: locale.email),
                        ),
                        16.height,
                        AppTextField(
                          textFieldType: TextFieldType.NUMBER,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          controller: dobCont,
                          focus: dobFocus,
                          nextFocus: mobileFocus,
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
                          nextFocus: branchFocus, // Updated next focus
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          decoration: inputDecoration(context,
                              label: locale.nationality),
                          onTap: changeCountry,
                        ),
                        16.height,
                        // Added Branch Selection Field
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: branchCont,
                          focus: branchFocus,
                          readOnly: true,
                          errorThisFieldRequired: locale.thisFieldIsRequired,
                          decoration: inputDecoration(context,
                              label: 'Select Branch', // Add this to locale
                              suffixIcon: const Icon(Icons.arrow_drop_down)),
                          onTap: showBranchSelector,
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