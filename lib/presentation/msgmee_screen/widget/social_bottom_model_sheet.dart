import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/custom_theme.dart';

class SocialOptionsModel {
  final String option;
  final VoidCallback clickAction;
  SocialOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

List<SocialOptionsModel> options = [
  SocialOptionsModel(option: 'New Message', clickAction: () {}),
  SocialOptionsModel(option: 'Make a Call', clickAction: () {}),
  SocialOptionsModel(option: 'Create New Group', clickAction: () {}),
  SocialOptionsModel(option: 'Create a Broadcast', clickAction: () {}),
  SocialOptionsModel(
      option: 'Sync your account to web panel', clickAction: () {}),
  SocialOptionsModel(option: 'Archived Chats List', clickAction: () {}),
  SocialOptionsModel(
      option: 'Sync your SocioMee connections', clickAction: () {}),
  SocialOptionsModel(option: 'Settings', clickAction: () {}),
  SocialOptionsModel(option: 'Logout', clickAction: () {}),
];

class SocialBottomModelSheet extends StatelessWidget {
  const SocialBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {},
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
