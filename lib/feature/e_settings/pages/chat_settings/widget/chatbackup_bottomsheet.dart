// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:msgmee/common_widgets/custom_button_widget.dart';

import '../../../../../theme/colors.dart';

class OptionsModel {
  final String option;
  bool isSelected;
  ChatBackupOptions value;
  OptionsModel({
    required this.option,
    required this.isSelected,
    required this.value,
  });
}

List<OptionsModel> options = [
  OptionsModel(
      option: 'Every hour',
      isSelected: false,
      value: ChatBackupOptions.everyhour),
  OptionsModel(
      option: 'Every 4 hours',
      isSelected: false,
      value: ChatBackupOptions.every4hour),
  OptionsModel(
      option: 'Everyday', isSelected: false, value: ChatBackupOptions.everyday),
  OptionsModel(
      option: 'Every week',
      isSelected: true,
      value: ChatBackupOptions.everyweek),
  OptionsModel(
      option: 'Every month',
      isSelected: false,
      value: ChatBackupOptions.everymonth),
  OptionsModel(
      option: 'Only when i back up',
      isSelected: false,
      value: ChatBackupOptions.onlywhenibackup),
];

enum ChatBackupOptions {
  everyhour,
  every4hour,
  everyday,
  everyweek,
  everymonth,
  onlywhenibackup,
}

class ChatBackUpBottomSheet extends StatefulWidget {
  const ChatBackUpBottomSheet({super.key});

  @override
  State<ChatBackUpBottomSheet> createState() => _ChatBackUpBottomSheetState();
}

class _ChatBackUpBottomSheetState extends State<ChatBackUpBottomSheet> {
  int selected = 0;
  ChatBackupOptions? groupvalue = ChatBackupOptions.everyhour;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: Container(
          height: 450.h,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(25)),
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
              Text('Schedule Chat Backup',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: groupvalue == options[index].value
                              ? AppColors.seconderyColor1
                              : Colors.transparent,
                          child: ListTile(
                            tileColor: AppColors.seconderyColor,
                            selectedTileColor: AppColors.seconderyColor,
                            onTap: () {
                              setState(() {
                                groupvalue = options[index].value;
                              });
                            },
                            leading: Text(options[index].option),
                            trailing: Radio<ChatBackupOptions>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        groupvalue == options[index].value
                                            ? AppColors.primaryColor
                                            : AppColors.lightgrey),
                                activeColor: AppColors.primaryColor,
                                value: options[index].value,
                                groupValue: groupvalue,
                                onChanged: (ChatBackupOptions? e) {
                                  setState(() {
                                    groupvalue = e;
                                  });
                                }),
                          ),
                        ),
                        index == 5
                            ? Container()
                            : Divider(
                                color: AppColors.seconderyColor,
                                height: 0,
                                thickness: .5,
                              )
                      ],
                    );
                  }),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButtonWidget(
                    height: 49,
                    title: 'OK',
                    color: AppColors.primaryColor,
                    ontap: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ));
  }
}
