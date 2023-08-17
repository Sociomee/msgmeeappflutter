import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/colors.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.remainChar,
    this.showchar = true,
    this.textWeight = FontWeight.w400,
    this.onTap,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String remainChar;
  final VoidCallback? onTap;
  bool? showchar;
  FontWeight? textWeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.black, fontSize: 14.sp, fontWeight: textWeight),
        ),
        const SizedBox(height: 12),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          cursorColor: AppColors.primaryColor,
          inputFormatters: [
            LengthLimitingTextInputFormatter(64),
          ],
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.borderColor)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.borderColor)),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              hintText: hintText,
              hintStyle:
                  TextStyle(color: AppColors.hinttextColor, fontSize: 14.sp)),
        ),
        showchar!
            ? Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'Max $remainChar Characters',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.black, fontSize: 12.sp),
                    ),
                  ],
                ),
              )
            : Container(),
        const SizedBox(height: 15),
      ],
    );
  }
}
