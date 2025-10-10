import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/screens/debug/firebase_debug_screen.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/no_branch_error_widget.dart';
import '../main.dart';
import '../network/rest_apis.dart';
import '../utils/constants.dart';
import 'branch/branch_repository.dart';
import 'walkThrough/view/walk_through_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _tapCount = 0;
  
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: context.primaryColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    });

    await getBranchList(branchList: []).then((value) {
      if (value.isNotEmpty) {
        if (value.length == 1) {
          setBranchAndRedirectToDashboard(value.first);
        }
      }
    }).catchError((e) {
      /// When error occure in Branch List API
      push(NoBranchErrorWidget(errorMessage: e.toString()),
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    });

    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == ThemeConst.THEME_MODE_LIGHT) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == ThemeConst.THEME_MODE_DARK) {
      appStore.setDarkMode(true);
    }

    ///Set app configurations
    getAppConfigurations().then((value) {}).catchError((e) {
      log(e);
    });

    if (!mounted) return;
    if (getBoolAsync(SharedPreferenceConst.IS_FIRST_TIME, defaultValue: true)) {
      const WalkThroughScreen().launch(context, isNewTask: true);
    } else {
      const DashboardScreen().launch(context, isNewTask: true);
    }
  }

  void _onLogoTap() {
    _tapCount++;
    if (_tapCount >= 5) {
      // Reset counter
      _tapCount = 0;
      // Navigate to Firebase Debug Screen
      const FirebaseDebugScreen().launch(context);
      toast('🔍 Firebase Debug Screen opened!');
    } else {
      // Show hint after 3 taps
      if (_tapCount == 3) {
        toast('Tap ${5 - _tapCount} more times to open Firebase Debug');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: Padding(
          padding: EdgeInsets.all(context.width() * 0.2),
          child: GestureDetector(
            onTap: _onLogoTap,
            child: Image.asset(
              splash_screen_logo,
              fit: BoxFit.cover,
            ).center(),
          ),
        ),
      ),
    );
  }
}
