import 'dart:convert';

import 'package:store/layout/cubit/cubit.dart';
import 'package:store/models/products_cart_model.dart';
import 'package:store/shared/components/constansts/constansts.dart';

// CartModel listModelFromJson(dynamic json)
// {
//   return CartModel(
//     products: (json['data'])?.map((e) =>e==null?null:CartProducts.fromJson(e as dynamic))?.toList(),
//   );
// }
Map<String,dynamic> listModelToJson(String total,context)=><String,dynamic>{

  'products':jsonEncode(StoreAppCubit.get(context).product),
  'total':total,
  'Authorization':token
};