
import 'package:equatable/equatable.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

abstract class FavoriteAndCategoryState extends Equatable {
  const FavoriteAndCategoryState();
}

class FavoriteAndCategoryInitial extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetCategoriesSuccessState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetCategoriesErrorState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}
class GetCategoriesLoadingState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetFavoriteSuccessState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetFavoriteErrorState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}
class GetFavoriteLoadingState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetSubCateSuccessState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}

class GetSubCateErrorState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}
class GetSubCateLoadingState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}
class CateConnectionState extends FavoriteAndCategoryState {
  @override
  List<Object> get props => [];
}
class ChangeTgaState extends FavoriteAndCategoryState{
  @override
  List<Object> get props => [];
}

class ProductRemoveState extends FavoriteAndCategoryState{
  @override
  List<Object> get props => [];
}
class GetProductOfCategorySuccessState extends FavoriteAndCategoryState{
  final ProductsOfCategoriesEntity productsOfCategoriesEntity;

  GetProductOfCategorySuccessState(this.productsOfCategoriesEntity);
  @override
  List<Object> get props => [];
}
class GetProductOfCategoryErrorState extends FavoriteAndCategoryState{
  @override
  List<Object> get props => [];
}