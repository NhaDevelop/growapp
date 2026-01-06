import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/dashboard_repository.dart';
import 'package:grow_tokyo_app/screens/profile/model/social_data.dart';
import 'package:grow_tokyo_app/screens/profile/shimmer/social_media_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  Future<SocialData>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    future = getSocialUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.socialMedia),
      body: SnapHelperWidget(
        future: future,
        initialData: socialDataCached,
        loadingWidget: const SocialMediaShimmer(),
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            retryText: locale.reload,
            imageWidget: const ErrorStateWidget(),
            onRetry: () {
              init();
              setState(() {});
            },
          );
        },
        onSuccess: (snap) {
          return AnimatedScrollView(
            padding: const EdgeInsets.all(16),
            children: [
              SettingItemWidget(
                leading:
                    Image.asset(ic_facebook_colored, height: 16, width: 16),
                title: locale.facebook,
                splashColor: Colors.transparent,
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor),
                onTap: () {
                  // Use VN Facebook link if country is Vietnam
                  String url = appStore.countryCode.toLowerCase() == 'vn'
                      ? snap.facebookVnLink
                      : snap.facebookLink;
                  commonLaunchUrl(url,
                      launchMode: LaunchMode.externalApplication);
                },
              ),
              if (snap.instagramLink.validate().isNotEmpty &&
                  snap.instagramLink != '#') ...[
                16.height,
                SettingItemWidget(
                  leading:
                      Image.asset(ic_instagram_colored, height: 16, width: 16),
                  title: locale.instagram,
                  splashColor: Colors.transparent,
                  decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: context.cardColor),
                  onTap: () {
                    // Use VN Instagram link if country is Vietnam
                    String url = appStore.countryCode.toLowerCase() == 'vn'
                        ? snap.instagramVnLink
                        : snap.instagramLink;
                    commonLaunchUrl(url,
                        launchMode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
