import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/sub_category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';

class GetSubCategoryUseCase extends BaseUseCase<SubCategoryEntity,String>
{
  final BaseCategoryAndFavoriteRepo baseCategoryAndFavoriteRepo;

  GetSubCategoryUseCase(this.baseCategoryAndFavoriteRepo);
  @override
  Future<Either<Failure, SubCategoryEntity>> call(String parameters)async {
    return await baseCategoryAndFavoriteRepo.getSubCategory(parameters);
  }

}