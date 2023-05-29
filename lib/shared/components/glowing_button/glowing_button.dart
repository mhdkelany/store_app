import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/auth/login/login_screen.dart';
import 'package:store/shared/components/components.dart';

import '../constansts/string_const.dart';

class GlowingButton extends StatefulWidget {
  GlowingButton(
      {Key? key,
      this.firstColor = Colors.cyan,
      this.secondColor = Colors.greenAccent})
      : super(key: key);
  Color firstColor;
  Color secondColor;

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  bool glowing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (value) {
        navigateTo(context, LoginScreen(isMarket: false));
        setState(() {});
        glowing = false;
      },
      onTapDown: (value) {
        setState(() {
          glowing = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 50,
        ),
        height: 45.h,
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              widget.firstColor,
              widget.secondColor,
            ],
          ),
          boxShadow: glowing
              ? [
                  BoxShadow(
                    color: widget.firstColor.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: Offset(-8, 0),
                  ),
                  BoxShadow(
                    color: widget.secondColor.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: Offset(8, 0),
                  ),
                  BoxShadow(
                    color: widget.firstColor.withOpacity(0.2),
                    spreadRadius: 16,
                    blurRadius: 32,
                    offset: Offset(-8, 0),
                  ),
                  BoxShadow(
                    color: widget.secondColor.withOpacity(0.2),
                    spreadRadius: 16,
                    blurRadius: 32,
                    offset: Offset(8, 0),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loginNow,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'tajawal-light',
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              !glowing?Icons.arrow_circle_left_outlined:Icons.arrow_circle_left,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
