import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/connect_webpanel/linked_devices_screen.dart';
import 'package:msgmee/presentation/new_message/new_message_screen.dart';

import '../../../theme/custom_theme.dart';

class ChatOptionsModel {
  final String option;
  final VoidCallback clickAction;
  ChatOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

class SocialBottomModelSheet extends StatelessWidget {
  const SocialBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatOptionsModel> options = [
      ChatOptionsModel(
          option: 'New Message',
          clickAction: () {
            screenNavigator(context, NewMessageScreen());
          }),
      ChatOptionsModel(option: 'Make a Call', clickAction: () {}),
      ChatOptionsModel(option: 'Create New Group', clickAction: () {}),
      ChatOptionsModel(option: 'Create a Broadcast', clickAction: () {}),
      ChatOptionsModel(
          option: 'Sync your account to web panel',
          clickAction: () {
            screenNavigator(context, LinkedDevicesScreen());
          }),
      ChatOptionsModel(option: 'Archived Chats List', clickAction: () {}),
      ChatOptionsModel(
          option: 'Sync your SocioMee connections', clickAction: () {}),
      ChatOptionsModel(option: 'Settings', clickAction: () {}),
      ChatOptionsModel(option: 'Logout', clickAction: () {}),
    ];
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 356.h,
        decoration: BoxDecoration(
            color: CustomTheme.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: CustomTheme.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: options[index].clickAction,
                    splashColor: CustomTheme.seconderyColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 24),
                                child: Text(
                                  options[index].option,
                                  style: TextStyle(color: CustomTheme.grey),
                                ),
                              ),
                              Divider(height: 0, color: CustomTheme.grey)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
