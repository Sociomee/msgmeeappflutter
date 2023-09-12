import 'package:flutter/material.dart';
import '../../../../../../theme/colors.dart';

// ignore: must_be_immutable
class BroadcastTextFieldWidget extends StatelessWidget {
  BroadcastTextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.remainChar,
    this.showchar = true,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String remainChar;
  bool? showchar;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 43,
          child: TextFormField(
            onChanged: onChanged,
            controller: controller,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
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
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        showchar!
            ? Padding(
                padding: EdgeInsets.only(left: 235.0, top: 5),
                child: Text('Max $remainChar Characters',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.grey, fontSize: 12)),
              )
            : Container(),
        const SizedBox(height: 15),
      ],
    );
  }
}
