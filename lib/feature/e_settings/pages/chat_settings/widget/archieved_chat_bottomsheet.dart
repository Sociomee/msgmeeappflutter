import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/e_settings/models/archieved_chat_model.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';

class ArchievedChatBottomSheet extends StatefulWidget {
  const ArchievedChatBottomSheet({super.key});

  @override
  State<ArchievedChatBottomSheet> createState() =>
      _ArchievedChatBottomSheetState();
}

class _ArchievedChatBottomSheetState extends State<ArchievedChatBottomSheet> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return expand
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                height: 2,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('My Chats',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select All',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Archives Selected',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.grey),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: archievedChatList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              activeColor: AppColors.primaryColor,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: AppColors.primaryColor),
                              ),
                              value: archievedChatList[index].selected,
                              onChanged: (e) {
                                setState(() {
                                  archievedChatList[index].selected =
                                      !archievedChatList[index].selected;
                                });
                              }),
                          SizedBox(width: 10),
                          Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: index % 2 == 0
                                  ? AppColors.blue
                                  : AppColors.darkgreen,
                              shape: OvalBorder(),
                            ),
                            child: Text(
                              archievedChatList[index].name[0],
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            archievedChatList[index].name,
                            style: TextStyle(
                              color: Color(0xFF151624),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            archievedChatList[index].size,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 20)
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                height: 2,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey),
              ),
              SizedBox(height: 20),
              Text('Archive Chats',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Do you want to realy archive all chats?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CustomButtonWidget(
                  title: 'Ok',
                  color: AppColors.primaryColor,
                  ontap: () {
                    setState(() {
                      expand = true;
                    });
                  }),
              SizedBox(height: 30),
            ],
          );
  }
}
