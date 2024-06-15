import 'package:dartz/dartz.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/profile/data/data_source/profile_data_source.dart';
import 'package:store/modules/profile/domain/entity/edit_profie_entity.dart';
import 'package:store/modules/profile/domain/repo/base_profile_repo.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';

class ProfileRepo extends BaseProfileRepo
{
  final BaseProfileDataSource baseProfileDataSource;

  ProfileRepo(this.baseProfileDataSource);
  @override
  Future<Either<Failure, UserEntity>> getProfile()async {
    final result=await baseProfileDataSource.getProfile();
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }
  @override
  Future<Either<Failure, EditProfileEntity>> editProfile(EditProfileParameters parameters)async {
    final result=await baseProfileDataSource.editProfile(parameters);
    try{
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.errorModel.message));
    }
  }

}