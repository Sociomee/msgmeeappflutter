import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/colors.dart';

class Options {
  final String title;
  final VoidCallback onclick;
  Options({
    required this.title,
    required this.onclick,
  });
}

List<Options> options = [
  Options(title: 'All Connections', onclick: () {}),
  Options(title: 'Only SocioMee Connections ', onclick: () {}),
  Options(title: 'Only MsgMee Connections ', onclick: () {}),
  Options(title: 'Only my Phone Connections ', onclick: () {}),
];

class BottomOptionsWidget extends StatelessWidget {
  const BottomOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 210.w,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, top: 14, bottom: 14),
                        child: Text(
                          options[index].title,
                          style: TextStyle(
                              fontSize: 14, color: AppColors.iconColor),
                        ),
                      ),
                      index == options.length - 1
                          ? Container()
                          : Divider(
                              height: 0,
                              color: AppColors.grey,
                            )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
