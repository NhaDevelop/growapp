class BlogPostModel {
  final String title;
  final String contentHtml;
  final String featuredImageUrl;

  BlogPostModel({
    required this.title,
    required this.contentHtml,
    required this.featuredImageUrl,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      title: json['title']['rendered'],
      contentHtml: json['content']['rendered'],
      featuredImageUrl: json['_embedded']?['wp:featuredmedia'] is List
          ? json['_embedded']['wp:featuredmedia'][0]['link']
          : '',
    );
  }
}
