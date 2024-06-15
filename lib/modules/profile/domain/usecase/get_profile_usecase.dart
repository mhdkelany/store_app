import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/auth/domain/entity/login_entity.dart';
import 'package:store/modules/profile/domain/repo/base_profile_repo.dart';

class GetProfileUseCase extends BaseUseCase<UserEntity,NoParameters>
{
  final BaseProfileRepo baseProfileRepo;

  GetProfileUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, UserEntity>> call(NoParameters parameters)async {
    return await baseProfileRepo.getProfile();
  }
}