import 'package:dartz/dartz.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/order/data/data_source/order_datasource.dart';
import 'package:store/modules/order/data/model/get_details_order_model.dart';
import 'package:store/modules/order/data/model/get_orders_model.dart';
import 'package:store/modules/order/domain/order_usecase/order_usecase.dart';
import 'package:store/modules/order/domain/repo/base_order_repo.dart';

class OrderRepo extends BaseOrderRepo {
  final BaseOrderDataSource baseOrderDataSource;

  OrderRepo(this.baseOrderDataSource);

  @override
  Future<Either<Failure, dynamic>> order(OrderParameters parameters) async {
    final result = await baseOrderDataSource.order(parameters);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }
  @override
  Future<Either<Failure, GetOrdersModel>> getOrders() async {
    final result = await baseOrderDataSource.getOrders();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, OrderForMoreDetailsModel>> getOrdersDetails(int parameter) async {
    final result = await baseOrderDataSource.getOrdersDetails(parameter);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}
