import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';
import '../../../models/archieved_chat_model.dart';

class DeleteChatBottomSheet extends StatefulWidget {
  const DeleteChatBottomSheet({super.key});

  @override
  State<DeleteChatBottomSheet> createState() => _DeleteChatBottomSheetState();
}

class _DeleteChatBottomSheetState extends State<DeleteChatBottomSheet> {
  bool expand = true;
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
                child: Text('Delete Chats',
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
                    GestureDetector(
                      onTap: () {
                        if (deletedChatList
                                .where((e) => e.selected == true)
                                .toList()
                                .length !=
                            deletedChatList.length) {
                          setState(() {
                            for (var i = 0; i < deletedChatList.length; i++) {
                              deletedChatList[i].selected = true;
                            }
                          });
                        } else {
                          setState(() {
                            for (var i = 0; i < deletedChatList.length; i++) {
                              deletedChatList[i].selected = false;
                            }
                          });
                        }
                      },
                      child: Text(
                        deletedChatList
                                    .where((e) => e.selected == true)
                                    .toList()
                                    .length ==
                                deletedChatList.length
                            ? 'Unselect All'
                            : 'Select All',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expand = false;
                        });
                      },
                      child: Text(
                        'Clear Selected',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.grey),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: deletedChatList.length,
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
                              value: deletedChatList[index].selected,
                              onChanged: (e) {
                                setState(() {
                                  deletedChatList[index].selected =
                                      !deletedChatList[index].selected;
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
                              deletedChatList[index].name[0],
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            deletedChatList[index].name,
                            style: TextStyle(
                              color: Color(0xFF151624),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            deletedChatList[index].size,
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
              SizedBox(height: 17),
              Container(
                height: 4.5,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightgrey),
              ),
              SizedBox(height: 20),
              Text('Delate All Chats',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Are you sure! Do you want to delate all chats?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButtonWidget(
                    height: 49,
                    title: 'OK',
                    color: AppColors.primaryColor,
                    ontap: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(height: 30),
            ],
          );
  }
}
