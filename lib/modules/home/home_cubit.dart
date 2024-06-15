import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/home/domain/entity/change_favorite_entity.dart';
import 'package:store/modules/home/domain/entity/get_home_entity.dart';
import 'package:store/modules/home/domain/usecase/change_favorite_usecase.dart';
import 'package:store/modules/home/domain/usecase/get_home_usecase.dart';
import 'package:store/modules/home/domain/usecase/get_home_without_token_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeUseCase getHomeUseCase;
  final GetHomeAsGuestUseCase getHomeAsGuestUseCase;
  final ChangeFavoriteUseCase changeFavoriteUseCase;
  HomeCubit(this.getHomeUseCase,this.getHomeAsGuestUseCase,this.changeFavoriteUseCase) : super(HomeInitial());
  static HomeCubit get(BuildContext context)=>BlocProvider.of(context);
  Map<String, bool> isFavorite = {};
  HomeEntity? homeModel;
  int currentPageGetHome=1;
  FutureOr<void> getHome({bool isRefresh=false})async  {
      emit(StoreHomeLoadingState());
      final result=await getHomeUseCase.call(currentPageGetHome);
      result.fold((l) {
        emit(StoreHomeErrorState(error: l.message));
      }, (r) {
        if (isRefresh) {
          homeModel =r;
          emit(StoreHomeSuccessState(homeModel!));
          homeModel!.allProducts.forEach((element) {
            isFavorite.addAll({
              element.idProduct!: element.inFavorites!,
            });
          });
          print(isFavorite);
        }
        else {
          homeModel!.allProducts.addAll(r.allProducts);
          homeModel!.allProducts.forEach((element) {
            isFavorite.addAll({
              element.idProduct!: element.inFavorites!,
            });
          });
          emit(StoreHomeSuccessState(homeModel!));
        }
        currentPageGetHome++;
      });
  }
  int currentPage = 1;

  FutureOr<void> getHomeWithoutToken({bool isRefresh=false}) async {
    emit(GetHomeWithoutTokenLoadingState());
    if (await checkConnection()) {
      if(isRefresh)
      {
        currentPage=1;
      }
      final result=await getHomeAsGuestUseCase.call(currentPage);
      result.fold((l) {
        emit(GetHomeWithoutTokenErrorState());
      }, (r) {
        if(isRefresh) {
          homeModel = r;
          emit(GetHomeWithoutTokenSuccessState());

        }else{
          homeModel!.allProducts.addAll(r.allProducts);
          emit(GetHomeWithoutTokenSuccessState());

        }
        currentPage++;
      });
    }
  }
  ChangeFavoriteEntity? changeFavoritesModel;

  FutureOr<void> changeFavorites(String id)async {
    isFavorite[id] = !isFavorite[id]!;
    final result= await changeFavoriteUseCase.call(ChangeFavoriteParameters(id, isFavorite[id]!));
    result.fold((l) {
      isFavorite[id] = !isFavorite[id]!;
      emit(ChangeFavoritesErrorState());
    }, (r) {
      print(r);
      print(isFavorite[id]);
      changeFavoritesModel = r;
      if (changeFavoritesModel!.status == false) {
        isFavorite[id] = !isFavorite[id]!;
      } else {}
      emit(ChangeFavoritesSuccessState());
    });
  }

}
