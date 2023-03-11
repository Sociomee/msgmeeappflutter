import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

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
              color: CustomTheme.black, fontSize: 14, fontWeight: textWeight),
        ),
        const SizedBox(height: 12),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          cursorColor: CustomTheme.primaryColor,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomTheme.borderColor)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: CustomTheme.borderColor)),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: CustomTheme.primaryColor)),
              hintText: hintText,
              hintStyle: const TextStyle(color: CustomTheme.lightgrey)),
        ),
        showchar!
            ? Padding(
                padding: EdgeInsets.only(left: 230.0, top: 5),
                child: Text(
                  'Max $remainChar Characters',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CustomTheme.black, fontSize: 12),
                ),
              )
            : Container(),
        const SizedBox(height: 15),
      ],
    );
  }
}
