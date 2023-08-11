// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/colors.dart';

class OptionsModel {
  final String title;
  bool isSelected;
  NotificationOption value;

  OptionsModel({
    required this.title,
    required this.isSelected,
    required this.value,
  });
}

List<OptionsModel> options = [
  OptionsModel(
      title: 'Vibrate only',
      isSelected: false,
      value: NotificationOption.vibrate),
  OptionsModel(
      title: 'Tone only', isSelected: false, value: NotificationOption.tone),
  OptionsModel(
      title: 'Vibrate & Tone ',
      isSelected: false,
      value: NotificationOption.vibrateandtone),
  OptionsModel(
      title: 'Silent', isSelected: false, value: NotificationOption.slient),
];

enum NotificationOption { vibrate, tone, vibrateandtone, slient }

class NotificationBottomSheet extends StatefulWidget {
  const NotificationBottomSheet({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<NotificationBottomSheet> createState() =>
      _NotificationBottomSheetState();
}

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {
  NotificationOption? groupvalue = NotificationOption.vibrate;
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
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text(widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          groupvalue = options[index].value;
                        });
                      },
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: AppColors.seconderyColor,
                            selectedTileColor: AppColors.seconderyColor,
                            leading: Text(
                              options[index].title,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: Radio<NotificationOption>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        groupvalue == options[index].value
                                            ? AppColors.primaryColor
                                            : AppColors.lightgrey),
                                activeColor: AppColors.primaryColor,
                                value: options[index].value,
                                groupValue: groupvalue,
                                onChanged: (NotificationOption? e) {
                                  setState(() {
                                    groupvalue = e;
                                  });
                                }),
                          ),
                          index == options.length - 1
                              ? Container()
                              : Divider(
                                  color:
                                      AppColors.seconderyColor.withOpacity(.5),
                                  height: 0,
                                  thickness: 1,
                                ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
