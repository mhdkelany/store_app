import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

class ProductsOfCategoryModel extends ProductsOfCategoriesEntity {
  ProductsOfCategoryModel({
    required super.status,
    required super.message,
    required super.products,
  });

  factory ProductsOfCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductsOfCategoryModel(
      status: json['state'],
      message: json['message'],
      products: json['data']!=null?List<ProductModel>.from(
        (json['data'] as List).map(
          (e) => ProductModel.fromJson(e),
        ),
      ):[],
    );
  }
}

class ProductModel extends Product {
  ProductModel({
    required super.idProduct,
    required super.name,
    required super.shortDescription,
    required super.longDescription,
    required super.price,
    required super.quantity,
    required super.discount,
    required super.image,
    required super.inFavorites,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      idProduct: json['id_pro'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      price: json['price'],
      quantity: json['quantity'],
      discount: json['discount'],
      image: json['img'],
      inFavorites: json['isfav'],
    );
  }
}
