import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:store/modules/register/cubit.dart';
import 'package:store/modules/register/states.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class VerifiedScreen extends StatelessWidget {
  var optController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  StreamController<ErrorAnimationType> optControllerError=StreamController<ErrorAnimationType>();
  FirebaseAuth auth=FirebaseAuth.instance;
  bool ?isTimeOut;
  bool?isMarket;
  String verificationId;
  String name;
  String phone;
  String password;
  String address;
  VerifiedScreen({required this.verificationId,required this.phone,required this.name,required this.address,required this.password,this.isTimeOut,this.isMarket});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterUserMarketCubit,RegisterUserMarketStates>(
      listener: (context,state)
      {
        if(state is AuthPhoneErrorState)
          {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'لم تتم عملية التحقق',
              desc: 'هنالك خطأ برمز التحقق',
              btnCancelOnPress: () {},
            )..show();
          }
        if(state is AuthPhoneSuccessState)
          {
            if(isMarket!)
            {
              RegisterUserMarketCubit.get(context).createUser(password: password, name: name, phone: phone, address: address,userType: 0,context: context);

            }
            else
            {
              RegisterUserMarketCubit.get(context).createUser(password: password, name: name, phone: phone, address: address,userType: 1,context: context);
            }
          }
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
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/verified.png'),height: MediaQuery.of(context).size.height*0.3,),
                        SizedBox(
                          height: 10,
                        ),
                        PinCodeTextField(
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return 'امﻷ الحقل';
                              }
                            return null;
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            selectedColor: primaryColor,
                            selectedFillColor: primaryColor,
                            //errorBorderColor: Colors.red,
                            inactiveFillColor: Colors.white,
                            inactiveColor: primaryColor
                          ),

                          textStyle: TextStyle(
                            color: Colors.black
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.white70,
                          enableActiveFill: true,
                          errorAnimationController: optControllerError,
                          controller: optController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {

                          },
                          beforeTextPaste: (text) {
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title:Text("Allowing to paste $text") ,
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);

                                }, child: Text('نعم')),
                                TextButton(onPressed: ()
                                {
                                }, child: Text('لا')),
                              ],
                            ));
                            return true;
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc

                          }, appContext: context,
                        ),
                        if(isTimeOut!)
                        Row(
                          children: [
                            Text('لم يصل رمز التحقق؟',style: Theme.of(context).textTheme.caption,),
                            Container(height: MediaQuery.of(context).size.height*0.05, child: TextButton(onPressed:state is VerifiedPhoneLoadingState?null: ()
                            {
                              RegisterUserMarketCubit.get(context).verifiedPhone(phone);
                            }, child: Text('إعادة ارسال')))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed:state is AuthPhoneLoadingState||isTimeOut!?null: ()async
                            {
                              print(password);
                              RegisterUserMarketCubit.get(context).authPhone(verificationId: verificationId, opt: optController.text, password: password, name: name, phone: phone, address: address, context: context);
                            },
                            child:State is AuthPhoneLoadingState? Text('انتظر...'):Text('تحقق'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
