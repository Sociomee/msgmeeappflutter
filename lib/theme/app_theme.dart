import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CustomTheme.white,
    appBarTheme: AppBarTheme(
      color: CustomTheme.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      toolbarTextStyle:
          TextTheme(subtitle1: TextStyle(color: CustomTheme.black)).bodyText2,
      titleTextStyle:
          TextTheme(subtitle1: TextStyle(color: CustomTheme.black)).headline6,
    ),
    // colorScheme: ColorScheme.light(
    //   primary: Colors.white,
    //   onPrimary: Colors.white,
    //   secondary: Colors.red,
    // ),
    // cardTheme: CardTheme(
    //   color: Colors.teal,
    // ),
    // iconTheme: IconThemeData(
    //   color: Colors.white54,
    // ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: CustomTheme.black,
      ),
      subtitle2: TextStyle(
        color: CustomTheme.black,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      toolbarTextStyle:
          TextTheme(subtitle1: TextStyle(color: CustomTheme.white)).bodyText2,
      titleTextStyle:
          TextTheme(subtitle1: TextStyle(color: CustomTheme.white)).headline6,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: Colors.white,
        // fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        // fontSize: 18.0,
      ),
    ),
  );
}
