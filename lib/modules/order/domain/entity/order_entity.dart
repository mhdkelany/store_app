import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final bool status;
  final List<OrderDetailsEntity> details;

  OrderEntity({
    required this.status,
    required this.details,
  });

  @override
  List<Object> get props => [
        status,
        details,
      ];
}

class OrderDetailsEntity extends Equatable {
  final String idUser;
  final String idBill;
  final String orderState;
  final String date;
  final String total;

  OrderDetailsEntity({
    required this.idUser,
    required this.idBill,
    required this.orderState,
    required this.date,
    required this.total,
  });

  @override
  List<Object> get props => [
        idUser,
        idBill,
        orderState,
        date,
        total,
      ];
}
