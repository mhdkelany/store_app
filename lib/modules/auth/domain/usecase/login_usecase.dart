import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/auth/domain/repo/base_auth_repo.dart';

class LoginUseCase extends BaseUseCase<UserEntity, LoginParameters> {
  final BaseAuthRepo baseAuthRepo;

  LoginUseCase(this.baseAuthRepo);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParameters parameters) async {
    return await baseAuthRepo.login(parameters);
  }
}

class LoginParameters extends Equatable {
  LoginParameters({required this.phone, required this.password, required this.userType, this.tokenMobile});

  final String phone;
  final String password;
  final String ?tokenMobile;
  final int userType;

  @override
  List<Object> get props => [phone, password, userType];
}
