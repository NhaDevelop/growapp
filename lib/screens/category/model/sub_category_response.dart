class SubCategoryResponse {
    List<SubCategoryData>? data;
    String? message;
    bool? status;

    SubCategoryResponse({this.data, this.message, this.status});

    factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
        return SubCategoryResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => SubCategoryData.fromJson(i)).toList() : null,
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['message'] = message;
        data['status'] = status;
        if (this.data != null) {
            data['data'] = this.data!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SubCategoryData {
    String? createdAt;
    String? createdBy;
    String? deletedAt;
    String? deletedBy;
    int? id;
    String? name;
    int? parentId;
    String? slug;
    int? status;
    String? updatedAt;
    String? updatedBy;

    SubCategoryData({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.id, this.name, this.parentId, this.slug, this.status, this.updatedAt, this.updatedBy});

    factory SubCategoryData.fromJson(Map<String, dynamic> json) {
        return SubCategoryData(
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
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['created_at'] = createdAt;
        data['id'] = id;
        data['name'] = name;
        data['parent_id'] = parentId;
        data['slug'] = slug;
        data['status'] = status;
        data['updated_at'] = updatedAt;
        if (createdBy != null) {
            data['created_by'] = createdBy;
        }
        if (deletedAt != null) {
            data['deleted_at'] = deletedAt;
        }
        if (deletedBy != null) {
            data['deleted_by'] = deletedBy;
        }
        if (updatedBy != null) {
            data['updated_by'] = updatedBy;
        }
        return data;
    }
}