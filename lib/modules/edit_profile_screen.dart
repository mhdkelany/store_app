import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/map_change_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/network/local/cache_helper.dart';

class EditProfileScreen extends StatelessWidget {
var nameController=TextEditingController();
var phoneController=TextEditingController();
var addressController=TextEditingController();
var passwordController=TextEditingController();
var formKey=GlobalKey<FormState>();
String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  @override
  Widget build(BuildContext context) {
    nameController.text=StoreAppCubit.get(context).userInformation!.name!;
    phoneController.text=StoreAppCubit.get(context).userInformation!.phone!;
    addressController.text=' |  انقر لتحديث الموقع';
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
        if(state is ChangeProfileSuccessState)
          {
            if(state.editProfileModel.status!)
              {
                print(state.editProfileModel.token);
                CacheHelper.putData(key: 'token', value:state.editProfileModel.token ).then((value) {
                  token=null;
                  token=CacheHelper.getCacheData(key: 'token');
                StoreAppCubit.get(context).getProfile(context);
                    //navigateToEnd(context, ProfileScreen());
                });
              }
          }
      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/editprof.png'),
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height*0.3,
                        ),
                        defaultTextFromField(
                            isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            controller: nameController,
                            text: 'اسم المحل',
                            prefix: Icons.home_work_outlined,
                            inputType: TextInputType.name,
                            validate: (String value)
                            {
                              //    validator(value, 5, 20, 'name');
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                              if(value.trim().length<5)
                                return 'يجب ان تكون القيمة اكبر من 5';
                              if(value.trim().length>20)
                                return 'يجب ان تكون القيمة اقل من 20';
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFromField(
                            isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            controller: phoneController,
                            text: 'رقم الجوال',
                            prefix: Icons.call,
                            inputType: TextInputType.number,
                            validate: (String value)
                            {
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                              if(value.trim().length<10)
                                return 'يجب ان تكون القيمة اكبر من 10';
                              if(value.trim().length>11)
                                return 'يجب ان يكون الرقم يساوي 10';
                              RegExp reg=RegExp(pattern);
                              if(!reg.hasMatch(value))
                              {
                                return 'يجب ادخال رقم هاتف';
                              }
                            }
                        ),
                        if(StoreAppCubit.get(context).userInformation!.userType==0)
                        SizedBox(
                          height: 20.0,
                        ),
                        if(StoreAppCubit.get(context).userInformation!.userType==0)
                        defaultTextFromField(
                          readOnly: true,
                            isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            controller: addressController,
                            text: 'العنوان',
                            onTap: (){
                              StoreAppCubit.get(context).myMarker=[];
                              StoreAppCubit.get(context).isBill=false;
                            StoreAppCubit.get(context).initialMap();
                            navigateTo(context, MapChangeScreen());
                            },
                            prefix: Icons.location_on,
                            inputType: TextInputType.text,
                            validate: (String value)
                            {
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFromField(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ) ,
                            controller: passwordController,
                            text: 'كلمة المرور الجديدة',
                            prefix: Icons.lock_outline,
                            suffix: StoreAppCubit.get(context).icon,
                            inputType: TextInputType.visiblePassword,
                            validate: (String value)
                            {
                              if(phoneController.text.isEmpty) {
                                if (value.trim().length < 8)
                                  return 'يجب ان تكون القيمة اكبر من 8';
                                if (value.trim().length > 20)
                                  return 'يجب ان تكون القيمة اقل من 20';
                              }
                              if(!passwordController.text.isEmpty)
                                {
                                  if (value.trim().length < 8)
                                    return 'يجب ان تكون القيمة اكبر من 8';
                                  if (value.trim().length > 20)
                                    return 'يجب ان تكون القيمة اقل من 20';
                                }
                            }
                            ,
                            isShow: StoreAppCubit.get(context).isShow,
                            onPressedSuffix: ()
                            {
                              StoreAppCubit.get(context).changeVisibilityPassword();
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          function:state is ChangeProfileLoadingState?null: ()
                          {
                            if(formKey.currentState!.validate()) {
                              //navigateTo(context, LoginScreen());
                              if(StoreAppCubit.get(context).userInformation!.userType==0) {
                                StoreAppCubit.get(context).editProfile(
                                    userType: 0,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    );
                                print('${StoreAppCubit.get(context).lat} sssss');
                                print('${StoreAppCubit.get(context).lng} lng');
                              }
                               else {
                                StoreAppCubit.get(context).editProfile(
                                    userType: 1,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                                // print(StoreAppCubit.get(context).lat);
                                print(StoreAppCubit
                                    .get(context)
                                    .userInformation!
                                    .userType);
                              }
                            }
                          },
                          widget:state is ChangeProfileLoadingState?
                          Row(
                            children: [
                              Text(
                                'جاري التعديل...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                              : Text(
                            'تعديل',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
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
