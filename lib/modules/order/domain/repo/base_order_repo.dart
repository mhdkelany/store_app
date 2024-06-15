import 'package:dartz/dartz.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/order/domain/entity/order_entity.dart';
import 'package:store/modules/order/domain/entity/order_more_details_entity.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';

abstract class BaseOrderRepo{
  Future<Either<Failure,dynamic>> order(OrderParameters parameters);
  Future<Either<Failure,OrderEntity>> getOrders();
  Future<Either<Failure,OrderForMoreDetailsEntity>> getOrdersDetails(int parameter);
}