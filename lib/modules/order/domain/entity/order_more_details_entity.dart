import 'package:equatable/equatable.dart';

class OrderForMoreDetailsEntity extends Equatable {
  final bool status;
  final List<MoreDetailsOfOrderEntity> orders;

  OrderForMoreDetailsEntity({
    required this.status,
    required this.orders,
  });

  @override
  List<Object> get props => [
        status,
        orders,
      ];
}

class MoreDetailsOfOrderEntity extends Equatable {
  final String name;
  final String sum;
  final String quantity;
  final String idBill;

  MoreDetailsOfOrderEntity({
    required this.name,
    required this.sum,
    required this.quantity,
    required this.idBill,
  });

  @override
  List<Object> get props => [
        name,
        sum,
        quantity,
        idBill,
      ];
}
