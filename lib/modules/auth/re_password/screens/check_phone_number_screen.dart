import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/cubit.dart';
import 'package:store/modules/auth/re_password/re_password_cubit/states.dart';
import 'package:store/modules/auth/re_password/screens/change_password_screen.dart';
import 'package:store/modules/auth/re_password/screens/repassword_verified_screen.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

var phoneNumberController = TextEditingController();
class CheckPhoneNumberScreen extends StatelessWidget {
  CheckPhoneNumberScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: buildText(
            text: '$rePasswordTitle',
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildText(
                    text: '$firstCaptionRePassword',
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0.sp,
                        fontFamily: 'tajawal-light')),
                SizedBox(
                  height: 15.h,
                ),
                buildText(
                  text: '$secondCaptionRePassword',
                  textStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.0.sp,
                      fontFamily: 'tajawal-light'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                defaultTextFromField(
                  isShow: false,
                  controller: phoneNumberController,
                  inputType: TextInputType.phone,
                  hintText: '075555555',
                  text: 'رقم الهاتف',
                  prefix: Icons.phone,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  validate: (String value) {
                    if (value.trim().isEmpty) {
                      return '$validation';
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocConsumer<RePasswordCubit, RePasswordStates>(
                  listener: (context, state) {
                    if (state is RePasswordCheckPhoneNumberSuccessState) {
                      if (!state.checkPhoneNumberModel.status!) {
                        showDialog(
                          context: context,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                insetPadding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                contentPadding: EdgeInsets.all(15),
                                alignment: AlignmentDirectional.center,
                                titlePadding: EdgeInsets.all(15),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                title: buildText(text: 'الرقم غير صحيح'),
                                content: buildText(
                                    text: 'يرجى إعادة المحاولة لاحقاَ'),
                              ),
                            ),
                          ),
                        );
                      } else if (state.checkPhoneNumberModel.status!) {
                        navigateTo(context, ChangePasswordScreen(phone: phoneNumberController.text));
                       // RePasswordCubit.get(context).rePasswordVerifiedPhone(phoneNumberController.text);
                      }
                    }
                    if (state is RePasswordCheckPhoneNumberErrorState) {
                      print(state.message);
                    }
                  },
                  builder: (context, state) {
                    return defaultButton(
                      function: state is RePasswordCheckPhoneNumberLoadingState
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                RePasswordCubit.get(context).checkPhoneNumber(
                                    phoneNumberController.text);
                              }
                            },
                      widget: state is RePasswordCheckPhoneNumberLoadingState
                          ? buildText(
                              text: '$rePasswordButtonTextLoading',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'tajawal-light',
                              ),
                            )
                          : buildText(
                              text: '$rePasswordButtonText',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'tajawal-light',
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
