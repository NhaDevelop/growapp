import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/generated/assets.dart';
import 'package:nb_utils/nb_utils.dart';

class VoiceSearchComponent extends StatefulWidget {
  const VoiceSearchComponent({super.key});

  @override
  VoiceSearchComponentState createState() => VoiceSearchComponentState();
}

class VoiceSearchComponentState extends State<VoiceSearchComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.cardColor,
      width: context.width(),
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.volumnGif,
              fit: BoxFit.cover, height: 60, width: 120),
        ],
      ),
    );
  }
}
