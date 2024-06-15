part of 'home_cubit.dart';


abstract class HomeState {}

class HomeInitial extends HomeState {}
class StoreHomeLoadingState extends HomeState{}
class StoreHomeSuccessState extends HomeState
{
  HomeEntity homeEntity;
  StoreHomeSuccessState(this.homeEntity);
}
class StoreHomeErrorState extends HomeState
{
 final String error;

  StoreHomeErrorState({required this.error});
}

class GetHomeWithoutTokenSuccessState extends HomeState{}
class GetHomeWithoutTokenLoadingState extends HomeState{}
class GetHomeWithoutTokenErrorState extends HomeState{}

class ChangeFavoritesSuccessState extends HomeState{}
class ChangeFavoritesLoadingState extends HomeState{}
class ChangeFavoritesErrorState extends HomeState{}

class StoreCategoriesSuccessState extends HomeState{}
class StoreCategoriesErrorState extends HomeState{
  final String error;

  StoreCategoriesErrorState({required this.error});
}
