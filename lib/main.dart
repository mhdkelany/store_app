import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:store/layout/big_cubit/big_cubit.dart';
import 'package:store/layout/big_cubit/states_big.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/choice_user.dart';
import 'package:store/modules/main_screen.dart';
import 'package:store/modules/on_boarding_screen.dart';
import 'package:store/modules/register/cubit.dart';
import 'package:store/modules/register/states.dart';
import 'package:store/modules/splash_screen.dart';
import 'package:store/modules/zoom_drawer_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'package:store/shared/style/route_manager.dart';
import 'package:store/shared/style/theme.dart';

import 'layout/layout_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  token=CacheHelper.getCacheData(key: 'token');
  bool? isBoard=CacheHelper.getCacheData(key: 'onBoard');
  bool? isSailing=CacheHelper.getCacheData(key: 'isSailing');
  Widget widget;
  if(isBoard!=null)
  {
    if(token!=null)
    {
      if(isSailing!)
      {
        widget=MainScreen();
      }
      else
        widget=DrawerScreen();
    }
    else{
      widget=ChoiceUser();
    }
  }
  else{
    widget=OnBoardingScreen();
  }

  runApp( MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
Widget? widget;
MyApp({this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>RegisterUserMarketCubit()),
        BlocProvider(create: (BuildContext context)=>StoreAppCubit()..clearCache()),
        BlocProvider(create: (BuildContext context)=>NetConnectionCubit()),
      ],
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state) {
          // if(state is emitNetDisConnected)
          //   {
          //     print('ssssssssssss');
          //     //ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('data'), Colors.red, Duration(seconds: 5)));
          //
          //   }
          // if(state is emitNetConnected)
          //   {
          //     print('mmmmmm');
          //     StoreAppCubit.get(context).getProfile(context);
          //     StoreAppCubit.get(context).getProductIncludeCategory('1');
          //     StoreAppCubit.get(context).getCategories();
          //   }
        },
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            themeMode: ThemeMode.light,
            // onGenerateRoute: RoutesManager.getRoute,
            // initialRoute: Routes.splashRoute,
            home:Directionality(
              textDirection: TextDirection.rtl,
              child:widget!
              )

          );
        },
      ),
    );
  }
}

