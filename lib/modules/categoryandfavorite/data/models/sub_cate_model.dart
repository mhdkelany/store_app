import 'package:store/modules/categoryandfavorite/domain/entity/sub_category_entity.dart';

class SubCateModel extends SubCategoryEntity {
  SubCateModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory SubCateModel.fromJson(Map<String, dynamic> json) {
    return SubCateModel(
      status: json['state'],
      message: json['message'],
      data: List<SubCateDataModel>.from(
        (json['data'] as List).map(
          (e) => SubCateDataModel.fromJson(e),
        ),
      ),
    );
  }
}

class SubCateDataModel extends SubCategoryDataEntity {
  SubCateDataModel({
    required super.name,
    required super.id,
    required super.image,
  });

  factory SubCateDataModel.fromJson(Map<String, dynamic> json) {
    return SubCateDataModel(
      name: json['name'],
      id: json['id_cate'],
      image: json['img'],
    );
  }
}
