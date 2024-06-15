import 'package:dartz/dartz.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/data/data_source/auth_data_source.dart';
import 'package:store/modules/auth/domain/entity/check_phone_number_entity.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/auth/domain/entity/register_entity.dart';
import 'package:store/modules/auth/domain/repo/base_auth_repo.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';

class AuthRepo extends BaseAuthRepo
{
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepo(this.baseAuthDataSource);
  @override
  Future<Either<Failure, UserEntity>> login(LoginParameters parameters)async {
    final result=await baseAuthDataSource.login(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(RegisterParameters parameters)async {
    final result=await baseAuthDataSource.register(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, CheckPhoneNumberEntity>> checkPhoneNumber(String parameters) {
    // TODO: implement checkPhoneNumber
    throw UnimplementedError();
  }

}