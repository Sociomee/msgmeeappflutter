import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/mx_appbar.dart';
import 'package:msgmee/data/model/pending_request_model.dart';
import 'package:msgmee/theme/colors.dart';

import '../chat_screen/widgets/exit_alert_dialog.dart';

class PendingGroupRequestScreen extends StatefulWidget {
  const PendingGroupRequestScreen({super.key});

  @override
  State<PendingGroupRequestScreen> createState() =>
      _PendingGroupRequestScreenState();
}

class _PendingGroupRequestScreenState extends State<PendingGroupRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 16,
          ),
        ),
        title: Text(
          'Pending Request',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.lightgrey1,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 1, child: Text('Edit Group')),
                PopupMenuItem(value: 2, child: Text('Delete Group')),
                PopupMenuItem(value: 3, child: Text('Report Group')),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ExitAlertDialog();
                    });
              } else if (value == 2) {
              } else if (value == 3) {}
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Today(3)',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                itemCount: pendingrequestList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                pendingrequestList[index].image,
                                height: 41,
                                width: 41,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pendingrequestList[index].title,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    activeColor: AppColors.primaryColor,
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => const BorderSide(
                                          width: 1.0,
                                          color: AppColors.primaryColor),
                                    ),
                                    value:
                                        pendingrequestList[index].showOlderChat,
                                    onChanged: (e) {
                                      setState(() {
                                        pendingrequestList[index]
                                                .showOlderChat =
                                            !pendingrequestList[index]
                                                .showOlderChat;
                                      });
                                    },
                                  ),
                                  Text('Show older chats',
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            'Decline',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFFF00000),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 42),
                          Text(
                            'Accept',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF368C4E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.lightgrey1,
                      )
                    ],
                  );
                }),
            SizedBox(height: 40),
            Text(
              'Tomorrow(3)',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                itemCount: pendingrequestList1.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                pendingrequestList1[index].image,
                                height: 41,
                                width: 41,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pendingrequestList1[index].title,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    activeColor: AppColors.primaryColor,
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => const BorderSide(
                                          width: 1.0,
                                          color: AppColors.primaryColor),
                                    ),
                                    value: pendingrequestList1[index]
                                        .showOlderChat,
                                    onChanged: (e) {
                                      setState(() {
                                        pendingrequestList1[index]
                                                .showOlderChat =
                                            !pendingrequestList1[index]
                                                .showOlderChat;
                                      });
                                    },
                                  ),
                                  Text('Show older chats',
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            'Decline',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFFF00000),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 42),
                          Text(
                            'Accept',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF368C4E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.lightgrey1,
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
