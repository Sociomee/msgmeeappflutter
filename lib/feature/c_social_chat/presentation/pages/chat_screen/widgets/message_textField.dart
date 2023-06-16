import 'package:flutter/material.dart';
import '../../../../../../theme/colors.dart';

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget(
      {super.key, required this.messageController, required this.onChanged});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: messageController,
      decoration: InputDecoration(
        fillColor: AppColors.lightgrey1,
        hintText: "Type your message",
        hintStyle: TextStyle(color: Colors.black54),
        contentPadding:
            EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: AppColors.lightgrey1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: AppColors.lightgrey1)),
        suffixIcon: Image.asset('assets/smiley.png', width: 18, height: 18),
      ),
      onChanged: onChanged,
    );
  }
}
