import 'package:flutter/material.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/theme/colors.dart';

import '../widgets/chat_profile_widget.dart';

class ArchivedListScreen extends StatefulWidget {
  const ArchivedListScreen({super.key});

  @override
  State<ArchivedListScreen> createState() => _ArchivedListScreenState();
}

class _ArchivedListScreenState extends State<ArchivedListScreen> {
  List<int> selectedindex = [];
  bool longpressclicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,
                    size: 18, color: AppColors.black))),
        titleSpacing: 5,
        leadingWidth: 40,
        title: selectedindex.isNotEmpty
            ? Text(
                selectedindex.length.toString(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              )
            : Text(
                'Archived List',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          selectedindex.isNotEmpty
              ? Icon(Icons.archive_outlined, color: AppColors.black, size: 18)
              : Container(),
          SizedBox(width: 20),
          selectedindex.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'You are  going to delete chats!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete chats',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF368C4E),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                      color: AppColors.grey.withOpacity(.3),
                                      thickness: 1),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF368C4E),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                      color: AppColors.grey.withOpacity(.3),
                                      thickness: 1),
                                ),
                                Text(
                                  'Learn More',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF2F80ED),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 20)
                              ],
                            ),
                          );
                        });
                  },
                  child: Icon(Icons.delete_outline,
                      color: AppColors.black, size: 18))
              : Container(),
          PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Select all chats',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      'Clear all chats',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text(
                      'Mark all as read',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ];
              },
              offset: Offset(-10, 10),
              color: Colors.white,
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  if (selectedindex.length != 9) {
                    setState(() {
                      selectedindex.clear();
                    });
                    selectedindex.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8]);
                  } else {
                    setState(() {
                      selectedindex.clear();
                    });
                  }
                } else if (value == 2) {
                } else if (value == 3) {}
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (selectedindex.contains(index)) {
                            setState(() {
                              selectedindex.remove(index);
                            });
                          } else {}
                        },
                        onLongPress: () {
                          if (longpressclicked) {
                            // setState(() {
                            //   longpressclicked = false;
                            // });
                          } else {
                            setState(() {
                              selectedindex.add(index);
                              longpressclicked = true;
                            });
                          }
                        },
                        child: Container(
                          color: selectedindex.contains(index)
                              ? AppColors.seconderyColor1
                              : AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                ChatProfileWidget(
                                    imageUrl: dummyData[index].imageUrl,
                                    isOnline: dummyData[index].isOnline,
                                    hasStory: dummyData[index].hasStory),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dummyData[index].name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 8),
                                    Text(dummyData[index].message,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grey)),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(dummyData[index].time,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grey)),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        dummyData[index].unseenMessage != 0
                                            ? Container(
                                                height: 20,
                                                // width: 20,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 6),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Text(
                                                    dummyData[index]
                                                        .unseenMessage
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                          height: 0,
                          thickness: 1,
                          color: Color(0xFFE4E4E4).withOpacity(.5)),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
