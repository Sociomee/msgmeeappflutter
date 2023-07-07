import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class AppColors {
  //color
  static const Color primaryColor = Color(0XFF81C14B);
  static const Color seconderyColor = Color(0XFFACDAD6);
  static const Color selectedChatColor = Color(0xFFE3F4EA);
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
  static const Color hintTextColor = Color(0XFF333333);
  static const Color borderColor = Color(0XFFE0E0E0);
  static const Color bottomSheettextColor = Color(0XFF4F4F4F);
  static const Color primaryDarkColor = Color(0XFF083A3D);
  static const Color yellowColor = Color(0xFFF8C756);
  static const Color roseGradientDeep = Color(0XFFE71414);
  static const Color roseGradientLight = Color(0XFFF58A8A);
  static const Color lavenderGradientDeep = Color(0XFF9F03FC);
  static const Color lavenderGradientLight = Color(0XFFCF81FD);
  static const Color peachGradientDeep = Color(0XFF1BC0E4);
  static const Color peachGradientLight = Color(0XFF8DDFF1);
  static const Color oceanGradientDeep = Color(0XFF1550EA);
  static const Color oceanGradientLight = Color(0XFF8AA8F5);
  static const List<Color> berryGradientDeep = [
    Color(0XFF304AD3),
    Color(0XFF1F32DD),
    Color(0XFF7114E7),
    Color(0XFFE71486)
  ];
  static const List<Color> berryGradientLight = [
    Color(0X80304AD3),
    Color(0X801F32DD),
    Color(0X807114E7),
    Color(0X80E71486)
  ];
  static const Color candyGradientDeep = Color(0XFFEA15AF);
  static const Color candyGradientLight = Color(0XFFF58AD7);
  static const Color tulipGradientDeep = Color(0XFFEA9515);
  static const Color tulipGradientLight = Color(0XFFF5CA8A);
  static const Color honeyGradientDeep = Color(0XFF19EA15);
  static const Color honeyGradientLight = Color(0XFF8CF58A);
  static const Color kiwiGradientDeep = Color(0XFF4AB585);
  static const Color kiwiGradientLight = Color(0XFFA4DAC2);
  static const Color wallpaperColor1 = Color(0XFFFCFF73);
  static const Color wallpaperColor2 = Color(0XFFFF7A00);
  static const Color wallpaperColor3 = Color(0XFFFF9900);
  static const Color wallpaperColor4 = Color(0XFFF00000);
  static const Color wallpaperColor5 = Color(0XFF0267DD);
  static const Color wallpaperColor6 = Color(0XFFCA00B6);
  static const Color wallpaperColor7 = Color(0XFFD2FFAE);
  static const Color wallpaperColor8 = Color(0XFFFFB0B0);
  static const Color wallpaperColor9 = Color(0XFFFFDD64);
  static const Color wallpaperColor10 = Color(0XFF87C228);
  static const Color wallpaperColor11 = Color(0XFF420B0B);
  static const Color wallpaperColor12 = Color(0XFFC2A3A3);
//otp pin theme
  static final defaultpintheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.grey),
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
      color: AppColors.white,
      border: Border.all(color: AppColors.primaryColor),
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
