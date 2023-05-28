import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/menu_item.dart';
import 'package:store/modules/call_me_screen.dart';
import 'package:store/modules/order/screens/orders_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class MenuItems
{
  static var address= MenuItemDrawer(Icons.location_on_outlined, 'الموقع');
  static var orders= MenuItemDrawer(Icons.account_tree_outlined, 'طلباتي');
  static var all=<MenuItemDrawer>[
    address,
    orders
  ];
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            backgroundColor: primaryColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 10,top: 100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/prof.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if(StoreAppCubit.get(context).userInformation!=null)
                      Text('${StoreAppCubit.get(context).userInformation!.name}'),
                      SizedBox(height: 5,),
                      if(StoreAppCubit.get(context).userInformation!=null)
                      Text(
                          '${StoreAppCubit.get(context).userInformation!.phone}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,color: Colors.white,),
                              SizedBox(width: 10,),
                              if(StoreAppCubit.get(context).userInformation!=null)
                              Text('${StoreAppCubit.get(context).userInformation!.address}',style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'tajawal-light'
                              ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if(token!=null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()
                          {
                            StoreAppCubit.get(context).getOrdersForUser();
                            navigateTo(context, OrdersScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Icon(Icons.account_tree,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('طلباتي',style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'tajawal-light'
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if(token==null)
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                loginNow,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'tajawal-light',
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()
                          {
                            navigateTo(context, CallMeScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Icon(Icons.phone,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('اتصل بنا',style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'tajawal-light'
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()
                          {
                            logOut(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app,color: Colors.white,),
                              SizedBox(width: 20,),
                              Text('تسجيل خروج',style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'tajawal-light'
                              ),),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
  Widget buildMenuItem(MenuItemDrawer itemDrawer)=>ListTile(
    minLeadingWidth: 20.w ,

    title: Icon(itemDrawer.icon,color: Colors.white,size: 22,),
    leading: Text('${itemDrawer.title}',style: TextStyle(
      fontSize: 14.sp,
      fontFamily: 'tajawal-light'
    ),),
    onTap: (){},
  );
}
