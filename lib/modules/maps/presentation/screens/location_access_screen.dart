import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store/modules/auth/login/login_cubit/cubit.dart';
import 'package:store/modules/auth/login/login_cubit/states.dart';
import 'package:store/modules/auth/login/login_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class LocationAccessScreen extends StatelessWidget {
  bool? isMarket;
  LocationAccessScreen({this.isMarket});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginUserMarketCubit(),
      child: BlocConsumer<LoginUserMarketCubit,LoginUserMarketStates>(
        listener: (context,state)
        {
          if(state is LocationDoNotOpenState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('Go To Phone Setting And Take Location Permission To App'), Colors.amber, Duration(seconds: 2)));
            }
          if(state is LocationState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('please turn on the location'), Colors.amber, Duration(seconds: 2)));
            }
          if(state is LocationOpenState){
            navigateToReplacement(context, LoginScreen(isMarket:isMarket! ));
          }
        },
        builder: (context,state)
        {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Align(alignment:AlignmentDirectional.center,child: Lottie.asset('assets/lottie/location.json',height: 300)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Location Permission Required',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1. ',style: TextStyle(color: Colors.black54,fontSize: 16),),
                              Expanded(
                                child: Text(
                                  'To use Talabyyat you must turn on location. ',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('2. ',style: TextStyle(color: Colors.black54,fontSize: 16),),
                              Expanded(
                                child: Text(
                                  'Location Works in background.',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('3. ',style: TextStyle(color: Colors.black54,fontSize: 16),),
                              Expanded(
                                child: Text(
                                'Talabyyat collects location data to enable deliver the order to your location if the user\'s status is "shop owner", ',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                         SizedBox(
                           height: 2,
                         ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('_  ',style: TextStyle(color: Colors.black54,fontSize: 16),),
                              Expanded(
                                child: Text(
                                'Or take the order from your location if the user status is "Merchant"',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 16,
                                  ),

                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'من اجل استخدام طلبيات يجب عليك تفعيل الموقع',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 3,color: ColorsApp.primaryColor)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.not_listed_location,color: primaryColor,size: 28,),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(child: Text(
                                'We use location to deliver the order to your address',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'tajawal-light'
                                )
                                ,)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 3,color: ColorsApp.primaryColor)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.check_circle,color: primaryColor,size: 28,),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                  child: Text(
                                    'OR to take order from you',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontFamily: 'tajawal-light'
                                    ),
                                  )),
                            ],
                          ),
                         // Spacer(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: ()
                                {
                                  LoginUserMarketCubit.get(context).determinePosition();
                                }, child: Text('تشغيل | Turn On',style: TextStyle(fontSize: 18),)),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
