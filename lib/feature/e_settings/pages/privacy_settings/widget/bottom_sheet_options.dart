// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/colors.dart';

class OptionsModel {
  final String title;
  bool isSelected;
  PrivacyOption value;
  OptionsModel({
    required this.title,
    required this.isSelected,
    required this.value,
  });
}

List<OptionsModel> options = [
  OptionsModel(
      title: 'Everyone', isSelected: false, value: PrivacyOption.everyone),
  OptionsModel(
      title: 'My contacts', isSelected: false, value: PrivacyOption.mycontact),
  OptionsModel(
      title: 'My contacts exceptation',
      isSelected: false,
      value: PrivacyOption.excetpcontact),
  OptionsModel(title: 'Nobody', isSelected: true, value: PrivacyOption.nobody),
];

enum PrivacyOption { everyone, mycontact, excetpcontact, nobody }

class OptionsBottomSheet extends StatefulWidget {
  const OptionsBottomSheet(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  State<OptionsBottomSheet> createState() => _OptionsBottomSheetState();
}

class _OptionsBottomSheetState extends State<OptionsBottomSheet> {
  PrivacyOption? groupvalue = PrivacyOption.everyone;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 295.h,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
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
              SizedBox(height: 6),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: ListTile(
                            tileColor: AppColors.seconderyColor,
                            selectedTileColor: AppColors.seconderyColor,
                            onTap: () {},
                            leading: Text(
                              options[index].title,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: Radio<PrivacyOption>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        groupvalue == options[index].value
                                            ? AppColors.primaryColor
                                            : AppColors.lightgrey),
                                activeColor: AppColors.primaryColor,
                                value: options[index].value,
                                groupValue: groupvalue,
                                onChanged: (PrivacyOption? e) {
                                  setState(() {
                                    groupvalue = e;
                                  });
                                }),
                          ),
                        ),
                        index == options.length - 1
                            ? Container()
                            : Divider(
                                color: AppColors.lightgrey1,
                                height: 0,
                                thickness: 1,
                              ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
