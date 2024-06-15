import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/modules/order/domain/repo/base_order_repo.dart';

class OrderParameters extends Equatable {
  final List<CartProducts> product;
  final double totalBill;
  final double? lat;
  final double? lng;
  final BuildContext context;

  OrderParameters(
      {required this.product,
      required this.totalBill,
      required this.lat,
      required this.lng,
      required this.context});

  @override
  List<Object> get props => [
        product,
        totalBill,
        lat!,
        lng!,
        context,
      ];
}

class OrderUseCase extends BaseUseCase<dynamic, OrderParameters> {
  final BaseOrderRepo baseOrderRepo;

  OrderUseCase(this.baseOrderRepo);

  @override
  Future<Either<Failure, dynamic>> call(OrderParameters parameters) async {
    return await baseOrderRepo.order(parameters);
  }
}
