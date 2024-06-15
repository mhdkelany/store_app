import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';

class CategoryUseCase extends BaseUseCase<CategoryEntity,NoParameters>
{
  final BaseCategoryAndFavoriteRepo baseCategoryAndFavoriteRepo;

  CategoryUseCase(this.baseCategoryAndFavoriteRepo);
  @override
  Future<Either<Failure, CategoryEntity>> call(NoParameters parameters)async {
    return await baseCategoryAndFavoriteRepo.getCategories();
  }

}