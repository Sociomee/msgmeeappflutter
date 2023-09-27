import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/msgmee_screen.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../../common_widgets/Mx_appbar.dart';
import '../../../../../data/model/dummy_chat_model.dart';
import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';

class ShareGroupInvitationPage extends StatefulWidget {
  const ShareGroupInvitationPage({super.key});

  @override
  State<ShareGroupInvitationPage> createState() =>
      _ShareGroupInvitationPageState();
}

class _ShareGroupInvitationPageState extends State<ShareGroupInvitationPage> {
  bool selectmode = false;
  List<int> isSelected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 18,
            ),
          ),
        ),
        title: Text(
          isSelected.isNotEmpty
              ? '${isSelected.length} Selected'
              : 'Share via Msgmee',
          style: TextStyle(
            color: Color(0xFF4E4E4E),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              animatedScreenReplaceNavigator(context, MsgmeeScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Text(
                'Send',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
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
                        onLongPress: () {
                          if (!isSelected.contains(index)) {
                            setState(() {
                              selectmode = true;
                              isSelected.add(index);
                            });
                          } else if (selectmode && isSelected.length == 1) {
                            setState(() {
                              selectmode = false;
                            });
                          } else {
                            setState(() {
                              isSelected.remove(index);
                            });
                          }
                        },
                        onTap: () {
                          if (selectmode && !isSelected.contains(index)) {
                            setState(() {
                              isSelected.add(index);
                            });
                          } else if (selectmode && isSelected.length == 1) {
                            setState(() {
                              selectmode = false;
                              isSelected.remove(index);
                            });
                          } else {
                            setState(() {
                              isSelected.remove(index);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isSelected.contains(index)
                                  ? AppColors.selectedChatColor
                                  : AppColors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: ChatProfileWidget(
                                    imageUrl: dummyData[index].imageUrl,
                                    isOnline: dummyData[index].isOnline,
                                    hasStory: dummyData[index].hasStory),
                              ),
                              SizedBox(width: 13),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(dummyData[index].name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(dummyData[index].message,
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.grey)),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(dummyData[index].time,
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.grey)),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SizedBox(width: 5),
                                      dummyData[index].unseenMessage != 0
                                          ? Container(
                                              height: 20,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 6),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
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
