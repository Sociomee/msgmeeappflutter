import 'package:flutter/material.dart';
import '../../../../theme/custom_theme.dart';

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget(
      {super.key, required this.messageController, required this.onChanged});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: CustomTheme.primaryColor,
      controller: messageController,
      decoration: InputDecoration(
        fillColor: CustomTheme.lightgrey1,
        hintText: "Type your message",
        hintStyle: TextStyle(color: Colors.black54),
        contentPadding:
            EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: CustomTheme.lightgrey1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: CustomTheme.lightgrey1)),
        suffixIcon: Image.asset('assets/smiley.png', width: 18, height: 18),
      ),
      onChanged: onChanged,
    );
  }
}

class ReplyMessageTextField extends StatelessWidget {
  const ReplyMessageTextField(
      {super.key,
      required this.messageController,
      this.onChanged,
      required this.message});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 263,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CustomTheme.lightgrey),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 32,
            width: 232,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(10)),
            child: Text(message),
          ),
          TextField(
            cursorColor: CustomTheme.primaryColor,
            controller: messageController,
            decoration: InputDecoration(
              fillColor: CustomTheme.lightgrey1,
              hintText: "Type your message",
              hintStyle: TextStyle(color: Colors.black54),
              contentPadding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
              focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(width: 2, color: CustomTheme.lightgrey1)),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon:
                  Image.asset('assets/smiley.png', width: 18, height: 18),
            ),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
