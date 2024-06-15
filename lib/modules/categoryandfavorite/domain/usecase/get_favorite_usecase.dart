import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';

class GetFavoriteUseCae extends BaseUseCase<ProductsOfCategoriesEntity,NoParameters>
{
  final BaseCategoryAndFavoriteRepo baseCategoryAndFavoriteRepo;

  GetFavoriteUseCae(this.baseCategoryAndFavoriteRepo);
  @override
  Future<Either<Failure, ProductsOfCategoriesEntity>> call(NoParameters parameters)async {
    return await baseCategoryAndFavoriteRepo.getFavorite(parameters);
  }

}