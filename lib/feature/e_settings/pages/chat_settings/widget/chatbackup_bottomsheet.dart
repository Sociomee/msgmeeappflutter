import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';

class OptionsModel {
  final String option;
  bool isSelected;

  OptionsModel({required this.option, required this.isSelected});
}

List<OptionsModel> options = [
  OptionsModel(option: 'Every hour', isSelected: false),
  OptionsModel(option: 'Every 4 hours', isSelected: false),
  OptionsModel(option: 'Everyday', isSelected: false),
  OptionsModel(option: 'Every week', isSelected: true),
  OptionsModel(option: 'Every month', isSelected: false),
  OptionsModel(option: 'Only when i back up', isSelected: false),
];

class ChatBackUpBottomSheet extends StatefulWidget {
  const ChatBackUpBottomSheet({super.key});

  @override
  State<ChatBackUpBottomSheet> createState() => _ChatBackUpBottomSheetState();
}

class _ChatBackUpBottomSheetState extends State<ChatBackUpBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 480.h,
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          tileColor: AppColors.seconderyColor,
                          selectedTileColor: AppColors.seconderyColor,
                          onTap: () {
                            options[index].isSelected =
                                !options[index].isSelected;
                            setState(() {});
                          },
                          leading: Text(options[index].option),
                          trailing: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1),
                                borderRadius: BorderRadius.circular(100)),
                            child: options[index].isSelected
                                ? Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        border: Border.all(
                                            color: AppColors.white, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  )
                                : Container(),
                          ),
                        ),
                        Divider(color: AppColors.primaryColor)
                      ],
                    );
                  }),
              SizedBox(height: 30),
              CustomButtonWidget(
                  title: 'Ok', color: AppColors.primaryColor, ontap: () {}),
            ],
          ),
        ));
  }
}
