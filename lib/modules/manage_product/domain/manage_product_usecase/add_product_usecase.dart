import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/repo/base_manage_product_repo.dart';

class AddProductUseCase extends BaseUseCase<OwnProductEntity,AddProductParameters>
{
  final BaseManageProductRepo baseManageProductRepo;

  AddProductUseCase(this.baseManageProductRepo);

  @override
  Future<Either<Failure, OwnProductEntity>> call(AddProductParameters parameters)async {
    return await baseManageProductRepo.addProduct(parameters);
  }
}

class AddProductParameters extends Equatable {
  final Map data;
   File? file;
  final BuildContext context;
  AddProductParameters({required this.context,required this.data, required this.file,});

  @override
  List<Object> get props => [data, file!];
}