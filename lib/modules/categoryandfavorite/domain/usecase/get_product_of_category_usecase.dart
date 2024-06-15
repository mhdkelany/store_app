import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';

class GetProductOfCategoryUseCase extends BaseUseCase<ProductsOfCategoriesEntity,ProductOfCategoryParameters> {
  final BaseCategoryAndFavoriteRepo baseCategoryAndFavoriteRepo;

  GetProductOfCategoryUseCase(this.baseCategoryAndFavoriteRepo);
  @override
  Future<Either<Failure, ProductsOfCategoriesEntity>> call(ProductOfCategoryParameters parameters)async {
    return await baseCategoryAndFavoriteRepo.getProductsOfCategory(parameters);
  }


}

class ProductOfCategoryParameters extends Equatable {
  final String id;
  final  int page;

  ProductOfCategoryParameters({required this.id,  this.page=1,});

  @override
  List<Object> get props => [id, page];
}