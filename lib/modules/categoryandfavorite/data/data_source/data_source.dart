import 'package:dio/dio.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/categoryandfavorite/data/models/category_model.dart';
import 'package:store/modules/categoryandfavorite/data/models/products_of_category_model.dart';
import 'package:store/modules/categoryandfavorite/data/models/sub_cate_model.dart';
import 'package:store/modules/categoryandfavorite/domain/usecase/get_product_of_category_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';

abstract class BaseCategoryAndFavoriteDataSource {
  Future<CategoryModel> getCategories();
  Future<ProductsOfCategoryModel> getProductsOfCategory(ProductOfCategoryParameters parameters);
  Future<ProductsOfCategoryModel> getFavorite(NoParameters parameters);
  Future<SubCateModel> getSubCate(String id);
}
class CategoryAndFavoriteDataSource extends BaseCategoryAndFavoriteDataSource
{
  @override
  Future<CategoryModel> getCategories()async {
    final response=await Dio().get('$baseUrl$CATEGORIES');
    if(response.statusCode==200)
      {
        return CategoryModel.fromJson(response.data);
      }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<ProductsOfCategoryModel> getProductsOfCategory(ProductOfCategoryParameters parameters)async {
    final response=await Dio().post('$baseUrl$PRODUCTCAT',data: {'page':parameters.page,'id_cate':parameters.id});
    if(response.statusCode==200)
    {
      return ProductsOfCategoryModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<ProductsOfCategoryModel> getFavorite(NoParameters parameters)async {
    final response=await Dio().get('$baseUrl$FAVORITES',queryParameters: {'Authorization':token});
    if(response.statusCode==200)
    {
      return ProductsOfCategoryModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<SubCateModel> getSubCate(String id)async {
    final response=await Dio().post('${baseUrl}cate_child.php',data: {'id_cate':id});
    if(response.statusCode==200)
    {
      return SubCateModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }



}