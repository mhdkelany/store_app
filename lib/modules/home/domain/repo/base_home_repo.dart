import 'package:dartz/dartz.dart';
import 'package:store/core/failure.dart';
import 'package:store/modules/home/domain/entity/change_favorite_entity.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';
import 'package:store/modules/home/domain/usecase/change_favorite_usecase.dart';

abstract class BaseHomeRepo{
  Future<Either<Failure,HomeEntity>> getHome(int parameters);
  Future<Either<Failure,HomeEntity>> getHomeAsGuest(int parameters);
  Future<Either<Failure,ChangeFavoriteEntity>> changeFavoriteState(ChangeFavoriteParameters parameters);

}