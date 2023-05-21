import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/choice_user.dart';
import 'package:store/modules/main_screen.dart';
import 'package:store/modules/on_boarding_screen.dart';
import 'package:store/modules/auth/register/cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';
import 'package:store/modules/zoom_drawer_screen.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'package:store/shared/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getCacheData(key: 'token');
  bool? isBoard = CacheHelper.getCacheData(key: 'onBoard');
  bool? isSailing = CacheHelper.getCacheData(key: 'isSailing');
  Widget widget;
  if (isBoard != null) {
    if (token != null) {
      if (isSailing!) {
        widget = MainScreen();
      } else
        widget = DrawerScreen();
    } else {
      widget = ChoiceUser();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  Widget? widget;

  MyApp({this.widget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext context) => RegisterUserMarketCubit()),
              BlocProvider(
                create: (BuildContext context) => StoreAppCubit(),
              ),
              BlocProvider(
                create: (context) => RePasswordCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => CategoriesAndFavoriteCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => OrderCubit(),
              ),
            ],
            child: BlocConsumer<StoreAppCubit, StoreAppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: lightMode,
                    themeMode: ThemeMode.light,
                    // onGenerateRoute: RoutesManager.getRoute,
                    // initialRoute: Routes.splashRoute,
                    home: Directionality(
                        textDirection: TextDirection.rtl, child: widget!));
              },
            ),
          );
        });
  }
}
