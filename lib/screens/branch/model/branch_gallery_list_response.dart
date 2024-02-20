class BranchGalleryListResponse {
    List<BranchGalleryData>? data;
    String? message;
    bool? status;

    BranchGalleryListResponse({this.data, this.message, this.status});

    factory BranchGalleryListResponse.fromJson(Map<String, dynamic> json) {
        return BranchGalleryListResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => BranchGalleryData.fromJson(i)).toList() : null, 
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

class BranchGalleryData {
    int? branchId;
    String? createdAt;
    int? createdBy;
    int? deletedAt;
    int? deletedBy;
    String? fullUrl;
    int? id;
    int? status;
    String? updatedAt;
    int? updatedBy;

    BranchGalleryData({this.branchId, this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.fullUrl, this.id, this.status, this.updatedAt, this.updatedBy});

    factory BranchGalleryData.fromJson(Map<String, dynamic> json) {
        return BranchGalleryData(
            branchId: json['branch_id'], 
            createdAt: json['created_at'], 
            createdBy: json['created_by'], 
            deletedAt: json['deleted_at'],
            deletedBy: json['deleted_by'],
            fullUrl: json['full_url'], 
            id: json['id'], 
            status: json['status'], 
            updatedAt: json['updated_at'], 
            updatedBy: json['updated_by'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['branch_id'] = branchId;
        data['created_at'] = createdAt;
        data['created_by'] = createdBy;
        data['full_url'] = fullUrl;
        data['id'] = id;
        data['status'] = status;
        data['updated_at'] = updatedAt;
        data['updated_by'] = updatedBy;
        if (deletedAt != null) {
            data['deleted_at'] = deletedAt;
        }
        if (deletedBy != null) {
            data['deleted_by'] = deletedBy;
        }
        return data;
    }
}