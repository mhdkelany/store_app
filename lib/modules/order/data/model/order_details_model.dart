import 'package:store/modules/order/domain/entity/order_entity.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  OrderDetailsModel({
    required super.idUser,
    required super.idBill,
    required super.orderState,
    required super.date,
    required super.total,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      idUser: json['id_user'],
      idBill: json['id_bill'],
      orderState: json['state_order'],
      date: json['creation_date'],
      total: json['total'],
    );
  }
}
