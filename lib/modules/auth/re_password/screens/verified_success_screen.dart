import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/other/other_screens/choice_user.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/string_const.dart';

class VerifiedSuccessScreen extends StatelessWidget {
  const VerifiedSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.h,
              ),
              buildText(
                text: '$rePasswordSuccessTitle',
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontFamily: 'tajawal-light',
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Icon(
                Icons.check_circle_outline_outlined,
                size: 200.sp,
                color: Colors.deepOrange,
              ),
              SizedBox(
                height: 15.0.h,
              ),
              buildText(
                text: '$rePasswordSuccessContain',
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontFamily: 'tajawal-light',
                ),
              ),
              //Spacer(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                child: defaultButton(
                  function: () {
                    navigateToEnd(context, ChoiceUser());
                  },
                  widget: buildText(
                    text: 'العودة الى اختيار المستخدم',
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
