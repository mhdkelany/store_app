import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/base_use_case.dart';
import 'package:store/modules/auth/domain/usecase/login_usecase.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/auth/presentation/screens/register_screen.dart';
import 'package:store/modules/auth/re_password/screens/check_phone_number_screen.dart';
import 'package:store/modules/auth/register/cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/home/home_cubit.dart';
import 'package:store/modules/home/presentation/screen/zoom_drawer_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/string_const.dart';

class LoginBodyWidget extends StatelessWidget {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String patternPassword =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final bool isMarket;
   AuthState state;
   LoginBodyWidget({super.key,required this.state,required this.isMarket,required this.phoneController,required this.passwordController,required this.formKey,required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تسجيل الدخول',
            style: TextStyle(
                fontSize: 22.0.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Text(
            isMarket
                ? 'سجل دخولك الان لبيع المزيد من المنتجات'
                : 'سجل دخولك الان للحصول على المزيد من المنتجات',
            style:
            Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 10.0.h,
          ),
          defaultTextFromField(
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              controller: phoneController,
              isShow: false,
              text: 'رقم الجوال',
              prefix: Icons.call_outlined,
              inputType: TextInputType.phone,
              validate: (String value) {
                if (value.trim().isEmpty)
                  return 'يجب ان لا يكون فارغا';
                if (value.trim().length < 10)
                  return 'يجب ان تكون القيمة اكبر من 10';
                if (value.trim().length >= 11)
                  return 'يجب ان يكون الرقم يساوي 10';
                RegExp reg = RegExp(pattern);
                if (!reg.hasMatch(value)) {
                  return 'يجب ادخال رقم هاتف';
                }
              }),
          SizedBox(
            height: 15.0,
          ),
          defaultTextFromField(
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              controller: passwordController,
              text: 'كلمة المرور',
              prefix: Icons.lock_outline,
              suffix:
              AuthCubit.get(context)
                  .icon,
              inputType:
              TextInputType.visiblePassword,
              validate: (String value) {
                if (value.trim().isEmpty)
                  return 'يجب ان لا يكون فارغا';
                if (value.trim().length < 8)
                  return 'يجب ان تكون القيمة اكبر من 8';
                if (value.trim().length > 20)
                  return 'يجب ان تكون القيمة اقل من 20';
              },
              isShow:
              AuthCubit.get(context)
                  .isShow,
              onPressedSuffix: () {
                AuthCubit.get(context)
                    .removeState();
                AuthCubit.get(context)
                    .changeVisibilityPassword();
              }),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              navigateTo(
                  context, CheckPhoneNumberScreen());
            },
            child: buildText(
              text: '$didYouForgetPassword',
              textStyle: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'tajawal-light',
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          defaultButton(
            function: state
            is LoginLoadingState
                ? null
                : () {
              FocusScope.of(context).unfocus();
              if (formKey.currentState!
                  .validate()) if (!isMarket) {
                print('${isMarket}mmm');
                AuthCubit.get(context).login(
                    loginParameters:
                    LoginParameters(
                        phone:
                        phoneController
                            .text,
                        password:
                        passwordController
                            .text,
                        userType: 1));
                print(false);
              } else if (isMarket) {
                FirebaseMessaging.instance
                    .getToken()
                    .then((value) {
                  fireBaseToken = value!;
                  AuthCubit.get(context).login(
                      loginParameters:
                      LoginParameters(
                          phone:
                          phoneController
                              .text,
                          password:
                          passwordController
                              .text,
                          userType: 0,
                          tokenMobile:
                          value));
                }).catchError((error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                      buildSnackBar(
                        Text(
                          'حدث خطأ ما يرجى إعادة المحاولة',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        Colors.red,
                        Duration(seconds: 3),
                      ));
                });
              }
            },
            widget:
            state is LoginLoadingState
                ? Row(
              children: [
                Text(
                  'الرجاء الانتظار...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
              mainAxisAlignment:
              MainAxisAlignment.center,
            )
                : Text(
              'سجل الدخول',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                'ليس لديك حساب مسبق؟',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              TextButton(
                  onPressed: () {
                    RegisterUserMarketCubit.get(
                        context)
                        .determinePosition();
                    navigateTo(
                        context,
                        RegisterScreen(
                            isMarket: isMarket));
                  },
                  child: Text('انشاء حساب'))
            ],
          ),
          if (!isMarket)
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                    navigateTo(
                        context, DrawerScreen());
                    FavoriteAndCategoryCubit.get(context)
                        .getCategories(NoParameters());
                    HomeCubit.get(context)
                        .getHomeWithoutToken(
                        isRefresh: true);
                  },
                  child: Text('تخطي'),
                ),
              ],
            )
        ],
      ),
    );
  }
}
