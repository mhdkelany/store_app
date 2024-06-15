import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/order/domain/entity/order_entity.dart';
import 'package:store/modules/order/domain/repo/base_order_repo.dart';

class GetOrdersUseCase extends BaseUseCase<OrderEntity,NoParameters>
{
  final BaseOrderRepo baseOrderRepo;

  GetOrdersUseCase(this.baseOrderRepo);

  @override
  Future<Either<Failure, OrderEntity>> call(NoParameters parameters)async {
    return await baseOrderRepo.getOrders();
  }
}