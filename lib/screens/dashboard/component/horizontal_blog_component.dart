import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/blog_repository.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/blog_post_model.dart';
import 'package:grow_tokyo_app/screens/dashboard/shimmer/blog_component_shimmer.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/blog_post_list_screen.dart';
import 'package:grow_tokyo_app/screens/profile/view/html_content_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class HorizontalBlogComponent extends StatefulWidget {
  const HorizontalBlogComponent({super.key});

  @override
  State<HorizontalBlogComponent> createState() =>
      _HorizontalBlogComponentState();
}

class _HorizontalBlogComponentState extends State<HorizontalBlogComponent> {
  Future<List<BlogPostModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    future = getBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget(
      future: future,
      initialData: blogPostListCached,
      loadingWidget: const BlogComponentShimmer().paddingAll(16),
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
      onSuccess: (list) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  locale.blog,
                  style: boldTextStyle(size: 16),
                ).expand(),
                TextButton(
                  onPressed: () => const BlogPostListScreen().launch(context),
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
              child: IntrinsicHeight(
                child: Row(
                  children: list
                      .map((e) => BlogItemComponent(post: e, width: 270)
                          .paddingOnly(right: 16))
                      .toList(),
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BlogItemComponent extends StatelessWidget {
  final BlogPostModel post;
  final double? width;
  const BlogItemComponent({super.key, required this.post, this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(
                url: post.featuredImageUrl,
                height: 160,
                width: double.infinity),
            Text(post.title, style: primaryTextStyle()).paddingAll(16),
          ],
        ),
      ),
    ).onTap(
      () => HtmlContentScreen(title: post.title, htmlData: post.contentHtml)
          .launch(context),
    );
  }
}
