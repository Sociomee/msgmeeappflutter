import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/custom_theme.dart';

class ProfileOptionsModel {
  final String option;
  final VoidCallback clickAction;
  ProfileOptionsModel({
    required this.option,
    required this.clickAction,
  });
}

List<ProfileOptionsModel> options = [
  ProfileOptionsModel(option: 'Block', clickAction: () {}),
  ProfileOptionsModel(option: 'Report', clickAction: () {}),
];

class ProfileBottomModelSheet extends StatelessWidget {
  const ProfileBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          // height: 280.h,
          decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
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
      ),
    );
  }
}
