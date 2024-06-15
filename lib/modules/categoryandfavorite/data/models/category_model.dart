import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.status,
    required super.message,
    required super.cateData,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['state'],
      message: json['message'],
      cateData: List<CategoryDataModel>.from(
        (json['data'] as List).map(
          (e) => CategoryDataModel.fromJson(e),
        ),
      ),
    );
  }
}

class CategoryDataModel extends CategoryData {
  CategoryDataModel({
    required super.name,
    required super.idCate,
    required super.image,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
        name: json['name'], idCate: json['id_cate'], image: json['img']);
  }
}
