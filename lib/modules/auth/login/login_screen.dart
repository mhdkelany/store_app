import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/modules/auth/login/login_cubit/cubit.dart';
import 'package:store/modules/auth/login/login_cubit/states.dart';
import 'package:store/modules/auth/login/widgets/header.dart';
import 'package:store/modules/auth/re_password/screens/check_phone_number_screen.dart';
import 'package:store/modules/auth/register/cubit.dart';
import 'package:store/modules/auth/register/register_screen.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/main_screen.dart';
import 'package:store/modules/zoom_drawer_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/style/color.dart';


class LoginScreen extends StatelessWidget {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String patternPassword =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMarket;

  LoginScreen({required this.isMarket});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginUserMarketCubit(),
      child: BlocConsumer<LoginUserMarketCubit, LoginUserMarketStates>(
        listener: (context, state) {
          if (state is LoginUserMarketLoadingState) {
            showDialog(
                context: context, builder: (context) => Loading(context));
          }
          if (state is CheckSocketState) {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                Text('لا يوجد اتصال بالإنترنت'),
                Colors.amber,
                Duration(seconds: 5)));
          }
          if (state is LoginUserMarketSuccessState) {
            if (state.dataModel.statusProfile != null) if (!state
                .dataModel.statusProfile!) {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                  Text('حسابك متوقف لا يمكنك تسجيل الدخول'),
                  Colors.amber,
                  Duration(seconds: 5)));
              Navigator.pop(context);
            }
            //if(LoginUserMarketCubit.get(context).dataModel!=null)
            if (state.dataModel.status != null) if (state.dataModel.userType ==
                1) {
              if (state.dataModel.status!) {
                CacheHelper.putData(key: 'token', value: state.dataModel.token)
                    .then((value) {
                  navigateToEnd(context, DrawerScreen());
                  CacheHelper.putData(key: 'isSailing', value: false);

                  token = state.dataModel.token;
                  StoreAppCubit.get(context).getProfile(context);
                  CategoriesAndFavoriteCubit.get(context).getCategories();
                });
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                  Text(
                    '${state.dataModel.message}يرجى التأكد من البيانات المدخلة',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Colors.red,
                  Duration(seconds: 3),
                ));
              }
            } else {
              if (state.dataModel.status!) {
                CacheHelper.putData(key: 'token', value: state.dataModel.token)
                    .then((value) {
                  navigateToEnd(context, MainScreen());
                  CacheHelper.putData(key: 'isSailing', value: true);
                  token = state.dataModel.token;
                  StoreAppCubit.get(context).getProfile(context);
                  CategoriesAndFavoriteCubit.get(context).getCategories();
                });
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                  Text(
                    '${state.dataModel.message}يرجى التأكد من البيانات المدخلة',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  Colors.red,
                  Duration(seconds: 3),
                ));
              }
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                key: scaffoldKey,
                // appBar: AppBar(
                //   leading: IconButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     icon: Icon(IconBroken.Arrow___Right_2),
                //   ),
                // ),
                body: OfflineBuilder(
                  connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                  ) {
                    final bool connected =
                        connectivity != ConnectivityResult.none;
                    if (connected) {
                      return Builder(builder: (context) {
                        // if(LoginUserMarketCubit.get(context).place==null&&LoginUserMarketCubit.get(context).countTime<10)
                        //   LoginUserMarketCubit.get(context).determinePosition();
                        return SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 250.h,
                                  child: HeaderWidget(
                                      250.h, true, Icons.login_rounded),
                                ),
                                SizedBox(
                                  height: 10.0.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(
                                              fontSize: 28.0.sp,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10.0.h,
                                        ),
                                        Text(
                                          isMarket
                                              ? 'سجل دخولك الان لبيع المزيد من المنتجات'
                                              : 'سجل دخولك الان للحصول على المزيد من المنتجات',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(
                                          height: 10.0.h,
                                        ),
                                        defaultTextFromField(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            controller: phoneController,
                                            isShow: false,
                                            text: 'رقم الجوال',
                                            prefix: Icons.call,
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
                                          height: 20.0,
                                        ),
                                        defaultTextFromField(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            controller: passwordController,
                                            text: 'كلمة المرور',
                                            prefix: Icons.lock_outline,
                                            suffix: LoginUserMarketCubit.get(
                                                    context)
                                                .icon,
                                            inputType:
                                                TextInputType.visiblePassword,
                                            validate: (String value) {
                                              // RegExp reg=RegExp(patternPassword);
                                              // if(!reg.hasMatch(value))
                                              // {
                                              //   return 'يجب ان تحتوي على حرف واحد على الاقل ورقم واحد ورمز واحد';
                                              // }
                                              if (value.trim().isEmpty)
                                                return 'يجب ان لا يكون فارغا';
                                              if (value.trim().length < 8)
                                                return 'يجب ان تكون القيمة اكبر من 8';
                                              if (value.trim().length > 20)
                                                return 'يجب ان تكون القيمة اقل من 20';
                                            },
                                            isShow: LoginUserMarketCubit.get(
                                                    context)
                                                .isShow,
                                            onPressedSuffix: () {
                                              LoginUserMarketCubit.get(context)
                                                  .changeVisibilityPassword();
                                            }),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            navigateTo(context,
                                                CheckPhoneNumberScreen());
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
                                                  is LoginUserMarketLoadingState
                                              ? null
                                              : () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (formKey.currentState!
                                                      .validate()) if (!isMarket) {
                                                    print('${isMarket}mmm');
                                                    LoginUserMarketCubit.get(
                                                            context)
                                                        .userLogin(
                                                            phone:
                                                                phoneController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            userType: 1);
                                                    print(false);
                                                  } else if (isMarket) {
                                                    print('${isMarket} ss');
                                                    FirebaseMessaging.instance
                                                        .getToken()
                                                        .then((value) {
                                                      LoginUserMarketCubit.get(
                                                              context)
                                                          .userLogin(
                                                              phone:
                                                                  phoneController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                              tokenMobile:
                                                                  value,
                                                              userType: 0);
                                                    }).catchError((error) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              buildSnackBar(
                                                        Text(
                                                          'حدث خطأ ما يرجى إعادة المحاولة',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        Colors.red,
                                                        Duration(seconds: 3),
                                                      ));
                                                    });
                                                  }
                                                },
                                          widget: state
                                                  is LoginUserMarketLoadingState
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
                                        if(!isMarket)
                                        Row(
                                          children: [
                                            Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                navigateTo(context, DrawerScreen());
                                                CategoriesAndFavoriteCubit.get(context).getCategories();
                                                StoreAppCubit.get(context).getHomeWithoutToken(isRefresh: true);
                                              },
                                              child: Text('تخطي'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    } else {
                      return buildNoInternet(context);
                    }
                  },
                  child: Center(child: SpinKitFadingCircle(color: primaryColor,)),
                )),
          );
        },
      ),
    );
  }

  Widget buildNoInternet(context) => Center(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/no_internet.png'),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'لا يوجد اتصال بالانترنت !'
              'تأكد من اتصالك ثم اعد المحاولة',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 15.0,
            ),
            CircularProgressIndicator()
          ],
        ),
      ));
}
