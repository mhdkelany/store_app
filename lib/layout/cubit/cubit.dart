import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/user_data_model.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/screens/categories_screen.dart';
import 'package:store/modules/categoryandfavorite/presentation/screens/favorites_screen.dart';
import 'package:store/modules/home/presentation/screen/home_screen.dart';
import 'package:store/modules/profile/presentation/screens/profile_screen.dart';
import 'package:store/modules/manage_product/presentation/screens/uploade_wish_screen.dart';

class StoreAppCubit extends Cubit<StoreAppStates> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectivityStreamSubscription;

  StoreAppCubit() : super(StoreAppInitialState()) {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.none) {
          emit(ConnectionErrorState());
        } else {
          emit(ConnectionSuccessState());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }

  static StoreAppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(isHome: true, isMerchant: false),
    UploadWishScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNav(int value, context) {
    if (value == 1) {
      FavoriteAndCategoryCubit.get(context)
          .getProductOfCategory(ProductOfCategoryParameters(id: '1',), isRefresh: true);
      selectIndex(0);
    }
    if (value == 3) FavoriteAndCategoryCubit.get(context).getFavorite(NoParameters());
    if (value == 2)
      emit(OpenWishScreenState());
    else {
      currentIndex = value;
      emit(ChangeBottomNavState());
    }
  }

  int selectedIndex = 0;

  void selectIndex(index) {
    selectedIndex = index;
    emit(SelectedIndexState());
  }

  CacheManager cacheManager = CacheManager(Config('images_key',
      maxNrOfCacheObjects: 20, stalePeriod: Duration(days: 1)));

  void clearCache() {
    imageCache.clear();
    imageCache.clearLiveImages();
    cacheManager.emptyCache();
    emit(ClearFromCacheState());
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isOpenDrawer = false;

  void changeDrawer() {
    if (!isOpenDrawer) {
      xOffset = -50;
      yOffset = 150;
      scaleFactor = 0.6;
      isOpenDrawer = true;
      emit(ChangeDrawerState());
    } else {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isOpenDrawer = false;
      emit(ChangeDrawerState());
    }
  }

  UserInformation? userInformation;


  bool isShow = true;
  IconData icon = Icons.visibility_off_outlined;

  void changeVisibilityPassword() {
    isShow = !isShow;
    icon = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

  dynamic category;
  dynamic subCategory;

  void choiceFromCategory(dynamic value) {
    category = value;
    //emit(ChoiceFromCategory());
  }

  void choiceFromSubCategory(dynamic value) {
    subCategory = value;
    emit(ChoiceFromCategory());
  }




  int selectedIndexForMerchant = 0;

  void changeBottomForMerchant({required int index}) {
    selectedIndexForMerchant = index;
    emit(ChangeBottomForMerchant());
  }

}

