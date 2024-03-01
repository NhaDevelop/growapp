import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

class BlogComponent extends StatelessWidget {
  const BlogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              locale.blog,
              style: boldTextStyle(size: 16),
            ).expand(),
            TextButton(
              onPressed: () {},
              child: Text(
                locale.viewAll,
                style: primaryTextStyle(
                  size: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20),
        8.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _Item(
                key: UniqueKey(),
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'https://via.placeholder.com/150',
              ),
              _Item(
                key: UniqueKey(),
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'https://via.placeholder.com/150',
              ),
              _Item(
                key: UniqueKey(),
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'https://via.placeholder.com/150',
              ),
              _Item(
                key: UniqueKey(),
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'https://via.placeholder.com/150',
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 270,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(url: image, height: 160, width: double.infinity),
            Text(text, style: primaryTextStyle()).paddingAll(16),
          ],
        ),
      ),
    ).paddingOnly(right: 16);
  }
}
