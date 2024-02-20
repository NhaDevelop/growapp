class CategoryDetailResponse {
    CategoryDetail? data;
    String? message;
    bool? status;

    CategoryDetailResponse({this.data, this.message, this.status});

    factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) {
        return CategoryDetailResponse(
            data: json['data'] != null ? CategoryDetail.fromJson(json['data']) : null,
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['message'] = message;
        data['status'] = status;
        if (this.data != null) {
            data['data'] = this.data!.toJson();
        }
        return data;
    }
}

class CategoryDetail {
    String? createdAt;
    String? createdBy;
    String? deletedAt;
    String? deletedBy;
    int? id;
    String? name;
    String? parentId;
    String? slug;
    int? status;
    String? updatedAt;
    String? updatedBy;

    CategoryDetail({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.id, this.name, this.parentId, this.slug, this.status, this.updatedAt, this.updatedBy});

    factory CategoryDetail.fromJson(Map<String, dynamic> json) {
        return CategoryDetail(
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
        if (parentId != null) {
            data['parent_id'] = parentId;
        }
        if (updatedBy != null) {
            data['updated_by'] = updatedBy;
        }
        return data;
    }
}