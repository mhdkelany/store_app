import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/utils/services/serviecs_locator.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/cubit.dart';
import 'package:store/modules/auth/register/cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/maps/presentation/controller/map_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/other/other_screens/choice_user.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

import '../../network/local/cache_helper.dart';

String? token;
String fireBaseToken='';
String uId='';
bool? location;
 logOutDeleteToken({required String token,required int id,required BuildContext context})
{
  DioHelper.postData(
    url: 'logout.php',
    data: {
      'token':fireBaseToken,
      "id_user":id
    },
  ).then((value) {
    logOut(context);
  }).catchError((error){
    print(id);
    print(error);
  });
}
void logOut(context, {int? id})
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      HomeCubit.get(context).homeModel=null;
      navigateToEnd(context, ChoiceUser());
      token=null;
    }
  });
bool check=false;
}
Future<bool> checkConnection()
async{
  try
  {
    final result=await InternetAddress.lookup('ibrahim-store.com');
    if(result.isNotEmpty&&result[0].rawAddress.isNotEmpty)
    {
      print('connect');
      return true;
    }
    else
    {
      print('not connect');
      return false;

    }
  }
  on SocketException catch(_)
  {
    print('not connect');
    return false;

  }
}



// Widget checkConnection(Widget internet,Widget noInternet)
// {
//   OfflineBuilder(
//       connectivityBuilder: (
//       BuildContext context,
//       ConnectivityResult connectivity,
//       Widget child,
//   )
//           {
//             final bool connected = connectivity != ConnectivityResult.none;
//             if(connected)
//               {
//                 return internet;
//               }
//             else{
//               return noInternet;
//             }
//           },
//           child: Center(child: CircularProgressIndicator()),
//   );
//   return ;
// }

validator(String value,int min,int max,String type)
{
  if(value.length<min)
  {
    return 'يجب ان تكون القيمة اكبر من $min';
  }
  if(value.length>=max)
  {
    return'يجب ان تكون القيمة اقل من $max';
  }
  if(value.isEmpty)
  {
    return'يجب ان لا يكون فارغا';
  }
}
