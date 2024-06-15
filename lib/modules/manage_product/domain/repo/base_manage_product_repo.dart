import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/search_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';

abstract class BaseManageProductRepo{
  Future<Either<Failure,OwnProductEntity>> getOwnProducts(int page);
  Future<Either<Failure,OwnProductEntity>> getAllOwnProducts(NoParameters noParameters);
  Future<Either<Failure,OwnProductEntity>> addProduct(AddProductParameters parameters);
  Future<Either<Failure,UpdateProductEntity>> editProduct(AddProductParameters parameters);
  Future<Either<Failure,UpdateProductEntity>> postWish(String parameters);
  Future<Either<Failure,SearchProductEntity>> searchProduct(String parameters);
}