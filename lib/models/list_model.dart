import 'dart:convert';

import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/shared/components/constansts/constansts.dart';

// CartModel listModelFromJson(dynamic json)
// {
//   return CartModel(
//     products: (json['data'])?.map((e) =>e==null?null:CartProducts.fromJson(e as dynamic))?.toList(),
//   );
// }
Map<String,dynamic> listModelToJson(String total,context)=><String,dynamic>{

  'products':jsonEncode(OrderCubit.get(context).product),
  'total':total,
  'Authorization':token
};