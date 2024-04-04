import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/blog_repository.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/horizontal_blog_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/blog_post_model.dart';
import 'package:grow_tokyo_app/screens/dashboard/shimmer/blog_list_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class BlogPostListScreen extends StatefulWidget {
  const BlogPostListScreen({super.key});

  @override
  State<BlogPostListScreen> createState() => _BlogPostListScreenState();
}

class _BlogPostListScreenState extends State<BlogPostListScreen> {
  Future<List<BlogPostModel>>? future;
  List<BlogPostModel> list = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    future = getBlogPosts(page: page, list: list);
  }

  Future<void> reload() async {
    page = 1;
    future = getBlogPosts(page: page, list: list);
    setState(() {});
  }

  Future<void> loadMore() async {
    page++;
    future = getBlogPosts(page: page, list: list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.blog),
      body: SnapHelperWidget(
        future: future,
        initialData: blogPostListCached,
        loadingWidget: const BlogPostListShimmer(),
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            retryText: locale.reload,
            imageWidget: const ErrorStateWidget(),
            onRetry: reload,
          );
        },
        onSuccess: (list) {
          return AnimatedListView(
            itemCount: list.length,
            padding: const EdgeInsets.all(16),
            onSwipeRefresh: reload,
            onNextPage: loadMore,
            itemBuilder: (context, index) {
              return BlogItemComponent(post: list[index]).paddingBottom(16);
            },
          );
        },
      ),
    );
  }
}
