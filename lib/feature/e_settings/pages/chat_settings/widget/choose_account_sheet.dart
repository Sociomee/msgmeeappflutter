import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/colors.dart';

class OptionsModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  bool isSelected;
  GoogleAccountOption value;
  OptionsModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.value,
  });
}

List<OptionsModel> options = [
  OptionsModel(
    title: 'Savannah Nguyen',
    isSelected: false,
    imageUrl:
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600',
    subtitle: 'savannah_nguyen123@gmail.com',
    value: GoogleAccountOption.ac1,
  ),
  OptionsModel(
    title: 'Wade Warren',
    isSelected: false,
    imageUrl:
        'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600',
    subtitle: 'dummy_email@gmail.com',
    value: GoogleAccountOption.ac2,
  ),
  OptionsModel(
    title: 'Annette Black',
    isSelected: false,
    imageUrl:
        'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600',
    subtitle: 'dummy_email@gmail.com',
    value: GoogleAccountOption.ac3,
  ),
  OptionsModel(
    title: 'Marvin McKinney',
    isSelected: true,
    imageUrl:
        'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600',
    subtitle: 'dummy_email@gmail.com',
    value: GoogleAccountOption.ac4,
  ),
];

enum GoogleAccountOption { ac1, ac2, ac3, ac4 }

class ChooseAccountBottomSheet extends StatefulWidget {
  const ChooseAccountBottomSheet({super.key});

  @override
  State<ChooseAccountBottomSheet> createState() =>
      _ChooseAccountBottomSheetState();
}

class _ChooseAccountBottomSheetState extends State<ChooseAccountBottomSheet> {
  GoogleAccountOption? groupvalue = GoogleAccountOption.ac1;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 415.h,
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
              Text('Choose Google Account',
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
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.grey,
                              backgroundImage:
                                  NetworkImage(options[index].imageUrl),
                            ),
                            title: Text(options[index].title,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 14)),
                            subtitle: Text(options[index].subtitle,
                                style: TextStyle(
                                    color: AppColors.iconColor, fontSize: 11)),
                            trailing: Radio<GoogleAccountOption>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        groupvalue == options[index].value
                                            ? AppColors.primaryColor
                                            : AppColors.lightgrey),
                                activeColor: AppColors.primaryColor,
                                value: options[index].value,
                                groupValue: groupvalue,
                                onChanged: (GoogleAccountOption? e) {
                                  setState(() {
                                    groupvalue = e;
                                  });
                                }),
                          ),
                        ),
                        Divider(
                          color: AppColors.lightgrey,
                          height: 0,
                          thickness: 1,
                        ),
                      ],
                    );
                  }),
              SizedBox(height: 24),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add new account',
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 16),
                  )),
              SizedBox(height: 24),
            ],
          ),
        ));
  }
}
