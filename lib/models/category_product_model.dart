import 'home_model.dart';

class CategoryIncludeProduct {
  bool? status;
  String? message;
  List<Products>products = [];

  CategoryIncludeProduct.fromJson(dynamic json)
  {
    status = json['state'];
    message = json['message'];
    if(json['data']!=null)
    json['data'].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}
