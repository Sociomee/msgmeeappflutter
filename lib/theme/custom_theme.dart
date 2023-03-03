import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomTheme {
  //color
  static const Color primaryColor = Color(0XFF81C14B);
  static const Color seconderyColor = Color(0XFFACDAD6);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color lightgrey = Color(0XFFC2C2C2);
  static const Color black = Colors.black;
  static const Color blue = Color(0xFF2850B7);
  static const Color darkgreen = Color(0XFF368C4E);
  static const Color errorRedColor = Color(0XFFEB5757);
  static const Color seconderyColor1 = Color(0XFFE3F4EA);
  static const Color lightgrey1 = Color(0XFFF5F5F5);
  static const Color iconColor = Color(0XFF4F4F4F);
  static const Color audioiconColor = Color(0XFF56CCF2);
  static const Color mediaiconColor = Color(0XFFFF822E);
  static const Color dociconColor = Color(0XFF2CB9B0);

//otp pin theme
  static final defaultpintheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: CustomTheme.white,
      border: Border.all(color: CustomTheme.grey),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  static final focuspintheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: CustomTheme.white,
      border: Border.all(color: CustomTheme.primaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static const linkstyle = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.375,
  );
}
