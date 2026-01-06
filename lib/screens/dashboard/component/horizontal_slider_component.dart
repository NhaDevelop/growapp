import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/slider_data.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:grow_tokyo_app/main.dart';

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
  List<SliderData> filteredSlides = [];

  @override
  void initState() {
    super.initState();

    // Initialize filtered slides
    _updateFilteredSlides();

    // Wait for the first frame to be rendered before starting the timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (getBoolAsync(SharedPreferenceConst.AUTO_SLIDER_STATUS,
              defaultValue: true) &&
          filteredSlides.length >= 2) {
        timer = Timer.periodic(
            const Duration(seconds: DASHBOARD_AUTO_SLIDER_SECOND),
            (Timer timer) {
          // Check if controller is attached before animating
          if (!controller.hasClients || !mounted) return;

          if (currentPage < filteredSlides.length - 1) {
            currentPage++;
          } else {
            currentPage = 0;
          }
          controller.animateToPage(currentPage,
              duration: const Duration(milliseconds: 950),
              curve: Curves.easeOutQuart);
        });

        controller.addListener(() {
          if (controller.hasClients) {
            currentPage = controller.page!.toInt();
          }
        });
      }
    });
  }

  void _updateFilteredSlides() {
    const vietnamSlideUrl =
        "https://cms.hairmake-grow.com/upload/slider/9/1749536216.jpg";

    if (appStore.countryId.toString().trim() == "238") {
      // Show ONLY the Vietnam slide
      filteredSlides = widget.sliderList.where((data) {
        final url = data.sliderImage.validate().trim().toLowerCase();
        return url == vietnamSlideUrl;
      }).toList();
    } else {
      // Show ALL slides EXCEPT the Vietnam slide
      filteredSlides = widget.sliderList.where((data) {
        final url = data.sliderImage.validate().trim().toLowerCase();
        return url != vietnamSlideUrl;
      }).toList();
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
    if (filteredSlides.isEmpty) return const Offstage();

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultRadius),
            child: PageView.builder(
              controller: controller,
              reverse: false,
              itemCount: filteredSlides.length,
              itemBuilder: (_, i) {
                final data = filteredSlides[i];
                return CachedImageWidget(
                  url: data.sliderImage.validate(),
                  height: 200,
                  width: context.width(),
                  fit: BoxFit.cover,
                  radius: defaultRadius,
                ).onTap(() {
                  final link = data.link.validate();
                  if (link.isNotEmpty) launchUrlString(link);
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
              pages: filteredSlides,
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
