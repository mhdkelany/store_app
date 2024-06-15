import 'package:flutter/material.dart';

class BuildBottom
{
 static PreferredSizeWidget buildBottom()=>PreferredSize(
    preferredSize: Size.fromHeight(20),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0))),
      padding: EdgeInsets.only(top: 5, bottom: 10),
      width: double.infinity,
    ),
  );
}