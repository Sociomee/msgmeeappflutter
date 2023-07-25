import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../theme/colors.dart';
import '../../../cubit/show_attachment.dart';
import '../../../cubit/show_contact_textfield.dart';

class MessageTextFieldWidget extends StatelessWidget {
  const MessageTextFieldWidget({
    super.key,
    required this.messageController,
    required this.onChanged,
    this.color,
    required this.imageTextfield,
  });
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final Color? color;
  final bool imageTextfield;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: messageController,
      onTap: () {
        context.read<ShowAttachment>().closeAttachment();
      },
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
        suffixIcon: SizedBox(
          width: 10,
          height: 10,
          child: Center(
            child: SvgPicture.asset(
                imageTextfield ? 'assets/smiley_dark.svg' : 'assets/smiley.svg',
                fit: BoxFit.contain),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class ContactMessageFieldWidget extends StatelessWidget {
  const ContactMessageFieldWidget(
      {super.key, required this.messageController, this.onChanged, this.color});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // width: 280.w,
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? AppColors.lightgrey1,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                margin: EdgeInsets.only(top: 5, left: 5),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Abriella Bond',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 10.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Contact:',
                                style: TextStyle(
                                  color: Color(0xFF555555),
                                  fontSize: 10.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(Icons.person_2_outlined, size: 18),
                              Text(
                                'Joy Arthur',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 10.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 90.w),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                        height: 44.h,
                        width: 44.w,
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 4.w),
                    child: Icon(Icons.close),
                  ))
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
            width: 270.w,
            child: TextFormField(
              onChanged: onChanged,
              cursorColor: AppColors.primaryColor,
              controller: messageController,
              onTap: () {
                context.read<ShowAttachment>().closeAttachment();
              },
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
                suffixIcon: SizedBox(
                  width: 10,
                  height: 10,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/smiley.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 3)
        ],
      ),
    );
  }
}
