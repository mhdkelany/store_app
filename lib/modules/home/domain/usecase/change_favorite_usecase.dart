import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/home/domain/entity/change_favorite_entity.dart';
import 'package:store/modules/home/domain/repo/base_home_repo.dart';

class ChangeFavoriteUseCase extends BaseUseCase<ChangeFavoriteEntity,ChangeFavoriteParameters>
{
  final BaseHomeRepo baseHomeRepo;

  ChangeFavoriteUseCase(this.baseHomeRepo);
  @override
  Future<Either<Failure, ChangeFavoriteEntity>> call(ChangeFavoriteParameters parameters)async {
    return await baseHomeRepo.changeFavoriteState(parameters);
  }

}

class ChangeFavoriteParameters extends Equatable {
  final String id;
  final bool status;

  ChangeFavoriteParameters(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}