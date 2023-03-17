import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  var passwordController = TextEditingController();
  var acceptPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildText(
          text: '$ChangePasswordVerifiedTitle',
          textStyle: Theme.of(context).textTheme.caption,
        ),
        centerTitle: true,
      ),
      body: Column(
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
            isShow: false,
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
              if (value.trim().length < 6) {
                return '${validationForLengthPassword}';
              }
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          defaultTextFromField(
            isShow: false,
            controller: acceptPasswordController,
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
              if (value.trim().length < 6) {
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
          defaultButton(
            function: () {},
            widget: buildText(text: 'تغيير'),
          ),
        ],
      ),
    );
  }
}
