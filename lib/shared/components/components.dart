import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:store/shared/style/color.dart';
import 'package:store/shared/style/route_manager.dart';

import '../../layout/cubit/states.dart';

navigateTo(BuildContext context,Widget widget)=>Navigator.push(context,Routes(widget));
Widget defaultTextFromField({
  required TextEditingController controller,
   String? text,
   IconData? prefix,
  required TextInputType inputType,
   OutlineInputBorder? border,
   OutlineInputBorder? border2,
   OutlinedBorder? sqareBorder,
   InputBorder? noneBorder,
  bool isShow=true,
  IconData? suffix,
  required  Function validate,
  Function? onPressedSuffix,
  Function? textOnChanged,
  Function? textOnSubmit,
  Function? onTap,
  bool readOnly=false,
  FloatingLabelBehavior? floatingLabelBehavior,
  String? hintText,
  Color ?focusColor,
  Color ?fillColor,
  Color ?hoverColor,
  Color ?prefixIconColor,
  Widget? prefixWidget,
  int maxLine=1

})=> TextFormField(
 maxLines: maxLine,
  readOnly: readOnly,
style: TextStyle(
  fontSize: 18
),
  controller: controller,
  decoration: InputDecoration(
    focusedBorder: border2,
    focusColor: focusColor,
    fillColor:fillColor ,
    hoverColor: hoverColor,
    hintStyle: TextStyle(
      fontFamily: 'tajawal-medium',
      color: Colors.grey
    ),
    hintText: hintText,
    floatingLabelBehavior: floatingLabelBehavior,
    contentPadding: EdgeInsets.symmetric(vertical: 15),
      border: border,
      labelText: text,
      prefix:prefixWidget ,
      prefixIconColor:prefixIconColor ,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: IconButton(
        onPressed:(){
          if(onPressedSuffix!=null)
            onPressedSuffix();
        } ,
        icon: Icon(
            suffix
        ),
      )
  ),
  keyboardType: inputType,
  validator:  (value)=>validate(value),
  obscureText: isShow,
  onChanged: (String s){
    if(textOnChanged!=null)
      textOnChanged(s);
  },
  onFieldSubmitted: (s){
    if(textOnSubmit!=null)
    {
      textOnSubmit(s);
    }
  },
  onTap: (){
    if(onTap!=null)
      onTap();
  },
);
Widget defaultButton({
  double width=double.infinity,
  Color color=primaryColor,
  required  Function? function,
  required Widget widget,
})=>  Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: color
  ),
  width: width,
  height: 50.0,
  child: MaterialButton(
    onPressed: (){
      if(function!=null)
      function();
      } ,
    child: widget

  ),
);
navigateToEnd(BuildContext context,Widget widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
SnackBar buildSnackBar(Widget content,Color color,Duration duration,{Key? key})=>SnackBar(
  key:key ,
    content: content,
  duration: duration,
  backgroundColor: color,
);
buildDialog(context,StoreAppStates state)=> showDialog(context: context, builder: (context)=>AlertDialog(

  title: Text('No Internet Connection'),
  content: Text('Turn on the WiFi or Mobil Data'),
  actions: [
    TextButton(onPressed: ()
    {
      if(state is ConnectionErrorState)
      {
        buildDialog(context, state);
        Navigator.pop(context);
      }
    }, child: Text('Ok'))
  ],
));
