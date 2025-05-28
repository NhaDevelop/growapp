class PagesResponse {
  final List<PageModel> pages;

  PagesResponse({required this.pages});

  factory PagesResponse.fromJson(Map<String, dynamic> json) {
    List<PageModel> pages = [];
    pages =
        (json['data'] as List).map((page) => PageModel.fromJson(page)).toList();
    return PagesResponse(pages: pages);
  }
}

class PageModel {
  final int id;
  final String name;
  final String description;

  PageModel({required this.id, required this.name, required this.description});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
