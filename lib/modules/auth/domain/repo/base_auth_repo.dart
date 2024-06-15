import 'package:dartz/dartz.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/auth/domain/entity/register_entity.dart';
import 'package:store/modules/auth/domain/entity/check_phone_number_entity.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';

abstract class BaseAuthRepo
{
  Future<Either<Failure,UserEntity>>login(LoginParameters parameters);
  Future<Either<Failure,RegisterEntity>>register(RegisterParameters parameters);
  Future<Either<Failure,CheckPhoneNumberEntity>>checkPhoneNumber(String parameters);
}