import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class PostWishUseCase extends BaseUseCase<UpdateProductEntity,String>
{
  final BaseManageProductRepo baseManageProductRepo;

  PostWishUseCase(this.baseManageProductRepo);

  @override
  Future<Either<Failure, UpdateProductEntity>> call(String parameters)async {
    return await baseManageProductRepo.postWish(parameters);
  }

}