import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/models/category_product_model.dart';
import 'package:store/modules/categoryandfavorite/models/categories_model.dart';
import 'package:store/modules/categoryandfavorite/models/favorites_model.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/modules/manage_product/model/sub_category_model.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

class CategoriesAndFavoriteCubit extends Cubit<CategoriesAndFavoriteState>
{
  CategoriesAndFavoriteCubit():super(CategoriesAndFavoriteInitState());

 static CategoriesAndFavoriteCubit get(BuildContext context)=>BlocProvider.of(context);

  CategoriesModel? categoriesModel;
  void getCategories()async
  {
    if(await checkConnection()){
      DioHelper.getData(
        url: CATEGORIES,
        token: token,
      ).then((value) {
        categoriesModel=CategoriesModel.fromJson(value.data);
        print(value.data);
        emit(StoreCategoriesSuccessState());
      }).catchError((error){
        emit(StoreCategoriesErrorState());
      }).timeout(Duration(seconds: 60),onTimeout: (){
        emit(StoreCategoriesErrorState());
      });
    }
  }
  CategoryIncludeProduct? categoryIncludeProduct;
  void getProductIncludeCategory(String id)async
  {
    if(await checkConnection()) {
      try {
        DioHelper.postData(
            url: PRODUCTCAT,
            token: token,
            data: {
              'id_cate': id
            }
        ).then((value) {
          if (value.statusCode == 200) {
            categoryIncludeProduct =
                CategoryIncludeProduct.fromJson(value.data);
            categoryIncludeProduct!.products.forEach((element) {
              // inTheCart.addAll({element.idProduct!:false});
            });
            emit(getProductIncludeCategorySuccessState());
          }
        }).catchError((error) {
          print(error.toString());
          emit(getProductIncludeCategoryErrorState());
        }).timeout(Duration(seconds: 60),onTimeout: (){
          emit(getProductIncludeCategoryErrorState());
        });
      }
      catch (e) {
        print(e.toString());
      }
    }
  }
  FavoritesModel? favoritesModel;
  void getFavorites()async
  {
    if(await checkConnection()) {
      emit(GetFavoritesLoadingState());
      DioHelper.getData(
          url: FAVORITES,
          query: {
            'Authorization': token,
          }
      ).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        //print(favoritesModel!.products[0].idProduct);
        print(value.data);
        emit(GetFavoritesSuccessState());
      }).catchError((error) {
        emit(GetFavoritesErrorState());
      }).timeout(Duration(seconds: 60),onTimeout: ()
      {
        emit(GetFavoritesErrorState());
      });
    }
  }
  SubCategoryModel? subCategoryModel;
  void getSubOfCategory({required String id}) async {
    if (await checkConnection()) {
      emit(GetSubOfCategoryLoadingState());
      DioHelper.postData(
        url: 'cate_child.php',
        data: {
          'id_cate': id,
        },
      ).then((value) {
        subCategoryModel=SubCategoryModel.fromJson(value.data);
        emit(GetSubOfCategorySuccessState());
        // ignore: argument_type_not_assignable_to_error_handler
      }).catchError(() {
        emit(GetSubOfCategoryErrorState());
      });
    }
  }

}