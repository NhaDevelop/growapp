class BlogPostModel {
  final String title;
  final String contentHtml;
  final String featuredImageUrl;

  BlogPostModel({
    required this.title,
    required this.contentHtml,
    required this.featuredImageUrl,
  });

  static BlogPostModel? fromJson(Map<String, dynamic> json, String countryCode) {
    final postLink = json['link'] as String? ?? '';

    // Only filter for Vietnam posts
    if (countryCode == 'vn' && !postLink.contains('/vi/')) {
      return null; // skip if not Vietnamese URL
    }

    // For Cambodia or others, no filtering by URL substring (show all)
    // if (countryCode == 'kh') no filter

    String imageUrl = '';

    if (json['_embedded']?['wp:featuredmedia'] is List &&
        json['_embedded']!['wp:featuredmedia'].isNotEmpty) {
      final media = json['_embedded']!['wp:featuredmedia'][0];
      final sourceUrl = media['source_url'];

      if (sourceUrl is String) {
        imageUrl = sourceUrl;
      }
    }

    return BlogPostModel(
      title: json['title']?['rendered'] ?? '',
      contentHtml: json['content']?['rendered'] ?? '',
      featuredImageUrl: imageUrl,
    );
  }
}
