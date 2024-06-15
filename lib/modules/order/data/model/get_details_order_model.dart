import 'package:store/modules/order/domain/entity/order_more_details_entity.dart';

class MoreDetailsOfOrderModel extends MoreDetailsOfOrderEntity {
  MoreDetailsOfOrderModel({
    required super.name,
    required super.sum,
    required super.quantity,
    required super.idBill,
  });

  factory MoreDetailsOfOrderModel.fromJson(Map<String, dynamic> json) {
    return MoreDetailsOfOrderModel(
      name: json['name'],
      sum: json['sum'],
      quantity: json['quantity'],
      idBill: json['id_bill'],
    );
  }
}

class OrderForMoreDetailsModel extends OrderForMoreDetailsEntity {
  OrderForMoreDetailsModel({
    required super.status,
    required super.orders,
  });

  factory OrderForMoreDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderForMoreDetailsModel(
      status: json['state'],
      orders: List<MoreDetailsOfOrderEntity>.from(
        (json['orders'] as List).map(
          (e) => MoreDetailsOfOrderModel.fromJson(e),
        ),
      ),
    );
  }
}
