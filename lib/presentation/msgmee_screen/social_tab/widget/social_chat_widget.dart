import 'package:flutter/material.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/theme/colors.dart';
import '../../chat_screen/chat_screen.dart';
import '../../widget/chat_profile_widget.dart';
import '../../widget/profile_image_view_dialog.dart';

class SocialchatWidget extends StatelessWidget {
  const SocialchatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  screenNavigator(
                      context,
                      ChatScreen(
                        name: dummyData[index].name,
                        imageUrl: dummyData[index].imageUrl,
                        isOnline: dummyData[index].isOnline,
                        hasStory: dummyData[index].hasStory,
                      ));
                },
                splashColor: AppColors.seconderyColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => ProfileViewDialog(
                                    profilename: dummyData[index].name,
                                    imageUrl: dummyData[index].imageUrl,
                                  ));
                        },
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
                          Text(dummyData[index].name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
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
                          dummyData[index].unseenMessage != 0
                              ? Container(
                                  height: 20,
                                  // width: 20,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                      dummyData[index].unseenMessage.toString(),
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                color: AppColors.grey,
              ),
              // SizedBox(height: 5)
            ],
          );
        });
  }
}
