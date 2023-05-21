import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/cubit.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/states.dart';
import 'package:store/modules/auth/re_password/screens/verified_success_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({required this.phone, Key? key}) : super(key: key);
  var passwordController = TextEditingController();
  var acceptPasswordController = TextEditingController();
  String phone;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: buildText(
            text: '$ChangePasswordVerifiedTitle',
            textStyle: Theme.of(context).textTheme.caption,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildText(
                    text: '$firstCaptionChangePassword',
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0.sp,
                        fontFamily: 'tajawal-light')),
                SizedBox(
                  height: 10.h,
                ),
                defaultTextFromField(
                  isShow: true,
                  controller: passwordController,
                  inputType: TextInputType.visiblePassword,
                  text: 'كلمة المرور الجديدة',
                  prefix: Icons.lock,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  validate: (String value) {
                    if (value.trim().isEmpty) {
                      return '$validation';
                    }
                    if (value.trim().length < 8) {
                      return '${validationForLengthPassword}';
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                defaultTextFromField(
                  isShow: true,
                  controller: acceptPasswordController,
                  inputType: TextInputType.visiblePassword,
                  text: 'تأكيد كلمة المرور',
                  prefix: Icons.lock,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  validate: (String value) {
                    if (value.trim().isEmpty) {
                      return '$validation';
                    }
                    if (value.trim().length < 8) {
                      return '${validationForLengthPassword}';
                    }
                    if (passwordController.text != value) {
                      return '${validationForAcceptPassword}';
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocConsumer<RePasswordCubit, RePasswordStates>(
                  listener: (context, state) {
                    if (state is RePasswordErrorState) {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: buildText(text: 'خطأ'),
                          content: buildText(text: '${state.errorMessage}'),
                        ),
                      );
                    }
                    if(state is RePasswordSuccessState)
                      {
                        navigateToReplacement(context, VerifiedSuccessScreen());
                      }
                  },
                  builder: (context, state) {
                    return defaultButton(
                      function: state is RePasswordLoadingState
                          ? null
                          : () {
                              if (formKey.currentState!.validate())
                                RePasswordCubit.get(context).rePassword(
                                    phone: phone,
                                    password: passwordController.text);
                            },
                      widget: state is RePasswordLoadingState?buildText(
                      text: 'انتظر',
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ):buildText(
                        text: 'تغيير',
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
