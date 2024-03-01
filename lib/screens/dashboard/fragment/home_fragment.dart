import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/loader_widget.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/blog_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/common_app_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_appbar_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_menu_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/horizontal_slider_component.dart';
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
  UniqueKey keyForBranchList = UniqueKey();
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
      }
    });
  }

  void init() async {
    future = userDashboard(branchId: appStore.branchId);

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
                  keyForBranchList = UniqueKey();
                  setState(() {});
                },
              );
            },
            loadingWidget: const DashboardShimmer(),
            onSuccess: (snap) {
              return CommonAppComponent(
                innerWidget: DashboardAppBarComponent(
                  hintText: locale.searchForServices,
                  positionWidgetHeight: 200,
                  positionWidget: HorizontalSliderComponent(
                    sliderList: snap.data!.sliderData.validate(),
                  ),
                  positionBottom: -145,
                ),
                mainWidgetHeight: 190,
                onSwipeRefresh: () async {
                  init();
                  keyForBranchList = UniqueKey();
                  setState(() {});

                  return await 2.seconds.delay;
                },
                subWidget: Column(
                  children: [
                    AppButton(
                      color: context.primaryColor,
                      textColor: white,
                      onTap: () {},
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
                    const DashboardMenuComponent()
                        .paddingSymmetric(horizontal: 20),
                    16.height,
                    const BlogComponent(),
                  ],
                )
                    .paddingOnly(top: context.statusBarHeight + 150)
                    .withWidth(context.width()),
              );
            },
          ),
          Observer(
              builder: (context) =>
                  const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
