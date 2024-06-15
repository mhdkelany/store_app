import 'package:store/modules/categoryandfavorite/data/models/products_of_category_model.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';

class NewHomeModel extends HomeEntity {
  NewHomeModel({
    required super.status,
    required super.top,
    required super.cate,
    required super.banner,
    super.statusProfile,
    required super.allProducts,
  });

  factory NewHomeModel.fromJsom(Map<String, dynamic> json) {
    return NewHomeModel(
      status: json['state'] != null ? json['state'] : null,
      statusProfile:
          json['state_profile'] != null ? json['state_profile'] : null,
      allProducts: json['products'] != null
          ? List<Product>.from(
              (json['products'] as List).map((e) => ProductModel.fromJson(e)))
          : [],
      top: json['top'] != null
          ? List<Product>.from(
              (json['top'] as List).map((e) => ProductModel.fromJson(e)))
          : [],
      cate: json['data'] != null
          ? List<Product>.from(
              (json['data'] as List).map((e) => ProductModel.fromJson(e)))
          : [],
      banner: json['banner'] != null
          ? List<BannerEntity>.from(
              (json['banner'] as List).map((e) => BannersModel.fromJson(e)))
          : [],
    );
  }
}

class BannersModel extends BannerEntity {
  BannersModel({
    required super.id,
    required super.image,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id_banner'],
      image: json['img'],
    );
  }
}
