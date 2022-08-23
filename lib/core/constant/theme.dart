import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTheme {
  static const _appBarTheme = AppBarTheme(
    elevation: 0,
    color: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  static const _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    headline5: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    headline6: TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 15,
      height: 2,
    ),
    bodyText2: TextStyle(
      color: Colors.black54,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF00c569),
    colorScheme: const ColorScheme.light(primary: Color(0xFF00c569)),
    fontFamily: "opensans",
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
  );

  static final appBarTitleStyle =
      Get.textTheme.headline2?.copyWith(fontWeight: FontWeight.w500);
}
