import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';

class EditProductModel extends UpdateProductEntity {
  EditProductModel({
    required super.message,
    required super.status,
  });

  factory EditProductModel.fromJson(Map<String, dynamic> json) {
    return EditProductModel(
      message: json['message'],
      status: json['state'],
    );
  }
}
