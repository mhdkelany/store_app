import 'package:store/models/home_model.dart';
import 'package:store/modules/categoryandfavorite/data/models/products_of_category_model.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';

class SearchModel
{
  bool? status;
  String? message;
  List<Product>products = [];

  SearchModel.fromJson(dynamic json)
  {
    status = json['state'];
    message = json['message'];
    if(json['data']!=null)
      json['data'].forEach((element) {
        products.add(ProductModel.fromJson(element));
      });
  }
}