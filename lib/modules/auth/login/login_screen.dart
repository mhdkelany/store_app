import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/modules/auth/login/widgets/header.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/auth/presentation/widgets/login_widgets/login_body_widget.dart';
import 'package:store/modules/auth/presentation/widgets/login_widgets/login_build_no_internet.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        AuthCubit.get(context).loginOperation(context, state);
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              key: scaffoldKey,
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
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
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: LoginBodyWidget(isMarket: isMarket,state: state,formKey: formKey,passwordController: passwordController,phoneController: phoneController,scaffoldKey: scaffoldKey,),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return LoginBuildNoInternet();
                  }
                },
                child: Center(
                    child: SpinKitFadingCircle(
                  color: primaryColor,
                )),
              )),
        );
      },
    );
  }

}
