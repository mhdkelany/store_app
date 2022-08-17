import 'package:store/models/home_model.dart';

class FavoritesModel
{
  bool? status;
  String? message;
  List<Products>products = [];

  FavoritesModel.fromJson(dynamic json)
  {
    status = json['state'];
    message = json['message'];
    if(json['data']!=null)
    json['data'].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}
class FavoritesData {
  String? idProduct;
  String? name;
  String? shortDescription;
  String? longDescription;
  dynamic? price;
  String? quantity;
  String? idUser;
  String? image;
  bool? inFavorites;

  FavoritesData.fromJson(dynamic json)
  {
    name = json['pro_name'];
    idProduct = json['id_pro'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    price = json['price'];
    quantity = json['quantity'];
    idUser = json['id_user'];
    image = json['img'];
    inFavorites = json['isfav'];
  }
}