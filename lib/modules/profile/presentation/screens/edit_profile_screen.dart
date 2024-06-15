import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/auth/login/login_cubit/states.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/maps/presentation/controller/map_cubit.dart';
import 'package:store/modules/maps/presentation/screens/map_change_screen.dart';
import 'package:store/modules/profile/domain/usecase/edit_profile_usecase.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';
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
    nameController.text=ProfileCubit.get(context).userInformation!.name!;
    phoneController.text=ProfileCubit.get(context).userInformation!.phone!;
    addressController.text=' |  انقر لتحديث الموقع';
    return BlocConsumer<ProfileCubit,ProfileState>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
        if(state is ChangeProfileSuccessState)
          {
            print(0);
            if(state.editProfileEntity.status!)
              {
                print(state.editProfileEntity.token);
                CacheHelper.putData(key: 'token', value:state.editProfileEntity.token ).then((value) {
                  token=null;
                  token=CacheHelper.getCacheData(key: 'token');
                ProfileCubit.get(context).getProfile(NoParameters(),context);
                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تم التعديل بنجاح'), Colors.green, Duration(seconds: 5)));
                  ProfileCubit.get(context).removeState();
                });
              }else{
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لم يتم التعديل، الرجاء التأكد من الحقول المدخلة'), Colors.red, Duration(seconds: 5)));
              ProfileCubit.get(context).removeState();
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
                        if(ProfileCubit.get(context).userInformation!.userType==0)
                        SizedBox(
                          height: 20.0,
                        ),
                        if(ProfileCubit.get(context).userInformation!.userType==0)
                        defaultTextFromField(
                          readOnly: true,
                            isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            controller: addressController,
                            text: 'العنوان',
                            onTap: (){
                              MapCubit.get(context).myMarker=[];
                              MapCubit.get(context).isBill=false;
                            MapCubit.get(context).initialMap(context);
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
                              if(ProfileCubit.get(context).userInformation!.userType==0) {
                                ProfileCubit.get(context).editProfile(
                                  EditProfileParameters(
                                  lat: MapCubit.get(context).lat,
                                  lng: MapCubit.get(context).lng,
                                    userType: 0,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,)
                                    );
                              }
                               else {
                                ProfileCubit.get(context).editProfile(
                                    EditProfileParameters(
                                      lat: MapCubit.get(context).lat,
                                      lng: MapCubit.get(context).lng,
                                      userType:1 ,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,)
                                );
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
