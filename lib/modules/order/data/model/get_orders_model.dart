import 'package:store/models/order_details_model.dart';
import 'package:store/modules/order/domain/entity/order_entity.dart';

class GetOrdersModel extends OrderEntity {
  GetOrdersModel({
    required super.status,
    required super.details,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersModel(
      status: json['state'],
      details: List<OrderDetailsEntity>.from(
        (json['orders'] as List).map(
          (e) => OrderDetailsModel.fromJson(e),
        ),
      ),
    );
  }
}
