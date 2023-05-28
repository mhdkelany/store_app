import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store/shared/components/constansts/shimmer_widget.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/route_manager.dart';

import '../../layout/cubit/states.dart';

navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, Routes(widget));

navigateToReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(context, Routes(widget));

Widget defaultTextFromField(
        {required TextEditingController controller,
        String? text,
        IconData? prefix,
        required TextInputType inputType,
        OutlineInputBorder? border,
        OutlineInputBorder? border2,
        OutlinedBorder? sqareBorder,
        InputBorder? noneBorder,
        bool isShow = true,
        IconData? suffix,
        required Function validate,
        Function? onPressedSuffix,
        Function? textOnChanged,
        Function? textOnSubmit,
        Function? onTap,
        bool readOnly = false,
        FloatingLabelBehavior? floatingLabelBehavior,
        String? hintText,
        Color? focusColor,
        Color? fillColor,
        Color? hoverColor,
        Color? prefixIconColor,
        Widget? prefixWidget,
        int maxLine = 1}) =>
    TextFormField(
      maxLines: maxLine,
      readOnly: readOnly,
      style: TextStyle(fontSize: 16.sp),
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: border2,
          focusColor: focusColor,
          fillColor: fillColor,
          hoverColor: hoverColor,
          hintStyle:
              TextStyle(fontFamily: 'tajawal-medium', color: Colors.grey),
          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          border: border,
          labelText: text,
          prefix: prefixWidget,
          prefixIconColor: prefixIconColor,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (onPressedSuffix != null) onPressedSuffix();
            },
            icon: Icon(suffix),
          )),
      keyboardType: inputType,
      validator: (value) => validate(value),
      obscureText: isShow,
      onChanged: (String s) {
        if (textOnChanged != null) textOnChanged(s);
      },
      onFieldSubmitted: (s) {
        if (textOnSubmit != null) {
          textOnSubmit(s);
        }
      },
      onTap: () {
        if (onTap != null) onTap();
      },
    );

Widget defaultButton({
  double width = double.infinity,
  Color color = primaryColor,
  required Function? function,
  required Widget widget,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: color),
      width: width,
      height: 50.0,
      child: MaterialButton(
          onPressed: () {
            if (function != null) function();
          },
          child: widget),
    );

navigateToEnd(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

SnackBar buildSnackBar(Widget content, Color color, Duration duration,
        {Key? key}) =>
    SnackBar(
      key: key,
      content: content,
      duration: duration,
      backgroundColor: color,
    );

buildDialog(context, StoreAppStates state) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Turn on the WiFi or Mobil Data'),
          actions: [
            TextButton(
                onPressed: () {
                  if (state is ConnectionErrorState) {
                    buildDialog(context, state);
                    Navigator.pop(context);
                  }
                },
                child: Text('Ok'))
          ],
        ));

Widget buildText({
  required String text,
  TextStyle? textStyle,
  int? lines,
  TextDirection? textDirection,
  TextAlign? textAlign,
}) =>
    Text(
      '$text',
      style: textStyle,
      maxLines: lines,
      textAlign: textAlign,
      textDirection: textDirection,
    );

Widget buildShimmer(context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: ShimmerWidget.rectangular(height: 200),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: ShimmerWidget.rectangular(
            height: 20,
            width: MediaQuery.of(context).size.height * 0.18,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.18,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  child: ShimmerWidget.circular(height: 70, width: 70),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ShimmerWidget.rectangular(
                    height: 8,
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ],
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: ShimmerWidget.rectangular(
            height: 20,
            width: MediaQuery.of(context).size.height * 0.18,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAlias,
              child: ShimmerWidget.rectangular(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.30,
              ),
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
          ),
        ),
      ],
    );

Widget Loading(BuildContext context) => AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: SpinKitDoubleBounce(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );

