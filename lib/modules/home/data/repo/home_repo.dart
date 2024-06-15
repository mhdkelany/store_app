import 'package:dartz/dartz.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/home/data/data_source/home_datasource.dart';
import 'package:store/modules/home/domain/entity/change_favorite_entity.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';
import 'package:store/modules/home/domain/repo/base_home_repo.dart';
import 'package:store/modules/home/domain/usecase/change_favorite_usecase.dart';

class HomeRepo extends BaseHomeRepo
{
  final BaseHomeDataSource baseHomeDataSource;

  HomeRepo(this.baseHomeDataSource);
  @override
  Future<Either<Failure, HomeEntity>> getHome(int parameters)async {
    final result=await baseHomeDataSource.getHome(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, HomeEntity>> getHomeAsGuest(int parameters)async {
    final result=await baseHomeDataSource.getHomeAsGuest(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }
  @override
  Future<Either<Failure, ChangeFavoriteEntity>> changeFavoriteState(ChangeFavoriteParameters parameters)async {
    final result=await baseHomeDataSource.changeFavoriteState(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}