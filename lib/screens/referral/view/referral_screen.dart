import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/back_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/common_app_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_appbar_component.dart';
import 'package:grow_tokyo_app/screens/referral/component/referral_code_details.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: CommonAppComponent(
        innerWidget: DashboardAppBarComponent(
          innerChild: appBarWidget(
            locale.referral,
            center: true,
            color: context.primaryColor,
            textColor: white,
            backWidget: const BackWidget(),
          ),
        ),
        subWidget: Transform.translate(
          offset: const Offset(0, -20),
          child: const ReferralCodeDetails(),
        ),
      ),
    );
  }
}
