import 'dart:io';

import 'package:store/modules/choice_user.dart';
import 'package:store/shared/components/components.dart';

import '../../network/local/cache_helper.dart';

String? token='';
String uId='';
bool? location;

void logOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateToEnd(context, ChoiceUser());
    }
  });
bool check=false;
}
Future<bool> checkConnection()
async{
  try
  {
    final result=await InternetAddress.lookup('google.com');
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
