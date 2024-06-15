
import 'package:equatable/equatable.dart';
import 'package:store/modules/manage_product/domain/entity/own_product_entity.dart';
import 'package:store/modules/manage_product/domain/entity/update_product_entity.dart';

abstract class ManageProductState extends Equatable {
  const ManageProductState();
}

class ManageProductInitial extends ManageProductState {
  @override
  List<Object> get props => [];
}

class ChoiceImageSuccessState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class ChoiceImageErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class RemoveImageState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class GetProductForUserErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}
class GetProductForUserSuccessState extends ManageProductState {
  final OwnProductEntity ownProductEntity;

  GetProductForUserSuccessState(this.ownProductEntity);
  @override
  List<Object> get props => [];
}
class GetProductForUserLoadingState extends ManageProductState {
  @override
  List<Object> get props => [];
}
class InsertProductForUserErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class InsertProductForUserLoadingState extends ManageProductState {
  @override
  List<Object> get props => [];
}
class InsertProductForUserSuccessState extends ManageProductState {
  final OwnProductEntity ownProductEntity;

  InsertProductForUserSuccessState(this.ownProductEntity);
  @override
  List<Object> get props => [];
}

class UpdateProductForUserErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class UpdateProductForUserLoadingState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class UpdateProductForUserSuccessState extends ManageProductState {
  final UpdateProductEntity updateProductEntity;

  UpdateProductForUserSuccessState(this.updateProductEntity);
  @override
  List<Object> get props => [];
}

class PostWishErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}


class PostWishLoadingState extends ManageProductState {
  @override
  List<Object> get props => [];
}


class PostWishSuccessState extends ManageProductState {
  final UpdateProductEntity updateProductEntity;

  PostWishSuccessState(this.updateProductEntity);
  @override
  List<Object> get props => [];
}

class QuantityProductIsEmptyState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class GetProductForUserAllLoadingState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class GetProductForUserAllSuccessState extends ManageProductState {
  final OwnProductEntity ownProductEntity;

  GetProductForUserAllSuccessState(this.ownProductEntity);
  @override
  List<Object> get props => [];
}

class GetProductForUserAllErrorState extends ManageProductState {
  @override
  List<Object> get props => [];
}
class SearchForUserState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class StartSearchingState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class ClearTextState extends ManageProductState {
  @override
  List<Object> get props => [];
}

class SearchProductsSuccessState extends ManageProductState{
  @override
  List<Object> get props => [];
}
class SearchProductsLoadingState extends ManageProductState{
  @override
  List<Object> get props => [];
}
class SearchProductsErrorState extends ManageProductState{
  @override
  List<Object> get props => [];
}