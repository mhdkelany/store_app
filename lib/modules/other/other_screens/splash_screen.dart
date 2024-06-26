import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/other/other_screens/choice_user.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/other/other_screens/on_boarding_screen.dart';
import 'package:store/modules/home/presentation/screen/zoom_drawer_screen.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/style/color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/shared/components/constansts/constansts.dart';

import '../../../shared/components/components.dart';
import '../../home/presentation/screen/main_screen.dart';

class SplashScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
  // token=CacheHelper.getCacheData(key: 'token');


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
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,state)
      {
        if(state is StoreHomeSuccessState)
        {
          if(state.homeEntity.statusProfile!=null){
            if(!state.homeEntity.statusProfile!)
            {
              logOut(context);
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('نم حظرك مؤقتاً'), Colors.amber, Duration(seconds: 5)));
            }
          }
        }
      },
      builder: (context,state)
      {
        return AnimatedSplashScreen(
          splash:  Column(
            children: [
              Image(
                image: AssetImage("assets/images/shopping.png"),
                width: 120,
                height: 120,
                color: Colors.white,
              ),
              Text(
                'متجرك',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          nextScreen:widget,
          backgroundColor: primaryColor,
          splashIconSize: 160,
          duration: 3000,
          pageTransitionType: PageTransitionType.leftToRight,
        );
      },
    );
  }
}
