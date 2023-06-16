import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../helper/navigator_function.dart';
import '../../../../../../theme/colors.dart';
import '../../media_doc_screen/media_and_doc_screen.dart';

class ChatOptionsModel {
  final String option;
  final VoidCallback clickAction;
  ChatOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

class ChatScreenBottomModelSheet extends StatelessWidget {
  const ChatScreenBottomModelSheet({super.key, required this.profilename});
  final String profilename;
  @override
  Widget build(BuildContext context) {
    List<ChatOptionsModel> options = [
      ChatOptionsModel(
          option: 'Media, links and docs',
          clickAction: () {
            screenNavigator(
                context, MediaAndDocScreen(profilename: profilename));
          }),
      ChatOptionsModel(option: 'Search', clickAction: () {}),
      ChatOptionsModel(option: 'Mute Messages', clickAction: () {}),
      ChatOptionsModel(option: 'Clear Chat', clickAction: () {}),
      ChatOptionsModel(
          option: 'Block',
          clickAction: () {
            // screenNavigator(context, LinkedDevicesScreen());
          }),
      ChatOptionsModel(option: 'Settings', clickAction: () {}),
    ];
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            height: 256.h,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: options[index].clickAction,
                        splashColor: AppColors.seconderyColor,
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
                                      style: TextStyle(color: AppColors.grey),
                                    ),
                                  ),
                                  index == options.length - 1
                                      ? Container()
                                      : Divider(
                                          height: 0, color: AppColors.grey)
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}
