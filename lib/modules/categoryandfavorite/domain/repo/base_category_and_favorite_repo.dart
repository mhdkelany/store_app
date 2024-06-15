import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/sub_category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';

abstract class BaseCategoryAndFavoriteRepo {
  Future<Either<Failure,CategoryEntity>> getCategories();
  Future<Either<Failure,ProductsOfCategoriesEntity>> getProductsOfCategory(ProductOfCategoryParameters parameters);
  Future<Either<Failure,ProductsOfCategoriesEntity>> getFavorite(NoParameters parameters);
  Future<Either<Failure,SubCategoryEntity>> getSubCategory(String id);
}