import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msgmee/theme/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle:
          TextTheme(titleMedium: TextStyle(color: AppColors.black)).bodyMedium,
      titleTextStyle:
          TextTheme(titleMedium: TextStyle(color: AppColors.black)).titleLarge,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        color: AppColors.black,
        fontSize: 18.0,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor, //<-- SEE HERE
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
          TextTheme(titleMedium: TextStyle(color: AppColors.white)).bodyMedium,
      titleTextStyle:
          TextTheme(titleMedium: TextStyle(color: AppColors.white)).titleLarge,
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
      titleMedium: TextStyle(
        color: Colors.white,
        // fontSize: 20.0,
      ),
      titleSmall: TextStyle(
        color: Colors.white70,
        // fontSize: 18.0,
      ),
    ),
  );
}
