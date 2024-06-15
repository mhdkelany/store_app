import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class GetAllOwnProductUseCase extends BaseUseCase<OwnProductEntity,NoParameters>
{
  final BaseManageProductRepo baseManageProductRepo;

  GetAllOwnProductUseCase(this.baseManageProductRepo);
  @override
  Future<Either<Failure, OwnProductEntity>> call(NoParameters noParameters)async {
    return await baseManageProductRepo.getAllOwnProducts(noParameters);
  }

}