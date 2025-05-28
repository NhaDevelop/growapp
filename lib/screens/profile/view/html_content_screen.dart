import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';

class HtmlContentScreen extends StatelessWidget {
  final String title;
  final String htmlData;
  const HtmlContentScreen(
      {super.key, required this.title, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(data: htmlData),
      ),
    );
  }
}
