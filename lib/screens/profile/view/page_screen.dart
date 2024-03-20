import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grow_tokyo_app/screens/profile/model/pages_response.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';

class PageScreen extends StatelessWidget {
  final PageModel data;
  const PageScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: data.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(data: data.description),
      ),
    );
  }
}
