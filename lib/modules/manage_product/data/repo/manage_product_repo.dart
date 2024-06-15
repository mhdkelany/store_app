import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/data/data_source/manage_product_data_source.dart';
import 'package:store/modules/manage_product/data/model/search_prodyct_model.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class ManageProductRepo extends BaseManageProductRepo
{
  final BaseManageProductDataSource baseManageProductDataSource;

  ManageProductRepo(this.baseManageProductDataSource);
  @override
  Future<Either<Failure, OwnProductEntity>> getOwnProducts(int page)async {
    final result=await baseManageProductDataSource.getOwnProducts(page);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, OwnProductEntity>> addProduct(AddProductParameters parameters)async {
    final result=await baseManageProductDataSource.addProduct(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, UpdateProductEntity>> editProduct(AddProductParameters parameters)async {
    final result=await baseManageProductDataSource.editProduct(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, UpdateProductEntity>> postWish(String parameters)async {
    final result=await baseManageProductDataSource.postWish(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, OwnProductEntity>> getAllOwnProducts(NoParameters noParameters)async {
    final result=await baseManageProductDataSource.getAllOwnProducts();
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }
  @override
  Future<Either<Failure, SearchProductModel>> searchProduct(String parameter)async {
    final result=await baseManageProductDataSource.searchProduct(parameter);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}