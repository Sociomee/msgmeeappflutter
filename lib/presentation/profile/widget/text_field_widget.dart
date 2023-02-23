import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.onChanged});
  final String title;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: CustomTheme.black, fontSize: 14),
        ),
        const SizedBox(height: 12),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          cursorColor: CustomTheme.primaryColor,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: CustomTheme.primaryColor)),
              hintText: hintText,
              hintStyle: const TextStyle(color: CustomTheme.lightgrey)),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 230.0, top: 5),
          child: Text(
            'Max 64 Characters',
            textAlign: TextAlign.center,
            style: TextStyle(color: CustomTheme.black, fontSize: 12),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
