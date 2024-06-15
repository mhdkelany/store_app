import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/order/domain/entity/order_more_details_entity.dart';
import 'package:store/modules/order/domain/repo/base_order_repo.dart';

class GetOrderDetailsUseCase extends BaseUseCase<OrderForMoreDetailsEntity,int>
{
  final BaseOrderRepo baseOrderRepo;

  GetOrderDetailsUseCase(this.baseOrderRepo);

  @override
  Future<Either<Failure, OrderForMoreDetailsEntity>> call(int parameters)async {
    return await baseOrderRepo.getOrdersDetails(parameters);
  }
}