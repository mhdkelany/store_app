import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/core/exception.dart';
import 'package:store/core/network/error_model.dart';
import 'package:store/modules/manage_product/data/model/edit_product_model.dart';
import 'package:store/modules/manage_product/data/model/own_product_model.dart';
import 'package:store/modules/manage_product/data/model/search_prodyct_model.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/end_point/end_point.dart';
import 'package:http/http.dart' as http;


abstract class BaseManageProductDataSource {
  Future<OwnProductModel> getOwnProducts(int page);
  Future<OwnProductModel> getAllOwnProducts();
  Future<OwnProductModel> addProduct(AddProductParameters parameters);
  Future<EditProductModel> editProduct(AddProductParameters parameters);
  Future<EditProductModel> postWish(String parameters);
  Future<SearchProductModel> searchProduct(String parameters);
}

class ManageProductDataSource extends BaseManageProductDataSource {
  @override
  Future<OwnProductModel> getOwnProducts(int page) async {
    final response = await Dio().post('$baseUrl$GET_PRODUCT_FOR_USER', data: {
      'Authorization': token,
      'page': page,
    });
    if(response.statusCode==200)
      {
        return OwnProductModel.fromJson(response.data);
      }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<OwnProductModel> addProduct(AddProductParameters parameters)async {
    var request = await http.MultipartRequest(
        "POST", Uri.parse('https://ibrahim-store.com/api2/add_pro.php'));
    var length = await parameters.file!.length();
    var multiPartFile = http.MultipartFile(
        "image", http.ByteStream(parameters.file!.openRead()), length,
        filename: parameters.file!.path.split('/').last);
    request.files.add(multiPartFile);
    request.fields['name'] = parameters.data['name'];
    request.fields['short_description'] = parameters.data['shortDescription'];
    request.fields['long_description'] = parameters.data['longDescription'];
    request.fields['price'] = parameters.data['price'];
    request.fields['quantity'] = parameters.data['quantity'];
    request.fields['Authorization'] = parameters.data['token'];
    request.fields['id_cate'] = parameters.data['idCategory'];

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      print(response.body);
      Navigator.pop(parameters.context);
      return OwnProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<EditProductModel> editProduct(AddProductParameters parameters)async {
    var request = await http.MultipartRequest("POST",
        Uri.parse('https://ibrahim-store.com/api2/update_details_pro.php'));
    if (parameters.file != null) {
      var length = await parameters.file!.length();
      var multiPartFile = http.MultipartFile(
          "image", http.ByteStream(parameters.file!.openRead()), length,
          filename: parameters.file!.path.split('/').last);
      request.files.add(multiPartFile);
    }
    request.fields['name'] = parameters.data['name'];
    request.fields['short_description'] = parameters.data['shortDescription'];
    request.fields['long_description'] = parameters.data['longDescription'];
    request.fields['price'] = parameters.data['price'];
    request.fields['quantity'] = parameters.data['quantity'];
    request.fields['Authorization'] = parameters.data['token'];
    request.fields['id_cate'] = parameters.data['idCategory'];
    request.fields['id_pro'] = parameters.data['idProduct'];
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if(myRequest.statusCode==200)
      {
        return EditProductModel.fromJson(jsonDecode(response.body));
      }else{
      throw ServerException(ErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<EditProductModel> postWish(String parameters)async {
    final response = await Dio().post('$baseUrl$WISH', data: {
      'Authorization': token,
      'description': parameters,
    });
    if(response.statusCode==200)
    {
      return EditProductModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<OwnProductModel> getAllOwnProducts() async {
    final response = await Dio().post('$baseUrl$GET_PRODUCT_FOR_USER', data: {
      'Authorization':token,
      'page':0,
    });
    if(response.statusCode==200)
    {
      return OwnProductModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<SearchProductModel> searchProduct(String parameters) async{
    final response = await Dio().post('$baseUrl$SEARCH', data: {
      'product':parameters
    });
    if(response.statusCode==200)
    {
      return SearchProductModel.fromJson(response.data);
    }else{
      throw ServerException(ErrorModel.fromJson(response.data));
    }
  }
}
