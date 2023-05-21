import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                size: 40,
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
            ],
          ),
        ),
      ),
    );
  }
}
