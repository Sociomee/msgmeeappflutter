import 'package:flutter/material.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/theme/custom_theme.dart';
import '../../widget/chat_profile_widget.dart';

class SocialchatWidget extends StatelessWidget {
  const SocialchatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            splashColor: CustomTheme.seconderyColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChatProfileWidget(
                          imageUrl: dummyData[index].imageUrl,
                          isOnline: dummyData[index].isOnline,
                          hasStory: dummyData[index].hasStory),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dummyData[index].name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 11),
                          Text(dummyData[index].message,
                              style: TextStyle(
                                  fontSize: 13, color: CustomTheme.grey)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dummyData[index].time,
                              style: TextStyle(
                                  fontSize: 13, color: CustomTheme.grey)),
                          SizedBox(height: 11),
                          dummyData[index].unseenMessage != 0
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: CustomTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                      dummyData[index].unseenMessage.toString(),
                                      style: TextStyle(
                                          color: CustomTheme.white,
                                          fontSize: 12)),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: CustomTheme.grey,
                )
              ],
            ),
          );
        });
  }
}
