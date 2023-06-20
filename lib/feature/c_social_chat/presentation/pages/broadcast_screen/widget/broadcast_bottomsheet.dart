import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../helper/navigator_function.dart';
import '../../../../../../theme/colors.dart';
import '../../media_doc_screen/media_and_doc_screen.dart';


class BroadcastOptionsModel {
  final String option;
  final VoidCallback clickAction;
  BroadcastOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

class BroadcastBottomModelSheet extends StatelessWidget {
  const BroadcastBottomModelSheet({super.key, required this.profilename});
  final String profilename;
  @override
  Widget build(BuildContext context) {
    List<BroadcastOptionsModel> options = [
      BroadcastOptionsModel(option: 'Search', clickAction: () {}),
      BroadcastOptionsModel(option: 'Clear Chat', clickAction: () {}),
      BroadcastOptionsModel(
          option: 'Media, links and docs',
          clickAction: () {
            screenNavigator(
                context, MediaAndDocScreen(profilename: profilename));
          }),
      BroadcastOptionsModel(option: 'Change Wallpaper', clickAction: () {}),
    ];
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            height: 180.h,
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
