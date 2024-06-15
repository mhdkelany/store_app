import 'package:dartz/dartz.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';
import 'package:store/modules/home/domain/repo/base_home_repo.dart';

class GetHomeAsGuestUseCase extends BaseUseCase<HomeEntity,int>
{
  final BaseHomeRepo baseHomeRepo;

  GetHomeAsGuestUseCase(this.baseHomeRepo);
  @override
  Future<Either<Failure, HomeEntity>> call(int parameters)async {
    return await baseHomeRepo.getHomeAsGuest(parameters);
  }

}