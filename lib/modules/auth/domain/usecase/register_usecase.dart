import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/register_entity.dart';
import 'package:store/modules/auth/domain/repo/base_auth_repo.dart';
class RegisterUseCase extends BaseUseCase<RegisterEntity,RegisterParameters>
{
  final BaseAuthRepo baseAuthRepo;

  RegisterUseCase(this.baseAuthRepo);
  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParameters parameters)async {
    return await baseAuthRepo.register(parameters);
  }
}
class RegisterParameters extends Equatable {
  final String name;
  final String password;
  final String phone;
  final String address;
  final int userType;
  final double lat;
  final double lng;

  RegisterParameters(
    this.name,
    this.password,
    this.phone,
    this.address,
    this.userType,
    this.lat,
    this.lng,
  );

  @override
  List<Object> get props => [
        name,
        password,
        phone,
        address,
        userType,
        lat,
        lng,
      ];
}
