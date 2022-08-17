import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/cart_screen.dart';
import 'package:store/modules/uploade_wish_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../modules/search_screen.dart';

class LayoutScreen extends StatelessWidget {
  var keyOne=GlobalKey();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('ssss');
    //   if(ShowCaseWidget.of(context).mounted)
    //    ShowCaseWidget.of(context).startShowCase([
    //     keyOne,
    //   ]);
    // });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state)
        {
          if(state is StoreHomeSuccessState)
          {
            if(state.homeModel.status!=null){
              if(!state.homeModel.status!)
              {
                logOut(context);
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('نم حظرك مؤقتاً'), Colors.amber, Duration(seconds: 5)));
              }
            }
          }
          if(state is OpenWishScreenState)
            navigateTo(context, UploadWishScreen());
          if(state is ConnectionErrorState)
          {
            buildDialog(context, state);
          }
          if(state is ConnectionSuccessState)
          {
            StoreAppCubit.get(context).getProfile(context);
            StoreAppCubit.get(context).getCategories();
            print('innnnnnnn');
              // ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              //     Text('تم العودة للأتصال', style: TextStyle(),), Colors.green,
              //     Duration(seconds: 5)));


          }
          if(state is CheckSocketState)
            {
              buildDialog(context, state);
            }

        },
        builder: (context, state)
        {
          return WillPopScope(
            onWillPop: ()=>onBack(context),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(icon:Icon(Icons.menu_sharp),onPressed: (){
                  return ZoomDrawer.of(context)!.toggle();

                },),
                actions: [
                  IconButton(onPressed: (){
                   navigateTo(context, SearchScreen());
                  }, icon: Icon(IconBroken.Search)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        IconButton(onPressed: ()
                        {
                          navigateTo(context, CartScreen());
                          StoreAppCubit.get(context).priceTotal=0.0;
                          StoreAppCubit.get(context).getTotalBill();
                        }
                            ,icon:Icon(IconBroken.Buy)),
                        if(StoreAppCubit.get(context).product.length>0)
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.red.withOpacity(0.9),
                            child: Text('${StoreAppCubit.get(context).i}',style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home),
                      label: 'الرئيسية'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Category),
                      label: 'الاقسام'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Paper_Upload),
                      label: 'الأمنيات'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline),
                      label: 'المفضلة'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Profile),
                      label: 'حسابي'
                  ),
                ],
                currentIndex:StoreAppCubit.get(context).currentIndex ,
                onTap: (value)
                {
                  StoreAppCubit.get(context).changeBottomNav(value);
                },
              ),
              body:StoreAppCubit.get(context).screens[StoreAppCubit.get(context).currentIndex] ,
            ),
          );
          // return Scaffold(
          //   body: Stack(
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //             colors: [
          //               primaryColor,
          //               primaryColor,
          //
          //             ],
          //             begin: Alignment.bottomCenter,
          //             end: Alignment.topCenter
          //           )
          //         ),
          //       ),
          //       SafeArea(
          //           child: Container(
          //             width: 100.0,
          //             padding: EdgeInsets.all(8.0),
          //             child: Column(
          //               children: [
          //                 DrawerHeader(
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         CircleAvatar(
          //                           radius: 50.0,
          //                           backgroundImage: AssetImage('assets/images/prof.png'),
          //                         ),
          //                         SizedBox(
          //                           height: 10,
          //                         ),
          //                         Text(
          //                           'الاسم',
          //                           style: TextStyle(
          //                             fontSize: 20.0
          //                           ),
          //                         )
          //                       ],
          //                     )
          //                 ),
          //                 ListView(
          //                   children: [
          //                     ListTile(
          //                       onTap: (){},
          //                       leading: Icon(
          //                         Icons.home,
          //                         color: Colors.white,
          //                       ),
          //                       title: Text(
          //                         'طلباتي',
          //                         style: TextStyle(
          //                           fontFamily: 'tajawal-light'
          //                         ),
          //                       ),
          //                     ),
          //                     ListTile(
          //                       onTap: (){},
          //                       leading: Icon(
          //                         Icons.settings,
          //                         color: Colors.white,
          //                       ),
          //                       title: Text(
          //                         'الاعدادات',
          //                         style: TextStyle(
          //                           fontFamily: 'tajawal-light'
          //                         ),
          //                       ),
          //                     ),
          //                     ListTile(
          //                       onTap: (){},
          //                       leading: Icon(
          //                         Icons.login_outlined,
          //                         color: Colors.white,
          //                       ),
          //                       title: Text(
          //                         'تسجيل خروج',
          //                         style: TextStyle(
          //                           fontFamily: 'tajawal-light'
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 )
          //               ],
          //             ),
          //           )
          //       ),
          //       TweenAnimationBuilder(
          //           tween: Tween<double>(begin: 0,end: StoreAppCubit.get(context).value),
          //           duration: Duration(milliseconds: 500),
          //           builder: (_,double val,__)
          //           {
          //             return(Transform(
          //               alignment: Alignment.center,
          //               transform: Matrix4.identity()
          //               ..setEntry(3, 2, 0.001)
          //               ..setEntry(0, 3, 200*val)
          //               ..rotateY((pi/6)*val),
          //               child: Scaffold(
          //                 appBar: AppBar(
          //                   title: IconButton(icon:Icon(Icons.menu_sharp),onPressed: (){StoreAppCubit.get(context).getHome();},),
          //                   actions: [
          //                     IconButton(onPressed: (){
          //                       logOut(context);
          //                     }, icon: Icon(IconBroken.Search)),
          //                     IconButton(onPressed: ()
          //                     {
          //                       navigateTo(context, CartScreen());
          //                     }
          //                         ,icon:Icon(IconBroken.Buy)),
          //
          //                   ],
          //                 ),
          //                 bottomNavigationBar: BottomNavigationBar(
          //                   items: [
          //                     BottomNavigationBarItem(
          //                         icon: Icon(IconBroken.Home),
          //                         label: 'الرئيسية'
          //                     ),
          //                     BottomNavigationBarItem(
          //                         icon: Icon(IconBroken.Category),
          //                         label: 'الاقسام'
          //                     ),
          //                     BottomNavigationBarItem(
          //                         icon: Icon(IconBroken.Paper_Upload),
          //                         label: 'الأمنيات'
          //                     ),
          //                     BottomNavigationBarItem(
          //                         icon: Icon(Icons.favorite_outline),
          //                         label: 'المفضلة'
          //                     ),
          //                     BottomNavigationBarItem(
          //                         icon: Icon(IconBroken.Profile),
          //                         label: 'حسابي'
          //                     ),
          //                   ],
          //                   currentIndex:StoreAppCubit.get(context).currentIndex ,
          //                   onTap: (value)
          //                   {
          //                     StoreAppCubit.get(context).changeBottomNav(value);
          //                   },
          //                 ),
          //                 body:StoreAppCubit.get(context).screens[StoreAppCubit.get(context).currentIndex] ,
          //               ) ,
          //             ));
          //           }
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           StoreAppCubit.get(context).changeDrawer();
          //         },
          //       )
          //     ],
          //   ),
          // );

        },
      ),
    );
  }
  Future<bool> onBack(context)async
  {
    bool? exitApp=await showDialog(context: context, builder: (context)=>Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text('اغلاق التطبيق'),
        content: Text(StoreAppCubit.get(context).product.length>0?'سوف يتم حذف عناصر السلة':'هل تريد اغلاق التطبيق؟'),
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
