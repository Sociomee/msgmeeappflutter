import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../theme/colors.dart';
import '../../../cubit/show_contact_textfield.dart';

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget(
      {super.key,
      required this.messageController,
      required this.onChanged,
      this.color});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: messageController,
      decoration: InputDecoration(
        fillColor: color ?? AppColors.lightgrey1,
        filled: true,
        hintText: "Type your message",
        hintStyle: TextStyle(color: Colors.black54),
        contentPadding:
            EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: AppColors.lightgrey1)),
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

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget(
      {super.key, required this.messageController, this.onChanged, this.color});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 281,
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? AppColors.lightgrey1,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 52,
                margin: EdgeInsets.only(top: 5, left: 5),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Abriella Bond'),
                        Row(
                          children: [
                            Text('Contact:'),
                            Icon(
                              Icons.person_2_outlined,
                              size: 18,
                            ),
                            Text('Joy Arthur')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 60),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                        height: 44,
                        width: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    context.read<ShowContactTextField>().toggleValue();
                  },
                  child: Icon(Icons.close))
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 270,
            child: TextFormField(
              onChanged: onChanged,
              cursorColor: AppColors.primaryColor,
              controller: messageController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.lightgrey1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.lightgrey1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.lightgrey1)),
                fillColor: color ?? AppColors.lightgrey1,
                filled: true,
                hintText: "Type your message",
                hintStyle: TextStyle(color: Colors.black54),
                suffixIcon:
                    Image.asset('assets/smiley.png', width: 18, height: 18),
              ),
            ),
          ),
          SizedBox(height: 3)
        ],
      ),
    );
  }
}