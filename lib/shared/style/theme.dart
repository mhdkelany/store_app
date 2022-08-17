import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/shared/style/color.dart';
import 'color.dart';

ThemeData darkMode=ThemeData(

    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      color: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
    ),

    scaffoldBackgroundColor: HexColor('333739'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
    ),
);
ThemeData lightMode=ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch(
    ).copyWith(
      primary: primaryColor
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        // systemStatusBarContrastEnforced: true,
        // statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.black
      ),
      caption: TextStyle(
        fontSize: 14
      ),
      bodyText2: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          color: Colors.black
      ),
    ),
  fontFamily: 'tajawal-medium',
);
ThemeData lightModeFor=ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch(
    ).copyWith(
      primary: primaryColor
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.black
      ),
      caption: TextStyle(
        fontSize: 14
      ),
      bodyText2: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          color: Colors.black
      ),
    ),
  fontFamily: 'tajawal-medium',
);