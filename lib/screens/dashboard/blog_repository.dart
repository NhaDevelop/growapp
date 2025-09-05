import 'dart:convert';

import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/models/blog_post_model.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:http/http.dart' as http;

Future<List<BlogPostModel>> getBlogPosts({
  int page = 1,
  int perPage = 15,
  List<BlogPostModel>? list,
}) async {
  final countryCode = appStore.countryCode; // e.g., 'vn' or 'kh'
  final uri = Uri.https(
    "$countryCode.${BuildConfig.blogPostHost}",
    'wp-json/wp/v2/posts',
    {
      '_embed': '1',
      'page': page.toString(),
      'per_page': perPage.toString(),
    },
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    // Map and filter nulls after country-specific filtering inside fromJson
    final newItems = data
        .map((e) => BlogPostModel.fromJson(e, countryCode))
        .whereType<BlogPostModel>()
        .toList();

    if (page == 1) blogPostListCached = newItems;
    if (list == null) return newItems;

    if (page == 1) list.clear();
    list.addAll(newItems);
    return list;
  } else {
    try {
      final error = jsonDecode(response.body);
      if (error['code'] == 'rest_post_invalid_page_number') {
        return list ?? [];
      }
      throw Exception(error['message']);
    } catch (e) {
      throw Exception(response.reasonPhrase);
    }
  }
}
