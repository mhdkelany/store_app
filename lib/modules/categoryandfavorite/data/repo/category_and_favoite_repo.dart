import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/categoryandfavorite/data/data_source/data_source.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/sub_category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/repo/base_category_and_favorite_repo.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';

class CategoryAndFavoriteRepo extends BaseCategoryAndFavoriteRepo
{
  final BaseCategoryAndFavoriteDataSource baseCategoryAndFavoriteDataSource;

  CategoryAndFavoriteRepo(this.baseCategoryAndFavoriteDataSource);
  @override
  Future<Either<Failure, CategoryEntity>> getCategories()async {
    final result=await baseCategoryAndFavoriteDataSource.getCategories();
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ProductsOfCategoriesEntity>> getProductsOfCategory(ProductOfCategoryParameters parameters)async {
    final result=await baseCategoryAndFavoriteDataSource.getProductsOfCategory(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ProductsOfCategoriesEntity>> getFavorite(NoParameters parameters)async {
    final result=await baseCategoryAndFavoriteDataSource.getFavorite(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, SubCategoryEntity>> getSubCategory(String id)async {
    final result=await baseCategoryAndFavoriteDataSource.getSubCate(id);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }


}