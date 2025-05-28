import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/slider_data.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class HorizontalSliderComponent extends StatefulWidget {
  final List<SliderData> sliderList;

  const HorizontalSliderComponent({super.key, required this.sliderList});

  @override
  State<HorizontalSliderComponent> createState() =>
      _HorizontalSliderComponentState();
}

class _HorizontalSliderComponentState extends State<HorizontalSliderComponent> {
  PageController controller = PageController(keepPage: true, initialPage: 0);
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    if (getBoolAsync(SharedPreferenceConst.AUTO_SLIDER_STATUS,
            defaultValue: true) &&
        widget.sliderList.length >= 2) {
      timer = Timer.periodic(
          const Duration(seconds: DASHBOARD_AUTO_SLIDER_SECOND), (Timer timer) {
        if (currentPage < widget.sliderList.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        controller.animateToPage(currentPage,
            duration: const Duration(milliseconds: 950),
            curve: Curves.easeOutQuart);
      });

      controller.addListener(() {
        currentPage = controller.page!.toInt();
      });
    }
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliderList.isEmpty) return const Offstage();

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultRadius),
            child: PageView.builder(
              controller: controller,
              reverse: false,
              itemCount: widget.sliderList.length,
              itemBuilder: (_, i) {
                SliderData data = widget.sliderList[i];

                return CachedImageWidget(
                        url: data.sliderImage.validate(),
                        height: 200,
                        width: context.width(),
                        fit: BoxFit.cover,
                        radius: defaultRadius)
                    .onTap(() {
                  final link = data.link.validate();
                  if (link.isNotEmpty) launchUrlString(link);
                  // if (data.type == SLIDER_TYPE_CATEGORY) {
                  //   ViewAllServiceScreen(
                  //           serviceTitle: data.name.validate(),
                  //           categoryId: data.linkId)
                  //       .launch(context);
                  // } else if (data.type == SLIDER_TYPE_SERVICE) {
                  //   ViewAllServiceScreen(serviceTitle: data.name.validate())
                  //       .launch(context);
                  // }
                });
              },
            ),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: DotIndicator(
              pageController: controller,
              pages: widget.sliderList,
              indicatorColor: indicatorColor,
              unselectedIndicatorColor: lightGray,
              currentDotSize: 10,
              dotSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
