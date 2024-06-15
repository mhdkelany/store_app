import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/sub_category_entity.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/category_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_favorite_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_sub_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_state.dart';
import 'package:store/shared/components/constansts/constansts.dart';


class FavoriteAndCategoryCubit extends Cubit<FavoriteAndCategoryState> {
  final CategoryUseCase categoryUseCase;
  final GetProductOfCategoryUseCase getProductOfCategoryUseCase;
  final GetFavoriteUseCae getFavoriteUseCae;
  final GetSubCategoryUseCase getSubCategoryUseCase;
  FavoriteAndCategoryCubit(
      this.categoryUseCase, this.getProductOfCategoryUseCase,this.getFavoriteUseCae,this.getSubCategoryUseCase,)
      : super(FavoriteAndCategoryInitial());

  static FavoriteAndCategoryCubit get(BuildContext context) =>
      BlocProvider.of(context);
  CategoryEntity? categoryEntity;

  FutureOr<void> getCategories(NoParameters parameters) async {
    if (await checkConnection()) {
      emit(GetCategoriesLoadingState());
      final result = await categoryUseCase.call(parameters);
      result.fold(
        (l) {
          emit(GetCategoriesErrorState());
        },
        (r) {
          categoryEntity = r;
          emit(GetCategoriesSuccessState());
        },
      );
    } else {
      emit(CateConnectionState());
    }
  }

  dynamic tag = 0;

  void changeTag(Object value) {
    tag = value;
    emit(ChangeTgaState());
  }

  dynamic tag2 = 0;

  void changeTag2(Object value) {
    tag2 = value;
    emit(ChangeTgaState());
  }

  void removeState(){
    emit(ProductRemoveState());
  }

  ProductsOfCategoriesEntity? productsOfCategoriesEntity;
  int currentPage=1;
  FutureOr<void> getProductOfCategory(
      ProductOfCategoryParameters parameters,{bool isRefresh=false}) async {
    if (await checkConnection()) {
      final result = await getProductOfCategoryUseCase.call(parameters);
      result.fold(
        (l) {
          emit(GetProductOfCategoryErrorState());
        },
        (r) {
          if(isRefresh) {
            currentPage=1;
            productsOfCategoriesEntity = r;
            emit(GetProductOfCategorySuccessState(productsOfCategoriesEntity!));
          } else if(r.status){
            productsOfCategoriesEntity!.products.addAll(r.products);
            emit(GetProductOfCategorySuccessState(productsOfCategoriesEntity!));
          }
        },
      );
      currentPage++;
    }
  }
  ProductsOfCategoriesEntity? favoriteEntity;
  FutureOr<void> getFavorite(NoParameters parameters) async {
    if (await checkConnection()) {
      emit(GetFavoriteLoadingState());
      final result = await getFavoriteUseCae.call(parameters);
      result.fold(
            (l) {
          emit(GetFavoriteErrorState());
        },
            (r) {
          favoriteEntity = r;
          emit(GetFavoriteSuccessState());
        },
      );
    } else {
      emit(CateConnectionState());
    }
  }
   SubCategoryEntity? subCategoryEntity;
  FutureOr<void> getSubCate(String id) async {
    if (await checkConnection()) {
      emit(GetSubCateLoadingState());
      final result = await getSubCategoryUseCase.call(id);
      result.fold(
            (l) {
          emit(GetSubCateErrorState());
        },
            (r) {
          subCategoryEntity = r;
          if(subCategoryEntity!.data.isNotEmpty)
            {
              getProductOfCategory(ProductOfCategoryParameters(id: subCategoryEntity!.data[0].id),isRefresh: true);
            }
          emit(GetSubCateSuccessState());
        },
      );
    } else {
      emit(CateConnectionState());
    }
  }

}
