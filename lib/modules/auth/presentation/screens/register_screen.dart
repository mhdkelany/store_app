import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/auth/domain/usecase/register_usecase.dart';
import 'package:store/modules/auth/login/widgets/header.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/auth/register/map_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/icon_broken.dart';

import '../../../../shared/style/color.dart';


class RegisterScreen extends StatelessWidget {
 String cityChoice='';
  bool? isMarket;

  RegisterScreen({this.isMarket});

  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        /*if (state is VerifiedPhoneSuccessState) {
          navigateTo(
              context,
              VerifiedScreen(
                  verificationId:
                      AuthCubit.get(context).verificationIdd,
                  password: passwordController.text,
                  name: nameController.text,
                  phone: phoneController.text,
                  address: cityChoice,
                  isTimeOut: false,
                  isMarket: isMarket));
        }
        if (state is VerifiedPhoneRetrievalState) {
          navigateTo(
              context,
              VerifiedScreen(
                  verificationId:
                      AuthCubit.get(context).verificationIdd,
                  password: passwordController.text,
                  name: nameController.text,
                  phone: phoneController.text,
                  address: cityChoice,
                  isTimeOut: true,
                  isMarket: isMarket));
        }*/
       /* if (state is VerifiedPhoneErrorState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'خطأ',
            desc: '${AuthCubit.get(context).messageError}',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          )..show();
        }*/
        if(state is RegisterSuccessState)
          {
            if(!state.registerEntity.status){
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: 'خطأ',
                desc: '${state.registerEntity.message}',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            }
          }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Right_2,
                  color: Colors.white,
                ),
              ),
              title: MaterialButton(
                onPressed: () {
                  if (AuthCubit.get(context).showBottom ==
                      false) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          color: Colors.grey[100],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  navigateToReplacement(
                                      context,
                                      MapScreen(
                                        isMarket: isMarket!,
                                      ));
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
                                          color: primaryColor, fontSize: 16),
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
                                    Icon(IconBroken.Send),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AuthCubit.get(context)
                                                  .place ==
                                              null
                                          ? 'جاري جلب الموقع الحالي'
                                          : '${AuthCubit.get(context).place!.country},${AuthCubit.get(context).place!.locality},${AuthCubit.get(context).place!.subLocality}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).then((value) {
                      AuthCubit.get(context)
                          .changeBottomSheet(false, context);
                    });
                    AuthCubit.get(context)
                        .changeBottomSheet(true, context);
                  } else {
                    AuthCubit.get(context)
                        .changeBottomSheet(false, context);
                    Navigator.pop(context);
                    print(AuthCubit.get(context).showBottom);
                  }
                },
                minWidth: 1,
                padding: EdgeInsets.zero,
                height: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الموقع الحالي',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: primaryColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    child: HeaderWidget(
                        150.h, true, Icons.person_add_alt_1_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إنشاء حساب',
                            style:
                                TextStyle(fontSize: 28.0, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            isMarket!
                                ? 'أنشئ حسابك الان لبيع المزيد من المنتجات'
                                : 'أنشئ حسابك الان للحصول على المزيد من المنتجات',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultTextFromField(
                              isShow: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              controller: nameController,
                              text: isMarket! ? 'الاسم' : 'اسم المحل',
                              prefix: Icons.home_work_outlined,
                              inputType: TextInputType.name,
                              validate: (String value) {
                                //    validator(value, 5, 20, 'name');
                                if (value.trim().isEmpty)
                                  return 'يجب ان لا يكون فارغا';
                                if (value.trim().length < 3)
                                  return 'يجب ان تكون القيمة اكبر من 3';
                                if (value.trim().length > 20)
                                  return 'يجب ان تكون القيمة اقل من 20';
                              }),

                          CustomDropdown(
                            onChanged: (String value){
                              cityChoice=value;
                            },
                            closedBorderRadius: BorderRadius.circular(20),
                            expandedBorderRadius: BorderRadius.circular(20),
                            closedBorder: Border.all(color: Colors.grey),
                            validator: (value)=>value==null?'يجب ان لا يكون فارغاً':null,
                            items: items,
                            //controller: cityController,
                            excludeSelected: true,
                            errorStyle: TextStyle(
                              fontSize: 12
                            ),
                            hintText: 'اختر المحافظة',
                            closedErrorBorderRadius: BorderRadius.circular(20),

                          ),

                          defaultTextFromField(
                              // prefixWidget: Text('+962',style: TextStyle(color: Colors.black),),
                              isShow: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              controller: phoneController,
                              text: 'رقم الجوال',
                              prefix: Icons.call,
                              inputType: TextInputType.number,
                              validate: (String value) {
                                if (value.trim().isEmpty)
                                  return 'يجب ان لا يكون فارغا';
                                if (value.trim().length < 10)
                                  return 'يجب ان تكون القيمة اكبر من 10';
                                if (value.trim().length > 11)
                                  return 'يجب ان يكون الرقم يساوي 10';
                                RegExp reg = RegExp(pattern);
                                if (!reg.hasMatch(value)) {
                                  return 'يجب ادخال رقم هاتف';
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          defaultTextFromField(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              controller: passwordController,
                              text: 'كلمة المرور',
                              prefix: Icons.lock_outline,
                              suffix: AuthCubit.get(context).icon,
                              inputType: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.trim().isEmpty)
                                  return 'يجب ان لا يكون فارغا';
                                if (value.trim().length < 8)
                                  return 'يجب ان تكون القيمة اكبر من 8';
                                if (value.trim().length > 20)
                                  return 'يجب ان تكون القيمة اقل من 20';
                              },
                              isShow:
                                  AuthCubit.get(context).isShow,
                              onPressedSuffix: () {
                                AuthCubit.get(context)
                                    .changeVisibilityPassword();
                              }),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultButton(
                            function: state is RegisterLoadingState
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      // AuthCubit.get(context)
                                      //     .verifiedPhone(phoneController.text);
                                      if(isMarket!)
                                      {
                                        AuthCubit.get(context).register(RegisterParameters(nameController.text, passwordController.text, phoneController.text, cityChoice, 0, AuthCubit.get(context).lat!, AuthCubit.get(context).lang!),context);

                                      }
                                      else
                                      {
                                        AuthCubit.get(context).register(RegisterParameters(nameController.text, passwordController.text, phoneController.text, cityChoice, 1, AuthCubit.get(context).lat!, AuthCubit.get(context).lang!),context);
                                      }
                                    }
                                  },
                            widget: state is RegisterLoadingState
                                ? Row(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
