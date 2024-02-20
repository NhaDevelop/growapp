import 'package:grow_tokyo_app/screens/product/model/product_list_response.dart';

import '../../category/model/category_response.dart';

class ProductDashboardResponse {
  bool? status;
  ProductDashboardData? data;
  String? message;

  ProductDashboardResponse({this.status, this.data, this.message});

  factory ProductDashboardResponse.fromJson(Map<String, dynamic> json) {
    return ProductDashboardResponse(
      status: json['status'],
      data: json['data'] != null
          ? ProductDashboardData.fromJson(json['data'])
          : null,
      message: json['message'],
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

class ProductDashboardData {
  List<ProductData>? bestsellerProduct;
  List<CategoryData>? category;
  List<ProductData>? discountProduct;
  List<ProductData>? featuredProduct;

  ProductDashboardData(
      {this.bestsellerProduct,
      this.category,
      this.discountProduct,
      this.featuredProduct});

  factory ProductDashboardData.fromJson(Map<String, dynamic> json) {
    return ProductDashboardData(
      bestsellerProduct: json['bestseller_product'] != null
          ? (json['bestseller_product'] as List)
              .map((i) => ProductData.fromJson(i))
              .toList()
          : null,
      category: json['category'] != null
          ? (json['category'] as List)
              .map((i) => CategoryData.fromJson(i))
              .toList()
          : null,
      discountProduct: json['discount_product'] != null
          ? (json['discount_product'] as List)
              .map((i) => ProductData.fromJson(i))
              .toList()
          : null,
      featuredProduct: json['featured_product'] != null
          ? (json['featured_product'] as List)
              .map((i) => ProductData.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bestsellerProduct != null) {
      data['bestseller_product'] =
          bestsellerProduct!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (discountProduct != null) {
      data['discount_product'] =
          discountProduct!.map((v) => v.toJson()).toList();
    }
    if (featuredProduct != null) {
      data['featured_product'] =
          featuredProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
