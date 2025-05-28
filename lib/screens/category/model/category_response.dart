class CategoryResponse {
  List<CategoryData>? category;
  String? message;
  bool? status;

  CategoryResponse({this.category, this.message, this.status});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      category: json['data'] != null ? (json['data'] as List).map((i) => CategoryData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (category != null) {
      data['data'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  int? parentId;
  String? slug;
  int? status;
  String? updatedAt;
  int? updatedBy;
  String? categoryImage;

  /// Product Module
  int? brandId;

  CategoryData({
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.name,
    this.parentId,
    this.brandId,
    this.slug,
    this.status,
    this.updatedAt,
    this.updatedBy,
    this.categoryImage,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      slug: json['slug'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      categoryImage: json['category_image'],
      brandId: json['brand_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['deleted_at'] = deletedAt;
    data['deleted_by'] = deletedBy;
    data['parent_id'] = parentId;
    data['updated_by'] = updatedBy;
    data['category_image'] = categoryImage;
    data['brand_id'] = brandId;
    return data;
  }
}
