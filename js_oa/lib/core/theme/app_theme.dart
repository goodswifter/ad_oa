import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'no_splash_factory.dart';

final ThemeData appThemeData = ThemeData(
  // 设置背景颜色
  canvasColor: Color(0xFFF1F1F1),

  // canvasColor: Colors.grey.shade200,

  colorScheme: ColorScheme.light(
    primary: Colors.blue,
  ).copyWith(),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  splashFactory: NoSplashFactory(),
  appBarTheme: _appbarTheme(),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

AppBarTheme _appbarTheme() {
  return AppBarTheme(
      color: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: TextStyle(color: Colors.black, fontSize: 18));
}
