import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/loader_widget.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/screens/branch/view/select_branch_screen.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/common_app_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_appbar_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_menu_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/horizontal_blog_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/horizontal_slider_component.dart';
import 'package:grow_tokyo_app/screens/points/point_repository.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../auth/auth_repository.dart';
import '../dashboard_repository.dart';
import '../models/dashboard_model.dart';
import '../shimmer/dashboard_shimmer.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  Future<DashboardResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });

    1.seconds.delay.then((value) {
      if (appStore.isLoggedIn) {
        viewProfile().then((value) {
          //
        }).catchError(onError);
        getPointsAPI().then((value) {
          //
        }).catchError(onError);
      }
    });
  }

  void init() async {
    future = userDashboard();

    if (appConfigurationResponseCached == null) {
      getAppConfigurations();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        children: [
          SnapHelperWidget<DashboardResponse>(
            future: future,
            initialData: dashboardResponseCached,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              );
            },
            loadingWidget: const DashboardShimmer(),
            onSuccess: (snap) {
              return CommonAppComponent(
                innerWidget: const DashboardAppBarComponent(),
                onSwipeRefresh: () async {
                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
                subWidget: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: white,
                          borderRadius: radius(20),
                        ),
                        height: (snap.data?.sliderData ?? []).isEmpty ? 20 : 200,
                        child: HorizontalSliderComponent(
                          sliderList: snap.data!.sliderData.validate(),
                        ),
                      ),
                      24.height,
                      AppButton(
                        color: context.primaryColor,
                        textColor: white,
                        onTap: () {
                          const SelectBranchScreen(isFromDashboard: true).launch(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(calendar_add, height: 24, width: 24),
                            8.width,
                            Text(
                              locale.bookAppointment,
                              style: boldTextStyle(size: 16, color: white),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 20),
                      24.height,
                      DashboardMenuComponent(key: UniqueKey()).paddingSymmetric(horizontal: 20),
                      16.height,
                      HorizontalBlogComponent(key: UniqueKey()),
                    ],
                  ),
                ),
              );
            },
          ),
          Observer(builder: (context) => const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
