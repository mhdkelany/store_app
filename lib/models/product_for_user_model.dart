import 'home_model.dart';

class ProductForUserModel
{
  bool? profileStatus;
  bool? status;
  String? message;
  List<Products> productForUser=[];
  ProductForUserModel.fromJson(dynamic json)
  {
    if(json['state']!=null)
      status=json['state'];
    if(json['state_profile']!=null)
      profileStatus=json['state_profile'];
    message=json['message'];
    if(json['product']!=null)
      json['product'].forEach((element)
      {
        productForUser.add(Products.fromJson(element));
      });
  }
}