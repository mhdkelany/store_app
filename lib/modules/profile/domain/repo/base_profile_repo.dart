import 'package:dartz/dartz.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/profile/domain/entity/edit_profie_entity.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';

abstract class BaseProfileRepo{
  Future<Either<Failure,UserEntity>>getProfile();
  Future<Either<Failure,EditProfileEntity>>editProfile(EditProfileParameters parameters);
}