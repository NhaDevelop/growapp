import 'package:grow_tokyo_app/configs.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../model/walk_through_model.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<WalkThroughModel> pages = [];

  int currentPosition = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });
    pages.add(WalkThroughModel(
        title: locale.bookAndManageYourBookings,
        subTitle: locale.walkThrough1subTitle,
        img: walk_img1));
    pages.add(WalkThroughModel(
        title: locale.getCouponForDiscount,
        subTitle: locale.walkThrough2subTitle,
        img: walk_img2));
    pages.add(WalkThroughModel(
        title: locale.earnPointsByCompletingServices,
        subTitle: '${locale.walkThrough3subTitle} $APP_NAME',
        img: walk_img3));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: context.width(),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: primaryColor,
                borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                decorationImage: const DecorationImage(
                    image: AssetImage(bg_pattern), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                24.height,
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(logo_long, height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await setValue(
                                SharedPreferenceConst.IS_FIRST_TIME, false);

                            if (!context.mounted) return;
                            const DashboardScreen().launch(
                              context,
                              isNewTask: true,
                              pageRouteAnimation: PageRouteAnimation.Fade,
                            );
                          },
                          child: Text(locale.skip,
                              style: boldTextStyle(color: white)),
                        ),
                      ],
                    ),
                  ],
                ),
                8.height,
                SizedBox(
                  height: context.height() * 0.5,
                  width: context.width(),
                  child: PageView(
                    controller: pageController,
                    children: pages.map((e) {
                      return Image.asset(pages[currentPosition].img.validate(),
                              height: context.height() * 0.5, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(defaultRadius)
                          .paddingSymmetric(horizontal: 16);
                    }).toList(),
                    onPageChanged: (i) {
                      currentPosition = i;
                      setState(() {});
                    },
                  ),
                ),
                38.height,
                Text(pages[currentPosition].title.validate(),
                        style: boldTextStyle(size: LABEL_TEXT_SIZE))
                    .paddingSymmetric(horizontal: 16),
                16.height,
                Text(pages[currentPosition].subTitle.validate(),
                        style: secondaryTextStyle(),
                        textAlign: TextAlign.center)
                    .paddingSymmetric(horizontal: 16),
                24.height,
                AppButton(
                  width: 230,
                  elevation: 0,
                  color: secondaryColor,
                  onTap: () async {
                    if (currentPosition == 2) {
                      await setValue(
                          SharedPreferenceConst.IS_FIRST_TIME, false);
                      if (!context.mounted) return;
                      const DashboardScreen().launch(
                        context,
                        isNewTask: true,
                        pageRouteAnimation: PageRouteAnimation.Fade,
                      );
                    } else {
                      pageController.nextPage(
                          duration: 500.milliseconds,
                          curve: Curves.linearToEaseOut);
                    }
                  },
                  child: Text(
                      currentPosition == 2 ? locale.getStarted : locale.next,
                      style: boldTextStyle(color: white)),
                ),
                16.height,
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Column(
          children: [
            DotIndicator(
              pageController: pageController,
              pages: pages,
              indicatorColor: indicatorColor,
              unselectedIndicatorColor: lightGray,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.circle,
              currentDotSize: 26,
              currentDotWidth: 6,
              dotSize: 6,
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
