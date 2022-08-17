import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/register/cubit.dart';
import 'package:store/modules/register/map_screen.dart';
import 'package:store/modules/register/states.dart';
import 'package:store/modules/register/verified_screen.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constansts/constansts.dart';
import '../../shared/style/color.dart';

class RegisterScreen extends StatelessWidget {
  bool? isMarket;
  RegisterScreen({this.isMarket});
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var cityController=TextEditingController();
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  List<DropdownMenuItem> countries=[DropdownMenuItem(child: Text('1')),];
  @override
  Widget build(BuildContext context) {
    if(RegisterUserMarketCubit.get(context).place!=null)
    cityController.text='${RegisterUserMarketCubit.get(context).place!.locality!},${RegisterUserMarketCubit.get(context).place!.name!}';

    return BlocConsumer<RegisterUserMarketCubit,RegisterUserMarketStates>(
      listener: (context, state)
      {
       if(state is RegisterGetCurrentAddressSuccessState )
         {
           cityController.text=RegisterUserMarketCubit.get(context).place!.locality!;
         }
       if(state is VerifiedPhoneSuccessState)
         {
           navigateTo(context, VerifiedScreen(verificationId: RegisterUserMarketCubit.get(context).verificationIdd,password: passwordController.text, name: nameController.text, phone:phoneController.text, address: cityController.text,isTimeOut: false,isMarket:isMarket));
         }
       if(state is VerifiedPhoneRetrievalState)
         {
           navigateTo(context, VerifiedScreen(verificationId: RegisterUserMarketCubit.get(context).verificationIdd,password: passwordController.text, name: nameController.text, phone:phoneController.text, address: cityController.text,isTimeOut: true,isMarket:isMarket));
         }
       if(state is VerifiedPhoneErrorState)
         {
           AwesomeDialog(
             context: context,
             dialogType: DialogType.ERROR,
             animType: AnimType.BOTTOMSLIDE,
             title: 'خطأ',
             desc: '${RegisterUserMarketCubit.get(context).messageError}',
             btnCancelOnPress: () {},
             btnOkOnPress: () {},
           )..show();
         }
      },
      builder: (context, state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(IconBroken.Arrow___Right_2),),
              title: MaterialButton(
                onPressed: ()
                {
                  if(RegisterUserMarketCubit.get(context).showBottom==false) {
                    showModalBottomSheet(context:context,builder: (context) =>
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            color: Colors.grey[100],
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    navigateTo(context, MapScreen(isMarket: isMarket!,));
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        IconBroken.Plus,
                                        color: primaryColor,
                                        size: 24.0,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'أضف موقع جديد',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, bottom: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                          IconBroken.Send
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        RegisterUserMarketCubit
                                            .get(context)
                                            .place == null
                                            ? 'جاري جلب الموقع الحالي'
                                            : '${RegisterUserMarketCubit
                                            .get(context)
                                            .place!
                                            .country},${RegisterUserMarketCubit
                                            .get(context)
                                            .place!
                                            .locality},${RegisterUserMarketCubit
                                            .get(context)
                                            .place!
                                            .subLocality}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ).then((value) {
                      RegisterUserMarketCubit.get(context).changeBottomSheet(false,context);
                    });
                    RegisterUserMarketCubit.get(context).changeBottomSheet(true,context);
                  }
                  else{
                    RegisterUserMarketCubit.get(context).changeBottomSheet(false,context);
                    Navigator.pop(context);
                    print(RegisterUserMarketCubit.get(context).showBottom);
                  }
                },
                minWidth: 1,
                padding: EdgeInsets.zero,
                height:20 ,
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الموقع الحالي',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                        width: 5.0
                    ),
                    Icon(
                        Icons.arrow_drop_down
                    ),
                  ],
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إنشاء حساب',
                          style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                         isMarket!?'أنشئ حسابك الان لبيع المزيد من المنتجات': 'أنشئ حسابك الان للحصول على المزيد من المنتجات',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFromField(
                          isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            controller: nameController,
                            text: isMarket!?'الاسم':'اسم المحل',
                            prefix: Icons.home_work_outlined,
                            inputType: TextInputType.name,
                            validate: (String value)
                            {
                          //    validator(value, 5, 20, 'name');
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                              if(value.trim().length<3)
                                return 'يجب ان تكون القيمة اكبر من 3';
                              if(value.trim().length>20)
                                return 'يجب ان تكون القيمة اقل من 20';
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // DropdownButtonFormField<dynamic>(
                        //     items: ['دمشق','حلب','حمص','طرطوس','اللاذقية'].map((e) =>DropdownMenuItem(child: Text('$e'),value:e ,)).toList(),
                        //     onChanged: (value)
                        //     {
                        //       RegisterUserMarketCubit.get(context).changeDropButtonItem(value);
                        //     },
                        //   value: RegisterUserMarketCubit.get(context).selectedItem,
                        //   borderRadius: BorderRadius.circular(20.0),
                        //   decoration: InputDecoration(
                        //     border: InputBorder.none
                        //   ),
                        //   hint: Text('اختر المدينة'),
                        //   validator: (value)
                        //   {
                        //
                        //   },
                        // ),
                        defaultTextFromField(
                          isShow: false,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ) ,
                            readOnly: true,
                            controller: cityController,
                            text: 'المدينة',
                            prefix: IconBroken.Location,
                            inputType: TextInputType.text,
                            validate: (String value)
                            {
                              if(value.trim().isEmpty)
                              return 'انتظر لتحميل الموقع';
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFromField(
                         // prefixWidget: Text('+962',style: TextStyle(color: Colors.black),),
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
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFromField(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ) ,
                            controller: passwordController,
                            text: 'كلمة المرور',
                            prefix: Icons.lock_outline,
                            suffix: RegisterUserMarketCubit.get(context).icon,
                            inputType: TextInputType.visiblePassword,
                            validate: (String value)
                            {
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                              if(value.trim().length<8)
                                return 'يجب ان تكون القيمة اكبر من 8';
                              if(value.trim().length>20)
                                return 'يجب ان تكون القيمة اقل من 20';
                            }
                            ,
                            isShow: RegisterUserMarketCubit.get(context).isShow,
                            onPressedSuffix: ()
                            {
                              RegisterUserMarketCubit.get(context).changeVisibilityPassword();
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          function:state is VerifiedPhoneLoadingState? null: ()async
                          {
                            if(formKey.currentState!.validate()) {

                              print('ssssss');
                              RegisterUserMarketCubit.get(context).verifiedPhone(phoneController.text);
                            }
                          },
                          widget:state is VerifiedPhoneLoadingState?
                          Row(
                            children: [
                              Text(
                                'الرجاء الانتظار...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                              : Text(
                            'إنشاء حساب',
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
//AIzaSyBlZOVy5fanzdlB9Dkb-MQhLrkgZ51TGhI