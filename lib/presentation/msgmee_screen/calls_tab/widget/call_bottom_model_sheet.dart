import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/custom_theme.dart';

class CallOptionsModel {
  final String option;
  final VoidCallback clickAction;
  CallOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

List<CallOptionsModel> options = [
  CallOptionsModel(option: 'New Message', clickAction: () {}),
  CallOptionsModel(option: 'Schedule a Call', clickAction: () {}),
  CallOptionsModel(option: 'Make a Call', clickAction: () {}),
  CallOptionsModel(option: 'New Group', clickAction: () {}),
  CallOptionsModel(option: 'Broadcast', clickAction: () {}),
  CallOptionsModel(option: 'Settings', clickAction: () {}),
  CallOptionsModel(option: 'Logout', clickAction: () {}),
];

class CallBottomModelSheet extends StatelessWidget {
  const CallBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 280.h,
        decoration: BoxDecoration(
            color: CustomTheme.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            // Container(
            //   height: 4,
            //   width: 80,
            //   margin: EdgeInsets.only(top: 15),
            //   decoration: BoxDecoration(
            //       color: CustomTheme.grey,
            //       borderRadius: BorderRadius.circular(10)),
            // ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    splashColor: CustomTheme.seconderyColor,
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
                        index == options.length - 1
                            ? Container()
                            : Divider(height: 0, color: CustomTheme.grey)
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
