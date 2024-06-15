import 'package:store/modules/categoryandfavorite/data/models/products_of_category_model.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/manage_product/domain/entity/search_product_entity.dart';

class SearchProductModel extends SearchProductEntity {
  SearchProductModel({
    required super.message,
    required super.status,
    required super.product,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
        message: json['message'],
        status: json['state'],
        product: json['data'] != null
            ? List<Product>.from(
                (json['data'] as List).map((e) => ProductModel.fromJson(e)))
            : null);
  }
}
