import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/loader_widget.dart';
import '../main.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      height: context.height(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Observer(builder: (_) => const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
