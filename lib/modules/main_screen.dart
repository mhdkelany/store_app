import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/add_product_screen.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/drawer_screen.dart';
import 'package:store/modules/main_merchant_screen.dart';
import 'package:store/modules/profile_User_Screen.dart';
import 'package:store/modules/quantity_is_null_screen.dart';
import 'package:store/shared/components/components.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state)
      {
        if(state is ConnectionSuccessState)
        {
          StoreAppCubit.get(context).getProfile(context);
          CategoriesAndFavoriteCubit.get(context).getCategories();
         // ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تم العودة للأتصال',style: TextStyle(),), Colors.green, Duration(seconds: 5)));
        }
        if(state is ConnectionErrorState)
          {
            buildDialog(context, state);
          }

      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: WillPopScope(
            onWillPop: ()=>onBack(context),
            child: Scaffold(
              body: Stack(
                children: [
                  DrawerMerchantScreen(),
                  getWidget(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget getWidget(context)
  {
    if(StoreAppCubit.get(context).selectedIndex==0)
      {
        return MainMerchantScreen();
      }
   else if(StoreAppCubit.get(context).selectedIndex==1)
    {
      return AddProductScreen(isFromDrawer: true,);
    }
   else if(StoreAppCubit.get(context).selectedIndex==2)
    {
      return QuantityIsNullScreen();
    }
   else if(StoreAppCubit.get(context).selectedIndex==3)
    {
      return ProfileUserScreen();
    }
   else return Container();
  }
  Future<bool> onBack(context)async
  {
    bool? exitApp=await showDialog(context: context, builder: (context)=>Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('اغلاق التطبيق'),
        content: Text('هل تريد اغلاق التطبيق؟'),
        actions: [
          TextButton(
              onPressed: ()
              {
                Navigator.of(context).pop(false);
              },
              child: Text('لا')
          ),
          TextButton(
              onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
              child: Text('نعم')
          ),
        ],
      ),
    ));
    return exitApp??false;
  }
}
