import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

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
                color: CustomTheme.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextFormField(
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
                padding: EdgeInsets.only(left: 235.0, top: 5),
                child: Text('Max $remainChar Characters',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: CustomTheme.grey, fontSize: 12)),
              )
            : Container(),
        const SizedBox(height: 15),
      ],
    );
  }
}
