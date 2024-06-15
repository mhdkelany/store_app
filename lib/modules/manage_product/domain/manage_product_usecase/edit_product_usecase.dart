import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class EditProductUseCase extends BaseUseCase<UpdateProductEntity,AddProductParameters>
{
  final BaseManageProductRepo baseManageProductRepo;

  EditProductUseCase(this.baseManageProductRepo);

  @override
  Future<Either<Failure, UpdateProductEntity>> call(AddProductParameters parameters)async {
    return await baseManageProductRepo.editProduct(parameters);
  }
}