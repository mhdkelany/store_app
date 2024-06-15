import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/search_product_entity.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class SearchProductUseCase extends BaseUseCase<SearchProductEntity,String>
{
  final BaseManageProductRepo baseManageProductRepo;

  SearchProductUseCase(this.baseManageProductRepo);

  @override
  Future<Either<Failure, SearchProductEntity>> call(String parameters)async {
    return await baseManageProductRepo.searchProduct(parameters);
  }
}