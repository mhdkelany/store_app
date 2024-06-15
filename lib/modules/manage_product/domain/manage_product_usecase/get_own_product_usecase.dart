import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class GetOwnProductUseCase extends BaseUseCase<OwnProductEntity,int>
{
  final BaseManageProductRepo baseManageProductRepo;

  GetOwnProductUseCase(this.baseManageProductRepo);

  @override
  Future<Either<Failure, OwnProductEntity>> call(int parameters)async {
    return await baseManageProductRepo.getOwnProducts(parameters);
  }
}