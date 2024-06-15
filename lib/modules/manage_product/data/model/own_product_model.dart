import 'package:store/modules/categoryandfavorite/data/models/products_of_category_model.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';

class OwnProductModel extends OwnProductEntity {
  OwnProductModel({
    required super.statusProfile,
    required super.status,
    required super.message,
    required super.productForUser,
  });

  factory OwnProductModel.fromJson(Map<String, dynamic> json) {
    return OwnProductModel(
      statusProfile:
          json['state_profile'] != null ? json['state_profile'] : null,
      status: json['state'],
      message: json['message'],
      productForUser: List<Product>.from(
        (json['product'] as List).map(
          (e) => ProductModel.fromJson(e),
        ),
      ),
    );
  }
}
