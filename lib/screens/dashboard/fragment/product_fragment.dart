import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/loader_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsFragment extends StatelessWidget {
  ProductsFragment({super.key});

  final InAppWebViewKeepAlive webViewKeepAlive = InAppWebViewKeepAlive();

  String get languageCodePath =>
      appStore.selectedLanguageCode == 'vi' && appStore.countryCode == 'vn'
          ? "/${appStore.selectedLanguageCode}"
          : '';

  Uri get productUri => Uri.https(BuildConfig.getBlogHost(appStore.countryCode),
      "$languageCodePath/product");

  Future<void> _loadPage(InAppWebViewController webViewController) async {
    final url = await webViewController.getUrl();
    if (url?.toString() == productUri.toString()) return;
    if (url == null || url.pathSegments.isEmpty) {
      return webViewController.loadUrl(
          urlRequest: URLRequest(url: WebUri.uri(productUri)));
    }
    // case when the user changes the language or country in the app
    final String urlCountryCode = url.pathSegments.first;
    bool sameLanguage = false;
    if (url.pathSegments.contains(appStore.selectedLanguageCode) &&
        appStore.selectedLanguageCode == 'vi') {
      sameLanguage = true;
    }
    if (!url.pathSegments.contains('vi') &&
        appStore.selectedLanguageCode != 'vi') {
      sameLanguage = true;
    }
    if (urlCountryCode == appStore.countryCode && sameLanguage) return;
    return webViewController.loadUrl(
        urlRequest: URLRequest(url: WebUri.uri(productUri)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Column(
              children: [
                _buildHeader(context),
              ],
            ),
            Expanded(
              child: _buildWebView(),
            ),
          ],
        ),
        Observer(builder: (context) {
          return const LoaderWidget().visible(appStore.isLoading);
        })
      ],
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      keepAlive: webViewKeepAlive,
      onLoadStop: (controller, _) async {
        appStore.setLoading(false);
        await controller.evaluateJavascript(
            source: WEBVIEW_HEADER_FOOTER_REMOVAL_SCRIPT);
      },
      onLoadStart: (_, __) {
        appStore.setLoading(true);
      },
      onWebViewCreated: _loadPage,
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        final url = await controller.getUrl();
        final deepLink = navigationAction.request.url;
        if (deepLink != null &&
            url != navigationAction.request.url &&
            (deepLink.scheme != 'https' && deepLink.scheme != 'http')) {
          try {
            await launchUrl(deepLink,
                mode: LaunchMode.externalNonBrowserApplication);
          } catch (_) {}
          return NavigationActionPolicy.CANCEL;
        }

        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
        backgroundColor: context.primaryColor,
      ),
      child: Column(
        children: [
          Text(
            locale.shop,
            style: boldTextStyle(color: white, size: APPBAR_TEXT_SIZE),
            textAlign: TextAlign.center,
          ).paddingTop(50),
          24.height,
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
