import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/login/login_screen.dart';
import 'package:store/modules/register/cubit.dart';
import 'package:store/modules/register/states.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

import '../shared/style/icon_broken.dart';

class ChoiceUser extends StatelessWidget {
  const ChoiceUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<RegisterUserMarketCubit,RegisterUserMarketStates>(
        listener: (context,state)
        {
          if(state is RegisterUserMarketSuccessState)
            {
              if(state.registerModel.state!)
              {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text(
                  '${state.registerModel.message}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),Colors.green, Duration(seconds: 2)));

              }
              else
              {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar( Text(
                  ' ${state.registerModel.message} تأكد من البيانات المدخلة ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ), Colors.red, Duration(seconds: 3),));
              }

            }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image:AssetImage('assets/images/cartfull.png'),
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'مرحباً ',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'يمكنك الان من تجربة التطبيق يرجى اختيار نوع المستخدم',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    clipBehavior:Clip.antiAlias ,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        navigateTo(context, LoginScreen(isMarket: true,));
                      },
                      height: 50,
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              'تاجر',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            IconBroken.Arrow___Left_2,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    clipBehavior:Clip.antiAlias ,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        navigateTo(context, LoginScreen(isMarket: false,));
                      },
                      height: 50,
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'صاحب محل',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            IconBroken.Arrow___Left_2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
