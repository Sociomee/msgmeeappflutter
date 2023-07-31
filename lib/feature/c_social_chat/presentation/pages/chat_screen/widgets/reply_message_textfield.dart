import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/reply_msg/reply_msg_cubit.dart';

import '../../../../../../theme/colors.dart';

class ReplyMessageTextField extends StatelessWidget {
  const ReplyMessageTextField(
      {super.key, required this.messageController, this.onChanged, this.color});
  final TextEditingController messageController;
  final ValueChanged<String>? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ReplyMsgCubit>().state.replymodel;
    return AnimatedContainer(
      width: 280.w,
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? AppColors.lightgrey1,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240.w,
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
                          Text(cubit.owner,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 10.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            width: 110.w,
                            child: Text(cubit.msg,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF555555),
                                    fontSize: 10.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 130),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    context.read<ReplyMsgCubit>().closeReplyMsg();
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
              autofocus: true,
              onChanged: onChanged,
              cursorColor: AppColors.primaryColor,
              controller: messageController,
              onTap: () {
                // context.read<ReplyMsgCubit>().closeReplyMsg();
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
