import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/cubit.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/states.dart';
import 'package:store/modules/auth/re_password/screens/change_password_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';
import 'package:store/shared/style/color.dart';

class RePasswordVerifiedScreen extends StatelessWidget {
  RePasswordVerifiedScreen({required this.phone, Key? key}) : super(key: key);
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: buildText(
            text: '$rePasswordVerifiedTitle',
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildText(
                text: '${firstCaptionVerifiedRePassword}',
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                  fontFamily: 'tajawal-light',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              buildText(
                  text: '${secondCaptionVerifiedRePassword('${phone}')}',
                  textStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16.0.sp,
                    fontFamily: 'tajawal-light',
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10.h,
              ),
              BlocConsumer<RePasswordCubit, RePasswordStates>(
                listener: (context, state) {
                  if (state is RePasswordAuthPhoneLoadingState) {
                    showDialog(
                        context: context,
                        builder: (context) =>Loading(context));
                  }
                  else if (state is RePasswordVerifiedPhoneNumberWrongState) {
                    Fluttertoast.showToast(
                      msg: "${state.error}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      textColor: Colors.white,
                      fontSize: 14.0.sp,
                    );
                    Navigator.pop(context);
                  }
                  else if (state is RePasswordAuthPhoneSuccessState) {
                    navigateTo(context, ChangePasswordScreen(phone: phone!,));
                    Navigator.pop(context);

                  }
                },
                builder: (context, state) {
                  return OtpTextField(
                    numberOfFields: 6,
                    //fieldWidth: 50.0.w,
                    focusedBorderColor: primaryColor,
                    showFieldAsBox: true,
                    keyboardType: TextInputType.number,
                    borderRadius: BorderRadius.circular(15.0),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      RePasswordCubit.get(context)
                          .authPhone(opt: verificationCode);
                    }, // end onSubmit
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
